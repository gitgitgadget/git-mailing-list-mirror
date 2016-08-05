Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A143D2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427245AbcHEVKQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:10:16 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36276 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968301AbcHEVKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:10:10 -0400
Received: by mail-yw0-f194.google.com with SMTP id u134so22086012ywg.3
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:10:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1n2hoAZuz/rRFvx4unPoT2pDRKfxElAm7np3YD3unCU=;
        b=HIrLPV4IswK+B7zcy4+SjYJbquSlugv1P6pgPk/qgGJ5bFVPF7IYkpE1zdwWuYQ+7S
         KaZ0o2w7Hzqzn5e5JuVK+pPJ0+WSq5NqfbGqWlavCOTBwXx22Fzrb6o4GPFlVKCcS4Bw
         C2BeKrl/tVZhUUZGLH8sWtbhVV6bUNZXwwwi/mQ2WvRdoBPG1qBptup4uSTcz9IE15pb
         +eDHMUk0y4Klu2iPmyzbKSM9Ssu3JALKzh9cqJqIpEx4zQypXhXL1Eu2uToPs7iyhqbc
         e/y286UHbFvAPXuVelPZ13eIJWd7KLEhAVILYQ0dLj/ij8f1pSrI0xDqYXtX1eVRfpMs
         MICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1n2hoAZuz/rRFvx4unPoT2pDRKfxElAm7np3YD3unCU=;
        b=f6z6GG1n51j1hsod1HvzxHZLKlDwvESxwoEkUYyxywUNssxOHTLdU+yWExwOwC70ZX
         Nx7neQAJk0IAzeHHubaCd1E+PmBlpB8Lk86o4fEJtKT1HDqcnnM4xLiqimpcXpD1Pfgm
         eavnx009yM3q3FB6Wipp4AOReItiLDWW79Azs579MvnCiYzm9fEOzk+Dob1nIoo26XDv
         0XTY+PGe/MLOmQ/X6e/+B+d5L4m2svPS/p+OSROhLvlVBH5LUBwwWFda/ULwn4S/ImlI
         pKt0UYM21QvwhsNFyOsK4iN8Bia39kNbaa2BeXlSzCkaBjXboWxcei1DH51oLcf37sd1
         3jpw==
X-Gm-Message-State: AEkoouuJRgD2B5wXh2ThChRK2r1OUmaKh4FswmFo8s2tYcbA0oeOWdJ3v4MLBlalLIXdCR5QuYO8m3TikgeS3g==
X-Received: by 10.129.106.197 with SMTP id f188mr58623036ywc.38.1470431409148;
 Fri, 05 Aug 2016 14:10:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Fri, 5 Aug 2016 14:09:48 -0700 (PDT)
In-Reply-To: <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-6-git-send-email-git@jeffhostetler.com> <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 5 Aug 2016 14:09:48 -0700
X-Google-Sender-Auth: HwXIgeQ5-ql_Sk3BSJ2kfWMe4Pk
Message-ID: <CAPc5daUr7OgFeefbwWLWFt3KW_9X-ijRmHa2oj0--zY4fqt82A@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] status: print per-file porcelain v2 status data
To:	Jeff King <peff@peff.net>
Cc:	Jeff Hostetler <git@jeffhostetler.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 2:02 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 02, 2016 at 10:12:14AM -0400, Jeff Hostetler wrote:
>> +     switch (d->stagemask) {
>> +     case 1: key = "DD"; break; /* both deleted */
>> + ...
>> +     case 7: key = "UU"; break; /* both modified */
>> +     }
>> [...]
>> +     fprintf(s->fp, "%c %s %s %06o %06o %06o %06o %s %s %s %s%c",
>> +                     unmerged_prefix, key, submodule_token,
>
> Coverity complains that "key" can be uninitialized here. I think it's
> wrong, and just doesn't know that d->stagemask is constrained to 1-7.
>
> But perhaps it is worth adding a:
>
>   default:
>         die("BUG: unhandled unmerged status %x", d->stagemask);
>
> to the end of the switch. That would shut up Coverity, and give us a
> better indication if our constraint is violated.

This is pure curiosity but I wonder if Coverity shuts up if we
instead switched on (d->stagemask & 07). Your "default: BUG"
suggestion is what we should use as a real fix, of course.
