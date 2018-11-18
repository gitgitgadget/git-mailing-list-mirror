Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_BLACK,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363531F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 13:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeKRXuL (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 18:50:11 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34382 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKRXuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 18:50:10 -0500
Received: by mail-wr1-f47.google.com with SMTP id j2so873919wrw.1
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 05:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjUi8TnZuJCpNo9mca36g+wF+vfeGvlhjiPJQMqKfDc=;
        b=q5UcuEORr9qBkcstfHjjQgDeYs0wM3d8yN4AEhluoR/QROZE+ii854k+rfKvzvd0wS
         8JOvLWvHxIfmOj0FiyAXf5CQnXIXQc6ehQnHyEbHHdiGd7hzNpNL78Nb0Kr1PyUEbz7h
         cDPYLFxhNMTEMeldVcGQ6SbB/2sm6D7gGabo6lF7COJu5DoFjeh1LyNkynqfpirZ4flx
         B2b8wOVpeB/N8ZBRiXOcQB6o7vYv7WRXrftXeiTd6oSCXkzTxLlHXTGxp/VdOWJfGt3F
         iqOi0UAcWvx1X1nTT7MPU3iuSV5UatyY1mC7jOvHYSQiDuQg2+M75mFulPL1mv9Z6jTQ
         w65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjUi8TnZuJCpNo9mca36g+wF+vfeGvlhjiPJQMqKfDc=;
        b=LAPhXtMaAE3lBtvAss7u2cL99qhCUwdME2j4HJ6YWiWqfX9bOZ+oKCfAQquICiJv/b
         Lfv61GD+/OXT5g2/GvNk12rMsUl2pjti1b8YlIjFYSeghSaRwYCULPUF9ufh2LLUF5rh
         d1/4IdoLI61GrZuwE7iagoFX4XMlbiqUnrmm4NtHoeinjiPSMnoemODEumdwT/wDiDW9
         neu6+o/qwtPqcN6OR4vbiQ9GbO4qYi1p48wVaNrZDolbUbEAye6VdGqx01Vm6HUbG6yc
         mm8WyFMT8moHnqPMy4KlQuUQRgTE00m+lkyRRXfECHYC6mOysMjTJg0pPd0ySiFtlBbH
         6hCQ==
X-Gm-Message-State: AA+aEWYy4gI1c+do2CSfex0Q9zb/QAHPBQajsC9xpTl2B9BvakKuvug4
        CWrvBowiKeb7uaxmHhn9rh0=
X-Google-Smtp-Source: AFSGD/Xu4Iffazjg6tuIukr/W72CwJxBkUKBuQe5vh6YA0RS8Fn4hAFUfhud1hB88hbv4P0LY88s3g==
X-Received: by 2002:adf:e951:: with SMTP id m17-v6mr8013478wrn.126.1542547789662;
        Sun, 18 Nov 2018 05:29:49 -0800 (PST)
Received: from localhost.localdomain ([31.223.156.141])
        by smtp.gmail.com with ESMTPSA id t4-v6sm21426718wrb.67.2018.11.18.05.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 05:29:49 -0800 (PST)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: [PATCH 0/1 v3] make stash work if user.name and user.email are not configured
Date:   Sun, 18 Nov 2018 14:29:15 +0100
Message-Id: <20181118132915.9336-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.1052.gd166e6afe
In-Reply-To: <20181114221218.3112-1-slawica92@hotmail.com>
References: <20181114221218.3112-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
	* squash patch 1/2 and patch 2/2 into a single patch
	* modify first part of test when there is valid ident
	  present: create a stash, grab %an and %ae out of the 
	  resulting commit object and compare to original ident
	  
Slavica Djukic (1):
  stash: tolerate missing user identity

 git-stash.sh     | 17 +++++++++++++++++
 t/t3903-stash.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

-- 
2.19.1.1052.gd166e6afe

