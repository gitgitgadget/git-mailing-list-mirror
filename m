Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5ABE1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfGZU0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:26:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37933 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfGZU0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:26:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so16459081pgu.5
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9otzOOPm/xgobry+Pu0tswrqWoROtmckoyjYOj8o+Ys=;
        b=kXG8Omg+WPUL5eDwb5e2H2431cKkh5X87bho61e/OAW0+L2cHQh/SMdx+v2m9VsD9G
         6QfGdq6qdlw568cD9arPd9cqOZQFobBoUX26K7bXCA2mnMh4Qt7/YVPgXCrEz9ZKDA1E
         cX1qROZd3Sh7L63lXq2xB0AAmFzkl3d1U2bYdeCuH+kV93uC9wGKOO8Cdh8M8pOJLCcL
         qm2H5PkfwSZIOIb/eXrMHv2t5WE6psG49E0xvuSt0O0667MJvmxHPdUfHeG110fuG3o9
         yjOMT6lR9cos5Pj5qj1uitTHSJrGpmNHoUCU/asOSIJQ77eLZpFx5HTkA7em+63VPV/t
         W14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9otzOOPm/xgobry+Pu0tswrqWoROtmckoyjYOj8o+Ys=;
        b=O7BXWgywBk7VpK30solUlDFWoCNpviTUg5iUMl4jb/QXkQWTFUOTj9oo6T8ArjtNgj
         JCJc5tLVooVtb7Oh4tl3UjndP/XOtwormQFX6s8a9jW/XGaB2bbjU8LJum61GyG42c+f
         arQ0iEiQt99Zma1CW56wwtV2KKIxy7fX7aEjVjOjaL5n1FKxZ3Gh5wsYZDEHm9NvmD7K
         lqWRcEFVraqwzo8A6+h17rfmQ4C05wMOfHzGoMP9KbOkXgwfhfrwiJej0jBzalPWcJv6
         Gb2yamg6VfTLh/Lz9Kuspui/yKLglrU+h8j+qzZWB2WMfEuBPb4LfuCSqhcaJL1pbVE3
         7qBw==
X-Gm-Message-State: APjAAAXnj2UI+FoNyfeiGT+HNLjRsRmPp0WwF9+5mOC5DGFXPyt5jjgR
        aXkjEI7RpG6DTTqI0ODJ8D2f+tYQDpI=
X-Google-Smtp-Source: APXvYqw0dQFKlklpyW+q33VX5haTdUmoykgMTASU9o+IisCpv4COwgzrjOI+wdxaiICYs0LLlH5UeA==
X-Received: by 2002:a62:cdc3:: with SMTP id o186mr24356224pfg.168.1564172808845;
        Fri, 26 Jul 2019 13:26:48 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id 4sm63754514pfc.92.2019.07.26.13.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 13:26:48 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Johannes.Schindelin@gmx.de, dev+git@drbeat.li,
        gitster@pobox.com
Subject: [RFC PATCH 0/2] PCRE1 cleanup
Date:   Fri, 26 Jul 2019 13:26:40 -0700
Message-Id: <20190726202642.7986-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <87ftms7t6s.fsf@evledraar.gmail.com>
References: <87ftms7t6s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sent as an RFC since it was meant to be applied against ab/pcre-jit-fixes
but that is likely to change with the reroll of that branch.

 [PATCH 1/2] grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
 [PATCH 2/2] grep: refactor and simplify PCRE1 support

The end result could be squashed together before merging but sent as
independentt changes to make review easier, with the first change doing
the minimum required to make PCRE1 great again.

 Makefile |  9 ++-------
 grep.c   | 15 +++++++++------
 grep.h   | 11 -----------
 3 files changed, 11 insertions(+), 24 deletions(-)

base-commit: 0f8c4ddfdddb72dc62d76864f5d3d31f136c7129
-- 
2.22.0
