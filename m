Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F89220286
	for <e@80x24.org>; Sat,  9 Sep 2017 06:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757360AbdIIG5j (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:57:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33109 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdIIG5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 02:57:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so3037777wmn.0
        for <git@vger.kernel.org>; Fri, 08 Sep 2017 23:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6t9HhRrL7Gu8fddkePpI9rMa5vzYPFgwNnOl/nr209k=;
        b=Q889UaO75qO+71hStPky3bx70Hzhnk0RrL/tXRry6XsZvTd0BhrAkIhVP7ZNaghfjd
         9epGlNPLh5irrCcH0R46qFqUDtr/dYxVKlbAguY0grDjBEmEt3kOoYYOFbiP2OX3pyI4
         QL6h7xKe+raclqlr3fle50B3NEQSJA5lOkIH8W6KArT8FDUz+jMlXSvFAZSfs9Hwxbmj
         5NXDOLmN7GhmO7u4SckkGnQs1cNuQTjbtSsh315Vv5dVSpM+wX4BpBjFwY5C3s9Yedrv
         zj6eTIuOttutqrMpYNIdceRT1M5DmLMrNP2Dae7Obl6n6IisW72TnaACfCyhDz5KTEYi
         bS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6t9HhRrL7Gu8fddkePpI9rMa5vzYPFgwNnOl/nr209k=;
        b=IWspAhk/17ywkFqCojDGwPR/9FzrXAQScbfkh/r8ddW1FDGfun6yyG6nxf8/VzAPld
         oQTHGf2j2oX8vKK/IXZhpjQ0OwKdk25E0BZ9FB4HXPJB0uycJQG2ycFzMS3nIE0kE6vK
         ZjSuSBiQrjLaLHWVaeghh21iLLO1QyYrVGtsYZIGY/MW7wfdDtkhUuc05sVFbTz4xTJ5
         G/+1vkTkZdteOAzm17pBjC/BCDo2LjhLAO4117TD55w701aXggJpjdLh0OgWUalT/JIr
         NZxY4PFt7g1XHnrM+8CLh2DxNVmC4HeCOI9TQC6vhnft44+jFfwYgR0lXVHNzPvjuH6l
         p1vQ==
X-Gm-Message-State: AHPjjUhDYfSi2tYYbDyzb1V6xr7HLXAbsjfqVgZBdqXTsvv4bBtjFDcY
        8daNa/2glqV1S5C9WsmMrKdyAw==
X-Google-Smtp-Source: ADKCNb61eDQqum1L0uEHRG7/ScsQUo5gVH1ULbl9oMK6lGDxCKxt6IcFKvdwJnX/et05iVsAula+jg==
X-Received: by 10.28.193.129 with SMTP id r123mr1688725wmf.93.1504940256755;
        Fri, 08 Sep 2017 23:57:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id v82sm4269403wmd.44.2017.09.08.23.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Sep 2017 23:57:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 0/4] Rerolling ma/split-symref-update-fix
Date:   Sat,  9 Sep 2017 08:57:14 +0200
Message-Id: <cover.1504939825.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.460.g848a19d64
In-Reply-To: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com>
References: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'll take Peff's hint, tweak/add comments for correctness and symmetry
> with the previous patch and add an if-BUG for symmetry.

Here's a reroll of ma/split-symref-update-fix. The first three patches
are v3 plus Michael's Reviewed-By.

The fourth is the conceptual fix of adding `refname` instead of "HEAD"
into the list of affected refnames.

Thanks all for comments, suggestions and help along the way.

Martin

Martin Ågren (4):
  refs/files-backend: add longer-scoped copy of string to list
  refs/files-backend: fix memory leak in lock_ref_for_update
  refs/files-backend: correct return value in lock_ref_for_update
  refs/files-backend: add `refname`, not "HEAD", to list

 refs/files-backend.c | 62 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 18 deletions(-)

-- 
2.14.1.460.g848a19d64

