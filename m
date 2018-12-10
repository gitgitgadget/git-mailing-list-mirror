Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E295820A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeLJSrP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:47:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37873 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeLJSrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:47:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so5822393pfb.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1QaAWT0R1I2OrpRntjNQuPqJGMDgt9n8Mf3eyNG5vR8=;
        b=qU7LfdZK/ydvVnEHh2RzPbKoCbpYry3xfrlHXFJsd5pSh1sA3Ouv02gprWdEZkuo70
         ovR4V5FFbldqqcbh8N4Wb4X/TiGjUFI62hrrMODxcoRo9P8GDTIxojBrxgrIeh/Tii0J
         VR3ykslCRrl3ZkFwflYHn8jd1ONTTvI433pm0XFN+2BmxzE8g9AYca0lHuswOK+5EqKe
         UUlEcsBx+QnlKNen2vk3l5oMjtDiTI5TXmKpw4JpR6HIT3PraTzBhMPRyyLYoMc2XgdN
         2V16neNF0qAVQAvqYVwigolujN9VEPEQl3Vdkp5YfGWgowweM5mlo7/ZsBXqfPAmGPW5
         OKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1QaAWT0R1I2OrpRntjNQuPqJGMDgt9n8Mf3eyNG5vR8=;
        b=um2mv9jbXOUzOu++z2yEMnbNRe5O56BOhIIIPMmA0LNNies8EzqU4zkmy+Zg83n1Jd
         YmoCerbk9/Ibf/ozW6V+Tf2qh8ZVlTMK4BOXIM4Ko+S1n0BAL4Ylt7f1Jv9INHIPgmWo
         1N6t2gh/uixKu9ZtneXFDSRcW6LG0DDY8xhFWBI0N5maJ5rO6pAQd11Tx22WX6G+A4Nl
         E/CmUvn4UKrxgSZ2o6gZIRDvZ0/yIEJmRm9RFe0t7UX8f4I0i+GYTTmOgpf6NeilRhUd
         5Ee2e47M/Ot/+hfKgkJOBtfGgfSR30hIta0M27SU6vfc1zU9UgE5DzQXggGY+hf/N6cD
         Wa6A==
X-Gm-Message-State: AA+aEWbmrF8HOSvFGCE/opctYRU5Gm73qtufk/+Tp0YIIralyorNyksz
        J/ieNPLle8fpW1zmhydBdNs0Xt0i
X-Google-Smtp-Source: AFSGD/VADZfoxKH3vPrdqr4RhLtQaUr2Ou7u8LJj/074owVyMSKQNUbJ08yDfiHLjHRqRBGItpm3EA==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr11728167pgf.33.1544467633590;
        Mon, 10 Dec 2018 10:47:13 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v13sm18987497pff.20.2018.12.10.10.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:47:13 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:47:13 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:47:09 GMT
Message-Id: <pull.96.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] mingw: support absolute paths without a drive prefix
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

On Windows, when using a path like \hello\world, it is silently understood
to be absolute, but relative to the current directory's drive.

Let's support that, too.

Johannes Schindelin (2):
  mingw: demonstrate a problem with certain absolute paths
  mingw: allow absolute paths without drive prefix

 compat/mingw.c            | 10 +++++++++-
 t/t5580-clone-push-unc.sh | 19 ++++++++++++++-----
 2 files changed, 23 insertions(+), 6 deletions(-)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-96%2Fdscho%2Fdrive-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-96/dscho/drive-prefix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/96
-- 
gitgitgadget
