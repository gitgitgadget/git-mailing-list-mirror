Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0AEB207F8
	for <e@80x24.org>; Wed,  3 May 2017 20:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757924AbdECUEl (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 16:04:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35094 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757897AbdECUEh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 16:04:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id o68so23952pfj.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=odWyl3+yFLL0sTI+SgTRToi6XXn5HRF/4YFqzhv/tLo=;
        b=ay1LZPAFu1OizbfJyUS26+CPzWW1GT5fNlb3Jz8c2Hzq08ED/sq9JRS6FuoIl3lGUm
         FDTLDcCd0WYfBKqROMkoYO7Q3SIb4EM1BLSD2MVSYyTBMA+cRyoF2UrrwXPgf3uja4yx
         tdqhilmD+qQ1HdfwK46eEui+d6v7gCX0EFDhbd8ulyHwajUvVYDwzdpCHEGmIfJcFC5a
         N9gfwuaHTk3j+A8NpFbU+kbDFehnMX7ouR8++p5gjsnahKV82BKlxNyoVcQrLSVhpXnw
         D54XJX1eeEV7eTjT9sKboHKvmzvcuhFXuztpiFURcaosmzDC05MyePs19l26NdQ3Opv3
         4xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=odWyl3+yFLL0sTI+SgTRToi6XXn5HRF/4YFqzhv/tLo=;
        b=eVTK25TmCI0K1aWurNgTdyM99lFfOLI6PIeLzPECz4UhmUUn0G+AXMgFWriojCFvkM
         nTfIot4qwG0cMI3O4qQLgW5JLkoZmZd+bUoZQSiys9O1CsIITXrz71s6UHA1VQDH5gtF
         grnfX6qnCFLemlTVYVEj82w2JZQ0+mtdqP91YKKthSOI8jjbb7ncjWlUxqOE93i1+2Lg
         Sep1lpOqXXOVg+QBR04CL+czPPb0KEKnZzuP1xEww1x6sqKmCwQpda5ZNuKoWn1y2yjo
         a8gvqaS2uC0Rfd7ceoWm48Oh6rp1lAaWpV8anYPYQHQDQ/D3LJ08fP73kBPPWgxjK8Ca
         IXRg==
X-Gm-Message-State: AN3rC/6gm495de1SzIqHR/IrKxryYNu6bUi+GnjiUCt2qebY+BKxi47F
        t/OSnGD6qP70eQ==
X-Received: by 10.99.139.195 with SMTP id j186mr18001351pge.134.1493841877053;
        Wed, 03 May 2017 13:04:37 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:8ce6:bd0b:35b6:826c])
        by smtp.gmail.com with ESMTPSA id t66sm7238666pfe.134.2017.05.03.13.04.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 13:04:36 -0700 (PDT)
Date:   Wed, 3 May 2017 13:04:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] config.mak.uname: set NO_REGEX=NeedsStartEnd on AIX
Message-ID: <20170503200434.GF28740@aiede.svl.corp.google.com>
References: <20170503135430.7785-1-avarab@gmail.com>
 <20170503194708.GE28740@aiede.svl.corp.google.com>
 <CAGZ79kZHhAsoWKhGHfccspikANjK7z=Zdh1us8r1+hw+4kHUHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZHhAsoWKhGHfccspikANjK7z=Zdh1us8r1+hw+4kHUHg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Wed, May 3, 2017 at 12:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Is there e.g. a build farm where we can check for this kind of thing
>> more systematically on supported platforms?
>
> There is the OpenSuse build farm that provides builds for all kinds of
> linux distributions, though we'd rather be looking for *all*
> operating systems, not just various flavors of linux.
>
> After some research, I found
> https://gcc.gnu.org/wiki/CompileFarm
> https://launchpad.net/builders
> https://buildd.debian.org/
>
> The gcc build farm would include AIX, maybe we could talk to
> them to have more CI support on more platforms?

Thanks for the pointers.

> Also you're a DD, maybe we could hook up git testing on debian
> to test for different hardware platforms?

https://buildd.debian.org/status/package.php?p=git&suite=experimental
shows test suite results for Debian's various platforms running "next".

Hope that helps,
Jonathan
