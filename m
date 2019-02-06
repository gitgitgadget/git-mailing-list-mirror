Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11277211B5
	for <e@80x24.org>; Wed,  6 Feb 2019 18:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBFSpU (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:45:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45273 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFSpT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:45:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id t6so5529295edw.12
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5fW6OOV18E16BrbmgnNj6STaGyYsMAqIs04k88N4FK8=;
        b=rQ90kIFmu1nDOXHfmsbOKGtruaVCGJhMEQdaDOhXkNlcG5ivdXw4k8iZvGOBgwQ8Fw
         rVbYGDPjAE/ZNSyw7pTgYeQnRDoENIMkd6+4O42q0ZIfJGLu1mRJyZoM6BpsTt6LsyiF
         9pmIrBFHSy6+eY68Kz5kEk8wGtUtG0FQ2UBOrXxDNw88JJtD5MLhcuZKPKVsqFTL+kt2
         zW2pnByzcttB9alkWQPW3Lec4V57CtlRw2yfcXT4iE1hhkjUqna1X6v9zKdwtNy7oUCN
         XTVkypOAI8bROJK3msECkZjZvFCSq14UJCstYOIhxqJd4aLTbz1tKP5VHxpJs+3enImn
         N/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5fW6OOV18E16BrbmgnNj6STaGyYsMAqIs04k88N4FK8=;
        b=cn7EObPh0fcGHhW84nyiPUISKMmUj8DL0gf6AdAmKInemJtTze7VD7ETK6JJOm+82R
         xvzqrIPX4eJawSpMX1VU76iMyhP0s+EPljPsjOYKZtH/9Sd5KWW2MpDGIN+hcpUmCryj
         K4VCC7VdsmZlbvBKglKgu3gSkA99tOXGA/BBdvovXTQLFfMuYUJZngGZLP8o8rNwUhA6
         +Lq1a5VY6NlzpIZfmKOdcH8WT0WP44kLdUnqvVcjMSCSb0AiP2OHZPdi4BZjPIGW3g4P
         C5PaqINbQpiUYN1RV8dweH9C7XOGW3vm85FFDLa0zOQsu37R5EH6jhTDgNR5H43icuuE
         OLYA==
X-Gm-Message-State: AHQUAub7jsoC2Iat2MQT6ycAdOQDyTOZApDTAHTdfpoEr0zkVJaMnRDX
        Wcf/HWUSOxVUGIiFT27YJUQT/0tj
X-Google-Smtp-Source: AHgI3IbDYXsxre0lSVro8f+6wdIWMNdAoi4ZJAFFxi+kjTYuBZP0W14oO2ufIbHtpGmrO/qqfSpkYg==
X-Received: by 2002:a50:9665:: with SMTP id y92mr9084974eda.282.1549478717636;
        Wed, 06 Feb 2019 10:45:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g37sm6300831edb.85.2019.02.06.10.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 10:45:17 -0800 (PST)
Date:   Wed, 06 Feb 2019 10:45:17 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 18:45:14 GMT
Message-Id: <pull.118.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.118.git.gitgitgadget@gmail.com>
References: <pull.118.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] rebase: drop the unwanted -y 
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

I totally missed that this patch made it into next, and then master. Sorry
about that.

Changes since v1:

 * Focused on the "why?" in the commit message.

Johannes Schindelin (1):
  Revert "rebase: introduce a shortcut for --reschedule-failed-exec"

 Documentation/git-rebase.txt |  6 ------
 builtin/rebase.c             | 21 ---------------------
 git-legacy-rebase.sh         |  6 ------
 t/t3418-rebase-continue.sh   |  3 ---
 4 files changed, 36 deletions(-)


base-commit: b5101f929789889c2e536d915698f58d5c5c6b7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-118%2Fdscho%2Frevert-rebase-y-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-118/dscho/revert-rebase-y-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/118

Range-diff vs v1:

 1:  e61ebc3060 ! 1:  a4857fb32d Revert "rebase: introduce a shortcut for --reschedule-failed-exec"
     @@ -2,22 +2,20 @@
      
          Revert "rebase: introduce a shortcut for --reschedule-failed-exec"
      
     -    When contributing the patch series, the cover letter tried to convey
     -    clearly that the patch introducing the shortcut -y was included only to
     -    show that it is possible, with a slight bias against it.
     +    This patch was contributed only as a tentative "we could introduce a
     +    convenient short option if we do not want to change the default behavior
     +    in the long run" patch, opening the discussion whether other people
     +    agree with deprecating the current behavior in favor of the rescheduling
     +    behavior.
      
     -    During the review, there were a couple reviewers who agreed with this
     -    sentiment, and the author was happy that this patch was not needed and
     -    concurred that it should be dropped. See e.g. Stefan Beller's reply:
     +    But the consensus on the Git mailing list was that it would make sense
     +    to show a warning in the near future, and flip the default
     +    rebase.rescheduleFailedExec to reschedule failed `exec` commands by
     +    default. See e.g.
          <CAGZ79kZL5CRqCDRb6B-EedUm8Z_i4JuSF2=UtwwdRXMitrrOBw@mail.gmail.com>
      
     -    However, it slipped by the original patch author (yours truly) that the
     -    patch *was* included when the branch made it to `next` and then when it
     -    made it to `master`.
     -
     -    So let's back out that patch before it even slips into an official
     -    release (in which case we would even have to support this unwanted
     -    flag).
     +    So let's back out that patch that added the `-y` short option that we
     +    agreed was not necessary or desirable.
      
          This reverts commit 81ef8ee75d5f348d3c71ff633d13d302124e1a5e.
      

-- 
gitgitgadget
