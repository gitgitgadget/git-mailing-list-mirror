Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540972;
	b=WkDMfwXHHknSYcrh1Af8Kn/uKCPwzsaDO9XGsofsWVzZhNVRrhq71Y+qgvr+HfP/UUkn
	 BhcQLbwnq8AvZLzAoCE+rCSsBThhlruMVELbGzOrEs886X/nJ50KLAa6hfzGNfP2h8QTR
	 XMzyGKHDw3L7mY8ppRkItoRLVt1lpwPO0pKv8uc7obpUtTPUpPg93wrqZueoIJFADKh+8
	 qAuyReeR5H6hQTD1nM3ZszclC35sYIe0N1iI7lYrT7Bv95FdXujCNEL7+2Qu9qGPctL1J
	 oZMhmp6Qelf8GHKzmj6B9L8KK0qFPzUjkpzvzNGwHVJBk7y3eXxJWRNTyXbGxOa7O1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kezZGHeLloHaJ2MKhoiAIbrQQR8LDYCZTYZeN0WxIEU=;
	b=puVjx4R5xjmcja2fHlSv2uaAbl62FIBLs5DIrcgiYdpoctKsY+SWuoyzyhHIgo6j5m89
	 ODZ3cmdZK6v4nHDq98b7iesuQV09j2zg2kyMO66ETs1vlEw471GuX38au0j480Hw7Kshl
	 n6JDjgS70QJxTxPPrQQ7NP+55rEkfsMM7Y0HrMVwU2jJB5B7wuBJSV7R+au8+XuZi7CQB
	 j4V+b657NZeNFlQdrQofD5XEJg379e5goSjEOFkxGCjDK7y1gOZzExqhdM+B3tLJ3ksFX
	 wEbQfjNy3tyfzaZA5qvkmOYMsE8jGrDMuxM2vUQJX6yqeV3YtaYnLchJ9Xo9XDyTS1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CzRgw4xw;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC742606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC742606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CzRgw4xw
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ba380cd8dbso6421372a12.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540970; x=1796145770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kezZGHeLloHaJ2MKhoiAIbrQQR8LDYCZTYZeN0WxIEU=;
        b=CzRgw4xwiEAhTLIYId9wJWcX4IB+V9+EBK8z7CcKIts+oPS4MTtJ98HFQ1ggK3FDL1
         B5dhRFZAzj+YquCpcdYLxZzpQoGnqpoZlUQ1/EgzXp9hejr2i88AduePFvTcU3MTweet
         4rT19kfPFaebQuUOGyKMlcV5UcCKFyzkBhj+X07othKSPM55o5VmqlhoBGF5zgGOZqhU
         4AAr01Tmx0bnpqgoFJWxSUEyXJNASwnLsIQUYKqZq0VyccCz1hBZheWVJQnUdM112wTj
         w1YKfwx+bAiGfqhrjoYzMgPotliW2PoNIzQTJqB91Aey3WfAcAYeyrrUMKXcp5mZmlSk
         uYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540970; x=1796145770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kezZGHeLloHaJ2MKhoiAIbrQQR8LDYCZTYZeN0WxIEU=;
        b=Xduuc1SWXMrwGK3IdaKT3SVHLMVFSQHVPzu4dBO1z3vDDk9d6Zk81dwGS6Ov1YNetT
         izNVr89XLlw3ZDvmjqm98UelB0AToXmHVM3ZF+ZRLSgjqEDYv4ekgRMew1GJwuLuY8CT
         66F8w5aUAKKAfZeuwjrFAkLRE6Sn0My9QnZySsIZOuVhuIRFNHt3lcooDZx4lP5dBAIX
         D/FbZ0P0R95wc7Gl8QJvXAUi15kXlWvpqJ1KHaz740u1N5EEe0Disue9zGYNzTYTul5U
         71jSszHamI78K0zv1ojMmNnJxjtyGg2S5lkYphBrvlNcKfV4PqOXXntucicGtYZ9yxgZ
         ta6A==
X-Gm-Message-State: APuU4Z9EkO1Ii0QXE3hLnmo6bl9N2HLCZkskjxoTGdC7h5Aq0gVtZOUO
	4WAZ1etBdDQoF3n91MlJrH8tu2WOJeEvLRpqWywn2HkocuBwYj6MP1Yl8+Or0W5D4Gw=
X-Gm-Gg: AZFdTZdPn3SAV/ddJuYhoXoqQ+arQzV7cCfkeA7rlIXNmWRjC1E55MdKPyVj+FggSeO
	rhgN7gHlGwfmNIWYS7RMuoLHgtEwD1daIwP7/OX7t8eAwNcMLKBNy/DAJAN5/qf/D8DLu97uqfM
	WCBliwz1vfr7Kw2xeZMwr89jT1O8t2SiOMB+8TfVkTuf5IgCRlYsOwZp2GL58vMoNbh57fCEXnK
	ygHM8x11dRTXmSNx0j5EP401FCxyK8mkXXEpZ93CG1LOOoAh6jKtKDcItF3i/cSdNJkjGJQWw5G
	m1RiiO2LWqU+LaVeHWKiLid6Cb5/oPTc2EI8l4RxaIGnZEVyRF9x39PK23xwMhJl+ZcILJSnIIi
	RakmkpmZJHhy1adwXxHg1oauEkD2/o2JVXTcAnpgC96ks2lh2EgYI3w+U14vWzxZeh3bHVXB6DW
	AK4w0fFSHeKbauu0Ja0CO347y+J43wfZ9YtBXyelYDb7e/EG1hWjEJbPxs5nZ6MMBgRmB5OOl/m
	ayb5yrA8zUQiR0IKk4CBom+Dt8WHSm/2NpBxXo7TOO2NtT7MM1sMHTGV+SNuENl8sE6pIbn+kiG
	vVT0SsEpTvqP4vKIvaduRURH74f6ljib8wBq14sMqKBjksJwxRfWaR1UoB+f7XCRZCLgR2tc4Ae
	TxBBGxlUu57US58EoGD8ixR2yz1ghU30CteuzwVBC/XPhpObYfgXoWByLHOKnXdSjbBMfS0GlMq
	boow8+PPiE4xAnlrRC7pMR4jeyXBtx
X-Received: by 2002:a17:907:9584:b0:c34:e9fe:82ed with SMTP id a640c23a62f3a-c513a88223amr1197255966b.28.1795540969887;
        Tue, 24 Nov 2026 09:22:49 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm547394466b.68.2026.11.24.09.22.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:22:49 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v2 0/5] notes: start passing the repository through notes.[ch]
Date: Tue, 24 Nov 2026 18:21:41 +0100
Message-ID: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory series. It makes the code in notes.[c,h] and its
direct callers work on the repository stored in struct notes_tree instead
of the_repository. It deliberately does not convert the whole notes
subsystem yet; it does the bulk of the work in notes.[c,h] and leaves the
rest for future series.

What it does:
 - stores the repository in struct notes_tree;
 - uses the tree's repository when reading, writing and pruning notes;
 - passes the repository to the ref glob helpers and the combine_notes
   callbacks.

What is left for future series:
 - notes.c: the display-notes code keeps its state in globals, and log,
   format-patch, diff-tree and format-rev are given a repository but do
   not pass it on. format_note() still falls back to the global
   default_notes_tree, and expand_loose_notes_ref() only takes a strbuf.
   The hash-size helpers are also still on the global.
 - notes-utils.[c,h]: still use the_repository. And the hash-size helpers
   still on the global are reached from here, through create_notes_commit()
   -> write_notes_tree(), so converting notes-utils is tied to converting
   those helpers too.
 - notes-merge.[c,h]: still work on the global repository.

Changes since v1:
 - Dropped the final patch (notes-utils: use the given repository) so the
   series stays within notes.[c,h] and its callers, and reframed it as a
   preparatory series.
 - Moved the copy_note() change out of the combine_notes patch into the
   writing-and-pruning patch, where it belongs, and updated both commit
   messages.

Okhuomon Ajayi (5):
  notes: store the repository in struct notes_tree
  notes: use the tree's repository when reading notes
  notes: use the tree's repository when writing and pruning
  notes: pass the repository to the ref glob helpers
  notes: pass the repository to the combine_notes callbacks

 builtin/notes.c |   8 ++-
 notes-cache.c   |   3 +-
 notes-utils.c   |   9 ++-
 notes.c         | 164 ++++++++++++++++++++++++++++--------------------
 notes.h         |  40 +++++++-----
 5 files changed, 134 insertions(+), 90 deletions(-)

Range-diff against v1:
1:  79ca75340a = 1:  5ad0f1bd62 notes: store the repository in struct notes_tree
2:  9692b4f18c = 2:  1018419720 notes: use the tree's repository when reading notes
3:  f87b683aeb ! 3:  67a2942c09 notes: use the tree's repository when writing and pruning
    @@ Commit message
         the repository, passed down from the tree. prune_notes() hands
         the repository to its callback in a small struct.
     
    +    copy_note() also writes through the tree, by calling add_note(),
    +    so it uses the tree's hash algorithm for its null object ID.
    +
         Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
     
      ## notes.c ##
    @@ notes.c: int write_notes_tree(struct notes_tree *t, struct object_id *result)
      	}
      }
      
    +@@ notes.c: int copy_note(struct notes_tree *t,
    + 	if (note)
    + 		return add_note(t, to_obj, note, combine_notes);
    + 	else if (existing_note)
    +-		return add_note(t, to_obj, null_oid(the_hash_algo), combine_notes);
    ++		return add_note(t, to_obj, null_oid(t->repo->hash_algo),
    ++				combine_notes);
    + 
    + 	return 0;
    + }
4:  469aa752ab = 4:  7ea6c0e5a2 notes: pass the repository to the ref glob helpers
5:  517c056f8d ! 5:  ff8cf4d22a notes: pass the repository to the combine_notes callbacks
    @@ Commit message
         belongs to another repository. The callbacks are only called from
         note_tree_insert(), which has the tree.
     
    -    Pass the tree's repository to all combine_notes callbacks. Also make
    -    copy_note() use the tree's hash algorithm for its null object ID.
    +    Pass the tree's repository to all combine_notes callbacks.
     
         Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
     
    @@ notes.c: int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
      			       buf.len, OBJ_BLOB, cur_oid);
      
      out:
    -@@ notes.c: int copy_note(struct notes_tree *t,
    - 	if (note)
    - 		return add_note(t, to_obj, note, combine_notes);
    - 	else if (existing_note)
    --		return add_note(t, to_obj, null_oid(the_hash_algo), combine_notes);
    -+		return add_note(t, to_obj, null_oid(t->repo->hash_algo),
    -+				combine_notes);
    - 
    - 	return 0;
    - }
     
      ## notes.h ##
     @@ notes.h: struct strbuf;
6:  75b58d578b < -:  ---------- notes-utils: use the given repository
-- 
2.56.0

