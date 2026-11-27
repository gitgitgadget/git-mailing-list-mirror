Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817102;
	b=K97VH4TEYcW3MJcYEpG+7oTzCAdMfFtJvVtOeTUHUjhTYJwfDBjREND4+jKhGqL4kdh2
	 20+64LPhQiss8NwhDlu79gbdQWPJlFMKAd/FLEWQxwLSXnniIfrgycKvKPTZrCl5ykk5Q
	 3+e19mONNiI/mLK9y1zEJ84wdsMW5Eq27oGEbQtmMssmvpnWoxtRtarTm+DGVjwHJ46dn
	 PdjTk7/uYs+L0ki0zJHepoUumF5U7jnN3OwacNccavEawU1kCHfuckaxUly/Le0Q+GVEG
	 LJAt8DqLVSaCXC6qha6YmltlwUsn5udYkbLXKQP3R85YprXh7GHTYMzqdQk1dPVQYBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aWA6rugWTa1Abbj6YG4x9LNpOTs7X/JHD40B7NJ2RYY=;
	b=1P/X1M6lyxWEbGeuyCji9egeZSh8WMFh3272FLEzOPF7g6+22T678q+POX/su0I2oJ+H
	 XNbqme2nzkGLYyvqhYUjXvoJeRHvs6iu6KOuzorxnM5QLbkH1t/uZJLi2Os0+otfMRHKZ
	 90w97FHWT28/Y65VdDc/8Nlzq/uqo740xrSRik8Vn2/+1Kv0QjaesYMHNj0c5nA7Zs0pr
	 WulEIFrZdg3vi1z6YTGgnQM5TmtUkgl36aO6v5qN+c2879sWmHmDmg48wwLQ6dywLY/9K
	 C0sBbQLQcIEtW8D873TqjbzGO2nklujZVlhOjQu3f0L7pc4nF1OC0iUjo2Sq1a/o8bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="icK/g5Iz";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D6606A323
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 300D6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=icK/g5Iz
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so7776247f8f.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795817100; x=1796421900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWA6rugWTa1Abbj6YG4x9LNpOTs7X/JHD40B7NJ2RYY=;
        b=icK/g5IzXiS80Y1kf1QwAuAkZMnX6SomjKcMJ8Fag7luGXgcy5MV5mmUybsnH05WzV
         Tk/amVtfbS/5yYAZgm43MhEkegJpPRRmcYo9Ful21UiHDfok4uR5ivRckJGwSnjJ7EQw
         7pecY8DUeghuPbOD4UySXTzaaWDDCA3groHld25PZdKW1ikLB4zWGwUf23l8glNACCnn
         jJzYs6XgH6552qcr32VZa6ujD8S57TRnkMvXX83pFN3ya+JUMCYNKHSki+SKnCmlj9wv
         cEGPqXVq5Gapgnez+/omeQUTPDgJmoWjCu+YNEsaXPmVObYXmy+TG83GQM8yfMxnrHsZ
         vgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795817100; x=1796421900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWA6rugWTa1Abbj6YG4x9LNpOTs7X/JHD40B7NJ2RYY=;
        b=xrKNfLmVjlLMqG2WjatM8R9NFERw+dBsW67SMoHRc6U3hbPPQs6Zq0q33AA6+D/iFa
         jXDxWy2k1SRHSYqDSttVH690WjRGOiFndGugO5MEg4vcnvI2/RZih5xgpL2NOsMJ6Frr
         1vLtDQtG6b/TCi10gOo/WEMrfnUnOZ4HaeDu+47voixq6f2G5G/cd7C5aBDetSN2D6ft
         7IZKELiTW7wRe/XG42Mau6Kci34r8Uei89qKTTPNSzoi8rcYMylEHWhUu91CLDkD6vJs
         0ZCgUxWmBHQMJper1qjDdwB99SOePKdBMVNn3NwKJKJcKapcM+TW1XmEM4d32VfmcF1V
         klSw==
X-Gm-Message-State: APuU4Z8NH8GoYpSz19rOQIT55KGfBM+cyiOvY56czriZZJLSlgJnACn5
	opP88YmQgmL6Pz8E3mfl59w4DGczAqWtYmjSvPUMlv/1I05ioczGKeXGjrcu0DyVKH8=
X-Gm-Gg: AZFdTZc6cKMSYunHsdfEbGUL/aszkmzD2ZU3wp3a9ICZZTWPqUbzoq6q7sI45u6ndsd
	sLi73vvi147IMGKaE2kUJaEnkRKh91P7MLfLX8zFFWnY813T+P9FFUayUBv/jTJSBd3VgVj4BX1
	ZrTn/4N7FPEOqSn5mvhlUYVdczpmp4Ka7Al9S45G/GSgQBmNPPx6jijljdNgB/y5ZnhAG3/j/ZZ
	c/WVYPeF2UFhhUaWZ4b9CxQ89ZNcWcLVcwwBJxdzbfXLEdlUMASQR/YBTuvf5dIZi/gNH/qzJf/
	rOtLtnRpgr1FlsJgE3zjyVeOFiDT5q6YYw5fMI0WDUcmg3AgOtBIBkWm8GfiUJhcFUP6dE0oI4v
	S5YHyHCsIcLtxwCVhQj/WhfozcDyG8FhNY1TKSnJYmjq8pYlArhfBpxWUO35zFRP6it9k6S+mtL
	Zlm5oDAB7c51ioxvyKa96YFGV+7mMRPQHL+1rpnn9382J9TL0YQo8CcfbKQIYCnqCpgJGwd1lal
	mXcFwZFmbZzdw/ZgAuPlQdnlJQsZISEYbTzu4CtN+6khTXxYQzNEYpAtO0kSXXQ9XIT/hLJ4wQv
	6v45JU2scB3QTzhn9cnE77V7kenuHT3Lb9Ula2fL/naZDEhWXHqcFcXDjMyk2bRargxKEEHD5tp
	C1Yy2sBQNmHfZHxvJhTw3wikwTFsAoOZuYtuD/ZAa1USxUV9F86vssQ+rJX+EbZwO8VdeZeAQ61
	tE6JSZ9DfHjkQJW4QSNCE6D//k9Jfx2g==
X-Received: by 2002:a05:6000:4b15:b0:48d:df08:307c with SMTP id ffacd0b85a97d-4abb8ac0d92mr44673843f8f.44.1795817100287;
        Fri, 27 Nov 2026 14:05:00 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm51467422f8f.8.2026.11.27.14.04.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 14:04:59 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v7 0/6] notes: start passing the repository through notes.[ch]
Date: Fri, 27 Nov 2026 23:04:39 +0100
Message-ID: <20261127220445.45639-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126213306.87466-1-okhuomonajayi54@gmail.com>
References: <20261126213306.87466-1-okhuomonajayi54@gmail.com>
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
   The hash-size helpers are also still on the global, and the KEY_INDEX
   and SUBTREE_SHA1_PREFIXCMP macros in load_subtree() still derive their
   byte offset from the_hash_algo, so they need to move together with
   those helpers before a notes tree can mix hash algorithms.
 - notes-utils.[c,h]: still use the_repository. And the hash-size helpers
   still on the global are reached from here, through create_notes_commit()
   -> write_notes_tree(), so converting notes-utils is tied to converting
   those helpers too.
 - notes-merge.[c,h]: still work on the global repository.
 - notes-cache.c: notes_cache_init() passes its repository through, but
   notes_cache_match_validity(), notes_cache_write(), notes_cache_get()
   and notes_cache_put() still use the_repository.

Changes since v6:
 - Reword the reading patch's (3/6) log message, per review: describe the
   notes_tree_or_default() helper that an earlier patch introduced more
   directly, and mark the get_note() -> note_tree_find() call chain as an
   example.

Changes since v5:
 - Rewrite the reading patch's log message to give the wider picture
   first (the '.repo' member, the NULL-tree contract, and the entry
   points vs. the leaf helpers) rather than listing functions, per
   review.
 - Fix the helper patch's log message to call the function init_notes()
   at that step; the rename to notes_tree_init() lands in the next patch.
 - Note the KEY_INDEX and SUBTREE_SHA1_PREFIXCMP macros under what is
   left for a future series.

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

Range-diff against v6:
1:  1d17c6b7db = 1:  1d17c6b7db notes: add notes_tree_or_default()
2:  124381fdcc = 2:  124381fdcc notes: store the repository in struct notes_tree
3:  93afb08fb9 ! 3:  0dfe9934ce notes: use the tree's repository when reading notes
    @@ Commit message
         There is a catch in the notes API's NULL contract. Passing NULL in
         place of a notes tree is allowed and means "use the default notes
         tree", so a 't' handed around a call chain may be NULL and 't->repo'
    -    cannot be dereferenced blindly. The high-level entry points cope with
    -    this: add_note(), remove_note() and get_note() replace a NULL 't'
    -    with the default notes tree via notes_tree_or_default() on entry, so
    -    afterwards 't->repo' is safe. The internal format_note() does the
    -    same swap and initializes the tree if needed. The leaf helpers
    +    cannot be dereferenced blindly. A previous commit introduced a
    +    notes_tree_or_default() helper to cope with this, and ensured all the
    +    high-level entry points (except copy_note(), see below), as well as
    +    the internal format_note(), call this helper. The leaf helpers
         note_tree_find(), add_non_note() and load_subtree() do not check for
         NULL themselves; they rely on being reached only through those entry
    -    points (get_note() -> note_tree_find(), and note_tree_search() lazily
    -    unpacking a subtree through load_subtree(), still after the tree has
    -    been resolved).
    +    points (for example get_note() -> note_tree_find(), and
    +    note_tree_search() lazily unpacking a subtree through load_subtree(),
    +    still after the tree has been resolved).
     
         Given those guarantees, read objects and hash algorithms from t->repo
         instead of the_repository in note_tree_find(), add_non_note(),
4:  1cea119abf = 4:  494e142cf8 notes: use the tree's repository when writing and pruning
5:  1d2ecbe2a5 = 5:  2e38f08ca5 notes: pass the repository to the ref glob helpers
6:  8b59b9ba01 = 6:  30e785c788 notes: pass the repository to the combine_notes callbacks
-- 
2.56.0

