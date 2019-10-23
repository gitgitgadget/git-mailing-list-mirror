Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806511F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 20:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405962AbfJWUjA (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 16:39:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39494 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405622AbfJWUjA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 16:39:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so7451460wra.6
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pu014hJTm6P4yZv15fR4bHqwFtE8hvVbXQ3yTQ1QptY=;
        b=nnhWEaMPpBivtwAD4hopmHl9jGLsmiSp+/m0QeNw3fdDCIqI1at1aZJ9/MIySKdRCq
         m+4saCBDO0k+ofSAG9BXwsG/R3sZPqvGjrSheZ8NJHjut7f7VNjbVAKmm2SW53GbQuYO
         a1VsUDNXOxr7tIbUiG9KJ7Xhre1ncetWlCpY0nP9zJTo6qa+/IDABA9VC07p3fCyMcah
         +if/05VqMOj+KbYairVkEA00JbmDYFZOPLJycNDmSuxZJgFzsrubzt6JzsSeHxea08Zu
         QB78fLLKZjgkdvWeuJouFNAlywsrn0SFa2ah1zCNdJn2jm6TgTAQFJMHR0LHHNEa5roI
         HD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pu014hJTm6P4yZv15fR4bHqwFtE8hvVbXQ3yTQ1QptY=;
        b=V1rO7wEsAo+lGijOsHvaKI1Ra/nXhMJ3WEXsGTJyyrh10VgTBHZxYFhM8WWgFpWDlX
         XyQCB38dp+yhBF7PO1PreIQTqiSPnGG/2hXQqIrMCJ22FPjx+IGjlf/Tq6W3IDXD8R9q
         vOWWz9VRRAU/yJhYtlv1rl+6qiYJeCJ61J7WuR+NdNrt1mIZm+ZNepv0CLcYNRI8UwHo
         VSU3Lg9cp/jSCMoFw5y5tVCK9997HGT4Va1ZST1R5zo/GrjqUGg05FQ3nAxVNRyNFv2g
         NIePPYkN1daojTB3/A6RM83luSB4syL1J845JXGQU04wmG0aOCYzcTGUeLG51uZgbpgT
         RyOA==
X-Gm-Message-State: APjAAAW2/8eJkv7LhhdID0ufWnE7BPzrZp7YFUzk3EvwvHZYaW/Ogqoa
        T0M+pdscmZUwbx4x0Z/b45Wo/l2V
X-Google-Smtp-Source: APXvYqyLSpEBk4poFLxEY9n2WbjP2XLZgcbZ45KpgMy9aYhNpj8J2zb/YdcIdJUsuG1+t8OKBdrEkQ==
X-Received: by 2002:adf:fcd1:: with SMTP id f17mr595980wrs.82.1571863138308;
        Wed, 23 Oct 2019 13:38:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm11371377wro.20.2019.10.23.13.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:38:57 -0700 (PDT)
Message-Id: <pull.420.git.1571863137.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 20:38:56 +0000
Subject: [PATCH 0/1] [v2.24.0-rc0 BUG] index.version is not parsed correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another bug related to changes I made in this release. This time
it's not due to a strange side-effect of submodules but rather that I was
careless while copy-pasting some boilerplate code.

Basically, most of the config options used in repo-settings.c are boolean
settings. Except that "index.version" is an int setting!

I found this while incorporating v2.24.0-rc0 into our microsoft/git fork and
consuming it in VFS for Git. We really care about the index having version
4!

The tests I added around how the index version is set were not adequate to
cover the case of only "index.version=4". Add a test to prevent this issue
from happening again.

Thanks, -Stolee

Derrick Stolee (1):
  repo-settings: read an int for index.version

 repo-settings.c  | 2 +-
 t/t1600-index.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-420%2Fderrickstolee%2Frepo-settings-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-420/derrickstolee/repo-settings-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/420
-- 
gitgitgadget
