Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1397B1F89C
	for <e@80x24.org>; Thu, 19 Jan 2017 03:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbdASDTB (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 22:19:01 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34807 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbdASDTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 22:19:00 -0500
Received: by mail-pg0-f50.google.com with SMTP id 14so9918806pgg.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 19:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cPwHAQHuh/ke+/HJf3I2ZcjrkSbdZgvf0O0/HQ60PO0=;
        b=aZqiuDgkbU1YF7xQQiynfiuM242vHb2O7in5oN76iokMra18I233KgKojkN4zLDfx5
         O94pnI7Pxeq+y7+H1dz0K4v9oy/+oAaWilLTYTAsBA9Z/F4ZhhPBIcTkSjP7OrNLiUAS
         8VlNKF6wO0l3m2uVsgbvZQ0YomUU37dKkk/w8fBAZDxvxYcPGPUTcgh50yof6XgJ58O5
         zTvwDFfBImyL3iPMqnkDGmFdKNFzmrVpfkzvjuByvS0jWQGg4ilsMb+XY4k/ArlSMbP1
         zrlVPhL3y1/XfLFmVx7GpBT4KiGvwwbM03RwqquaddbZPartQ1I5oJmifvTgBT1Z/faA
         ztyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cPwHAQHuh/ke+/HJf3I2ZcjrkSbdZgvf0O0/HQ60PO0=;
        b=nF0vCuBXHatP4nd+EgXTrqOpHIaGZ5yjre+/8KN9qWc4+wIeYbKEJum5lpQFWabR05
         KjrFGYD9ZF/PRVJRu8IZAca5H5d0nm5FQL7Zh/Xgk/FwI0dOuwCLVolNFaBqrIBRLT3H
         wkOU+IqIP5YQ35NfmDdgWNmKC82LU4KcIUrzlADwmhA8n9deO2au1g04reSm1icIgWd6
         z8MTZezD0ExA56kAuubx8cZaySmu4SXxt6CWg1FZ8hu2KU+kLN7i32O/RQhhkP2JYPN/
         ytrFZeOgzVDzm/TFOSVIjX0pa8kPGnwqL2rt1vhfFuHs9Ke5QG9WCZoBTMiVl+ye1O1L
         R4ZQ==
X-Gm-Message-State: AIkVDXIgWtuXR4YOwtHIhCfHIUQrxAO9uUSFb24cTYxnDpHw4y5r7lltnHEGMguGyuzHqWZz
X-Received: by 10.84.173.195 with SMTP id p61mr1979009plb.63.1484795940078;
        Wed, 18 Jan 2017 19:19:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id w16sm3914555pgc.15.2017.01.18.19.18.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 19:18:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/4] start documenting core functions
Date:   Wed, 18 Jan 2017 19:18:50 -0800
Message-Id: <20170119031854.4570-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170118232145.31606-2-sbeller@google.com>
References: <20170118232145.31606-2-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* dropped commets on constants as they were not helpful
* fixed one result in the example for  index_name_pos(&index, "f", 1) (which
  is -3 now)

v2:
included all suggestions from Junio

v1:
The two single patches[1] are turned into a series here.

[1] https://public-inbox.org/git/20170117200147.25425-1-sbeller@google.com/

Thanks,
Stefan

Stefan Beller (4):
  cache.h: document index_name_pos
  cache.h: document remove_index_entry_at
  cache.h: document add_[file_]to_index
  documentation: retire unfinished documentation

 Documentation/technical/api-in-core-index.txt | 21 -------------
 cache.h                                       | 43 +++++++++++++++++++++++----
 read-cache.c                                  |  1 -
 3 files changed, 38 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/technical/api-in-core-index.txt

-- 
2.11.0.299.g762782ba8a

