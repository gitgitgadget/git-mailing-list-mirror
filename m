Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948E3200B9
	for <e@80x24.org>; Thu,  3 May 2018 00:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeECAyP (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 20:54:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40116 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeECAyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 20:54:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so11851498pgc.7
        for <git@vger.kernel.org>; Wed, 02 May 2018 17:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ehFCIz7kAQ80GHpl2grVhc8YiuhRJX7hNp7fH124XUo=;
        b=QrEiqhn+AglVjqogeoS2rzYvQgpZTqKLmJfK/PqKuvbEVwpnDhs/w9zRdKv6/cHiOm
         8H8myAxDZJIOEBgON+OTejPRYcFVO5ns3o3s+zbxOqtzXVW0wp5ECfRLsTI1zME57pid
         350CBxKfuYGJLqGp6EZM1l6WF6nNkCECysHQ/yQv3LXrVS3cfZGSbh4fcOOJrPmli0Kd
         hhacUO6emVhEztiWhxalgDx+GROHBVvZNxIBC8npiTN+WavzpCgMhNR4SfHAnpl+wyoW
         esjXdhyGxMwfezN5yTU9nTdy5iBXRLWgc5Wra0H6QW7BPmC2sgi6kE7dfCq46b+DmZkZ
         bF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ehFCIz7kAQ80GHpl2grVhc8YiuhRJX7hNp7fH124XUo=;
        b=dFiTDOmPo72TRCqYA6dHTueBTUXxehKcgo9OMLRuJAF7jv8A+JX78OJ2SgVEx+kLdh
         wS6aJIfURuc39lWFNW9udXUGc/iVlhc4noAugZCRPDaU2KE490s61uExUkBe7xOCWg+h
         Q6Dw1IcfLYUDf1GULc8vItOQE5DD2YxB/xi1pUkoJ2y1KWG79DxmDTu7BR9cBdPxWkwL
         W6uRBEKmLSut2xbjvR36KmPtt2s+/QMh1d53/Fxxnn5ffO0OyTGWLfllGrqwNK3N45bV
         IEtmwFY/vRtHaMss7HgRw/LvkbBgwmBaOHFIn/U6VDKujBWVhvGdfvHt7FbA9M1VbhaV
         A69A==
X-Gm-Message-State: ALQs6tAzr6nv1ozh/Xyxyqim0M/P2fQK/2+P9MerUjFqPLL48gmQBwBJ
        x1OpkuPf/JQClnlukUJ5amXkvw==
X-Google-Smtp-Source: AB8JxZom+NgeGDyYZdqU5ITeLHZru8XAOf4xuXtXE/lH2uvlFRXgGsUH3bOyH11FG15w/4lDPnbGAg==
X-Received: by 2002:a17:902:102:: with SMTP id 2-v6mr22245555plb.48.1525308853329;
        Wed, 02 May 2018 17:54:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a28sm26039253pfl.86.2018.05.02.17.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 17:54:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        christian.couder@gmail.com, pc44800@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] Rebooting pc/submodule-helper-foreach
Date:   Wed,  2 May 2018 17:53:53 -0700
Message-Id: <20180503005358.89082-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "What's cooking" email carried this series for some time now:
> * pc/submodule-helper-foreach (2018-02-02) 5 commits
>  - submodule: port submodule subcommand 'foreach' from shell to C
> - submodule foreach: document variable '$displaypath'
>  - submodule foreach: clarify the '$toplevel' variable documentation
>  - submodule foreach: document '$sm_path' instead of '$path'
>  - submodule foreach: correct '$path' in nested submodules from a subdirectory
> 
>  Expecting a response to review comments
>  e.g. cf. <20180206150044.1bffbb573c088d38c8e44bf5@google.com>

I reworded the commit message of the first patch and nearly confused
myself again, as "toplevel" doesn't refer to the "topmost" superproject,
just the direct superproject of the submodule.

However I think the code of the first patch is correct as originally presented.
Just the wording of the commit message was changed to explain the reasoning
more extensively.

With this series, we get
* keep the invariant of $toplevel + $path to be an absolute path that is
  correctly pointing at the submodule. "git -C $toplevel config" + $name
  allowing to ask configuration of the submodule.  
* $displaypath will have the relative path form $pwd to the submodule root.
* better documentation.

In later patches we could add $topmost, that points at the superproject
in which the command was started from, and $path_from_topmost, that would
be the relative path from $topmost to the submodule, potentially skipping
intermediate superprojects.

Thanks,
Stefan

Prathamesh Chavan (5):
  submodule foreach: correct '$path' in nested submodules from a
    subdirectory
  submodule foreach: document '$sm_path' instead of '$path'
  submodule foreach: clarify the '$toplevel' variable documentation
  submodule foreach: document variable '$displaypath'
  submodule: port submodule subcommand 'foreach' from shell to C

 Documentation/git-submodule.txt |  15 ++--
 builtin/submodule--helper.c     | 148 ++++++++++++++++++++++++++++++++
 git-submodule.sh                |  40 +--------
 t/t7407-submodule-foreach.sh    |  38 +++++++-
 4 files changed, 194 insertions(+), 47 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog

