Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21BC01F404
	for <e@80x24.org>; Thu, 22 Feb 2018 23:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeBVXUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 18:20:36 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36302 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBVXUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 18:20:35 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so2729263pfx.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 15:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fuWITD/1H4iux6tfOTGSn7ynSxwhLnIWudfwbRaVEuQ=;
        b=JvIS5CX1SRmxr+7xMoVd9dOhmtLGZv1fGHQRVisy29tJh3FTsrrocgSmMyUsjfp+bR
         yY9VngFpGx6ayacSyNsg2L6fFwo7VnzxSlcgzx9MdKhSSxpuZgVaWbIt3MZcoS/2A22E
         4aZOGnbLHb2zIuisxVFaYIz/SO/vC4tgqq7qMEenfvm89hWd3BkicZNFDvBtJlm6oliC
         J+YM52LHa3EI93aOp/EahLyUrwIKGKRBnUf57oC8WLSXruvCgb9OKPTncJBULf6InyaK
         9z416jfvfUECostz98VEnfL8HEDa/0hn+5U6jVmFonttcyvDlyq8VuRlTtZFK+KfqbVx
         jo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fuWITD/1H4iux6tfOTGSn7ynSxwhLnIWudfwbRaVEuQ=;
        b=OY9A/oGBg/UZsH9Xx0P86uivJhJXUkBMd+u9JrkBF2ix3k3EjA6wRsnMSu2taVWW3f
         OOWOkLFB/nF2MgJrhTc1GV2UW2i4ZtBT4k9xcf+mC1FmPGV3bCZ6Y0A0kuvf11iMSbSf
         NbeA1nevN8lRZdH1XhmRBtdNzk9Wl4kIFSVI39Zdz9dFnTm8xNem3i3Xl+dDc9QALlb2
         E1RBn6cqU2NeV3Lm/V4ZG+xGc+Fhj+AloSI058jdPN4muY4axOaY5Oz/1gpFhxqtzP4c
         bIWXUpaaziDwi4fZnYAePa1/XpdFXLQtGnPir/uNMl8qZeSWwmnnoFs2l8HgGkaCYz2p
         2yrQ==
X-Gm-Message-State: APf1xPBEIXq0NdnzphAfOmCsDJR1PIIzgMEN3qzj2cRwP4XWSL95Vqr2
        i1Y0nm0AxNKlzdIsIU6qa5mxO6wW
X-Google-Smtp-Source: AH8x224oVNvyXjZcnc4ymFOtUC6GUOVVIbSJoYuBv23PKFnuO0advQaDr/OSUnCe8yfgqw5pp2UOWA==
X-Received: by 10.101.69.9 with SMTP id n9mr7149331pgq.317.1519341634385;
        Thu, 22 Feb 2018 15:20:34 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q14sm1386442pgq.2.2018.02.22.15.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 15:20:33 -0800 (PST)
Date:   Thu, 22 Feb 2018 15:20:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?Q?=22Marcel_'childNo=CD=A1=2Ede'_Trautwein=22?= 
        <c0d3+gitscm@childno.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] [git 2.16.1] yeeek ... my files are gone .. by git pull
 <otherRepositoryUrl>
Message-ID: <20180222232031.GE256918@aiede.svl.corp.google.com>
References: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marcel,

Marcel 'childNo͡.de' Trautwein" wrote:

> I think we have a problem … or at least I had
> and I’m not quite sure if this is „working as designed“
> but I’m sure it „should not work as it did“.
[...]
> I wanted to clone another repository … but yeah … it’s late for me today and I put
> in s.th. `git pull git@private.gitlab.instance.example.com:aGroup/repository.git`
>
> next … all committed files are zapped and the repository given has
> been checked out in my home directory 🤯👻
>
> what? Shouldn’t this just fail? Why can I pass another remote to pull?

Sorry, this is not the most helpful reply but:

Can you describe a reproduction recipe so that I can experience the
same thing?

That is:

 1. steps to reproduce
 2. expected result
 3. actual result
 4. the difference and why it was unexpected

I suspect that this information is in your message, somewhere, but it
is (understandably) unfocussed and I am having trouble pulling it out.

[...]
> trying to fix this up by doing another pull failed:
> ```
> -bash:$ git remote -v
> origin	git@bitbucket.org:childnode/marcel.git (fetch)
> origin	git@bitbucket.org:childnode/marcel.git (push)
>
> -bash:$ git pull
> fatal: refusing to merge unrelated histories

Ok, this part is something I might be able to help shed some light on.

Searching for 'unrelated' in "git help pull" finds:

       --allow-unrelated-histories
	   By default, git merge command refuses to merge histories that do not
	   share a common ancestor. This option can be used to override this
	   safety when merging histories of two projects that started their
	   lives independently. As that is a very rare occasion, no
	   configuration variable to enable this by default exists and will not
	   be added.

So that explains the "what" of that error message.

The "why" is a separate question.  Could you share output from

  git log --all --graph --decorate --oneline --simplify-by-decoration

and

  git status

to help us understand your current state?

Also, suggestions for improvements to the 'refusing to merge' message
would be very welcome.

Thanks and hope that helps,
Jonathan
