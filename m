Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A561F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKSAVN (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:13 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:35900 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:13 -0500
Received: by mail-pg1-f174.google.com with SMTP id k13so10438383pgh.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJPDIjqWxK8tH7UkHmzEQStgSjj1EUiSj7HaV1CbgK0=;
        b=qyY071qa8ngbVVv4pjotEQW+nDeMAKBRpMmN5X7BT3Gz2crOm9cfD6z1+uM20GBC6R
         aBqrG+N8UxOMs4cKOls2eUs07IJFrshBTZDxUOLaAZ4q1ij6jdo9OoI9xB8tirMBqxZn
         U5pyfZBtEGgbkjQDrEIdJjulm5nO7WWKXPWCYgHocdA5eUrp+3lA92ATgi68xbSd7pYT
         cNNdQfTZ6tYHVFmiQ75o2EOYNL1M1txllvIXnHCk27Fsl/IUVZBF9fnkkKjJrtsij3Si
         mVsdxG8ijtvXNJQxnZVGUslkMbmLNJfeJjEnbAm0/9y7BK3aAMF6F9KAGHX5Osu7yd/N
         Wi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJPDIjqWxK8tH7UkHmzEQStgSjj1EUiSj7HaV1CbgK0=;
        b=MxJYJiBkSHeGzRJQGvqYgmwp+tmTYbw6yks4RCzOGK70WFoW6EawQl5r503rIPFRhy
         YBH+F4HRJsuCh2bV1+Dw7imlNuoPH0t9OkDgh1nFBWZm4H7T69Gj+zxoilEA9LquCx0O
         sg5CAYcR2ehqnoLkKze9o4urFKjFSLvM4UvkvF0eGBEN0h0DcD+t3qvVIBb3JLlT6Zf0
         Iek38Wd+jyIKB0Z2ucfDVKDvL8Vh6vrzuXxHYFYcEw01sud7GpoWrbd7/c3n/G/PEJX5
         6u2JE1oYLsqlMnQUQIYxSOlawm5VH26ufGq+ug4wl1NEJsqnScx9SBwPCkMHFuj6Fgn/
         Bspw==
X-Gm-Message-State: APjAAAUPE6yGjOt7qRSokIqpzx3f4VjpilDBLKwRHwTRnZwk0NrxLFAD
        NmONkHCDSNqnWvzLKLtUP7FXuPgU
X-Google-Smtp-Source: APXvYqy6pfM/FZlZILzT/tjOuKoa6ed8XOInV3CVjIs1OfgeFvvvTOeLowLi1tff65i0eSgo5eqETA==
X-Received: by 2002:a62:1605:: with SMTP id 5mr2310727pfw.206.1574122872200;
        Mon, 18 Nov 2019 16:21:12 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 23sm21024190pgw.8.2019.11.18.16.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:11 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:09 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 01/11] SubmittingPatches: use generic terms for hash
Message-ID: <3b9b72feec82ecce2bd279219957c22393e18408.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git is planning on upgrading from SHA-1 to be more hash-agnostic,
replace specific references to SHA-1 with more generic terminology.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 1a60cc1329..bb7e33ce15 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -142,7 +142,7 @@ archive, summarize the relevant points of the discussion.
 
 [[commit-reference]]
 If you want to reference a previous commit in the history of a stable
-branch, use the format "abbreviated sha1 (subject, date)",
+branch, use the format "abbreviated hash (subject, date)",
 with the subject enclosed in a pair of double-quotes, like this:
 
 ....
-- 
2.24.0.420.g9ac4901264

