Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DAEE1F464
	for <e@80x24.org>; Fri, 20 Sep 2019 15:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404292AbfITPo4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:44:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50391 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389400AbfITPo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:44:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so3040492wmg.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nFeuGShgqASFdTQAKeFyy0QebF+UcEKophcjT8piqQ8=;
        b=p0RQsPt6r0hZ+sGEDfrpcHEdfivKIF56FGQEG1zR9RFtvpiXTAPlT59igFVzmShwl+
         A66tnvTP+qZGKn+OInUz1wgGHEX4oHrkHAaPpjBtE8Pv0aHBXnVbTvScJr59mcZMEP8S
         lT3wFyf2ah3CGJp1nzgo2iSIsXC2FvV7fjpW/JJtmJnPBLij1GhOD9zAyXXlj8dbQPov
         jPqNt13BPcILyOPjWL692sPF3zWfJafMWjj/7S5ew3+eQmoQVtoAYd2ftDMJx7Q8q78L
         4whljSOeAxOBVF1lNMwJHtiN7x2SAkR4rL+wVk3PIYbnUONtblxEpDzVJ7saC7qDqkFu
         d/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nFeuGShgqASFdTQAKeFyy0QebF+UcEKophcjT8piqQ8=;
        b=IPVHrZwFnLaAAVM8evQSy1DBRPlrjJl4sdOnxQq1XBNpzjVaDCUF2lCmWg6NmUZ2RZ
         i0jAEB6Juf8/4+p7DCDJ49ETJYVDvMwVnmYNpPhor7mfgYe97vWHUcLmmVM6zFDVrjb8
         qSed7kui7WXJ4533Uur3D1q9tEhS7F43X8+H8O2Rxjl2BH87ht5gPCtyZoCGPMrO9IH9
         lxe0NbzRiEj2X8P2wv69BEiA0d1jbjihMiGq6N2jViYKHj1Xc649eTJpA3l5w5cl9G6j
         5wnC0wt6mu/DuxwejWX+ohyreEbGnxS4+S2uzPevgDqx/T5Oqa3+470CeRx8t6lsWde0
         4ndA==
X-Gm-Message-State: APjAAAUPyF2sVxbXcA6oN362i2ZaeGTO5dGxRhTrkssP/Tw3oR1nF9bO
        J9ONthZLbwidl87O0RU9e3g=
X-Google-Smtp-Source: APXvYqy9QeqsGife4JD464/OSIeAwCvyoq4zqAy+cm2gRn3cNfUWTBvsO0g57LLvxfZ+rrXnFTmCPA==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr4056012wmi.103.1568994294066;
        Fri, 20 Sep 2019 08:44:54 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id y13sm3155746wrg.8.2019.09.20.08.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:44:53 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:44:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/15] t6120: add a test to cover inner conditions in
 'git name-rev's name_rev()
Message-ID: <20190920154451.GB32332@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-7-szeder.dev@gmail.com>
 <2e18a216-f6f8-2307-2524-a2e1f44b26c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e18a216-f6f8-2307-2524-a2e1f44b26c7@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 11:14:56AM -0400, Derrick Stolee wrote:
> On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> > These conditions are not covered properly in the test suite.  As far
> > as purely test coverage goes, they are all executed several times over
> > in 't6120-describe.sh'.  However, they don't directly influence the
> > command's output, because the repository used in that test script
> > contains several branches and tags pointing somewhere into the middle
> > of the commit DAG, and thus result in a better name for the
> > to-be-named commit.

> > diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> > index 07e6793e84..2a0f2204c4 100755
> > --- a/t/t6120-describe.sh
> > +++ b/t/t6120-describe.sh
> > @@ -421,4 +421,47 @@ test_expect_success 'describe complains about missing object' '
> >  	test_must_fail git describe $ZERO_OID
> >  '
> >  
> > +#   -----------master
> > +#  /          /
> > +# A----------M2
> > +#  \        /
> > +#   \---M1-C
> > +#    \ /
> > +#     B
> > +test_expect_success 'test' '
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +
> > +		echo A >file &&
> > +		git add file &&
> > +		git commit -m A &&
> > +		A=$(git rev-parse HEAD) &&
> 
> Is it not enough to do something like test_commit here?

No, because 'test_commit' adds branches and tags pointing to commits
somewhere in the middle of the history, and those will serve as better
starting point for the resulting name.

> > +
> > +		git checkout --detach &&
> > +		echo B >file &&
> > +		git commit -m B file &&
> > +		B=$(git rev-parse HEAD) &&
> > +
> > +		git checkout $A &&
> > +		git merge --no-ff $B &&  # M1
> > +
> > +		echo C >file &&
> > +		git commit -m C file &&
> > +
> > +		git checkout $A &&
> > +		git merge --no-ff HEAD@{1} && # M2
> > +
> > +		git checkout master &&
> > +		git merge --no-ff HEAD@{1} &&
> > +
> > +		git log --graph --oneline &&
> > +
> > +		echo "$B master^2^2~1^2" >expect &&
> > +		git name-rev $B >actual &&
> 
> This matches your description.
> 
> Thanks,
> -Stolee
>  
