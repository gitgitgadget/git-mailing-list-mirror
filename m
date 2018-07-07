Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A39E1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 20:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeGGUoO (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 16:44:14 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:44577 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeGGUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 16:44:13 -0400
Received: by mail-yb0-f173.google.com with SMTP id a2-v6so5838998ybe.11
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l1OyqXu88em3wfddI8kIUf3Kszbswqo21D/IFbQseXQ=;
        b=g04o9rlp8vPucNEBSpJg7Bx/2IJqym8gQcdRtlI3iCkUDyau78mBhhr48CJg1dLeLk
         XSz5S83TGdbyvKdEF2ULhPIr6QkGXMZWF1FbxZ3pVyml9d+ouoleOY8PFMQeG4YR/HtC
         cZ32LyVkX9+glnnL2PvrIm6k/DfX2ca0lQdt2mi2dDWGcurAs9ZudVFQ9fJftqHcrjnv
         ZzhBfF3940764T8Y55NyYQEKWmokAnX+SfUaM3GqTx47awKn8Eigx2lTtXs8n063PhYR
         MJbPwCaH/ri8iVWDE44vaTVmtk+dzhmcuHoFFNcyt9uFerxYHbIsW2YHmwjtyLHQ2o4v
         ehSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l1OyqXu88em3wfddI8kIUf3Kszbswqo21D/IFbQseXQ=;
        b=tpRLYfa3EdtB9kGfJ0fee8EROZIbdjBfevENPIswissyMnjAsD6ke7+SjBQR/8InoZ
         VePub1picQH1UJN4wg4ZrGb/mmtzGBF8tZ8botKkoUIU2FQWbQMcHRQqte/q5+UKjbgf
         JWK7oHOiGi+iE3nZQvOGXyAibGJwy659ctTwMDoxDo8CgujUupdvDuRm4B21Hcnv6qXD
         mCFyVVGiOb1/v9Rf/oPNTqzINkNJ9FdxBRJPEX5xvm9DXrpkkpDu4hr15/0+XfA8XNvA
         i1LTsR5iSpXXSxWCzd13HQ3ApbQP+U5/tRS7zZxaZcWey9nL6SgOvbKBdChfDv1X1cDr
         rs7g==
X-Gm-Message-State: APt69E1sQjteT4kfrCoMGwqCCtbzITfI6Mfh4kjQe/UC9fu2L1xAMr0d
        AQVdXtiWf9TEwbwIrRWEp5rLkw==
X-Google-Smtp-Source: AAOMgpfRTyiZJVS274yfD7O/ibOYhbzcIiWOzRgdh6rBRSSY3+wwr92Z2xVkW2jw4g2fbHB7zqa0uw==
X-Received: by 2002:a25:c002:: with SMTP id c2-v6mr7811772ybf.466.1530996252389;
        Sat, 07 Jul 2018 13:44:12 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4535058ywd.21.2018.07.07.13.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 13:44:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/3] Add testcases showing suboptimal submodule/path conflict handling
Date:   Sat,  7 Jul 2018 13:44:01 -0700
Message-Id: <20180707204404.7208-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.134.gafc206209.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Last November, Stefan asked me about an issue with submodules.  In
addition to providing a fix for that issue, I mentioned a few other
problems I noticed with submodules and merging[1].  Turn those issues
into testcases (as I probably should have done back then).

[1] https://public-inbox.org/git/CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com/

Elijah Newren (3):
  t7405: add a file/submodule conflict
  t7405: add a directory/submodule conflict
  t7405: verify 'merge --abort' works after submodule/path conflicts

 t/t7405-submodule-merge.sh | 173 +++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

-- 
2.18.0.134.gafc206209.dirty

