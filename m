Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B8120A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeLMN1M (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:27:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52357 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbeLMN1M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:27:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so2351346wml.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 05:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pfcG/DE6maTw1H/nFHsFGxQ9/kVtObBdhxpacG/orP8=;
        b=e1njAP0q359C90sx9kGuCVaYXtFtl0sCFV7x6BOJ59BuVi7o2eRQSYoZIvdvf3pQmI
         WTKLBa+lvip4M1yW1QdH6qYPyFLqpekvoWPE8waxM6j/JIzl2QuqlFl8ObgTtWHbDqpr
         jdsrXR5xf9ryQeZDsbjPhdGwgwBixDAktKqPVpKlCb2M1zKgDD5XRZK6qnLnCGOuJ91V
         ueXDWadSEoQ4NHsdDCUWgfMiO7/iV5x+up+lSWZ0/Iz/9CPE/sLgZhMCcCxEmO4vvVJV
         8jXzhpI4I0e8cGF+SEzZESVJdxrwPToFRzs2rbRe0WnyQTlCpTn/E8Rrh73yVBwqXBwy
         5wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pfcG/DE6maTw1H/nFHsFGxQ9/kVtObBdhxpacG/orP8=;
        b=ozUqFUGM58VPBt74Fxkx2neQVuAdWc6hkGykmaWqQ0aB5la1oTjLoiM9W/ZhmF/fi2
         ewYb/zQvWXUWEVBntgf6Y5yr+u9tQYjJdXqVrdXIgroJzZUtCVXOdb/kexk2H3OukdVB
         81vEpvWejtLequwCgs2k50Z+PqwfGvW7yGEE5OSGDZPsj0ndxyGFh3JUCgw/3nRmnGo7
         eQIayyxa5sPrfDVNdoSZV8B57zbeBZ7cGjO5qTxRMPB88q6NpvMFM4uNuBzJIJeAVarS
         mXBa7Wd9PpNBdU6H76kKECRTJuZFPAACGH4lhHOSZwjaEnD+7VxmmeEGbvkwmx1FT41O
         Czww==
X-Gm-Message-State: AA+aEWZH2GiMBxUpkJqJJnHNqFjebFqnb6HOsYEHBwE0moWbvHWjyPbE
        R/t5+pp5b92eY3y75Twm3ro=
X-Google-Smtp-Source: AFSGD/UCYhoujhXMKa4l3wX7OgEU6vbpJQvyb9+KSJ9AI9FpRx1T2gD4es8PX0BuiiqkelOi6N/mQA==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr9610381wme.28.1544707630363;
        Thu, 13 Dec 2018 05:27:10 -0800 (PST)
Received: from szeder.dev (x4d0c57c8.dyn.telefonica.de. [77.12.87.200])
        by smtp.gmail.com with ESMTPSA id k19sm2251740wre.5.2018.12.13.05.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:27:09 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:27:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Fix regression in t9902 with NO_PERL
Message-ID: <20181213132707.GX30222@szeder.dev>
References: <pull.99.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.99.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 05:01:11AM -0800, Johannes Schindelin via GitGitGadget wrote:
> The oneline notwithstanding,13374987dd (completion: use _gitcompbuiltin for
> format-patch, 2018-11-03) changed also the way send-email options are
> completed, by asking the git send-email command itself what options it
> offers.
> 
> Necessarily, this must fail when built with NO_PERL because send-email 
> itself is a Perl script. Which means that we need the PERL prerequisite for
> the send-email test case in t9902.

I find this text in the cover letter to be a better commit message
than the text in the patch itself, because mentions when it broke and
clearly mentions why it broke.

> Johannes Schindelin (1):
>   t9902: 'send-email' test case requires PERL
> 
>  t/t9902-completion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-99%2Fdscho%2Ft9902-no-perl-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-99/dscho/t9902-no-perl-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/99
> -- 
> gitgitgadget
