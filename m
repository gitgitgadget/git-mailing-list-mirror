Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6B01FF6D
	for <e@80x24.org>; Sat, 17 Dec 2016 07:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbcLQHb6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 02:31:58 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:33068 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbcLQHb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 02:31:57 -0500
Received: by mail-it0-f67.google.com with SMTP id c20so5002430itb.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 23:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NRt10CIuS4m77TFbq23mkNV5i/jG3lDaX2pzPGvbRnY=;
        b=TIyhT0UkuPKnVhU5MwGu7nkXNLEq3sDrhYCIqX7IKK0aOP6uRwQXsT/Z81o+GcSyh7
         I/wkdnB9+779AYsYw2nGsxdYtVH3nzuzB4ol19SxyRGfNmuNaUtOOxLY67D2i7qLuApe
         wF0jZqG4ULZH/Ve+fmwvdKc01PCcPHxYhlkbxPUd04jF4yLGXnWwGR9YFq0l6nTGVipZ
         gXvs2xOVa7BXkqF5wUteaHkpDIpKeLMFQtNYhPpJZo/wAxRPR8KrbtqfZ6kkDM4IZDo5
         b3RAlqyMZBt8hd2zKOvUjNbwSFNYVHxNPFIhVHSVifA807LyMPTTBzPMjcR3XiBRXsjF
         wf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NRt10CIuS4m77TFbq23mkNV5i/jG3lDaX2pzPGvbRnY=;
        b=B2xVhEnEH2177J7WwzpqZu/Fbn2SHiXHQSkWr07uGQl8XgLRVSSdjrgUvCRALEulSW
         9LV+5kdMnSXZz+1FB9XkOKUX1YvD4VJNuXCQZi8cgSGCeTT9oI0mbg7UqgcKurIl5WN5
         6kElnOFaRF5JHcuDZPvKgcZLxlOlUt/VDBkllUV/CivXCrih80Chl72NI1CBYsrcoXyn
         Q/3egvGATvra4d2dL/ZuazQS3al4DR5Y/OtPV8aabapsJaRwL85Gn5O32T49ZGIl3eeN
         a1l10YH4kP4eZJSdKRHc9gRMGp435+Ly3M8TWE679S22tti3+0Yh6PSSk9uEvyG3zwP6
         VdhA==
X-Gm-Message-State: AKaTC02Ck+TS91G9tg8SIpSZS66Im7Xdab8MX4wEdm+6tRTZK2W0S4HHo21fO0iPjNGb1pQkddwHWKJAQIUC3g==
X-Received: by 10.36.95.202 with SMTP id r193mr6997973itb.17.1481959916291;
 Fri, 16 Dec 2016 23:31:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.0.93 with HTTP; Fri, 16 Dec 2016 23:31:55 -0800 (PST)
In-Reply-To: <6ABA4AA4-BD5C-4178-BB3B-91CA045EA2AD@gmail.com>
References: <20161213092225.15299-1-judge.packham@gmail.com>
 <20161214092731.29076-1-judge.packham@gmail.com> <20161214112401.mq3n5kui5eeebdtk@sigill.intra.peff.net>
 <6ABA4AA4-BD5C-4178-BB3B-91CA045EA2AD@gmail.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Sat, 17 Dec 2016 20:31:55 +1300
Message-ID: <CAFOYHZDSyFxMWqrHNEX+hb1N4iNbe7baO1pS3n9hSb+Hk7WrgA@mail.gmail.com>
Subject: Re: [RFC/PATCHv2] Makefile: add cppcheck target
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, GIT <git@vger.kernel.org>,
        stefan.naewe@atlas-elektronik.com,
        Elia Pinto <gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 9:28 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> On 14 Dec 2016, at 12:24, Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 14, 2016 at 10:27:31PM +1300, Chris Packham wrote:
>
> Changes in v2:
>
> - only run over actual git source files.
>
> - omit any files in t/
>
>
> I actually wonder if FIND_SOURCE_FILES should be taking care of the "t/"
> thing. I think "make tags" finds tags in t4051/appended1.c, which is
> just silly.
>
> - introduce CPPCHECK_FLAGS which can be overridden in the make command
>
>  line. This also uses a GNU make-ism to allow CPPCHECK_ADD to specify
>
>  additional checks to be enabled.
>
>
> The GNU-ism is fine; we already require GNU make to build.
>
> The patch itself is OK to me, I guess. The interesting part will be
> whether people start actually _using_ cppcheck and squelching the false
> positives.
>
>
> @Chris: If this gets in then it would be great to run it as part of the
> Travis-CI build: https://travis-ci.org/git/git/branches
>

Yeah I was thinking about this.

Since as always with a new tool there are some doubts over it's
usefulness. I could easily hook it up to a branch in my own fork of
git and keep that branch rebased on top of pu. I'd need to keep an eye
on it myself and report errors on the list.

If that goes well, at some point someone will ask how I'm detecting
these errors. Then I can point them at this patchset and if enough
people want easy access to it then that may provide an incentive for
this to be merged into git.git.
