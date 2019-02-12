Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08E21F453
	for <e@80x24.org>; Tue, 12 Feb 2019 09:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfBLJ4M (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 04:56:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39851 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBLJ4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 04:56:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1051586pld.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 01:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/lNZydNHpdWcdPETe2vNOhGBcXK/RZeXwTWcSDJ7vrw=;
        b=eraUawqEiCcAmGkFl74Zx5YSJV93yhuxmjKoefLrPrczma5DXZxhqZcFBfPe/jtzJf
         vCkzADLH5M2OunN0wkfkIvZdEWEabKPH6DlcTfvKTTLu3kNxgN3zap5/DaYYYbNixxgv
         ReAILtv3ojI59v2z7urvqfPEsSVpx+FyEcG0OSLQkvz3p/CT0lb0p/gYe/GI9g4hUNtW
         APx5uVFiCtqtWXFqKVEFII4ZqYbnrmda4lI8VV5gSK1U01+e5rSvDzdzY+ETAjHB3wAu
         2u9WcKj/RQByLifPfHtQT1Str47dfQ4f7ML5E9YH3HpMAOSYuQiFhV75H90On3UnvkYz
         R+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/lNZydNHpdWcdPETe2vNOhGBcXK/RZeXwTWcSDJ7vrw=;
        b=pnoV04vOB9DCaTefdUkFlGOEpktY7PHi21Lcb3nl4GPnPG6xM3lLdEx9Acwi0bOzWG
         o3xWrLUwWsswOp+t+DJvqUTpY4WHLbcFoV++oiGPWh6+HvRjKAMR6PHsSqm2lwW4FqnY
         ioRovZBdY6O/YtdKicM3bC0dXeWC+ROO1yNIl2YfW6c23kuCQugV6R6nrDHKYTk/kT5U
         fI3Hi6k0ByqU+2coY+SPW71c+M9ML7gDuRzyWvrq9vZEsAWv2CVRv8U2shmE2v+lqI49
         l8cvW5e2jVfGZeeMbWHTiyvQKbReUyDgsMnQKSPbBbxl80wJ4TK8Rq7RFSdZvUAve9pL
         7Vqw==
X-Gm-Message-State: AHQUAubHC851SpFYbm8FiWQW3RuRUXxPK6lBPL6zGIMbBgPALK4p2mWK
        hDvRCXEBplHGInkei58YeiKIxSeI
X-Google-Smtp-Source: AHgI3IahNgJg823m4cAYhWBoZm+HRJG4cd9mJEg5J+DDxuFf+whU1YvvrKrJ8fbcBTAg8SNDR7muDw==
X-Received: by 2002:a17:902:b681:: with SMTP id c1mr3171297pls.103.1549965371444;
        Tue, 12 Feb 2019 01:56:11 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id h189sm3621966pfb.52.2019.02.12.01.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:56:10 -0800 (PST)
Date:   Tue, 12 Feb 2019 01:56:09 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com
Subject: [PATCH v2 1/3] git-remote.txt: be specific about default behavior
Message-ID: <7e7e0dde0495e105bb717418745cc24edd051887.1549965172.git.liu.denton@gmail.com>
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
 <cover.1549965172.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549965172.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of beating around the bush, we directly specify the subcommand
that is called by default when none are provided. This way, a user will
know where to look for more information.
---
 Documentation/git-remote.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0cad37fb81..a2e685818b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -41,8 +41,8 @@ OPTIONS
 COMMANDS
 --------
 
-With no arguments, shows a list of existing remotes.  Several
-subcommands are available to perform operations on the remotes.
+With no arguments, the default command is 'show'.  Several subcommands are
+available to perform operations on the remotes.
 
 'add'::
 
-- 
2.20.1.522.gd8785cdd01

