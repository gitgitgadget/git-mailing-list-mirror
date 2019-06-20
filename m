Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DFB1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 02:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfFTCpV (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 22:45:21 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:44370 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTCpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 22:45:21 -0400
Received: by mail-io1-f45.google.com with SMTP id s7so67720iob.11
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 19:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T2P2q0xIOzhp3XK7d4a4gZeUSj1W9hkiMLmHUuEvfqA=;
        b=JlchAe68TWGdOR8JH2lptAh8b5xIiDDD+zbqBWgAC/WUG57GS6umN7TAUEzwG7HC8r
         F2f/b6Svy4IiS5fTYtiK9yyH85GDbZpVCApd3E0ftyqOMitFO3XmD2pY73C/5kVEKRrq
         o/v2/P+Zl0odliJ9RMZ3qiXJt1l+3j6a1sHgxIPxh8fvgxJ1MUBySJS4szc3KktxC+Lt
         iM1PaSDXIL1bbeXn669ah/yOHaJSOSVjdw4LPCMIhcyB5YV3yIsTERigtXb1ND9XKqZV
         hUffbrBrGRqMFK39WfV42OsEK6RsEK7HaSbNFBjho1oCu3mX/7bwN4qMFHlxPpBxb+Hm
         G4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T2P2q0xIOzhp3XK7d4a4gZeUSj1W9hkiMLmHUuEvfqA=;
        b=dwtdFKCtQxiPyym22SLtSfXX1Wi10asW/q/JOiW7KNVn2c5ORleqybQqlAFI+s4qrH
         BJIdS9rpdMaCq5J9yMbTLNOFqDsBgGPL96bDXmnHaN+WNt/h1ymU6bFxkK7we/R/VBBO
         l77d3BMpHs4nR3j7kPThYM1/2HbC10f6EjWQCcrQ/6HkGpuHj6/YKutVALbHSfkD6IYg
         4dDhfhtE0xv+yyLc9oY24W0ZD3UkFQZQrxxHMObT6ycaQ15h/+GbPcbin7ZokX9HyiuE
         gxvNc7PORWQSzifySFgF87/RKa9JFJ1dePzHGPmqtrr9YDpq/N6vhdUH6F4eTSGc1tUd
         JUcg==
X-Gm-Message-State: APjAAAUDDPrrtdE7jorpkekMS8b8aqoa8en7VIumaUpvhUE5n5Sz5zed
        Qgvk9UTVbzU6u7pVO75e59VC/aN43xE=
X-Google-Smtp-Source: APXvYqx/vliCmqp6DqC6WVv1OYDRcLDW66GrJDlQWekK4Nu/Fenw+nbm1mDKFZGVdnPT87Xw4Robeg==
X-Received: by 2002:a02:3c07:: with SMTP id m7mr68028071jaa.64.1560998719998;
        Wed, 19 Jun 2019 19:45:19 -0700 (PDT)
Received: from archbookpro.localdomain ([192.159.178.206])
        by smtp.gmail.com with ESMTPSA id v25sm15765722ioh.25.2019.06.19.19.45.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 19:45:19 -0700 (PDT)
Date:   Wed, 19 Jun 2019 22:45:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     "Pugh, Logan" <Logan.Pugh@austintexas.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [2.22.0] difftool no longer passes through to git diff if
 diff.tool is unset
Message-ID: <20190620024517.GA24321@archbookpro.localdomain>
References: <SN6PR09MB3248331E45EED2DD26CA55528AE50@SN6PR09MB3248.namprd09.prod.outlook.com>
 <20190620011744.GA3696@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620011744.GA3696@archbookpro.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 09:17:44PM -0400, Denton Liu wrote:
> Hi Logan,
> 
> On Wed, Jun 19, 2019 at 11:54:22PM +0000, Pugh, Logan wrote:
> > Note: This issue was originally discussed on this StackOverflow thread: https://stackoverflow.com/q/56675863
> > 
> > Prior to Git version 2.22.0 I was able to use git difftool without configuring diff.tool or merge.tool and it would show the diff using git diff.
> > 
> > E.g. with Git 2.21.0:
> > 
> > ~/gits/src/git$ git difftool --no-index color.c color.h
> > diff --git a/color.c b/color.h
> > index ebb222ec33..98894d6a17 100644
> > 
> > In Git version 2.22.0 an error message about diff.tool not being configured is displayed:
> > 
> > ~/gits/src/git$ git difftool --no-index color.c color.h
> > 
> > This message is displayed because 'diff.tool' is not configured.
> > See 'git difftool --tool-help' or 'git help config' for more details.
> > 'git difftool' will now attempt to use one of the following tools:
> > kompare emerge vimdiff
> > 
> > The following commit is thought to have caused the regression: https://github.com/git/git/commit/05fb8726cccc74908853c166248ff9b6abdafae5
> > 
> > Please let me know if I can provide any more info.
> > 
> > Thanks,
> > 
> > Logan
> 
> Thanks for the report. I'll take a look at this later today.

Using the following command on git.git,

	$ HOME=/dev/null ./git --exec-path=. difftool --no-index color.c color.h

I did a quick bisect on the issue and it seems like the cause of this
bug is actually 287ab28bfa (diff: reuse diff setup for --no-index case,
2019-02-16). I'll do a bit more digging tomorrow.

(CCing Peff into this)
