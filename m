Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9A5211B3
	for <e@80x24.org>; Mon, 24 Dec 2018 22:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLXW4G (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 17:56:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34315 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXW4F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 17:56:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so10835843ede.1
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 14:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=018kGNMIx4vwrIdFuve8YLfnsUp0M5RBh5oxmZMgKUU=;
        b=hzDigVBEO5hxmyefOL28kpRpg3I8c+kAvDRXfCZnLGLHQNADcVMKd3AFbtbaLTaYGe
         h3cJnq67b3hk5U/5Qp3tEJ4L+cDWYDa3AGAlqbRvtg7RhDqZ1sfmU6bZ/qtx0MA6feMe
         HHy39eNQJIApHYF9DW7dniUANS3rYboOSojKDX2K8P+TfDDWf9DZapafeE6LO3FiwGCD
         h7U+YI7dz5ZDkNrr0uTHcoZaEUdzJax7yElNk+zJpSVoHwjvF2olhKFk2MY6zlRDCpFO
         5/US77dcUOPe3ZjyvG9228OSCX1sJKy+BpICYsqjBA1Ixu/7VVCbYdLPGH4IP5Pj+p9H
         3QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=018kGNMIx4vwrIdFuve8YLfnsUp0M5RBh5oxmZMgKUU=;
        b=VKYS40xdX2VF/rOAgoANcjSMPkhY9IP7RF6IuqbCyrMpBlfgbNOKSukBO4d5TgoRlZ
         PgL2f+Qw0WleFGa2CL1Or7DDynEfEDCEdbFtYKOpaySdj7GUttxVfsry/9Twb8cFl5De
         ExYCYbJsTdYOKTlATM4y8PBC5MUurYjp99rMgisz/I7Oxvv3PZav4v/ZiC77AgA54vW1
         ZMvtQSwOqE3ZprLqf6Xhr5syfKvOGnmtiYzU86BmfBYqxeg3ZzCcSe6Jpmye9vdBimuS
         JaKkit9fQsN+FqzgemNy74CIE6wH1RlB5qVJ4AwKyck+bVx4s40p0k1pSV1wnSOMDvX0
         M7ng==
X-Gm-Message-State: AA+aEWb9nBS9JwHNLyWYUA9DXjwUoSzQNZEH73eMVAeiJ98GRDZrGsll
        s471/AIFw47p3NC6WAtFJue5YZdH
X-Google-Smtp-Source: AFSGD/X/xGWeb9i0wpqvOsbbquDQpucvWKhfFsjY1MB7WkO2EputImxyJsbfciap0hXbuFJS9S7WLg==
X-Received: by 2002:a50:9724:: with SMTP id c33mr11567933edb.288.1545692163858;
        Mon, 24 Dec 2018 14:56:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm9377361edd.25.2018.12.24.14.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 14:56:03 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:56:03 -0800 (PST)
X-Google-Original-Date: Mon, 24 Dec 2018 22:56:01 GMT
Message-Id: <pull.104.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.104.v2.git.gitgitgadget@gmail.com>
References: <pull.104.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/1] Make abspath() aware of case-insensitive filesystems
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is completely legitimate these days to call git add with absolute paths.
Of course, on a case-insensitive file system, users rightfully expect the
argument to be handled case-insensitively, too. This patch makes it so.

Git for Windows carried this patch for over one and a half years already, I
think it is time to get it into git.git.

Change since v2:

 * Replaced MINGW prerequisite in the test by CASE_INSENSITIVE_FS. v1 was
   sent out without a change by mistake. Sorry.

Johannes Schindelin (1):
  abspath_part_inside_repo: respect core.fileMode

 setup.c        | 6 +++---
 t/t3700-add.sh | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)


base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-104%2Fdscho%2Fcase-insensitive-abspath-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-104/dscho/case-insensitive-abspath-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/104

Range-diff vs v2:

 1:  3eaec10c46 ! 1:  b935e11d21 abspath_part_inside_repo: respect core.fileMode
     @@ -47,7 +47,7 @@
       	test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
       '
       
     -+test_expect_success MINGW 'path is case-insensitive' '
     ++test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
      +	path="$(pwd)/BLUB" &&
      +	touch "$path" &&
      +	downcased="$(echo "$path" | tr A-Z a-z)" &&

-- 
gitgitgadget
