Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28C91F491
	for <e@80x24.org>; Sat,  2 Jun 2018 11:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbeFBLuy (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 07:50:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35335 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeFBLux (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 07:50:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so6667400wme.0
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOIinjqFC/cJ2qRho2ZUnVV6x8M9LHvVqq+Juq7gOTk=;
        b=tddfd027w6kL3p0OorVOFaA7NnLrpri57wLTq0w9yQjAAZUKJb6XejHlr0VfCt6Ksm
         1Si947RwutQLRpOYoHaRiJ++WcOALg7WAJK2rjr50sMxSQR3tKDb86TEiVhY0m5FjGpt
         dou3rY1w6SpvnWmhoa9gWe5a6PfyG2G0dCIs6L3M40prEQ2QAWFGf6sDk5JiK6XL5CFY
         4GSWaURI+e0lt3Ajvl2QrJ0YiPFkHau0BWEm3Rbbev17BQ5I2Q8gifSfewZruwvGDuyH
         JNa/FWRs6PDG9VGvKLe90XZnm9IpcnD4Po61Ve1EDZ1YKWQMvNXMfHA5KyPVLGEpglA4
         H7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOIinjqFC/cJ2qRho2ZUnVV6x8M9LHvVqq+Juq7gOTk=;
        b=GOTVZPnp5EvZwH6M6WLGHm9cVSusH2pAJbZ0UPfOObnQKduk2HwxOKC5GCzTVhy1np
         OxYJ66O8A+XTk4gvm92XJrMGtz9apFfd/0PnfRgM37cmziDBOHxe/2GtfenM+d1gG+Ev
         K2SykA36giMiX37MZeTQYaz7q7RkL8V6PeUhQOH0neRBxINQDkImHg9rdkLT2C+umzYq
         1GTIAuh4lPEEGIyIMRzCR3pujW9fOz5vMVc3/EdnAQQZfSPZaYBjobbeRbEMRe1ywi+B
         5SefMGno//eOFhBz08KSCggIkcQjNTdNMQ1fvAHR5C5ug7qGIR6sRtHGezf1zc+iLZm5
         hndA==
X-Gm-Message-State: APt69E0nOTG6xzNgwoV+nox52DEHjxvOoeoGZbOHqhsti1/nxMj6mCxV
        1LhrHjxZbvTml8pGE7IPd4buNVvw
X-Google-Smtp-Source: ADUXVKIyeDSNP3M6TnLeoWWUnwqd3wfWmUIU6ixVNWFgDEBPR2EKPAPenGa3TcEQcqaysOl6pDIVyg==
X-Received: by 2002:a1c:7ce:: with SMTP id 197-v6mr1070536wmh.134.1527940251529;
        Sat, 02 Jun 2018 04:50:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v31-v6sm58977794wrc.80.2018.06.02.04.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 04:50:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 0/8] ambiguous checkout UI & checkout.defaultRemote
Date:   Sat,  2 Jun 2018 11:50:34 +0000
Message-Id: <20180602115042.18167-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Typo & grammar fixes suggested by Eric Sunshine. tbdiff from v5:
    
    1: ab4529d9f5 = 1: ab4529d9f5 checkout tests: index should be clean after dwim checkout
    2: c8bbece403 = 2: c8bbece403 checkout.h: wrap the arguments to unique_tracking_name()
    3: 4fc5ab27fa ! 3: 881fe63f4f checkout.c: introduce an *_INIT macro
        @@ -1,6 +1,6 @@
         Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         
        -    checkout.[ch]: introduce an *_INIT macro
        +    checkout.c: introduce an *_INIT macro
             
             Add an *_INIT macro for the tracking_name_data similar to what exists
             elsewhere in the codebase, e.g. OID_ARRAY_INIT in sha1-array.h. This
    4: fbce6df584 ! 4: 72ddaeddd3 checkout.c]: change "unique" member to "num_matches"
        @@ -1,6 +1,6 @@
         Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         
        -    checkout.[ch]: change "unique" member to "num_matches"
        +    checkout.c]: change "unique" member to "num_matches"
             
             Internally track how many matches we find in the check_tracking_name()
             callback. Nothing uses this now, but it will be made use of in a later
    5: 6e016d43d7 = 5: 5e8c82680b checkout: pass the "num_matches" up to callers
    6: 07b11b133d = 6: 07e667f80a builtin/checkout.c: use "ret" variable for return
    7: 97e84f6e1c ! 7: 0a148182e6 checkout: add advice for ambiguous "checkout <branch>"
        @@ -8,9 +8,9 @@
                 exactly one remote (call it <remote>) with a matching name, treat
                 as equivalent to [...] <remote>/<branch.
             
        -    This is a really useful feature. The problem is that when you and
        -    another remote (e.g. a fork) git won't find a unique branch name
        -    anymore, and will instead print this nondescript message:
        +    This is a really useful feature. The problem is that when you add
        +    another remote (e.g. a fork), git won't find a unique branch name
        +    anymore, and will instead print this unhelpful message:
             
                 $ git checkout master
                 error: pathspec 'master' did not match any file(s) known to git
        @@ -19,12 +19,12 @@
             
                 $ ./git --exec-path=$PWD checkout master
                 error: pathspec 'master' did not match any file(s) known to git.
        -        hint: The argument 'master' matched more than one remote tracking branch.
        +        hint: 'master' matched more than one remote tracking branch.
                 hint: We found 26 remotes with a reference that matched. So we fell back
                 hint: on trying to resolve the argument as a path, but failed there too!
                 hint:
        -        hint: If you meant to check out a remote tracking branch on e.g. 'origin'
        -        hint: you can do so by fully-qualifying the name with the --track option:
        +        hint: If you meant to check out a remote tracking branch on, e.g. 'origin',
        +        hint: you can do so by fully qualifying the name with the --track option:
                 hint:
                 hint:     git checkout --track origin/<name>
             
        @@ -97,12 +97,12 @@
          		int ret = checkout_paths(&opts, new_branch_info.name);
         +		if (ret && dwim_remotes_matched > 1 &&
         +		    advice_checkout_ambiguous_remote_branch_name)
        -+			advise(_("The argument '%s' matched more than one remote tracking branch.\n"
        ++			advise(_("'%s' matched more than one remote tracking branch.\n"
         +				 "We found %d remotes with a reference that matched. So we fell back\n"
         +				 "on trying to resolve the argument as a path, but failed there too!\n"
         +				 "\n"
        -+				 "If you meant to check out a remote tracking branch on e.g. 'origin'\n"
        -+				 "you can do so by fully-qualifying the name with the --track option:\n"
        ++				 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
        ++				 "you can do so by fully qualifying the name with the --track option:\n"
         +				 "\n"
         +				 "    git checkout --track origin/<name>"),
         +			       argv[0],
    8: a5cc070ebf ! 8: f3a52a26a2 checkout & worktree: introduce checkout.defaultRemote
        @@ -175,8 +175,8 @@
          	 *   (c) Otherwise, if "--" is present, treat it like case (1).
          	 *
         @@
        - 				 "If you meant to check out a remote tracking branch on e.g. 'origin'\n"
        - 				 "you can do so by fully-qualifying the name with the --track option:\n"
        + 				 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
        + 				 "you can do so by fully qualifying the name with the --track option:\n"
          				 "\n"
         -				 "    git checkout --track origin/<name>"),
         +				 "    git checkout --track origin/<name>\n"

Ævar Arnfjörð Bjarmason (8):
  checkout tests: index should be clean after dwim checkout
  checkout.h: wrap the arguments to unique_tracking_name()
  checkout.c: introduce an *_INIT macro
  checkout.c]: change "unique" member to "num_matches"
  checkout: pass the "num_matches" up to callers
  builtin/checkout.c: use "ret" variable for return
  checkout: add advice for ambiguous "checkout <branch>"
  checkout & worktree: introduce checkout.defaultRemote

 Documentation/config.txt       | 26 +++++++++++++++
 Documentation/git-checkout.txt |  9 ++++++
 Documentation/git-worktree.txt |  9 ++++++
 advice.c                       |  2 ++
 advice.h                       |  1 +
 builtin/checkout.c             | 41 ++++++++++++++++++-----
 builtin/worktree.c             |  4 +--
 checkout.c                     | 37 ++++++++++++++++++---
 checkout.h                     |  4 ++-
 t/t2024-checkout-dwim.sh       | 59 ++++++++++++++++++++++++++++++++++
 t/t2025-worktree-add.sh        | 21 ++++++++++++
 11 files changed, 197 insertions(+), 16 deletions(-)

-- 
2.17.0.290.gded63e768a

