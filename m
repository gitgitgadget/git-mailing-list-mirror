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
	by dcvr.yhbt.net (Postfix) with ESMTP id E49B31F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfKHUIl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34571 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbfKHUIk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id k7so4580041pll.1
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EfaRETGVRuIT2wvGmySlaI8x64YtNHN3iXITkbQFfI8=;
        b=hEBcHCsJTaZXkJM+5yyMivkfE1fAJQrt96/mpfA7VExHQpwqiesb0Y6I0iHlPrOlkW
         P92H3f3BU7HwpZBnQyw4jLntCW7xGukGSMIaTbIzGqO/8DfpcjE5QApOvrOxb8E6jrMC
         1Ucjr9a9csHmtpBJ12HZwwfXqwvafOHPr5wq2hDR6txUPjfet0AvLmiiBgZhxvozrcKs
         JpcmIDBYQX9vnv++kSqJ+7gfBCLtXYmyn5O5UQ+M9VNXPiB4OD+CtEPuAj6h1/Z8ZFZp
         tLNE+o8ZIy1S17rhit5dYlUmZTOnegwtwpg1iIKeIbyJCwKLXcl6dmD+LiMxmRijVHh6
         kKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EfaRETGVRuIT2wvGmySlaI8x64YtNHN3iXITkbQFfI8=;
        b=tufTRnlmHSu/WnAwMRk+raUI//D69iqUFhjJB7Rrw8KPxQzKqbouZqbpj1oDE5VW5N
         Klql2q2G00i0LxrXpCxWV3HZZlwcij69XICasaaCHAqTcII8In40ZZYRg1br+mfNjkHd
         Jpz4OxIlXaoyUARpJhnWwm5NcuhCN1UIhTZyN+vUgbyFNxn6BTTwX8mONzmf+MxMzNua
         2m4JqHPOxxXf2eeN1I18BkJMTIbdxq31d+EGkdBjCiAHymL2gToQhngvlrxSnoeVzljp
         nttE5GSpWeX+U4gAe6DoV1BfFJpu3Zlk65iKu8P2PqgbUi3zuQHzMD0QE6VWs3PNrvLi
         J1AA==
X-Gm-Message-State: APjAAAV0NFncRMXDnTSlAJ0OTKp0DaX5fmkONN7P9G2geB99COTakYrS
        xfPbhH7qh60V3OuiBEH0EK/uZFtF
X-Google-Smtp-Source: APXvYqwMSZ+hhsmikNNsT5z2sxcqKqiVcvqwGpLZyEVDE9gVmfp3mpfISgu1ITVokfoGbqyq08ovzg==
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr12704395plt.285.1573243719027;
        Fri, 08 Nov 2019 12:08:39 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 71sm8183459pfx.107.2019.11.08.12.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:38 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/10] SubmittingPatches: use `--pretty=summary`
Message-ID: <3aaa7a318b50fc296afdf5be98fbb9a714e23bd2.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git was taught the `--pretty=summary` option, it is no longer
necessary to manually specify the format string to get the commit
summary. Teach users to use the new option while keeping the old
invocation around in case they have an older version of Git.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index bb7e33ce15..849d27663e 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -153,6 +153,12 @@ with the subject enclosed in a pair of double-quotes, like this:
 The "Copy commit summary" command of gitk can be used to obtain this
 format, or this invocation of `git show`:
 
+....
+	git show -s --pretty=summary <commit>
+....
+
+or, on an older version of Git without support for --pretty=summary:
+
 ....
 	git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
 ....
-- 
2.24.0.298.g3e88fbd976

