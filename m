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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0825E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKOBAv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:51 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41375 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOBAv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:51 -0500
Received: by mail-pg1-f170.google.com with SMTP id h4so4879345pgv.8
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JVSGvzVUpd24odLVncvJ13MZcacBm4hnOc0q7NeALPs=;
        b=rDsWDV50782B6YfNO+eMoDOVV7yoEmooWHHGcWzHZrbegcwib7TVuTaHO7pKGgf3PR
         JFQpaV6IMedB9QAIxkvtpvWMcZ9xkCzFVy1jpK4Z0mMulZiubo1CPF9MHuEQiRgIOPk0
         M4RI7IFDDBRfMjrG24RwmcCEkGFknZcUkoTS+ho1X11D8ZOmbto/4pG690TdaXbYy2cn
         UhcNMK75VAngOxc34ati7bTGwSxhMgxls9aJlDh3MsqYA/UbpSGDq++xju15TYS0xvwV
         EAuQvSzqS2L9ZYs9AVn5EXAA9T7OB+ao4ajTWkN6W3TaBdnaiwZsBvntaXNbv6XNzXPF
         4obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JVSGvzVUpd24odLVncvJ13MZcacBm4hnOc0q7NeALPs=;
        b=qlA+gkY2Oe7593WYpUsDt4jJRorKshL+NaiwyksbKaUN1v4KMoLp/dVeLtZPpHpA7Y
         oOk0n98zuDAeL9icpwLqYH53xXt1sePhk3ctyXPYnHEI48LffAYOa5UD2KH+K0eorMNB
         l+kBk/445v50sx5vNBVuTgIP+vLlX/nMA05/ri8TiXTHx+12ldy76HAE51W0X8Z6jQtD
         uqphQ+J9i/cEYV60KKCAt9/OPTJTPKdTh47vwt9RJY4S4/E9WcevYPIPP2dLgQtEx71w
         xf5AggxDHNLBf7/N0afwiETpAje7xbLHHnL/maeAFiboBAj+Hig6L17XCUv3UgHn0CsZ
         Dzjw==
X-Gm-Message-State: APjAAAUemHbi4PWY9tzWFNxR3fcy3CE99mVjzricMzXT2yxDMtJDd9mg
        V7D+STfeZcvwrXiN5UqFiX9K1yEL
X-Google-Smtp-Source: APXvYqwBGC5x29wxz/DAOq8sV5NZyyuGneEZXhBO5PTjQmNZk5s7iHFDgTZxR3B5UfNUYDK3iTpP9A==
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr13761438pgm.120.1573779649603;
        Thu, 14 Nov 2019 17:00:49 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id p9sm8184012pfq.40.2019.11.14.17.00.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:49 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:47 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 07/27] t3600: comment on inducing SIGPIPE in `git rm`
Message-ID: <a34b78fc348f7997b53b2883a0a2a03f0713bfb2.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment about intentionally inducing SIGPIPE since this is unusual
and future developers should be aware. Also, even though we are trying
to refactor git commands out of the upstream of pipes, we cannot do it
here since we rely on it being upstream to induce SIGPIPE. Comment on
that as well so that future developers do not try to change it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0c3bf10edd..0ea858d652 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -251,6 +251,7 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
+	# git command is intentionally placed upstream of pipe to induce SIGPIPE
 	git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
 '
-- 
2.24.0.399.gf8350c9437

