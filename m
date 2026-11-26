Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728800;
	b=W3raTXyFSdgGilgEDDkKdcAqayAVOznM2sO+JZxhSU6KATB6pGqWEm7LmA9ktoZ9DeJt
	 UEVB0WUqKW0KLetOjVhWKpTqTWWYTho9ryMNb38O1UXweKFzQWwAIF0L4+6BiG/Nsl5yH
	 sMisCv7qwLvXTot9b1M9cklM9HK/4bqHbdvgQRqqolXHKD/ZNwDcPn4c+BfPGTtl05/Qn
	 T2nPJX1AcEybjrAMTqGlL70jb2Kl+X7XsqczgLAzfuXWDFN6B3rK6hKDmfj+nzhHMCdCs
	 F+vwjVXXVCbZHtYTkFN/HKPesQRIPwtFbuSLySohcGOgKFuqSV4aspKoiCCV3UtZQrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R6KGvWimpyZqckW3VKT3ylftiCilONyRwvFCUvHVgPo=;
	b=txKjpV5+3d9LSRD4oe0K5JmHmI3JpnysK6JLqbMMz+81CVoDZoyeeTxD5a5Fuc97hAnq
	 3TGy76Se9rEImySp2U7/3E1AVraioLeB/MNv07pmdHGvIBKyAO6L6lVDZWVPyT21/+n+z
	 f3HC99MTF8KVPKd/85DMe+LpuJ4KkHJD7D9kDK/yMZ9W5+m+lSqWDpHO9P+iCLoHOpPaK
	 pB+W7lCZ6/k/5FcXpHh8uAylCCi1fF7It+wCYdera3ejpEr30jT9q3Cn+vhbMx3pLFjDW
	 EQN5J9xHw4D4Jn/Gswtc7QYgGqM/dTPnGS5blhffHhLGMXwzu8Q0rZWIDoyb+a6b7Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+E4hk3M;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE82606A32E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE82606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+E4hk3M
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c51c294cef6so124098066b.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795728798; x=1796333598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6KGvWimpyZqckW3VKT3ylftiCilONyRwvFCUvHVgPo=;
        b=u+E4hk3MXZ7JV9HVsON2wTDXyr+ckHdyvoFCwQ+QFgd5UCMo+ve54m5xiTXB7qGzlU
         DzOzxRG+WuDNtwe6NpzuSCbPw+KnS4zf87NiyKXuMmcuhGnAA2ARDurvqAoL+WlqEQon
         oIhGBhxhUltewZifXWL9RgKRzr6nh5cQ7EEzIOGOXyVeuWyKHR1wNath78I1orS78u48
         Ow9fGpJCYMh7vEF4wrMAcc74lduVjKiq9s8OghmheSs1Mo8O1p3hnWNck35njrEJDTad
         wXNDkWomwo1v1Tyj+AOwMtTbvH5AW1F0SR022IJigsEPeXa+P2P2LrIUMXPZHIhBoHws
         90KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728798; x=1796333598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R6KGvWimpyZqckW3VKT3ylftiCilONyRwvFCUvHVgPo=;
        b=M91lvU0rNakmkdFT/uSjeLSZQYRE8fnVi/pKD+8oBz0lthK/IEReD+++EaPlh8aXTD
         pYlAhMd8GVNjQXCLXynKRHPlbcn0NwSyUqpXq8Udx8c+5Z1KsV9g/dd4+dv1URrCFats
         XMAIFzFvT+OnthMPfTXKbO87gV7z461PrdgdAiQ9Unzm6m1VpXuyN4dvICZKCndefLtP
         TxzL+/AuH+m5IbKxTgh2NNXHsEGBBVXYzMDLzlVZ8mmIyAT69BofjG9MOsTq/3chzSL2
         QlcddL8WTuKMVSpRCt6zSU0THqqNKgzgUZPMvCC+WushYVXX1LB/r/bqXXqGK+Jt2FVO
         PBAg==
X-Gm-Message-State: APuU4Z85Qmz+9RLMeYcIkhM+cpefwtNvcGJsouILZQTLDWawgWVEK2gT
	xV+KxOgyxBf1R7cPiG86OXfud4OUUraT/yXXeoSo508134pBmaAjMiMtaISn3du2N0udSg==
X-Gm-Gg: AZFdTZd2pyml4V2y4A+QsBBuLdz8taKuOefwiwkw9GzdXi71wjlGiOcOpch9HW9ukrN
	xmeIl9CDHh78Ec8W6uhkd0XAvzuyJEmrjJlOMu7ZjafU9Ccj/Mc5a1TkCwDGSr/It+YZkefCyp/
	ybMEBVqrtPNfzbCmzFiSHYvtmzUQ1cC4MTtI2vCruk8xRE8tBpmMkqkL9LneNgwliUO34sOJ1up
	fniP6d2wYiYKWa9DZTXOtM+hxLUM0TubHQs2+SaF1XdBN7LGwB07yMErNj0etkWmE4Vj1JheXe/
	V49KZfdv+7OChIOHIuZzJbpq7gNkueROVpeTkFylI8ecgO9LiVo4UuzNEdtCZXvKqD79rXc7qNH
	2HK83aAah3OEev9Dxz91szmrmCjsKhUbc44LDlkGZ1MS+8mLtxLTfOAAddbALOhijQ87iG3xWob
	u9hg6SeKTUAAVonQyrjULO0RoZC5OxzXrwlQuMI6b1G4JQQlF3JmmtOoWUbDu/c6OHsA5ezG5uY
	xfC/xqYZiB2qW2124WgeLjVft+RvsRsz81I1U5aoreMh/ZEpyJGPHjil8d917OUVZtQwaOpN8uY
	jNHbLZqoofqkUCnTjJ4qjTkIUqsgfkFEo7JaHVFj9lkPH28L117ECt+lAJpP8HraOoqq5YGAUB1
	M3U6eCzbtcSQ++ni06CyO6VJHEg2EhXuF5fjUMxgKoyXbwLkcKQe0bxMyHV1IwMyjwNFhwrshhs
	Y/6HOztCrjN9x3PRiopWWIEUMn8LPK
X-Received: by 2002:a17:907:d489:b0:c51:b953:d5ab with SMTP id a640c23a62f3a-c51b953d709mr470427266b.5.1795728798113;
        Thu, 26 Nov 2026 13:33:18 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm805237066b.86.2026.11.26.13.33.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 13:33:17 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v6 0/6] notes: start passing the repository through notes.[ch]
Date: Thu, 26 Nov 2026 22:33:00 +0100
Message-ID: <20261126213306.87466-1-okhuomonajayi54@gmail.com>
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

Changes since v5:
 - Rewrite the reading patch's log message to give the wider picture
   first (the '.repo' member, the NULL-tree contract, and the entry
   points vs. the leaf helpers) rather than listing functions, per
   review.
 - Fix the helper patch's log message to call the function init_notes()
   at that step; the rename to notes_tree_init() lands in the next patch.
 - Note the KEY_INDEX and SUBTREE_SHA1_PREFIXCMP macros under what is
   left for a future series.

Changes since v4:
 - Add notes_tree_or_default() and use it for the repeated NULL-tree
   check. copy_note() uses that helper for its new guard.
 - Document 'r' and 'flags' above notes_tree_init().
 - Explain in the reading patch why the converted helpers are safe when
   the tree is NULL. copy_note() was the exception.
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

Range-diff against v5:
1:  c9891e887c ! 1:  1d17c6b7db notes: add notes_tree_or_default()
    @@ Commit message
         means the default notes tree, and the tree must already be
         initialized.
     
    -    Use one helper for that check. notes_tree_init() asserts that
    -    the tree is not yet initialized, free_notes() only frees what is
    -    there, and format_note() initializes the tree when it is not, so
    -    those three keep their own checks.
    +    Use one helper for that check. init_notes() asserts that the tree is
    +    not yet initialized, free_notes() only frees what is there, and
    +    format_note() initializes the tree when it is not, so those three keep
    +    their own checks.
     
         Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
     
2:  831db4c68a = 2:  124381fdcc notes: store the repository in struct notes_tree
3:  82f6f6ea7c ! 3:  93afb08fb9 notes: use the tree's repository when reading notes
    @@ Metadata
      ## Commit message ##
         notes: use the tree's repository when reading notes
     
    -    note_tree_find(), add_non_note(), load_subtree(), remove_note()
    -    and format_note() already have the notes tree, but still read
    -    objects and hash algorithms from the_repository.
    +    In the previous step we added a '.repo' member to struct notes_tree
    +    so a notes tree records which repository it belongs to. Notes trees
    +    are passed down many call chains, but functions like note_tree_find()
    +    still read objects and hash algorithms from the_repository.
     
    -    Read them from t->repo, the repository stored on the tree.
    +    There is a catch in the notes API's NULL contract. Passing NULL in
    +    place of a notes tree is allowed and means "use the default notes
    +    tree", so a 't' handed around a call chain may be NULL and 't->repo'
    +    cannot be dereferenced blindly. The high-level entry points cope with
    +    this: add_note(), remove_note() and get_note() replace a NULL 't'
    +    with the default notes tree via notes_tree_or_default() on entry, so
    +    afterwards 't->repo' is safe. The internal format_note() does the
    +    same swap and initializes the tree if needed. The leaf helpers
    +    note_tree_find(), add_non_note() and load_subtree() do not check for
    +    NULL themselves; they rely on being reached only through those entry
    +    points (get_note() -> note_tree_find(), and note_tree_search() lazily
    +    unpacking a subtree through load_subtree(), still after the tree has
    +    been resolved).
     
    -    note_tree_find(), add_non_note() and load_subtree() do not check
    -    for a NULL tree themselves. add_note(), remove_note() and
    -    get_note() replace a NULL tree with the default notes tree and
    -    assert that it is initialized before those helpers run.
    -    format_note() does the same NULL swap, and initializes the tree
    -    if it is not already. load_subtree() is also reached when a
    -    lookup unpacks a subtree, which is still after that check.
    -    copy_note() is the one public function that does not do this;
    -    the next patch adds the guard.
    +    Given those guarantees, read objects and hash algorithms from t->repo
    +    instead of the_repository in note_tree_find(), add_non_note(),
    +    load_subtree(), remove_note() and format_note().
    +
    +    copy_note() also takes a notes tree but does not resolve NULL before
    +    using it, so a mechanical the_repository -> t->repo replacement there
    +    would be unsafe; it is handled in the next patch.
     
         Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
     
4:  b35eb50a45 = 4:  1cea119abf notes: use the tree's repository when writing and pruning
5:  dcda05343a = 5:  1d2ecbe2a5 notes: pass the repository to the ref glob helpers
6:  69928b58f6 = 6:  8b59b9ba01 notes: pass the repository to the combine_notes callbacks
-- 
2.56.0

