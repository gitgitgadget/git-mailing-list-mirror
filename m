Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644153;
	b=FgDD+Abb0TQAnjvAX+RstkkCGJjmxaZ6F6f1zuX0MbYhFi+0QNvJTAgnhkyyvZnixrIT
	 erp8dV/nL/02pY4m5gnhbZcaTkzq6RbiJ444wEnMNCSyv2t40G6pe469mC2m12QnLPik+
	 8PW2US/frLlfMW4Zys8duBFS06VCYdNi69lk7gdQSp3f2nIMzbaSuR3yx/g1DkJl4K3m8
	 EGXnrBzRM1OMpuZ7RQIPhAvVU7owvOvU7YiS0CBXqgKAAZIHihdL8y5z4+MS1CMCXfbsl
	 7YsmKUZ7gqw/S+zybX3dgSRacJ81XC5MJDrqyUpSGlsohKH1r3UdGKBGlCDrOn48fIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QW3JKu4Ju6ecGBFAob3aGqdbz2w3ML2gPpvKS3+j6Wk=;
	b=iEnfscABk+eixbl3VSaoRUH9b1FG1kdPGKdYC1T0MSvOHKzjVfYk1/cOe7DJdYxtVsyW
	 CW9+VJS9zy1K68HxQutOGmQvtTAalOvMXTohIxAtpd2jUUBdzMmhzM1LYI0tli9q8pRjb
	 TtSNCrlulJJSZYDx3Qih9OFF45V5Z/CczNL0DL2DPtFlzuUGR/A9d6yFod7dwxHM9NS9l
	 uMumT0sCWwC3IbBxa4arQuq32PNig+ltt2iKbgJmFnQGlsLRW3nsuysE/PA69j7SkyQUR
	 wja3PLtWp9P64oEFtsy+p3eg2VNO6eLuAdFbs4k7aUXQnKpnM96VgmZ3CafXbLzX1KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wf9vrA1S;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9CF606A339
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A9CF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wf9vrA1S
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c5126505cb3so821792466b.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644151; x=1796248951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QW3JKu4Ju6ecGBFAob3aGqdbz2w3ML2gPpvKS3+j6Wk=;
        b=Wf9vrA1SSEb8JDIv4oWKuMoOYS7KcRLWyEKpl0fVNNRPrwWAZ8Jza6FjBC5VqlYtnk
         MdRZcABuyQ4j4REg6p0O9D1ILMTKOGwmVUkbif6Ljjq6LFDphmnd/pF5QQOTc2x0iWCW
         RaYUKykjZp8fJYhyf5hCbNP1l6X3LBQPWBQ6Vwi/5ev6bnrEvqs4blwrBBX6VfsL5LFF
         4p3OFyHLbylMyAx8QF9UxRDsFFyU3rDPmRBLdfB6iy9kZ071iZ2s1B7L1UHKBTtLoiw2
         H8kA45cXXwF5NMn3Xkdl8AqIxD8TquXYoKWDG5fSZ3y2px06307yolXvkqrw24RO0uMY
         tSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644151; x=1796248951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QW3JKu4Ju6ecGBFAob3aGqdbz2w3ML2gPpvKS3+j6Wk=;
        b=m01wLJzwUAuRcjBBg2/GGs4Iabnyn37ug8eHkS5wDCj2dsNouKSKhe855D3h3rIvKM
         /NwORjI3ie/Y2kHcrdoJy+9O7Y6b0BTOfW57VvpEpQ0VVAI342kqL4htI9mSBU/eENMF
         q23pRVX7a9bg+JTPu7VAUT5Mz/KkaBgLGnW1AHkF86uBAiWBezJYEwxafOe/RvP8zgjd
         awFsIUkDXj9mlcTbNhjwHM7nuraAIGlCs8AWVF8/IwiznvSWaw18TzEqm5T4UTcovTed
         y/UOa5SKPT7pXDSZK5CZucOahZ5qCFEJ2wTCaXzWXRuPJc8d2GEDTHE9AMbesbSj5UQe
         Hvhg==
X-Gm-Message-State: APuU4Z8OoS6dHrQcz6mQXUy7oU465dXA7wc8aiE9DKmb1xQqvc/y/Qee
	YPO1vmEPKHHvk/8WXioEo2sF/3RsMts8WRFE86Xhu9ISeTq/8Pf8sR2EvP+y6H0F/sg=
X-Gm-Gg: AZFdTZfntCFD2r27s+DrmdnE1XbHxEDTa4kFzBV+F+LBOmpb7fXw35egTuiOFQWJr0z
	h0Bna8kQVUq62DmVost+1NYPXoAXrC6wlChEb7I/cOlV/FI5/YS/poErVIo+SJGDOqAIBzXJcM5
	UlkOMPZ1OS0B8JR0rTebEir8vFGUegfjV1mbXewbbAyONE5X+Q+Y1PXLdrJktkCdp4r9niYu+St
	UVyH0K1Mo/n3vBr3V0/vjTdorqOydDj8F8R1W/0jNH29L0h4+3a7noBQDHWRcfGjKWIP5lpdY8i
	AbTg/Axm+DdzWXn6rYNVWAvYh8b/JLagKGh8ODhz2ubxS8n0/un1yCMpzMWUeNCrfjZKE3ogJ5H
	G4cSI88AAvcz4psbdwAWvZrvh3OtMwcTC/LCt+HXVlu4/4Y8cRadz/E60G/L8iZaMF4o7FUNM24
	sUHiJyiMuc3yjTHJSq5ZvLXtA0sH25qYVGqG41J+ZNj6zRsRtxSZP2kUb8AiYAM7HgoDKnLCr4F
	g0IAydn1Vm3OWeaE6/bPaBAF74DN99n8K0BDyC5/sD01TsIJv3omHxOzki9A+Oxd7S9xepJPOqu
	kEjXIkzAZ5pbiI94eXyeszXDdhd4d0B/HsMVa0OORf3D8iD7d6zN65JVdB7ODUnmPPB7veSlyjh
	US6vZybcUZLj4yASCCuFDLwnttU5wdh31SHitZYS3pre7kjSqTjPXx5E+eZarnSjlNV6w3TzkQe
	ltCgaTJFuPuprYmfHFQF6GtGc7xHo2
X-Received: by 2002:a17:907:3f05:b0:c41:e0c0:e6b7 with SMTP id a640c23a62f3a-c513a99a69cmr1411445166b.12.1795644150684;
        Wed, 25 Nov 2026 14:02:30 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec3c60sm676998366b.50.2026.11.25.14.02.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 14:02:29 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v5 0/6] notes: start passing the repository through notes.[ch]
Date: Wed, 25 Nov 2026 23:02:08 +0100
Message-ID: <20261125220214.35881-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
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
 - adds notes_tree_or_default() for the shared NULL-tree check;
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
 - notes-cache.c: notes_cache_init() passes its repository through, but
   notes_cache_match_validity(), notes_cache_write(), notes_cache_get()
   and notes_cache_put() still use the_repository.

The previous round was labeled v2. It should have been v4, so this
reroll is v5.

Changes since v4:
 - Add notes_tree_or_default() and use it for the repeated NULL-tree
   check. copy_note() uses that helper for its new guard.
 - Document 'r' and 'flags' above notes_tree_init().
 - Explain in the reading patch why the converted helpers are safe
   when the tree is NULL. copy_note() was the exception.
 - List notes-cache.c with what is left for a future series.

Okhuomon Ajayi (6):
  notes: add notes_tree_or_default()
  notes: store the repository in struct notes_tree
  notes: use the tree's repository when reading notes
  notes: use the tree's repository when writing and pruning
  notes: pass the repository to the ref glob helpers
  notes: pass the repository to the combine_notes callbacks

 builtin/notes.c |   8 +-
 notes-cache.c   |   3 +-
 notes-utils.c   |   9 ++-
 notes.c         | 205 +++++++++++++++++++++++++++---------------------
 notes.h         |  44 +++++++----
 5 files changed, 159 insertions(+), 110 deletions(-)

Range-diff against v4:
-:  ---------- > 1:  c9891e887c notes: add notes_tree_or_default()
1:  5ad0f1bd62 ! 2:  831db4c68a notes: store the repository in struct notes_tree
    @@ notes.h: extern struct notes_tree {
       * This the first of the following to be defined:
       * 1. The '--ref' option to 'git notes', if given
     @@ notes.h: char *default_notes_ref(struct repository *repo);
    +  *
    +  * If you pass t == NULL, the default internal notes_tree will be initialized.
    +  *
    ++ * 'r' is the repository that this notes_tree belongs to.
    ++ *
    +  * The combine_notes function that is passed becomes the default combine_notes
    +  * function for the given notes_tree. If NULL is passed, the default
    +  * combine_notes function is combine_notes_concatenate().
    +  *
    ++ * 'flags' is a combination of the NOTES_INIT_* flags above.
    ++ *
       * Precondition: The notes_tree structure is zeroed (this can be achieved with
       * memset(t, 0, sizeof(struct notes_tree)))
       */
2:  1018419720 ! 3:  82f6f6ea7c notes: use the tree's repository when reading notes
    @@ Commit message
     
         Read them from t->repo, the repository stored on the tree.
     
    +    note_tree_find(), add_non_note() and load_subtree() do not check
    +    for a NULL tree themselves. add_note(), remove_note() and
    +    get_note() replace a NULL tree with the default notes tree and
    +    assert that it is initialized before those helpers run.
    +    format_note() does the same NULL swap, and initializes the tree
    +    if it is not already. load_subtree() is also reached when a
    +    lookup unpacks a subtree, which is still after that check.
    +    copy_note() is the one public function that does not do this;
    +    the next patch adds the guard.
    +
         Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
     
      ## notes.c ##
    @@ notes.c: static void load_subtree(struct notes_tree *t, struct leaf_node *subtre
      				     entry.mode, entry.oid.hash);
      		}
     @@ notes.c: int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
    - 	if (!t)
    - 		t = &default_notes_tree;
    - 	assert(t->initialized);
    + 	struct leaf_node l;
    + 
    + 	t = notes_tree_or_default(t);
     -	oidread(&l.key_oid, object_sha1, the_repository->hash_algo);
     -	oidclr(&l.val_oid, the_repository->hash_algo);
     +	oidread(&l.key_oid, object_sha1, t->repo->hash_algo);
3:  67a2942c09 ! 4:  b35eb50a45 notes: use the tree's repository when writing and pruning
    @@ Commit message
     
         copy_note() also writes through the tree, by calling add_note(),
         so it uses the tree's hash algorithm for its null object ID.
    +    It now takes a NULL tree the same way as the other entry points,
    +    through notes_tree_or_default(), before reading the tree's
    +    repository.
     
         Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
     
    @@ notes.c: int write_notes_tree(struct notes_tree *t, struct object_id *result)
     -	struct note_delete_list *l = NULL;
     +	struct prune_notes_data d = { 0 };
      
    - 	if (!t)
    - 		t = &default_notes_tree;
    - 	assert(t->initialized);
    + 	t = notes_tree_or_default(t);
      
     -	for_each_note(t, 0, prune_notes_helper, &l);
     +	d.repo = t->repo;
    @@ notes.c: int write_notes_tree(struct notes_tree *t, struct object_id *result)
      	}
      }
      
    +@@ notes.c: int copy_note(struct notes_tree *t,
    + 	      const struct object_id *from_obj, const struct object_id *to_obj,
    + 	      int force, combine_notes_fn combine_notes)
    + {
    +-	const struct object_id *note = get_note(t, from_obj);
    +-	const struct object_id *existing_note = get_note(t, to_obj);
    ++	const struct object_id *note;
    ++	const struct object_id *existing_note;
    ++
    ++	t = notes_tree_or_default(t);
    ++
    ++	note = get_note(t, from_obj);
    ++	existing_note = get_note(t, to_obj);
    + 
    + 	if (!force && existing_note)
    + 		return 1;
     @@ notes.c: int copy_note(struct notes_tree *t,
      	if (note)
      		return add_note(t, to_obj, note, combine_notes);
4:  7ea6c0e5a2 = 5:  dcda05343a notes: pass the repository to the ref glob helpers
5:  ff8cf4d22a = 6:  69928b58f6 notes: pass the repository to the combine_notes callbacks
-- 
2.56.0

