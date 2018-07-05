Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5091F62D
	for <e@80x24.org>; Thu,  5 Jul 2018 19:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeGETfL (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 15:35:11 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43684 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbeGETfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 15:35:10 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so3649492ybl.10
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dX8rILp+lHMb+kfxU2LdPd3lDUjcIVOUBcmuDd7Udt4=;
        b=iZVqw5s8JnC6dFrnCholiUoeKisA/ncZk2ZGTBhnuRPknmx+4wYvq//OwBSIs3uPMv
         +Yg013RaD2jdaseXM+3Ke0U19St6/DGyjq23/Lwj4ILqMttDXzCvmKIhnZVMsrcLMSRO
         cvP12gsBU94+UOsL5DVpmMtG8Kw+A6ZUT5LIXNprnhhaWyrwlBDFTeq9f3i9L6dXhxR4
         wfsB78tzfAR21vNeX/PyL+8W+v/NbgZBQYHyXrkzavGpSOAncslHLYNz8I+2saYpcV2G
         kAWs3dVdtcV65kPoxFUcRSvNbDkcYRHIf9kwdQJeArBuvI4FII5eDJAGf2TnNkpXrJfX
         VUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dX8rILp+lHMb+kfxU2LdPd3lDUjcIVOUBcmuDd7Udt4=;
        b=GKIkdWV/A0DC1l2YqcPlmsfasOGUxooQhhaJ/s9MKsefOgiXwd1L/mAtVmmFjs1Ueu
         JdmJJm5hqBvk5WdI0i06IK3Ysf9Von4xmyv3cnZ7YKih7qEspqJz7b9I2ZQ/7tw4Zvy9
         TvZbHrdx6l8iq46FOtu6jSs3UskQ833YLcHbaq0WFv6XE9c5VmsmbIcrNmTipiaYY/pz
         zDIyoCuZn+N+GPFoOvt/Z+UfuhoNsDg5QH1dUBH9MIVwFhe1vFbUKADwKlBz23QtLck/
         ZxETf/K4Yd/VCXw9zZjmpkaGqt6TZdOCeYx7O1c4YDmbJ2IwGgx71rIJbjdrmDBo3WWi
         5hkg==
X-Gm-Message-State: APt69E1Ga0McrF0MUQdxJTUU/zCxKA1Qdl6mIhBSsTTRGQ73oEWFFRLl
        m4iNsHmUkC4h+MkWTbpZDMyn9FavPJE=
X-Google-Smtp-Source: AAOMgpdji9XGrSHi+qdwzBtfzq+lDBZqgg6GB/xmOXlL76HFr2Mk3QV/4AuPX6fZZFyRsd4VfDsBRQ==
X-Received: by 2002:a5b:10:: with SMTP id a16-v6mr3818775ybp.224.1530819309656;
        Thu, 05 Jul 2018 12:35:09 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id z128-v6sm2421875ywe.38.2018.07.05.12.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 12:35:08 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:35:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Taylor Blau <me@taylorr.com>
Subject: Re: [PATCH] builtin/config: work around an unsized array forward
 declaration
Message-ID: <20180705193505.GA71957@syl.attlocal.net>
References: <20180705183445.30901-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705183445.30901-1-dev+git@drbeat.li>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 05, 2018 at 08:34:45PM +0200, Beat Bolli wrote:
> As reported here[0], Microsoft Visual Studio 2017.2 and "gcc -pedantic"
> don't understand the forward declaration of an unsized static array.
> They insist on an array size:
>
>     d:\git\src\builtin\config.c(70,46): error C2133: 'builtin_config_options': unknown size
>
> The thread [1] explains that this is due to the single-pass nature of
> old compilers.
>
> To work around this error, introduce the forward-declared function
> usage_builtin_config() instead that uses the array
> builtin_config_options only after it has been defined.

Argh, I think that this is my fault (via: fb0dc3bac1 (builtin/config.c:
support `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)).

Thank you for the explanation above, and for the patch below. I reviewed
it myself, and the fix seems to be appropriate.

> Also use this function in all other places where usage_with_options() is
> called with the same arguments.
>
> [0]: https://github.com/git-for-windows/git/issues/1735
> [1]: https://groups.google.com/forum/#!topic/comp.lang.c.moderated/bmiF2xMz51U
>
> Fixes https://github.com/git-for-windows/git/issues/1735
>
> Reported-By: Karen Huang (via GitHub)
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>

Thanks,
Taylor
