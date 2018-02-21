Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A211F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeBUSv6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:51:58 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44611 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeBUSvx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:51:53 -0500
Received: by mail-wr0-f193.google.com with SMTP id v65so7353813wrc.11
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8FN+BujzMGz9dh3QKk0WkCR7qongy4T26rnGbhDrxU=;
        b=tuXBCSc8XFZb0EGH5d5YSM0s21MBoPxaH9QYlY3Z9esf4bdNaUhZs+gE68OLPx7hEi
         fFNpOTNFRoakem6YYhnAhvkl7X1M+KRTK/O4O5TQqAaE/hZJQW08dBhg8m6TZbvtedYY
         yV5FOLsTM/Ea2mp0yIF7XkbTlv4/NwOGcu6pEL1hqaOfFLBsil2aXiReOIeBfFlexp/l
         IRiO/B6cwRFHoSkCVb4ULqIT9nGgWYHZ/wzQrnhSF/U6mqHHBHXJ5g5AL7LT1K8ESB/P
         oLSop7O9mANERuceNh4SNkXKBsNjy8C9GN2ckYSoCo1VlJX7lM8kRVVK5hBS1yQOYzGe
         APEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8FN+BujzMGz9dh3QKk0WkCR7qongy4T26rnGbhDrxU=;
        b=doqTJeasgzkBVRFlV9O//MddbmC/g9BAg5Xq0lQJ/xoMvyBg5jwuigSlxHYFp4vv6i
         6rXY0mSPYU7PsAwmdIO7+iYJjdfgmcMx7UtT7QDk5UFZ5knycuHDhWhL6lYSqOpzCPjw
         p5ULpD0FNAOqvk+IV/6rv26BiCtUk39N+S27APD6FFHlnVNydkmEJp0B6dK9TkkgdGiJ
         tU/jUaufqcPgzC0GzymrHeCcoXvVwRdWwPCJ7obLY94RqU/MlpcAT2oBmR7/u/TMsx5q
         JyhSC7XxRumaVnER0NUw++c24LadxtysnIJx3L7xCrMeLPhvcH1E6KzpRj4TSHn5iMtb
         VPVw==
X-Gm-Message-State: APf1xPCmkjVEw9/g84fM9bxlLarSkX2gmPbG7IZwP2ulNujwuCm7nELA
        F8fJt3eL87gB2epDZvRz0rDgjTpF
X-Google-Smtp-Source: AH8x2252+C6Uhp+Z3UWxH7ggXzrjbS1Fs6bFbW5kGboGM1rvSc6bh6vfsxnu0MwCnYPjy6L+CLslNQ==
X-Received: by 10.223.138.203 with SMTP id z11mr3272606wrz.199.1519239111420;
        Wed, 21 Feb 2018 10:51:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 128sm5224964wmi.20.2018.02.21.10.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Feb 2018 10:51:50 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] Re: t7006: add tests for how git config paginates
Date:   Wed, 21 Feb 2018 19:51:41 +0100
Message-Id: <cover.1519238410.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of my series to teach `git config` to only respect
`pager.config` when listing configuration, then changing the default to
"on". Thanks to Duy and Junio for feedback on the first version.

Based on Duy's feeback, I've changed the approach to more carefully
divide the various getters into "may produce multiple lines, so let's
page" vs "may not, so don't".

Junio hesitated whether we should add tests using `test_expect_success`,
then flip the test-definition, or whether we should start with a
"failure" that we then flip to "success". I have not done anything about
that, except to try and motivate the choice better in the commit message
of the second patch.

Martin

Martin Ågren (3):
  t7006: add tests for how git config paginates
  config: respect `pager.config` in list/get-mode only
  config: change default of `pager.config` to "on"

 Documentation/git-config.txt |  6 ++++++
 t/t7006-pager.sh             | 49 +++++++++++++++++++++++++++++++++++++-------
 builtin/config.c             | 10 +++++++++
 git.c                        |  2 +-
 4 files changed, 59 insertions(+), 8 deletions(-)

-- 
2.16.2.246.ga4ee44448f

