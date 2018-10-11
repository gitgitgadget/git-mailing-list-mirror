Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6991E1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 15:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbeJKXLT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 19:11:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38464 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbeJKXLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so10243796wrt.5
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DRjLiQGs5cL0c/LmpWsK7y86G2X24MvwGim9b/m3tgI=;
        b=eb/Gqv76Z0YQZXg6NXHWhgKLI1e1lWJj4hUNtTnxhuZ68zby1acXdkCb/Wf6FIaold
         OWwMVffKasp7oqbRAFTyAZVlhrwN4Nlc3kMZ2FNQEu6h1QAlOCFQfLfpyZSA3N+7EVYi
         FB/nr71lHN3EjvaFF6f1oYNjorAIHCFyAx7WU0/XVthQR5PHkclx1gHjLAoYaFCemT+W
         topFWhzZc1UtSU6Db++d4N8zs+Hq4gD3xNgXxw9CNlCgA46xs1Flx2BKsSbshjW6fDwX
         L0dhinu+1tVWKN50Ej6Q8uqbK/3DYWN3crpWEbQZ8ZPZ//HR+945pdyFXgG9Mqifl/Sk
         Ydrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DRjLiQGs5cL0c/LmpWsK7y86G2X24MvwGim9b/m3tgI=;
        b=FrXmmjpUSlcAR3e5zmkPj09NB/XMSfGl7fjUMbzpO4C0PGK03NfFBTmPvCNFueZ9jL
         xuQKyIjR/zJW9bZoXG2Pxk6tViiUuR8eLPZcs0oxLxbvVgeKODEKRNRH5o40ZaKfBQvC
         r0dNOMaaL3t90KxXwHNNophIeSJbMz3kGybLn9Z1RO3AcbGKfFWxlMbfA/b6V4Xgwr38
         tJVKO+Fr12DJN10EIbHjqjWSBehxMF3l0DwJf9DGLmcacfG+cEtKmmB6ppOYz5OOTApA
         rBeVyY1KDwQ6PH9sOZTAbOjKvpWH3Hy/5VCYQB0t3JqxJTfv2fDaen/pk6LOtUMszL7g
         6fVA==
X-Gm-Message-State: ABuFfohecnJgg/2tHRGfkfSY3yX4jtl/PyYoDnW86YIsYbAwHJz9D+vb
        9sYZz5hUX5xb/3NbYftrW533X18x
X-Google-Smtp-Source: ACcGV61CnLFhUfHcppukDSPa/GyCq1D0mDVuepVvBfgeEJAq0ZPksqY64St190tj2aPuCqaczMVM8A==
X-Received: by 2002:adf:bb41:: with SMTP id x1-v6mr1944831wrg.325.1539272613254;
        Thu, 11 Oct 2018 08:43:33 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id 130-v6sm21961603wmn.7.2018.10.11.08.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 08:43:32 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:43:19 +0100
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011154319.GA6386@rigel>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
 <20181011003440.GD13853@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181011003440.GD13853@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 08:34:40PM -0400, Jeff King wrote:
> It just seems like in its current form it might be in an uncanny valley
> where it is not quite scriptable plumbing, but not as informative as
> other porcelain.

I agree it feels a bit out of place, and still think that

    $ git branch --list HEAD

would be a good candidate to be taught how to print the current branch.

I suggested this in the previous iteration but either got lost in the
noise or was uninteresting. If the latter, I would love to receive
feedback on it.
https://public-inbox.org/git/20181010142423.GA3390@rigel/

Something like the following (not meant as a real patch), would show the
current branch when attached, (HEAD detached at hash) when detached, and
nothing if unborn branch.

This will also keep the current formatting git branch uses (which is
sliglty harder to parse). I view it as a plus. Otherwise people will
eventually start parsing it instead of using the recommended plumbing.

--
Cheers
Rafael Ascensão

-- >8 --
diff --git a/builtin/branch.c b/builtin/branch.c
index b67593288c..78a3de526c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -684,6 +684,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
+
+		while (*argv) {
+			if (!strcmp(*argv, "HEAD")) {
+				const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+				skip_prefix(refname, "refs/heads/", &refname);
+				filter.name_patterns[argv - filter.name_patterns] = refname;
+				break;
+			}
+			argv++;
+		}
+
 		/*
 		 * If no sorting parameter is given then we default to sorting
 		 * by 'refname'. This would give us an alphabetically sorted
