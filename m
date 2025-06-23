Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9AC3FB1B
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717927; cv=none; b=ZUa/79hjndgHLH2MGPL1HVpc+o1D2mIEYmWzVDolCVbP7bFe5eIfF1U0jXPRlZWxmHYfHVmIcwKcXfdVUwcRMdZYRSW4qShzjtT0xCG/BCRQpJPSiXtGA3Chm4CedbJaBzGJl6192qVIzT+DnJQq+KyDWFG3fQowc8qJsVg7Hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717927; c=relaxed/simple;
	bh=+nz6VDaKU2tI0D6baHXtJMYBJBdrMMoaMHXzN/tcLrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sG3cS+S1d5GzkwB5ElX0zglnmqJkoOJzCG8uZfsZnaUuT+0HvjPah1WjfSwvsyql2y28I2WG7E5ppWd9zb74koEcOsA6eS7OaaAhNvAbl5XwUy1UnIfSgi+ShNuZaGbaS4vmmkUm/B551uk2aF51DnBysC2ntCw2vz2PL8lXDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CwjvEuCr; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CwjvEuCr"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso3998985276.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750717925; x=1751322725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBe0j/4bpwdLf561fQNISG8odrCDioaR+oCSd+6c1vk=;
        b=CwjvEuCraRFBzzk+/ePw1r5fmrv3bl5x8uqZzNKk9yPUVkZWgFPb7gENHE5wpRSBca
         jNqpOHi2Z34szcQyDNY3CS36IAFVwFrOo53DiN/3ZMkLXAeiTV3K2PV8QsAq7qlI9ywZ
         E3WYFLIsBbsR8zkfELIJ/OjQMVYdHlC34WrHh/InZhtuR+EpXNj3qlOzg/ufnke2g4aI
         JDNjHnHbMW8bAhpHyJa5yqkpcTZ8sBFkKGM5JkpY46vy3mYWPguCgJ1FhzkaC4d1DEYN
         HSuGjfB8dLJxO5L+SD8RLvSbfpifP5DgZP5oqbmVSqGxD7bBXEO3tVgA/DVWPdsCLQNT
         I1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717925; x=1751322725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBe0j/4bpwdLf561fQNISG8odrCDioaR+oCSd+6c1vk=;
        b=rSl55lJRW1dw1XDXNffmZctuQHrixSzVbkrL8oEi37y9UptwiDAXM2mx+2AdL+Aug1
         UEYF5XMhIgCmllrmQZyZM4+ChJiz+6KnMY70uo+59xZ8br/D0pxQD2ufTC6K9BcgRgn1
         LszGu0bP0nViYcZ0/trhA4Hn6PshCuoEWaoWxuzf04AigLcHP6GLR2Ce50hk4vvo3CXL
         d+yvT/DFKwz8iuKvQmyHzVQEokMjoBvBZ/9DNCsutYK7bBNjwCe2jLZu1c6tyZNfY35M
         KrOD/gkcuKBW2LwoJ5wklKtiCISnG9Zw9mdtIT8BT2/FaqUl7N57a+d1EF4lOy/nLVPd
         khOw==
X-Gm-Message-State: AOJu0YxBC1VEkkyKx9sKUyToT4hoFrw/p5AA7tvTAVO3Y1zy7LVWeLjg
	/eXchhfBnAYrqPv1KMzKodppi1XESY+yeJvVlwpsGw0aoVa6QB7MDDaQvUypLjGN3JSbmWtBDo9
	0CIj0
X-Gm-Gg: ASbGncsVASsSUDT5CzkAsgBTtvaPmBBA9bWlVPlhyoUO4UCMi8BO7OsPEgU5fdnTh8b
	JcHFdTO+kt2ZSTEWwtxo4+0pBwDNkfkr1wDBGEa2HFaOEHEojveJbf3HBoaSMD6cp9cdxrdjvqO
	1WtDQFOX6+2+MhgwqDJEfI4F40+kZ6mPk569zczPvT9BVSay0PA2LT4UgSI0UjaoLTcII9vxL0C
	tpmEmhgQaR0MU6boljUmlC73Bm8VIL67R/26igWtKDECcXwZUFgln1mwRSo6YHp8Cvpp4Py3b8Y
	et5CHKq09/nkd2OppSoDFCxyA4yz0BsAUFOKu1HNGAfB7Rch/yW1LwrpkjUiTsJzs6GU5O3CUgu
	wQdJwU3ZRRTUHS30S/xzY3i7GIMB51wzl+Q==
X-Google-Smtp-Source: AGHT+IEcV+pNBeyXr+kM+xoGfTJGqu99Pllh3PKlAiZOz3ywm0rBhsfx5lZFf3OQlhZG0YGZulOaug==
X-Received: by 2002:a05:690c:3609:b0:712:36f3:f6d7 with SMTP id 00721157ae682-712c678be4dmr213365767b3.32.1750717924769;
        Mon, 23 Jun 2025 15:32:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c49b9ae2sm17660647b3.13.2025.06.23.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:32:04 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:32:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 0/9] repack: avoid MIDX'ing cruft pack(s) where possible
Message-ID: <cover.1750717921.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

Here is an additional reroll of my series to create MIDXs that do not
include a repository's cruft pack(s).

Nearly everything is identical between this version and the previous
(v5), with two exceptions:

 - Adjusted where to split a long line in show_object_pack_hint().

 - Fixed a test failure with GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL

Thanks for Junio and Peff (respectively) for pointing out each of the
above. As usual, a range-diff is attached for convenience.

Thanks in advance for any review :-).

Taylor Blau (9):
  pack-objects: use standard option incompatibility functions
  pack-objects: limit scope in 'add_object_entry_from_pack()'
  pack-objects: factor out handling '--stdin-packs'
  pack-objects: declare 'rev_info' for '--stdin-packs' earlier
  pack-objects: perform name-hash traversal for unpacked objects
  pack-objects: fix typo in 'show_object_pack_hint()'
  pack-objects: swap 'show_{object,commit}_pack_hint'
  pack-objects: introduce '--stdin-packs=follow'
  repack: exclude cruft pack(s) from the MIDX where possible

 Documentation/config/repack.adoc    |   7 +
 Documentation/git-pack-objects.adoc |  10 +-
 builtin/pack-objects.c              | 193 ++++++++++++++++++----------
 builtin/repack.c                    | 187 ++++++++++++++++++++++++---
 t/t5331-pack-objects-stdin.sh       | 122 +++++++++++++++++-
 t/t7704-repack-cruft.sh             | 145 +++++++++++++++++++++
 6 files changed, 573 insertions(+), 91 deletions(-)

Range-diff against v5:
 1:  19fab7a35c =  1:  8e7b2dacc7 pack-objects: use standard option incompatibility functions
 2:  6f2d3f17a4 =  2:  86fb36d317 pack-objects: limit scope in 'add_object_entry_from_pack()'
 3:  c06f5b264a =  3:  19e8c789e9 pack-objects: factor out handling '--stdin-packs'
 4:  40d7d87cb1 =  4:  c9f874eb94 pack-objects: declare 'rev_info' for '--stdin-packs' earlier
 5:  5e2599436c =  5:  6b0149a32d pack-objects: perform name-hash traversal for unpacked objects
 6:  3a5c3f63d8 =  6:  f31dd00a98 pack-objects: fix typo in 'show_object_pack_hint()'
 7:  796e8743f8 =  7:  5d15055985 pack-objects: swap 'show_{object,commit}_pack_hint'
 8:  8830775beb !  8:  3699c25337 pack-objects: introduce '--stdin-packs=follow'
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
     -		return;
     +	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
     +	if (mode == STDIN_PACKS_MODE_FOLLOW) {
    -+		if (object->type == OBJ_BLOB && !has_object(the_repository,
    -+							    &object->oid, 0))
    ++		if (object->type == OBJ_BLOB &&
    ++		    !has_object(the_repository, &object->oid, 0))
     +			return;
     +		add_object_entry(&object->oid, object->type, name, 0);
     +	} else {
 9:  8f505179cc !  9:  f519777059 repack: exclude cruft pack(s) from the MIDX where possible
    @@ builtin/repack.c: int cmd_repack(int argc,
      	string_list_sort(&names);
      
     +	if (get_local_multi_pack_index(the_repository)) {
    -+		uint32_t i;
     +		struct multi_pack_index *m =
     +			get_local_multi_pack_index(the_repository);
     +
    -+		ALLOC_ARRAY(midx_pack_names, m->num_packs);
    -+		for (i = 0; i < m->num_packs; i++)
    -+			midx_pack_names[midx_pack_names_nr++] = xstrdup(m->pack_names[i]);
    ++		ALLOC_ARRAY(midx_pack_names,
    ++			    m->num_packs + m->num_packs_in_base);
    ++
    ++		for (; m; m = m->base_midx)
    ++			for (uint32_t i = 0; i < m->num_packs; i++)
    ++				midx_pack_names[midx_pack_names_nr++] =
    ++					xstrdup(m->pack_names[i]);
     +	}
     +
      	close_object_store(the_repository->objects);

base-commit: f9aa0eedb37eb94d9d3711ef0d565fd7cb3b6148
-- 
2.50.0.61.g1981e40f2d
