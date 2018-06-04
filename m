Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE8C1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 21:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeFDVu6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 17:50:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35001 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeFDVu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 17:50:58 -0400
Received: by mail-wr0-f195.google.com with SMTP id l10-v6so209941wrn.2
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lpq4y91lC+rMQr1rEylAjh6rpqHLVrEKGaUUXz+HfmI=;
        b=Nkaq9bUxe9NHbIWWdPdHLVLoI7hjRudl5we5X/aPTPrYQiqm8uEhW4YLWbir5GPQaK
         BFLURJDyoSF2BlPRMBnVtvSUgKQys8zzwIPWL6LTn0w8XTlFXodsjpJ3dTeoxTbEMNij
         MX5rydUpmFcY2iz4aNAAlJR3P8TyzFXjBgiN3lcQmDeHccgfNcK0EP8W1lFOIRe5Jct1
         DZVnLee70zFzcKk7qUmP8Bagq8iBADQVv7XXDJDKCZJXVw0huhpEzQ9NBSF+cYmf+zca
         wOf9ydde4/UsZTzKc1ZspP7T+ZUb0Y3RSNk+obg48fcAGKE/3wbputtOCBkpcn8vszH/
         H8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lpq4y91lC+rMQr1rEylAjh6rpqHLVrEKGaUUXz+HfmI=;
        b=ChvIQOaXJQAWQc9yK00RDe9INlVH6RWbYo14lF/gsXG0a7hGUxL+AAy/b57DQXSteb
         lKJ/r2G+0Qc72GS2mbiIiTqNIMKv8rGTTOcvZ5xufJ4HqgeOqToBGHeGukcR6LGNvFM1
         iEMunJFGh1ZZILlBA3sPap5rRFHAkbKnjeo9EBIT44d/RzLE9PS1Nfl4K6B7WPSMqMd6
         JLDSrZXKRA9jesy4ccDCcTTW4yqegAt2coiSA7UBn2S5GDIqenmUy8+MCjufXmvBiuLT
         /V73uEq3sCZ0kps/ny3bDHnzuSoh2D+3eKaF99NWbVlp8F1aa7ZL7mlAE5ZGuFqSBBCu
         FIiw==
X-Gm-Message-State: ALKqPwcez39Yxnb5c3AvSDV770dO2frChyYEWUK8l/ADjEKZ0iNwhRDs
        3pUl8LpgiO+ddrZlaQDzQ8WrFV6w
X-Google-Smtp-Source: ADUXVKKOtniDte6NXzYHV0uMNKN0lJugIdHEPuIqEj95V9dUetNsusYhEM1x+ec0F+26tO4VSYjIrQ==
X-Received: by 2002:adf:e311:: with SMTP id b17-v6mr18405294wrj.158.1528149056386;
        Mon, 04 Jun 2018 14:50:56 -0700 (PDT)
Received: from rigel.lan (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id b74-v6sm34978wmi.13.2018.06.04.14.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 14:50:55 -0700 (PDT)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Marius Giurgi <marius.giurgi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC PATCH 1/2] docs: reflect supported fetch options of git pull
Date:   Mon,  4 Jun 2018 22:50:22 +0100
Message-Id: <20180604215023.20525-1-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git pull` understands some options of `git fetch` which then uses in
its operation. The documentation of `git pull` doesn't reflect this
clearly, showing options that are not yet supported (e.g. `--deepen`)
and omitting options that are supported (e.g. `--prune`).

Make the documentation consistent with present behaviour by hiding
unavailable options only.

Reported-by: Marius Giurgi <marius.giurgi@gmail.com>
Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
---

Marius asked on freenode.#git if pull supported `--prune`, upon
inspection seems like the man page was missing some of the supported
options and listing others that are not supported via pull.

Here's a quick summary of the changes to pull's documentation:

add:                      remove:
  --dry-run                 --deepen=<depth>
  -p, --prune               --shallow-since=<date>
  --refmap=<refspec>        --shallow-exclude=<revision>
  -t, --tags                -u, --update-head-ok
  -j, --jobs=<n>

 Documentation/fetch-options.txt | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 8631e365f..da17d27c1 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -14,6 +14,7 @@
 	linkgit:git-clone[1]), deepen or shorten the history to the specified
 	number of commits. Tags for the deepened commits are not fetched.
 
+ifndef::git-pull[]
 --deepen=<depth>::
 	Similar to --depth, except it specifies the number of commits
 	from the current shallow boundary instead of from the tip of
@@ -27,6 +28,7 @@
 	Deepen or shorten the history of a shallow repository to
 	exclude commits reachable from a specified remote branch or tag.
 	This option can be specified multiple times.
+endif::git-pull[]
 
 --unshallow::
 	If the source repository is complete, convert a shallow
@@ -42,10 +44,8 @@ the current repository has the same history as the source repository.
 	.git/shallow. This option updates .git/shallow and accept such
 	refs.
 
-ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
-endif::git-pull[]
 
 -f::
 --force::
@@ -63,6 +63,7 @@ ifndef::git-pull[]
 --multiple::
 	Allow several <repository> and <group> arguments to be
 	specified. No <refspec>s may be specified.
+endif::git-pull[]
 
 -p::
 --prune::
@@ -76,8 +77,14 @@ ifndef::git-pull[]
 	subject to pruning. Supplying `--prune-tags` is a shorthand for
 	providing the tag refspec.
 +
+ifdef::git-pull[]
+See the PRUNING section on linkgit:git-fetch[1] for more details.
+endif::git-pull[]
+ifndef::git-pull[]
 See the PRUNING section below for more details.
+endif::git-pull[]
 
+ifndef::git-pull[]
 -P::
 --prune-tags::
 	Before fetching, remove any local tags that no longer exist on
@@ -89,9 +96,6 @@ See the PRUNING section below for more details.
 +
 See the PRUNING section below for more details.
 
-endif::git-pull[]
-
-ifndef::git-pull[]
 -n::
 endif::git-pull[]
 --no-tags::
@@ -101,7 +105,6 @@ endif::git-pull[]
 	behavior for a remote may be specified with the remote.<name>.tagOpt
 	setting. See linkgit:git-config[1].
 
-ifndef::git-pull[]
 --refmap=<refspec>::
 	When fetching refs listed on the command line, use the
 	specified refspec (can be given more than once) to map the
@@ -119,6 +122,7 @@ ifndef::git-pull[]
 	is used (though tags may be pruned anyway if they are also the
 	destination of an explicit refspec; see `--prune`).
 
+ifndef::git-pull[]
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
 	populated submodules should be fetched too. It can be used as a
@@ -129,6 +133,7 @@ ifndef::git-pull[]
 	when the superproject retrieves a commit that updates the submodule's
 	reference to a commit that isn't already in the local submodule
 	clone.
+endif::git-pull[]
 
 -j::
 --jobs=<n>::
@@ -137,6 +142,7 @@ ifndef::git-pull[]
 	submodules will be faster. By default submodules will be fetched
 	one at a time.
 
+ifndef::git-pull[]
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=no` option).
@@ -153,7 +159,6 @@ ifndef::git-pull[]
 	recursion (such as settings in linkgit:gitmodules[5] and
 	linkgit:git-config[1]) override this option, as does
 	specifying --[no-]recurse-submodules directly.
-endif::git-pull[]
 
 -u::
 --update-head-ok::
@@ -163,6 +168,7 @@ endif::git-pull[]
 	to communicate with 'git fetch', and unless you are
 	implementing your own Porcelain you are not supposed to
 	use it.
+endif::git-pull[]
 
 --upload-pack <upload-pack>::
 	When given, and the repository to fetch from is handled
-- 
2.17.1

