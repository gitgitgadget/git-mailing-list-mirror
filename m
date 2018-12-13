Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A089211B3
	for <e@80x24.org>; Thu, 13 Dec 2018 14:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeLMOEV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 09:04:21 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33488 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeLMOEV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 09:04:21 -0500
Received: by mail-pg1-f176.google.com with SMTP id z11so1127000pgu.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CGNlxA4yUYRtCesszFirRSAaBvwXkTnaulVFCM1HPpc=;
        b=Vom/28v5fp3F4/Jd1QMmA0eTnZoQIuxfvHW1HjKIozwbNAvF1ovVbwvENt/8v4Bybs
         w3FYFtmnEH4HJD+LdIri/zlu3az0BoZWM8ubeySotai61nRUbqnSS3K25Amp4PEoFwIW
         v3YLNDOSICJD8hd46bFqc9CczZg7aPp9BWGuJdU5MmVFxwtNT1dlvkj7KqaQMMXa1lYR
         KpqBKF2+ueFB3tJ5eP0xWEiSLar0pbabrhz1ChHijG0lv120gHNVxGfZBZK+23Tpghwp
         LqVARPYlNLZGiOUcrksh0ZzqhmMGxGHfRtk9DqeOS7qlIEjnHUFoY0w0T2gXA9GkJ5i/
         Dp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CGNlxA4yUYRtCesszFirRSAaBvwXkTnaulVFCM1HPpc=;
        b=SrNz8UaAt6NMBJJS/6iS0QFre2ZXW/Z9+D2gPP9cuEmm/xW8DEEux4H3vZk84DXnWj
         2NLJ/M/wGGdge8wPpuOntiWHyrsCAl21SGfdIK3YBmoo5Xo/IkqCqHNhm5wb728NblYr
         jwfScwLnHB7HbwbHDaDL1nGLg5IodwXLkt+6M40ltBNn2UJVAycevntjz993Wf8/fySb
         XvswAqYEehxioFOeECmVklgWoDTof0QlDsBpKaYLOQq/xHNOmPCQTGacUYgYRVCYoFSb
         zkDimM5m9DKT/eDjw9h8pDAxji7ZNNkHIsmVMqcTnVnqw/8Tk4EcILZFXRHWrwF1/Sxu
         75Qg==
X-Gm-Message-State: AA+aEWZPLQyPa46ERyUnJYMR5lWsXm2EiSE3dZe1IGMr31VFJiwtzzyr
        TM4PAtBUXTHKeCBErX1xzLfaIQUx
X-Google-Smtp-Source: AFSGD/VotQTkfziNGncbjAsxS14SDOim6R47Grtn3nOQ3po5/GqFtfNOQqfgt3w4lhdR7iDhHiFAVg==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr20206458pgd.97.1544709859339;
        Thu, 13 Dec 2018 06:04:19 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id h134sm4012378pfe.27.2018.12.13.06.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 06:04:18 -0800 (PST)
Date:   Thu, 13 Dec 2018 06:04:18 -0800 (PST)
X-Google-Original-Date: Thu, 13 Dec 2018 14:04:15 GMT
Message-Id: <pull.99.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.99.git.gitgitgadget@gmail.com>
References: <pull.99.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Fix regression in t9902 with NO_PERL
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

The oneline notwithstanding, 13374987dd (completion: use _gitcompbuiltin for
format-patch, 2018-11-03) changed also the way send-email options are
completed, by asking the git send-email command itself what options it
offers.

Necessarily, this must fail when built with NO_PERL because send-email 
itself is a Perl script. Which means that we need the PERL prerequisite for
the send-email test case in t9902.

Changes since v1:

 * replaced the commit message by the cover letter, as it was deemed to be
   more informative.

Johannes Schindelin (1):
  t9902: 'send-email' test case requires PERL

 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-99%2Fdscho%2Ft9902-no-perl-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-99/dscho/t9902-no-perl-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/99

Range-diff vs v1:

 1:  32e6bf2dd3 ! 1:  8e3ddff2c7 t9902: 'send-email' test case requires PERL
     @@ -2,14 +2,14 @@
      
          t9902: 'send-email' test case requires PERL
      
     -    With NO_PERL, the `git send-email` script errors out with code 128,
     -    mentioning that Git was built without Perl support.
     +    The oneline notwithstanding, 13374987dd (completion: use _gitcompbuiltin
     +    for format-patch, 2018-11-03) changed also the way send-email options
     +    are completed, by asking the git send-email command itself what options
     +    it offers.
      
     -    Therefore, when the completion tries to ask for possible completions via
     -    `git send-email --git-completion-helper`, it won't provide what is
     -    necessary for that test case to pass.
     -
     -    So let's mark it with the PERL prerequisite.
     +    Necessarily, this must fail when built with NO_PERL because send-email
     +    itself is a Perl script. Which means that we need the PERL prerequisite
     +    for the send-email test case in t9902.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      

-- 
gitgitgadget
