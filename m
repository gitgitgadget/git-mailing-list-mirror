Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 649C41F453
	for <e@80x24.org>; Thu, 25 Oct 2018 19:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeJZDtA (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:49:00 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52546 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJZDtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:49:00 -0400
Received: by mail-wm1-f47.google.com with SMTP id 189-v6so2634121wmw.2
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9revWfsrKDPyuNI+VKDRgjznavhKwLuDS6r754EqQ4o=;
        b=Ru/Q38mNTo3TBFiOS0lQ7IJmG3H4YXReWTEfW7mKJRUtUwbAKb/IDMmJq5KT8khOyx
         3oPffvVEZfmw5aww6YY3TRXBVFUZ9/zgIBVKKLPxGzrkygLDaPbqlD3FLpC51GI71kgJ
         aj2gzajFF0W9WsNiLYOmaYKyI1jQ4xaczEOF5IJvuqX+a//aH3L0Z3R6tfD4uWa6dJlr
         1jzgNhGWsU/U2a0aZs5VJYe8cE81Uo6z9pvrwsdOU3DyDZ8JaR3/QSIyjLa1om/I1lXQ
         y+NbSzBQBMnlf6d9z/ekYHQd1BSGDNlqNQRfenf/LO5vWQw5uLRQijyZLni/TgP9gbVy
         wl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9revWfsrKDPyuNI+VKDRgjznavhKwLuDS6r754EqQ4o=;
        b=npagV3+46zHZrOozQpEflB2/tOQ9WfzgqrVk/G8Bfixus95RI3S/w7OBelvoXkm/sg
         31JQybIzuLBCaIG1rJ5ubuxnUHqSoOmjQGI7io7WZX6GSJrMo1YMPmyVwEt/MBCG3wDw
         bXQDZjz9404KTV4lMigBZQIhzjInrDzApcD9z1dnTZ4HCAvtqe3d4kQQ+YCWETj6UVsr
         J+x8N0LiknDGob3kSbW9GFW+LIVY2zDXb/MfLjRKUxKizzz+VR69PNF/v8TBUELo5erI
         RFOmFhwc5pqRA78+IEy3BSuD9z6L8O0FXFESHh43KgL6curXwWd9xx1ThwQRKMMWHMkw
         02Uw==
X-Gm-Message-State: AGRZ1gKfxI93x3S1kl7A1iyI7ftRIruLOBT6YV4v6gRxJ1bwFha+vuLF
        gNOv/N30hrZ1z7WXU9eJDI8=
X-Google-Smtp-Source: AJdET5e7IQ0ZtosLUXlWLMzjWbDzTJqhfi0lTVEp0rbkUA8027JsayJRJMTOm9TR4G7vGtPZOKqaYg==
X-Received: by 2002:a1c:be12:: with SMTP id o18-v6mr2642205wmf.111.1540494897199;
        Thu, 25 Oct 2018 12:14:57 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.124])
        by smtp.gmail.com with ESMTPSA id l140-v6sm3836936wmb.24.2018.10.25.12.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 12:14:56 -0700 (PDT)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        Slavica Djukic <slawica92@hotmail.com>
Subject: [PATCH v3 1/3]   [Outreachy] t3903-stash: test without configured user name
Date:   Thu, 25 Oct 2018 21:13:15 +0200
Message-Id: <cover.1540494231.git.slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <cover.1540410925.git.slawica92@hotmail.com>
References: <cover.1540410925.git.slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

    *changed:
	 test_must_fail git config user.email 
	 to:
	 test_unconfig user.email &&      
	 test_unconfig user.name 

	This is done to make sure that user.email and user.name are not set,
	instead of asserting it with test_must_fail config user.email.



Slavica (1):
  [Outreachy] t3903-stash: test without configured user name

 t/t3903-stash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.19.1.windows.1

