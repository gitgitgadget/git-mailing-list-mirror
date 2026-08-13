Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043C377A85
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636125; cv=none; b=WUf9W+hf1/jf2HlIqDzzHr4itRF3kOZ0Vht7Vu3c+6pJtp39uo+qjnSRLyYZCMeMdJx+Y1Pjp+tdPid/6l3pQMFHd23C+Vkt9AeobWoJWZHdoIUw1dVFg4PAYUeLhJZEqRpeInnaBjTesj6SayCz3avhawDgF4fnn3nD+dPy6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636125; c=relaxed/simple;
	bh=hnqE/EmjUC8NTqZwniw7D8CUY0vSlSXPUIAKLTv31vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7qGuAUeVcms7RvNbSmrRi5Rb7VNCGmuva+M+ztj/eHuppuUYfi8gbyJLwyqDFceHourDXHZx+4JetMdZozK97APRZA7Vm4D7+MsnOdHkxjoOf+JGeN7+R/kwvfXglPj4hSHIUAD65UGJWYFIcfE2p85i8C82+nRU44ENdlFdn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2W+OHUw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2W+OHUw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499840a2575so514485e9.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786636121; x=1787240921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e+bCFk6UnJvNVOszaIZ0dJz09evGoDHjF3VJ+b0cv00=;
        b=f2W+OHUwvplhqNL4vBaoxGTXUdZIqI+ChVKpz3wQc9TiI1orU76zS3gs9mU3hHxT6F
         D+SgiFBSHyQKJ2D0wYGF3QJ6CB+si6oU4A1YaVAQCNS57YnuN81LHOHEP2H1nyCNKZJS
         BQGHAUe5Hm36jK447zcwEys7Nk4nlc/8F5ykdbNj/F2e/lQtIgfai5LFDQIzPnpmT6Ex
         5KgZpjAqnDBmxtPRNNhKwPxsmOGTokA3Xqb44ISXDpxoG4JuGlRkReerYBZc2zVpwM4O
         OUb/EP6sFz0tAgae6nvkdUS3T0ur6s8JmSXHtMvn0sNxnzQWPuPjpIf613OvvjGV7MI+
         g2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636121; x=1787240921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e+bCFk6UnJvNVOszaIZ0dJz09evGoDHjF3VJ+b0cv00=;
        b=stD+YaxqFrOMm4VE5Gf6j3tsFXWBw0N78RjlfvAB7EMAsYZUOMhQ4EMOVBA/+sZ+ZR
         1+nLSjD+DQX9pBopsma+LrcBvGyntyAkv9yMmTV5Bp8w80vEfOkevGnkIfeFMy2R+KxU
         0jREEDNn6s00OOF2Dyhl2cKg1zn0OOUqCwEExS8ooxD3WVIXzygdbxSWGJstTmdpNTok
         FLN9G/W4dPDqExKvQJuhi9f0UBYSwh1mY8BCSxSChz5ARS4h2ryUheUK7xh5AmNn8Xl0
         9JWamaxhJ4L3IYNZBHetPWegHmM4sLHGIsd/UugBvVWSy7Ag0OjZ9U5ZDnLhSRU6ypjT
         Dgmg==
X-Gm-Message-State: AOJu0YzF2Wph2VHFj+WN0VRuHrMISNcwbNYHFySvTKm7hmmWMvjYpp4t
	34hlpy/jGJVxVYinrONTFsEuhPHQPYxGBCkIduCA4hd/VpJatuDMVwpTTdyqWA==
X-Gm-Gg: AR+sD1123mRqXG1GhCsjgSENc244LQEW2ipno7A/Yhar1f1OTxad88RHD0uFROJsBiI
	ddJmfYRz2K+n+GuDwxC49KJ96XI/vLZQcaI7k0ecF7XqTj0cA6tztWlSqStto1glSKORc6pDJzj
	OSXEFcAZSE+Ov4wu8FRpiQZRo3k/hmRMCFR1RPYqh/Omvn61yOpwi/E+puj2wU1ibT24cd4+7sx
	5OGnVxkjuTjs4R+700GXhEBkR5203Djmw5JmhnnwaEL5MC9q1C/vgxXEp/hmGdL8xrBdQ2ghysg
	a5FOyv57AvlT61DWNkaA/GdpI/tYVOpMlmIMkpgrIOmMfjGG3pC8kWtsngPaIAqgPgKT+lXFESY
	O0tRLW+TRnk3q4KGKq9HGnRs1N7CqMUOHObkbo4Ax/xKiyA3kkZhMg3kH0x++yqlwtoMx/N1BLr
	8torq5ojmLEAU/Mj8UgMgQV9Qe59vRSE2ljFQ4nDTfnavG2/uoMlzsvetlockJ/JLwS+kp4l/eE
	H/H4JqBsNBZXHPMw47Nx69UG2oRj8zG+4R+lXvntJEKvHngS+357VvY/9RXCwTqbM7Q5IFTGifP
	Uig=
X-Received: by 2002:a05:600c:4ed2:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-499821616c1mr70577285e9.5.1786636120640;
        Thu, 13 Aug 2026 08:48:40 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c0:e90b:439b:8502:172e:8dcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499821217acsm60633555e9.2.2026.08.13.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:48:39 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/5] Introduce 'uploadpack.lazyFetchTrusted'
Date: Thu, 13 Aug 2026 17:47:43 +0200
Message-ID: <20260813154748.2378747-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.547.gbb97bea608.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260807135511.1818458-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently the "promisor-remote" capability was added to protocol v2,
allowing servers and clients to agree on the promisor remotes they can
safely use.

The more servers use promisor remotes, the more it is important to
properly control if they can lazy fetch when responding to a clone or
fetch request from the client.

For example, in the context of large object promisors (see
"Documentation/technical/large-object-promisors.adoc"), if a client
clones with a filter set to 100kB while the server has moved all of
the blobs >= 10kB to a promisor remote, the server will not be able to
provide blobs between 10kB and 100kB to the client, which will make
the clone fail.

Even if the `--filter=auto` option is available since ef2f1845ec
(fetch-pack: wire up and enable auto filter logic, 2026-02-16) it's
still a good idea to provide more control over lazy fetching on the
server side to server operators, as lazy fetching on the server side
could be useful in corporate environments.

Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
2024-04-16), lazy fetching has been controlled by the
`GIT_NO_LAZY_FETCH` environment variable. This is a boolean that is
set to 'true' by default when calling `git upload-pack` for security
reasons.

The main security issue on the server side is making sure the served
repo itself is also trusted, as lazily fetching runs `git fetch`,
which may execute arbitrary commands specified in the configuration
and hooks of the served repo. The operator of the server should decide
and mark that trust, not the served repo itself, nor the client.

This series introduces a new 'uploadpack.lazyFetchTrusted' protected
configuration variable similar to 'safe.directory' (see
"Documentation/config/safe.adoc") to mark trusted repos where lazy
fetching is allowed. As it is protected, this config variable will
only take effect if it is set in global or system scope, so only
server operators can control it.

Previous related work
=====================

A previous series called "Introduce a 'fromAccepted' option to
GIT_NO_LAZY_FETCH" [1] took a different approach as it wanted to make
it easier to allow lazy fetching from accepted promisor remotes. But
after brian replied that he didn't think it was a good idea, and after
thinking about this more, my opinion now is that some promisor remotes
being accepted or not is not really relevant to the issue.

In my reply to brian, I said:

"""
Different features could be developed (in future work) to improve on
the current state:
    - a way for lazy fetching to work without reading config files,
triggering hooks, or doing potentially sensitive things,
    - an explicit way for operators to mark trusted repos (like
perhaps a server-side config the operator sets per-repo),
    - operator-defined allow/deny rules, or maybe
    - some ways/scripts/commands to scan repos and check configuration
information, remote settings and everything potentially sensitive to
decide if a repo looks safe enough to allow lazy fetching or not.
"""

So I decided to go with "an explicit way for operators to mark trusted
repos" and this series is an implementation of that.

Note that the feature developed in this series applies to protocol
v0/v1 as well as v2 while the previous one was only related to v2.

[1]: https://lore.kernel.org/git/CAP8UFD0_S9eg_w42tcNRnT9E2ntLr_eHLnzE4c2dSu67DzZoXg@mail.gmail.com/

Overview of the patches
=======================

  - Patch 1/5 is the only patch saved from the "Introduce a
    'fromAccepted' option to GIT_NO_LAZY_FETCH" series. It's not
    necessary for the rest of this series and its main feature to
    work, but I think it's a nice refactoring related to lazy
    fetching, so it might as well be part of this series. There is a
    small change in the commit message (to not mention following
    commits) compared to the version in the previous series.

  - Patches 2/5 and 3/5 extract and modify code used by the
    'safe.directory' config variable in a path_allowlist_apply()
    function, so that this function can be reused to process
    'uploadpack.lazyFetchTrusted' in the next patch.

  - Patch 4/5 actually uses path_allowlist_apply() from a new
    upload_pack_lazy_fetch_trusted() function to process
    'uploadpack.lazyFetchTrusted', but the result from that processing
    isn't actually used to have a practical effect.

  - Patch 5/5 wires up the new upload_pack_lazy_fetch_trusted()
    function to decide if lazy fetching can actually be enabled.

Changes since v1
================

The only change is that the Signed-off-by email address has been fixed
to "christian.couder@gmail.com", which is my primary address in
".mailmap" since 6375b40aea (mailmap: change primary address for
Christian Couder, 2026-08-03).

This version is also sent as a separate 'v2' iteration in reply to v1,
instead of being threaded onto the previous "Introduce a
'fromAccepted' option to GIT_NO_LAZY_FETCH" series, and it now
contains a 'base-commit' trailer, so that 'b4' and other tools can
find the right base and the right patches.

CI tests
========

I didn't run them as only commit messages changed since v1.

Range diff with v1
==================

1:  b5b0836d19 ! 1:  1605740203 promisor-remote: factor out lazy_fetch_objects()
    @@ Commit message
         'bool' instead of 'int', as it just returns whether all the objects
         could be fetched, and document its return value.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## promisor-remote.c ##
     @@ promisor-remote.c: static int fetch_objects(struct repository *repo,
2:  879e3a34e3 ! 2:  5f226b6508 setup: extract path_allowlist_apply()
    @@ Commit message
     
         While at it let's make the helper's code simpler and more generic.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## setup.c ##
     @@ setup.c: static int canonicalize_ceiling_entry(struct string_list_item *item,
3:  98431ab7b3 ! 3:  051aa11fc9 setup: add 'allow_dot' arg to path_allowlist_apply()
    @@ Commit message
     
         While at it let's document it properly in "setup.h".
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## setup.c ##
     @@ setup.c: static int canonicalize_ceiling_entry(struct string_list_item *item,
4:  a46f4c1bb8 ! 4:  045b5e647b upload-pack: read uploadpack.lazyFetchTrusted
    @@ Commit message
         Note that the new config variable should be read only from protected
         configuration files.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## upload-pack.c ##
     @@
5:  4063f233aa ! 5:  c116661202 builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
    @@ Commit message
         Now that "uploadpack.lazyFetchTrusted" is actually doing something,
         let's document it and reference it from GIT_NO_LAZY_FETCH's docs.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## Documentation/config/uploadpack.adoc ##
     @@ Documentation/config/uploadpack.adoc: uploadpack.allowRefInWant::


Christian Couder (5):
  promisor-remote: factor out lazy_fetch_objects()
  setup: extract path_allowlist_apply()
  setup: add 'allow_dot' arg to path_allowlist_apply()
  upload-pack: read uploadpack.lazyFetchTrusted
  builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo

 Documentation/config/uploadpack.adoc  |  42 ++++++++++
 Documentation/git-upload-pack.adoc    |   5 ++
 Documentation/git.adoc                |   4 +-
 builtin/upload-pack.c                 |  11 +++
 promisor-remote.c                     |  76 ++++++++++--------
 setup.c                               | 108 ++++++++++++++------------
 setup.h                               |  28 +++++++
 t/t5710-promisor-remote-capability.sh |  70 +++++++++++++++++
 upload-pack.c                         |  37 +++++++++
 upload-pack.h                         |   3 +
 10 files changed, 304 insertions(+), 80 deletions(-)


base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
-- 
2.55.0.565.gc116661202

