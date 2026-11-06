Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000871;
	b=nEgX7NJ0fOzTcQ4F+fFNCgHLCE3QuZcjr2h4btGL8CGb81obi0JRUiKo1Z8Ubilm3x59
	 6pJfQXYr8DdaJkirF/HSaJc42FphBuwYxflx2TqK81m7MOv29bvsRP6Ay/M2I9HoTyyQJ
	 XXhvRvdraOK5lb/EOX+1hz+VpcH4ZsIMDMC/YWNb9R/HcBMGG2PyPUJI9SPSbFcAt88Sb
	 Zh2yhTCeDbtqO/00siIKavXvAJCV1UZE4tTqKGqbwuN2o/mWxOSuA2BRq+LnNM7DCKAMF
	 x0mbd65alAJIPH/7Nwj8FbjNtYeN5Qil11yJ3TxqRKD/9QPYtfBdNNJeNHLTwjczfJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ad4vtiBJgPeZ8vJbK8ZifLX3NdcD0k/y7TtPZgEyWms=;
	b=cg+F0oaeIRiOWS0dzOVpvp20OJbzaWroKDrVcOMkYchmO+5LOGYNZO0AeRn+yyU2vyzi
	 HJN/fnz/5qrekB+/Td10a8F0/r+01dojIfAoTN45Whk1NIOaFGBwA7PKN4xmf4Xoi7J8L
	 jF9LI3QWhOoFaKw8bpzm77TrT/BYfflABgLRkCsmV/Wro/PeYRN8hFgJT8Jw3nejuwLNW
	 dHADgPQgZP0Jc3K/+mtDHFrQjrkjJ9BkUL5tbmKIG8npUm6Bz+wug9dI7brB6FnK7w2FT
	 6emIYmnmG8fLr2jqmsI9JCoiYcRs+FDjbOVwNiMxNA5sGxu7N2F4Q9ZpkE2cTM2YV3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ycAZs/1z";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A9606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F1A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ycAZs/1z
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so8515535e9.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 13:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000870; x=1794605670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ad4vtiBJgPeZ8vJbK8ZifLX3NdcD0k/y7TtPZgEyWms=;
        b=ycAZs/1zolyhRGiXSC7/iziJyKg2AGx8VgKc2rOSAxg3shtZK8gaUajfymNpFRtPLs
         R6xDv0aN8u0U9nwejGI+fGk8RdbchykSONJLwTWuYBLZWN1Vwm21TL1TE5Ebs3iRXydq
         sHIS0Kl2trdHKu3xAwV3tKjoyQ57znqj8J+nVGKOURSMuw4oZnU5tnZPqiMVVe/zRtrB
         rqZCA+Pq6hMLOMSBmunHCUhXEMt3fHJGpojLR/Pr6W/WeA297LpzQjGWrWdRxajYgE9d
         k+M0HpT0bnDgQFsGeg8UxzMAtf3Zqmio8McwXz7kq6n5Se/38JvXitVZlzymdI+QU9VF
         ed1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000870; x=1794605670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ad4vtiBJgPeZ8vJbK8ZifLX3NdcD0k/y7TtPZgEyWms=;
        b=e6kDX5VFZ7+rn1fIwOALDouXnCUH6T1B8AEQnOQVSVJwCVBYRuAd4XjQQYLfYwznaW
         tcHOn76LANsXOfNv+6pLioq6MnsZyjBX+zEEHVL9g7mUvEINz7TMLy3kSZLzcF/zq9ET
         E9R9Y1j9Cu7cYBOhYAY/q0tutyvpyv2/FkD2+LJ8K/hfvyfYvi2o9BYpiBQcyrFnUa3A
         ABoop3YFEvGpTWpfF8PI2Kw5K9hVcN0pofO6Fchgv1GGmt8e7D6zCLLWPvY5DlNABiPK
         +USahFRTErhDpPzSxkQVKiVkk9cY04U9Ns77DlwVTcO2qs6JYc1vAkIe6m7n9mmLdxJv
         4hqw==
X-Gm-Message-State: APuU4Z+v+0IqWmjOd3TMk2ivJiJw8IhWIjA55w6R/+pQPqorS6zvkzYW
	2c+nEdK9EvfK5eLFCrMpD2aQiMuw/B+9S57NUGTMi/qJKd7QspxlLcNCV54pK/H+
X-Gm-Gg: AYBFou0oUg/X++74vnSUheuSJb1gGBbQK7TaJXcj8ZQYg4rfHyhKc02ec3sMVE0fhXj
	9l7dj61FwDnFQDENk4jJUDh1iAH6T9PsXO3czvJ5wYnlBmqB8s1NMKHXzE7ukcE+mbZwIggnfyH
	J1BvR/xOyLs5cDcZMGDNsbxBlZBZbU/MjUTcX2luwkLuvXxhuPGRjQsjNBC6GoyoVcoQkWVMv8U
	g/aD2veZ6r+mJ0g8+5Wz3wiugLZyJdfgGtnclNldq45KSbAqMifxnlF00U3HFAtEmXuWOqHLuB4
	g9gtuddLAK9VRv8vR0dqHj7WANhQPD0pu2m+7PPca912tA4PpFxhX1lqe3Vh5PtZrRDn6DbPzNC
	NnrdaESiKw68oi0cpoA7EUBBEiTUQgAoEIcTWGDXRARAqHJLXNe0VIGu3O0vk3Au4ugJgTgnOw4
	dZ2hLwvjo4M3etL2DgzA1LwI/AQGH8+nPsK7rDj+W/dRqD9Hbdxx71NYE/TeWawz+7VsliIK6nc
	9y1UfY+0Vg9Ix/u2zZQAYUp+nDqNV2BD3y/7bHkJAIn5xrRhG5IwdW/Mecu9xc3htZ0YmDe+x5x
	Ig5iXN8roX6qG29ID/bXsRA1n3y98vqdIYV2NYIjVbGXom8NPIcgRaODisqYpzMQ6WROaBdvU25
	o3uj/N4r2RA4o2rtKN2G06gs=
X-Received: by 2002:a05:600c:c4a4:b0:4a1:f736:79f3 with SMTP id 5b1f17b1804b1-4b6de4a7678mr60361995e9.5.1794000869487;
        Fri, 06 Nov 2026 13:34:29 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3271867sm9994385e9.6.2026.11.06.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:34:28 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 0/5] root refs vs pseudorefs
Date: Fri,  6 Nov 2026 21:31:03 +0000
Message-ID: <cover.1794000450.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
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

Changes in v3:
- Explain the additional semantics of pseudorefs in the glossary.
- Clarify the FETCH_HEAD and MERGE_HEAD descriptions.
- Point gitdatamodel(7) to the glossary for root refs and pseudorefs.
- Reword messages of commits 1 and 2.

Andy Koppe (5):
  doc: glossary: add root ref and clarify pseudorefs
  doc: glossary: update per-worktree refs
  doc: stop calling root refs pseudorefs
  refs: stop calling root refs pseudorefs
  t: stop calling root refs pseudorefs

 Documentation/config/core.adoc                |   2 +-
 Documentation/for-each-ref-options.adoc       |   2 +-
 Documentation/git-ls-remote.adoc              |   4 +-
 Documentation/git-update-ref.adoc             |  13 +--
 Documentation/git-worktree.adoc               |  13 ++-
 Documentation/gitdatamodel.adoc               |  21 +++-
 Documentation/glossary-content.adoc           | 109 +++++++++++-------
 Documentation/rev-list-options.adoc           |   4 +-
 builtin/for-each-ref.c                        |   2 +-
 contrib/completion/git-completion.bash        |   7 +-
 refs.h                                        |  13 +--
 revision.c                                    |   2 +-
 t/show-ref-exists-tests.sh                    |   4 +-
 t/t0600-reffiles-backend.sh                   |   2 +-
 t/t0610-reftable-basics.sh                    |   2 +-
 t/t1400-update-ref.sh                         |  66 +++++------
 t/t1403-show-ref.sh                           |   2 +-
 t/t1460-refs-migrate.sh                       |   4 +-
 t/t4013-diff-various.sh                       |   6 +-
 ...iff.diff-tree_--cc_--summary_REVERSE_HEAD} |   2 +-
 t/t6302-for-each-ref-filter.sh                |   4 +-
 t/t9902-completion.sh                         |   4 +-
 22 files changed, 167 insertions(+), 121 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--summary_REVERSE => diff.diff-tree_--cc_--summary_REVERSE_HEAD} (73%)

Range-diff against v2:
1:  c52fbbd369 ! 1:  5630c671db doc: glossary: add root ref and clarify pseudorefs
    @@ Commit message
         not actually name them "root refs", even though the term is used
         elsewhere, for example by "git for-each-ref --include-root-refs". It
         also defines pseudorefs as refs, yet is_root_ref() deliberately excludes
    -    them, as they are not stored or handled by the ref backends.
    +    them, as they are not stored or handled by the ref backend.
     
         Add a "root ref" entry, moving the naming rules and the list of
         irregular root refs there from the "ref" entry. State that pseudorefs
         are not root refs, and refer to gitrevisions(7) for descriptions of
         commonly used root refs and pseudorefs.
     
    -    Reword the "pseudoref" entry so that it no longer calls them refs, add
    -    git-for-each-ref(1) as another example of how they are not proper refs,
    -    and explain that using a pseudoref containing multiple object IDs yields
    -    the first one.
    +    Reword the "pseudoref" entry so that it no longer calls them refs, and
    +    explain how their additional semantics set them apart. Clarify what
    +    FETCH_HEAD records and what its "fetch status" annotation means, and
    +    that MERGE_HEAD is also written by git-pull(1) and not only for merge
    +    conflicts.
     
         Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
     
    @@ Documentation/glossary-content.adoc: exclude;;
     -	read via normal Git commands, but cannot be written to by commands like
     -	linkgit:git-update-ref[1].
     +	A name that can be used like a <<def_ref,ref>> to refer to an
    -+	<<def_object,object>>, but that is not stored in the same way as refs.
    -+	For example, pseudorefs can be passed to linkgit:git-log[1] or
    -+	linkgit:git-diff[1], but they cannot be written by
    -+	linkgit:git-update-ref[1] or listed by linkgit:git-for-each-ref[1].
    ++	<<def_object,object>>, but that has additional semantics: it can
    ++	record more than one object ID and may carry extra metadata. In
    ++	contrast to <<def_root_ref,root refs>>, pseudorefs are therefore
    ++	not stored or handled by the ref backend.
    +++
    ++Pseudorefs can be passed to commands such as linkgit:git-log[1] or
    ++linkgit:git-diff[1], but cannot be written by linkgit:git-update-ref[1]
    ++or listed by linkgit:git-for-each-ref[1]. When a pseudoref contains more
    ++than one object ID, using it to refer to an object yields the first one.
      +
      The following pseudorefs are known to Git:
    --
     ++
    -+--
    -  - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pull[1]. It
    -    may refer to multiple object IDs. Each object ID is annotated with metadata
    -    indicating where it was fetched from and its fetch status.
    ++ - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pull[1]
    ++   to record the objects that have been fetched. Each object is annotated
    ++   with the ref and repository it was fetched from and whether it is to be
    ++   merged when pulling.
      
    -  - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
    -    conflicts. It contains all commit IDs which are being merged.
    -+--
    -++
    -+When a pseudoref contains more than one object ID, using it to refer to an
    -+object yields the first one.
    +- - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pull[1]. It
    +-   may refer to multiple object IDs. Each object ID is annotated with metadata
    +-   indicating where it was fetched from and its fetch status.
    +-
    +- - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
    +-   conflicts. It contains all commit IDs which are being merged.
    ++ - `MERGE_HEAD` is written by linkgit:git-merge[1] or linkgit:git-pull[1]
    ++   to record the commits being merged while a merge is in progress.
      
      [[def_pull]]pull::
      	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
2:  9e1ddc997c ! 2:  0bc902f13d doc: glossary: update per-worktree refs
    @@ Metadata
      ## Commit message ##
         doc: glossary: update per-worktree refs
     
    -    The "per-worktree ref" entry says that these are only HEAD and refs
    -    under "refs/bisect/", but that has been out of date since a9be29c981
    -    (sequencer: make refs generated by the `label` command worktree-local,
    -    2018-04-25). All root refs are per-worktree, as are refs under
    -    "refs/worktree/" and "refs/rewritten/". Pseudorefs are specific to each
    -    worktree too.
    +    The "per-worktree ref" entry says that only HEAD and refs under
    +    "refs/bisect/" are per-worktree, but that has been out of date since
    +    a9be29c981 (sequencer: make refs generated by the `label` command
    +    worktree-local, 2018-04-25). All root refs are per-worktree, as are refs
    +    under "refs/worktree/" and "refs/rewritten/". Pseudorefs are specific to
    +    each worktree too.
     
         Bring the list up to date, and refer to git-worktree(1) for how to
         access per-worktree refs of other worktrees. In the "worktree" entry,
    -    describe HEAD as a per-worktree ref and MERGE_HEAD as a pseudoref,
    -    rather than listing them separately from per-worktree refs.
    +    link to "per-worktree ref" instead of listing HEAD and MERGE_HEAD.
     
         Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
     
3:  6711bf027d ! 3:  ac3ed53867 doc: stop calling root refs pseudorefs
    @@ Documentation/gitdatamodel.adoc: remote-tracking branches: `refs/remotes/<remote
     +
     +[[root-refs]]
     +root refs::
    -+    Git may also create references other than `HEAD` at the root of the
    -+    hierarchy, for example `ORIG_HEAD` or `REBASE_HEAD`.
    ++    Git may create references other than `HEAD` at the root of the hierarchy,
    ++    for example `ORIG_HEAD` or `REBASE_HEAD`.
     +
     +[[pseudorefs]]
     +pseudorefs::
    -+    linkgit:git-fetch[1] and linkgit:git-merge[1] create the so-called
    -+    pseudorefs `FETCH_HEAD` and `MERGE_HEAD`. They are not references as
    -+    such, as they are not stored in the same way, but they can nevertheless
    -+    be used to refer to objects in commands such as linkgit:git-log[1] and
    -+    linkgit:git-diff[1].
    ++    linkgit:git-fetch[1], linkgit:git-merge[1] and linkgit:git-pull[1]
    ++    create the so-called pseudorefs `FETCH_HEAD` and `MERGE_HEAD`.
    ++    They are not references as such, because they are not stored by the
    ++    ref backend, but they can nevertheless be used to refer to objects in
    ++    commands such as linkgit:git-log[1] and linkgit:git-diff[1].
    ++
    ++See linkgit:gitglossary[7] for further details on root refs and
    ++pseudorefs.
      
      NOTE: Git may delete objects that aren't "reachable" from any reference
      or <<reflogs,reflog>>.
4:  ea7baa1269 = 4:  2c3f3ab195 refs: stop calling root refs pseudorefs
5:  d11ab774ec = 5:  d8a825d8cc t: stop calling root refs pseudorefs
-- 
2.56.0

