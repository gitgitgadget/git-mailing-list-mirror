Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15752F83AE
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248218; cv=none; b=j6wDPOZKsy8foHs9plfjWTclqMguL2rUeihTu9wp8USN5eancukJzoXFXI/LLrea0WXKHMjPHblKW6Xi4Yn80vwjC/zBI+FOmqLAd2JZCfCBvKNlZIhYP5LyaRBXBWGGi8We94h9Ygo1uwdBjXpqGe8GsdYsQg3aEUfa+5srfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248218; c=relaxed/simple;
	bh=d3QgsZtbfST5tukMH8JkV/QR65XS+D+jNRpfVDWFz90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2F+eOrHcINKQm6WaDBNh0mH2qOqVvAUE7lS8JPoK2xET/MCGR0k+s8H+9VFu4RPf6I/0sssreYEdwnJR19IeqRWZxDDkKpUVyMcBUUEm8ZSP13z4DPgnTsciqvOvNQvZLEYIiajjVN3IeJYDpWLXNryFaOPJoBzi8CX4YBYjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq+akAmW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq+akAmW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4833115090dso28572995e9.3
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248215; x=1771853015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9GtuIj4SjMKVf4NO7wiavBBrDniU4GtgoZbOmWSQHk=;
        b=lq+akAmWRacRB/iAtn4s3JWkP5wn38v6oCBkkhcHK6r041pspbsnqmhWEQnpcn9jJS
         Nyfu3EApIOzuHtNQdakqLjt4+jNpabyPcPBIi0d4PKJHojsBFF9rk/aJx5RN6jS6GuU2
         S1Q40myH9qbXyuhh2YC1WQ3yndRE59VAPSFhOM8p2xqbuGsfKDYsBl0xituenEloHXCx
         tBxMdd8RJgBaAHua3l2KbcJSlwyELnvJFDADbx1doscQHS4VeD7leXG+N1w6HEsI/LP8
         IsvlMFTYfyG0H45CgD0a8ctmC4SuQIUgvjcrUwTvDp+urzJvaKn0xBHCsxjmXV/GHQik
         l+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248215; x=1771853015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N9GtuIj4SjMKVf4NO7wiavBBrDniU4GtgoZbOmWSQHk=;
        b=klld9UvbKaJBhToPPkVWwYdBYltiyDYV8q2Nq8jgLocBs+zy3L0oHul4S/5juvDAs4
         kRrr8OIygqYdLaT6ECVc0Uoo7D2pB4CCw5NZ7sExf2djGi1LPkMZdZMrp0P6MOOzebDO
         /FmpRSBRTU6LW68jIXHtTp+feGp8B6+pyukPAEWl39j8YR08MkKkHb51+qyRvG6z3hNJ
         6DDe868/GWtBtyJnzy80Za2MRnmAodZk69DzhwVkradniXBQdv0hQckRtRFhT/MVT9Y6
         wz2Fcd/3ieQ/pdKtY5j03nV3Imae6it/78gE1kTiZBwXEPTUza07ibpR3T8uyMnE3gPL
         jQVg==
X-Gm-Message-State: AOJu0YyNP1+Im3AsBP7zQsI3gPvWLUrB5weyVcOZdIB8P6LtG8/izQu/
	egYKd19gtI+xKd3CEGlc5I7o63QpJd4q7//gnjYcdwoZ5shhYbC5/df+98jS/Q==
X-Gm-Gg: AZuq6aKPJXZf+85WIbcYmqRhpdI98pn4ysM8GmifngYtJ/l3kXHS/eixWAD6fMAbD6V
	yJi+XHVkVlvr8sKPDgZSO9KA2WbCxjavwl5EJRDz3hCvUsI8kwntoi0jV9JitHCNe0flLMq6+9u
	yPC9ky0Zynh4VxYZK36EsQLbKiQnkAwZ+M1Bk5ywPG0cKUhM5sA1Arsqf4LhFL2K/vC1jNp8Mx2
	wLO2o3iMXuUHO36qIhhA/VY8zi8eG75UVyNgq7nHyaLoLns31+SLnwS+xPh+tuWKfWgZQ3M+8bB
	lFA27SDpuEinvchNsRKOsXuCzPzUtsPcmBCvWNv97OevOoyPOd+v0/JxfdFt/43Yye4ITl7w5/W
	JzVy6IPtre+CuMhzgbaO+QXzh8WZTyfpzzbDHLUx2W3VjitT5XN+MlIHl4KoxUTigKnajFS1ong
	x9NMdZd/8OS/SUIQ3NWWPTD8EpYxUwpCzBNiGC4dD66eOlNNQ8zFEHrQ6QTp4xG+WZ21PEhw/AC
	5EsyR5mVJ7FZD9V1/iRLyJUuPc1t3b+JG/q5YM=
X-Received: by 2002:a05:600c:1549:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-48373a5d7b6mr169172455e9.23.1771248214540;
        Mon, 16 Feb 2026 05:23:34 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:33 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/9] Implement `promisor.storeFields` and `--filter=auto`
Date: Mon, 16 Feb 2026 14:23:06 +0100
Message-ID: <20260216132317.15894-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260212100843.883623-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduction
============

A previous patch series added the possibility to pass additional
fields, a "partialCloneFilter" and a "token" for each advertised
promisor remote, from a server to a client through the
"promisor-remote" capability.

On the client side though, it has so far only been possible to use
this new information to compare it with local information and then
decide if the corresponding advertised promisor remote is accepted or
not.

For the "token" it would be useful if it could be stored on the
client. For example in a setup where the client uses specialized
remote helpers which need a token to access the promisor remotes
advertised by the server, storing the token would allow the token to
be used when the client directly accesses a promisor remote for
example to lazy fetch some blobs it now needs.

To enable such a workflow, where the server can rotate tokens and the
client can have updated tokens from the server by simply fetching from
it, the first part of this series introduces a new
"promisor.storeFields" configuration option on the client side,
similar to the "promisor.checkFields" configuration option. When field
names, "token" or "partialCloneFilter", are listed in this new
configuration option, then the values of these field names transmitted
by the server are stored in the local configuration on the client
side.

Note that for security reasons, the corresponding remote name and url
of the advertised promisor remotes must have already been configured
on the client side. No new remote name nor url are configured.

For the "partialCloneFilter" field, simply storing the value is not
enough to enable dynamic updates. Currently, when a user initiates a
partial clone with `--filter=<filter-spec>`, that specific
<filter-spec> is saved in the client's local configuration (e.g.,
remote.origin.partialCloneFilter). Subsequent fetches then reuse this
value, ignoring suggestions from the server.

To avoid breaking this mechanism and still be able to use the
<filter-spec> that the server suggests for the promisor remotes that
the client accepts, the second part of this series introduces a new
`--filter=auto` mode for `git clone` and `git fetch`.

When `--filter=auto` is used, then "auto" is still saved as the
<filter-spec> for the server locally on the client, and then when a
fetch-pack happens, instead of passing just "auto", the actual filter
requested by the client is computed by combining the <filter-spec>s
that the server suggested for the promisor remotes that the client
accepted. This uses the "combine" filter mechanism that already exists
in "list-objects-filter-options.{c,h}".

This way by just using `--filter=auto` when cloning, a client makes
sure it will use the <filter-spec>s suggested by the server for the
promisor remotes it accepts.

This work is part of the "LOP" effort documented in:

  Documentation/technical/large-object-promisors.adoc

See that doc for more information on the broader context.

Overview of the patches
=======================

Patches 1/9 and 2/9 are the first part of the series and implement the
new "promisor.storeFields" configuration option. Patch 1/9 is a small
preparatory refactoring.

Patches from 3/9 to 9/9 implement the `--filter=auto` option:

  - Patches 3/9 and 4/9 are cleanups of "builtin/clone.c" and
    "builtin/fetch.c" respectively that make the `filter_options`
    variable local to cmd_clone() or cmd_fetch().

  - Patch 5/9 is a doc update as `--filter=<filter-spec>` wasn't
    documented for `git fetch`.

  - Patch 6/9 improves "list-objects-filter-options.{c,h}" to
    support the new 'auto' mode.

  - Patches 7/9 and 8/9 improves "promisor-remote.{c,h}" to support
    the new 'auto' mode.

  - Patch 9/9 make the new 'auto' mode actually work by wiring up
    everything together.

CI Report
=========

All the tests pass, see:

https://github.com/chriscool/git/actions/runs/22059799525

Changes since v3
================

Thanks to Patrick Steinhardt, Jean-Noël Avila, Peff and Junio Hamano
for reviewing or commenting on the previous version!

The only change compared to v3 is in patch 6/9 where in
"list-objects-filter-options.c" the `allow_auto_filter` variable in
`list_objects_filter_release()` is now initialized after the check to
return if `filter_options` is NULL instead of before that check.

Range diff since v3
===================

 1:  79255ceba7 =  1:  79255ceba7 promisor-remote: refactor initialising field lists
 2:  012aa7ef19 =  2:  012aa7ef19 promisor-remote: allow a client to store fields
 3:  f17a62e73e =  3:  f17a62e73e clone: make filter_options local to cmd_clone()
 4:  3c6e28dd84 =  4:  3c6e28dd84 fetch: make filter_options local to cmd_fetch()
 5:  3037d546b2 =  5:  3037d546b2 doc: fetch: document `--filter=<filter-spec>` option
 6:  9ce57b88dc !  6:  366c93e836 list-objects-filter-options: support 'auto' mode for --filter
    @@ list-objects-filter-options.c: void list_objects_filter_release(
        struct list_objects_filter_options *filter_options)
      {
        size_t sub;
    -+  unsigned int allow_auto_filter = filter_options->allow_auto_filter;
    ++  unsigned int allow_auto_filter;
      
        if (!filter_options)
                return;
    -@@ list-objects-filter-options.c: void list_objects_filter_release(
    ++
    ++  allow_auto_filter = filter_options->allow_auto_filter;
    +   strbuf_release(&filter_options->filter_spec);
    +   free(filter_options->sparse_oid_name);
    +   for (sub = 0; sub < filter_options->sub_nr; sub++)
                list_objects_filter_release(&filter_options->sub[sub]);
        free(filter_options->sub);
        list_objects_filter_init(filter_options);
 7:  37042f7019 =  7:  2eb3b9cddd promisor-remote: keep advertised filters in memory
 8:  dd17069aad =  8:  fae3e9089d promisor-remote: change promisor_remote_reply()'s signature
 9:  0f9675f477 =  9:  4627d513d6 fetch-pack: wire up and enable auto filter logic


Christian Couder (9):
  promisor-remote: refactor initialising field lists
  promisor-remote: allow a client to store fields
  clone: make filter_options local to cmd_clone()
  fetch: make filter_options local to cmd_fetch()
  doc: fetch: document `--filter=<filter-spec>` option
  list-objects-filter-options: support 'auto' mode for --filter
  promisor-remote: keep advertised filters in memory
  promisor-remote: change promisor_remote_reply()'s signature
  fetch-pack: wire up and enable auto filter logic

 Documentation/config/promisor.adoc           |  33 +++
 Documentation/fetch-options.adoc             |  19 ++
 Documentation/git-clone.adoc                 |  25 +-
 Documentation/gitprotocol-v2.adoc            |  24 +-
 Makefile                                     |   1 +
 builtin/clone.c                              |  18 +-
 builtin/fetch.c                              |  50 ++--
 connect.c                                    |   3 +-
 fetch-pack.c                                 |  24 ++
 list-objects-filter-options.c                |  39 ++-
 list-objects-filter-options.h                |   6 +
 list-objects-filter.c                        |   8 +
 promisor-remote.c                            | 256 +++++++++++++++++--
 promisor-remote.h                            |  17 +-
 t/meson.build                                |   1 +
 t/t5710-promisor-remote-capability.sh        | 123 +++++++++
 t/unit-tests/u-list-objects-filter-options.c |  53 ++++
 transport.c                                  |   1 +
 18 files changed, 628 insertions(+), 73 deletions(-)
 create mode 100644 t/unit-tests/u-list-objects-filter-options.c

-- 
2.53.0.77.g4627d513d6

