Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F00FF1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeBIUcb (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:31 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40268 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIUca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:30 -0500
Received: by mail-wm0-f54.google.com with SMTP id v123so18516830wmd.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zp2FmBfGKTyKxhxrfnWB4HLt0rFhomgoMuZ9+iCmtQ=;
        b=B1ic49x9tZ+R/OZXNlPE6Lclkbmg8hsBfil5fV+vt1ODvTBV7IT5lFVk0pBlYKsaM1
         NKzGKDRF/gcAkmeV8rGhjicr8PINpMqX2eNoJFXjmUYJIKRYo9554rWrvIlbSQn4UP7G
         Rb+cs38oZS6ikvYS6DagfdryMEADQMFDb8WsGQ10MnfmfSWQUfnsPF0zvvDZB/9nYmfS
         kBS3mtEEkBrJb0t6NS7qrMNXSQ26PrzkHMHrvVGQQ/W3nQwOKy1KhfPWVtTydJPxuTCY
         5ld3omZ7m6rR1hze8mOx2Iq89pcfa9LGVClE8J25/XF0bfxiqDbVt3kpZ3K+OGhhaaom
         acXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zp2FmBfGKTyKxhxrfnWB4HLt0rFhomgoMuZ9+iCmtQ=;
        b=Gi5LO1RtIWqr9wCkL+VuC2XS0f/QgFtWaJRbHtWW6F0nKquCJfsjdXrHcMmYlEwefh
         u55YwUSvTpkHqXmj5C+ENMDd1cUxWpG39/XRfdgySNtnLZV8xRsTo6AmbrWg1KllAlS3
         FATFuDN6hrbozIgkgoqgabUsiJC0r9akpH+SZ8d8M0S34UA1P3Q0HlZE9CkU+Mzl/vjR
         Or8hTZGdgnR7O9ai53PjJLrAK8hh6amrdzq8khpWvQ4ugwbKfVdrPb/rP/F/rwC0Tyi0
         ldtskoT+jgFgCkij4+ZhVXR99l5bz0BjyS2AsuKG6SyQzL9s42BAfwQCH9IDC50fz01W
         ExSw==
X-Gm-Message-State: APf1xPCZRtEyHcEiKl72zhlIjPah8kxbgC6WpqejrPe321hvH/AUFJJt
        Uv71iwDccgbCw8HES2QItU8ZcI41
X-Google-Smtp-Source: AH8x224+snSrXd9LVwzOKlwalh19WEW1fkEGn+aMZam9c/lKKPSBcxaBOPRCw98le3O18oflFl964g==
X-Received: by 10.28.190.3 with SMTP id o3mr3297923wmf.17.1518208348536;
        Fri, 09 Feb 2018 12:32:28 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/17] document & test fetch pruning & add fetch.pruneTags
Date:   Fri,  9 Feb 2018 20:31:59 +0000
Message-Id: <20180209203216.11560-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a v5 (correct subject line this time!). Many thanks to Eric for
a thorough review.

I'll spare you the per-patch changelog. These are all minor commit
message / doc / comment wording changes, with the exception of making
a bit of the test code better, and adding a \n for grep
portability. tbdiff at the end.

Ævar Arnfjörð Bjarmason (17):
  fetch: don't redundantly NULL something calloc() gave us
  fetch: trivially refactor assignment to ref_nr
  fetch: stop accessing "remote" variable indirectly
  remote: add a macro for "refs/tags/*:refs/tags/*"
  fetch tests: refactor in preparation for testing tag pruning
  fetch tests: re-arrange arguments for future readability
  fetch tests: add a tag to be deleted to the pruning tests
  fetch tests: test --prune and refspec interaction
  fetch tests: double quote a variable for interpolation
  fetch tests: expand case/esac for later change
  fetch tests: fetch <url> <spec> as well as fetch [<remote>]
  git fetch doc: add a new section to explain the ins & outs of pruning
  git remote doc: correct dangerous lies about what prune does
  git-fetch & config doc: link to the new PRUNING section
  fetch tests: add scaffolding for the new fetch.pruneTags
  fetch: add a --prune-tags option and fetch.pruneTags config
  fetch: make the --prune-tags work with <url>

 Documentation/config.txt               |  20 ++-
 Documentation/fetch-options.txt        |  17 ++-
 Documentation/git-fetch.txt            |  87 ++++++++++++
 Documentation/git-remote.txt           |  14 +-
 builtin/fetch.c                        |  54 ++++++--
 contrib/completion/git-completion.bash |   2 +-
 remote.c                               |  15 +++
 remote.h                               |   5 +
 t/t5510-fetch.sh                       | 238 +++++++++++++++++++++++++++------
 9 files changed, 391 insertions(+), 61 deletions(-)

tbdiff:

 1: da0992d97c =  1: da0992d97c fetch: don't redundantly NULL something calloc() gave us
 2: c781d18a29 !  2: 899430a3b2 fetch: trivially refactor assignment to ref_nr
    @@ -7,8 +7,8 @@
         "j" is, and "j" is only incremented in that loop, so this change isn't
         a logic error.
         
    -    This change makes a subsequent change which splits the incrementing of
    -    "ref_nr" into two blocks.
    +    This change simplifies a subsequent change, which will split the
    +    incrementing of "ref_nr" into two blocks.
         
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 3: 1203ef6e35 =  3: 98e3a28bdf fetch: stop accessing "remote" variable indirectly
 4: 1d7956c444 =  4: 384c1fc318 remote: add a macro for "refs/tags/*:refs/tags/*"
 5: a0dc3eb024 =  5: ec92777861 fetch tests: refactor in preparation for testing tag pruning
 6: 7ed1561e3d =  6: 1c23526223 fetch tests: re-arrange arguments for future readability
 7: 6dbf0e688d =  7: 59abe07b71 fetch tests: add a tag to be deleted to the pruning tests
 8: 9fc3589793 =  8: af7acef671 fetch tests: test --prune and refspec interaction
 9: a4487f9389 =  9: cb72187362 fetch tests: double quote a variable for interpolation
10: b8c07e2d42 = 10: 300c1c0985 fetch tests: expand case/esac for later change
11: 6341131ee0 ! 11: 550e7df594 fetch tests: fetch <url> <spec> as well as fetch [<remote>]
    @@ -60,15 +60,12 @@
     -	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
     +	mode=$6
     +
    -+	if ! test -e prune-type-setup-done
    ++	if test -z "$cmdline_setup"
     +	then
    -+		test_expect_success 'prune_type setup' '
    -+			git -C one config remote.origin.url >one.remote-url &&
    -+			git -C one config remote.origin.fetch >one.remote-fetch &&
    -+			remote_url="file://$(cat one.remote-url)" &&
    -+			remote_fetch="$(cat one.remote-fetch)" &&
    -+			cmdline_setup="\"$remote_url\" \"$remote_fetch\"" &&
    -+			touch prune-type-setup-done
    ++		test_expect_success 'setup cmdline_setup variable for subsequent test' '
    ++			remote_url="file://$(git -C one config remote.origin.url)" &&
    ++			remote_fetch="$(git -C one config remote.origin.fetch)" &&
    ++			cmdline_setup="\"$remote_url\" \"$remote_fetch\""
     +		'
     +	fi
     +
12: 824c3ed4c1 ! 12: 273f4c603f git fetch doc: add a new section to explain the ins & outs of pruning
    @@ -32,7 +32,7 @@
     +<commit>` needlessly verbose, as well as impacting anything else
     +that'll work with the complete set of known references.
     +
    -+These remote tracking references can be deleted as a one-off with
    ++These remote-tracking references can be deleted as a one-off with
     +either of:
     +
     +------------------------------------------------
    @@ -44,13 +44,13 @@
     +------------------------------------------------
     +
     +To prune references as part of your normal workflow without needing to
    -+remember to run that set `fetch.prune` globally, or
    ++remember to run that, set `fetch.prune` globally, or
     +`remote.<name>.prune` per-remote in the config. See
     +linkgit:git-config[1].
     +
     +Here's where things get tricky and more specific. The pruning feature
     +doesn't actually care about branches, instead it'll prune local <->
    -+remote references as a function of the refspec of the remote (see
    ++remote-references as a function of the refspec of the remote (see
     +`<refspec>` and <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> above).
     +
     +Therefore if the refspec for the remote includes
13: 59de997172 ! 13: ada313b523 git remote doc: correct dangerous lies about what prune does
    @@ -11,7 +11,7 @@
         oldest version I could be bothered to test).
         
         E.g. if "refs/tags/*:refs/tags/*" is explicitly set in the refspec of
    -    the remote it'll delete all local tags <name> doesn't know about.
    +    the remote, it'll delete all local tags <name> doesn't know about.
         
         Instead, briefly give the reader just enough of a hint that this
         option might constitute a shotgun aimed at their foot, and point them
    @@ -36,11 +36,11 @@
     -These stale branches have already been removed from the remote repository
     -referenced by <name>, but are still locally available in
     -"remotes/<name>".
    -+Deletes stale references associated with <name>. By default stale
    -+remote-tracking branches under <name>, but depending on global
    -+configuration and the configuration of the remote we might even prune
    -+local tags that haven't been pushed there. Equivalent to `git fetch
    -+--prune <name>`, except that no new references will be fetched.
    ++Deletes stale references associated with <name>. By default, stale
    ++remote-tracking branches under <name> are deleted, but depending on
    ++global configuration and the configuration of the remote we might even
    ++prune local tags that haven't been pushed there. Equivalent to `git
    ++fetch --prune <name>`, except that no new references will be fetched.
     ++
     +See the PRUNING section of linkgit:git-fetch[1] for what it'll prune
     +depending on various configuration.
14: 5dfc9177bb = 14: eeb9102d9f git-fetch & config doc: link to the new PRUNING section
15: fc0890eb9c ! 15: 6c1facccda fetch tests: add scaffolding for the new fetch.pruneTags
    @@ -28,7 +28,7 @@
     +	cmdline=$7
     +	mode=$8
      
    - 	if ! test -e prune-type-setup-done
    + 	if test -z "$cmdline_setup"
      	then
     @@
      		cmdline="$new_cmdline"
16: 03b1393ea2 ! 16: 1d8d6e29fc fetch: add a --prune-tags option and fetch.pruneTags config
    @@ -1,9 +1,10 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    fetch: add a --fetch-prune option and fetch.pruneTags config
    -    
    -    Add a --fetch-prune option to git-fetch, along with fetch.pruneTags
    -    config option. This allows for doing any of:
    +    fetch: add a --prune-tags option and fetch.pruneTags config
    +    
    +    Add a --prune-tags option to git-fetch, along with fetch.pruneTags
    +    config option and a -P shorthand (-p is --prune). This allows for
    +    doing any of:
         
             git fetch -p -P
             git fetch --prune --prune-tags
    @@ -366,7 +367,7 @@
     +		if test "$fetch_prune_tags" = 'true' ||
     +		   test "$remote_origin_prune_tags" = 'true'
     +		then
    -+			if ! printf '%s' "$cmdline" | grep -q refs/remotes/origin/
    ++			if ! printf '%s' "$cmdline\n" | grep -q refs/remotes/origin/
     +			then
     +				new_cmdline="$new_cmdline refs/tags/*:refs/tags/*"
     +			fi
    @@ -396,7 +397,7 @@
     +test_configured_prune false true  false true  pruned pruned ""
     +test_configured_prune true  false true  false kept   kept   ""
     +
    -+# When --prune-tags is supplied it's ignored if an explict refspec is
    ++# When --prune-tags is supplied it's ignored if an explicit refspec is
     +# given, same for the configuration options.
     +test_configured_prune unset unset unset unset pruned kept \
     +	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
    @@ -405,13 +406,15 @@
     +test_configured_prune unset unset unset true pruned  kept \
     +	"--prune origin +refs/heads/*:refs/remotes/origin/*"
     +
    -+# Pruning that also takes place if s!origin!<file:// url of remote>!,
    -+# or otherwise uses the file://-specific codepath. However, because
    -+# there's no implicit +refs/heads/*:refs/remotes/origin/* refspec and
    -+# supplying it on the command-line negate --prune-tags the branches
    -+# will not be pruned.
    -+test_configured_prune_type unset unset unset unset kept kept     "origin --prune-tags" "name"
    -+test_configured_prune_type unset unset unset unset kept kept     "origin --prune-tags" "link"
    ++# Pruning that also takes place if a file:// url replaces a named
    ++# remote, with the exception of --prune-tags on the command-line
    ++# (arbitrary limitation).
    ++#
    ++# However, because there's no implicit
    ++# +refs/heads/*:refs/remotes/origin/* refspec and supplying it on the
    ++# command-line negates --prune-tags, the branches will not be pruned.
    ++test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "name"
    ++test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "link"
     +test_configured_prune_type unset unset unset unset pruned pruned "origin --prune --prune-tags" "name"
     +test_configured_prune_type unset unset unset unset kept   kept   "origin --prune --prune-tags" "link"
     +test_configured_prune_type unset unset unset unset pruned pruned "--prune --prune-tags origin" "name"
    @@ -427,9 +430,8 @@
     +test_configured_prune_type unset  true unset true  pruned pruned "origin" "name"
     +test_configured_prune_type unset  true unset true  kept   pruned "origin" "link"
     +
    -+# When all remote.origin.fetch settings are deleted a --prune
    -+# --prune-tags still implicitly supplies refs/tags/*:refs/tags/* so
    -+# tags, but not tracking branches, will be deleted.
    ++# Interaction between --prune-tags and no "fetch" config in the remote
    ++# at all.
     +test_expect_success 'remove remote.origin.fetch "one"' '
     +	(
     +		cd one &&
17: f0dca21626 ! 17: ddcd576c5c fetch: make the --prune-tags work with <url>
    @@ -1,6 +1,6 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    fetch: make the --fetch-prune work with <url>
    +    fetch: make the --prune-tags work with <url>
         
         Make the new --prune-tags option work properly when git-fetch is
         invoked with a <url> parameter instead of a <remote name>
    @@ -91,8 +91,18 @@
     --- a/t/t5510-fetch.sh
     +++ b/t/t5510-fetch.sh
     @@
    - test_configured_prune_type unset unset unset unset kept kept     "origin --prune-tags" "name"
    - test_configured_prune_type unset unset unset unset kept kept     "origin --prune-tags" "link"
    + 	"--prune origin +refs/heads/*:refs/remotes/origin/*"
    + 
    + # Pruning that also takes place if a file:// url replaces a named
    +-# remote, with the exception of --prune-tags on the command-line
    +-# (arbitrary limitation).
    +-#
    +-# However, because there's no implicit
    ++# remote. However, because there's no implicit
    + # +refs/heads/*:refs/remotes/origin/* refspec and supplying it on the
    + # command-line negates --prune-tags, the branches will not be pruned.
    + test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "name"
    + test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "link"
      test_configured_prune_type unset unset unset unset pruned pruned "origin --prune --prune-tags" "name"
     -test_configured_prune_type unset unset unset unset kept   kept   "origin --prune --prune-tags" "link"
     +test_configured_prune_type unset unset unset unset kept   pruned "origin --prune --prune-tags" "link"
    @@ -103,6 +113,18 @@
      test_configured_prune_type unset unset true  unset kept   pruned "--prune origin" "link"
      test_configured_prune_type unset unset unset true  pruned pruned "--prune origin" "name"
     @@
    + test_configured_prune_type unset  true unset true  pruned pruned "origin" "name"
    + test_configured_prune_type unset  true unset true  kept   pruned "origin" "link"
    + 
    +-# Interaction between --prune-tags and no "fetch" config in the remote
    +-# at all.
    ++# When all remote.origin.fetch settings are deleted a --prune
    ++# --prune-tags still implicitly supplies refs/tags/*:refs/tags/* so
    ++# tags, but not tracking branches, will be deleted.
    + test_expect_success 'remove remote.origin.fetch "one"' '
    + 	(
    + 		cd one &&
    +@@
      	)
      '
      test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "name"

-- 
2.15.1.424.g9478a66081

