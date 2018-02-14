Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4A31F404
	for <e@80x24.org>; Wed, 14 Feb 2018 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161220AbeBNRbt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 12:31:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54501 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161026AbeBNRbr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 12:31:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id o189so4429510wme.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 09:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AHe9IkSSpnLlrWNDonSDyYzKIZNUF/qmiDMOCWyXf9I=;
        b=bO7pJ3naz4no0jlQfeDsVUbpkmVZFBp3CP0kj7cibNil7EzUYHxO+15MXIWjhpvexv
         8P4591Ojhmbnhxu/tQ2q0+7qkA2h9QWxmzAJb9AsBbVBO/CClhoZ7jYfugEo9Q2h0Y7N
         154r2Xy1iD3gEIBY2qfAYL1K5pXB0wyWP6KAwc4T6F5HRV0IJ00oH+1uHIGJpA3Y/2w6
         AoVFnTfON4rbG5ncMX+cVBvmnX6sDNkRrm8l9f8BMsoidxxl/HV0lwyOIP5s9phSMBbT
         doySC5EOfGe+yyFu0jNxsVFfC/AXEPN433XrXTUErwr1itz++FaoiCY/JkBY8in9aqaI
         aR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AHe9IkSSpnLlrWNDonSDyYzKIZNUF/qmiDMOCWyXf9I=;
        b=qS/jXBN0jMUE3XkZjPAPLMqEaJVZZykmRRKNP+yGP1769E81PNImPkgmmq1uPG5OMF
         F4zGBw0wXtrP0mbXseGu90257IQlH8t9q43U4wHG3pFF/YEJEun1xszLQJkrelIEaUG8
         7rzDYvownFZduZWdrRtpuinIzQTOXCcnRxJ4sp6NuNotaDjjLnpLvehR/DdNt8TLeN2q
         /S3iv7cdC7m86aUor1bSexghiG+8LMJdUVG0860azARmnLL/njq93tCLXsMBHOQnScmp
         PgHtXxy34+/wvsHAf5i7mBYd1mNlukCBixGH28WzfcxO3eGR//TnzSSoBpMB48PCXPL2
         +oYA==
X-Gm-Message-State: APf1xPCl/nnCSiMnHMh+ruewN99r+r4ISQCF93oSVli3uwQFPryfNrsn
        dlkg8wQRoylXsoOeXr4C6Ny3mvBMGzY=
X-Google-Smtp-Source: AH8x227U6RPit33LypnWK8FJsg1V/GBYDfsx90N3ioDEOMnVoh525f4+qg2x/KUUCz+PI36hc89M3g==
X-Received: by 10.28.43.66 with SMTP id r63mr232993wmr.30.1518629506218;
        Wed, 14 Feb 2018 09:31:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e7sm1828815wrd.17.2018.02.14.09.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 09:31:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Andreas Kalz <andreas-kalz@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug? Error during commit
References: <trinity-cb66d9d6-9035-4c98-948e-6857a7bd4de2-1517838396145@3c-app-gmx-bs16>
        <trinity-5e3c4029-b348-4bd5-9337-215808436a12-1517838482997@3c-app-gmx-bs16>
        <CACsJy8CGQ4ynYFT0mY1DfcGGdzwP36eonMvr-kEZazX_82ag2Q@mail.gmail.com>
        <20180207204520.GA31757@sigill.intra.peff.net>
        <CACsJy8C72Gv4D46tOmgTqi=8aHVG7D=yZR2F7VPLRcm1e_jTYg@mail.gmail.com>
        <20180210121607.GA21843@sigill.intra.peff.net>
Date:   Wed, 14 Feb 2018 09:31:44 -0800
In-Reply-To: <20180210121607.GA21843@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 10 Feb 2018 07:16:07 -0500")
Message-ID: <xmqqsha3o4u7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's the patch to make "show -B --stat" work. I'll give some more
> thought to whether this is a good idea and prepare a series.
>
> One downside is that in the common case it causes us to look up each
> object twice (once to get its size, and then again to load the content).
> I wonder if we should have a function for "read this object, unless it's
> over N bytes, in which case just tell me the size". That's weirdly
> specific, but I think pretty much every user of core.bigfilethreshold
> would want it.

After reading through "git grep" hits for the global variable, I
think it makes sense to have such a helper with a good name without
configurable N (just use big_file_threshold that is global).  The
user of the interface either punt on size like this caller, or
would switch to the streaming interface.

>
> ---
> diff --git a/diffcore-break.c b/diffcore-break.c
> index c64359f489..35f5b50bcc 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -61,6 +61,13 @@ static int should_break(struct diff_filespec *src,
>  	    !oidcmp(&src->oid, &dst->oid))
>  		return 0; /* they are the same */
>  
> +	if (diff_populate_filespec(src, CHECK_SIZE_ONLY) ||
> +	    diff_populate_filespec(dst, CHECK_SIZE_ONLY))
> +		return 0; /* error but caught downstream */
> +
> +	if (src->size > big_file_threshold || dst->size > big_file_threshold)
> +		return 0; /* too big to be worth computation */
> +
>  	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
>  		return 0; /* error but caught downstream */
>  
