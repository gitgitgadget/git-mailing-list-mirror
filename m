Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A22A1FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 08:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755037AbcLNIeB (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:34:01 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35337 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754722AbcLNIeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:34:00 -0500
Received: by mail-io0-f193.google.com with SMTP id f73so3398235ioe.2
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rSjU3XtMVB0XUyqCmK+heIGITm1wsMeMzoR7ZHtPWJI=;
        b=Cdt2qMkzhpPqA2Z+dukQYMwY3vutpouMLBJepMQpkSRexDRBh915HYeA50oNhEbB2u
         z1PLJudd9PMuRT3OZkWS1xAqQEWwIdtAbmlbeEZ//UBhhH69XpBlZ0AYHnuehwduomm2
         ly2VSOL1G1pEwQUzknMcH+StN9H5UheGaRE7Ggx23TqLmuo9B0dxBPNQHKhW561tv90T
         +W80cfUUcQPhO+d7aeqo9S/JFonm2LNr8s536nFD2HMiTnIpH9GpUOsDnJOjnYZjnvYO
         aM5OKCGbbCZeabtTAHXp1dAkARUN9lf+VcjizEm2u00f/wOf/7y7lHlutKVSJ8QoweUd
         T0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rSjU3XtMVB0XUyqCmK+heIGITm1wsMeMzoR7ZHtPWJI=;
        b=ZKFNMgbg0TvA4HIVcNinxAgvODkFYI/+w8m0bVKYdLD/GPljZ4l0wpEbJM1Ky8nqAH
         PtLach38YY+xN2sF6BWPh25H77ycZYGChjbWXwd9JH83mUYiqJOWGvP8PtTaUHlaJlKJ
         5mPNihyMl5EAipzTDs2h2keRFFUzZqxXbxD3dcQLGo5GH+o1aCtHPgbTN1lC7Eladm6f
         p94L+TwyQdyZjNkY3gza6bUZGXsgr576L0i7odWN6JF6RUWlw09ElRFGpmq/cAOtBhMz
         xgfKUzoCxj7C0/4Zzp94rO8fAys1zInRFje/Vhajp/Yt6VoAbPvHAqSvJ6oqte7l4Rba
         /q9g==
X-Gm-Message-State: AKaTC0175FkWsS38av6sO9h69+HBjD/pMBooRMbZEZG8auu28CBTth1VcXFHLUIIKVbsTTri7mzmHS8IJcApXA==
X-Received: by 10.107.170.129 with SMTP id g1mr78690325ioj.51.1481704439845;
 Wed, 14 Dec 2016 00:33:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.0.93 with HTTP; Wed, 14 Dec 2016 00:33:59 -0800 (PST)
In-Reply-To: <20161213121510.5o5axuwzztbxcvfd@sigill.intra.peff.net>
References: <20161213092225.15299-1-judge.packham@gmail.com> <20161213121510.5o5axuwzztbxcvfd@sigill.intra.peff.net>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Wed, 14 Dec 2016 21:33:59 +1300
Message-ID: <CAFOYHZBRq=5FGswQZSYbn0JdrEv+xqLm6gdpD_nE+1L_CfPHEw@mail.gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add cppcheck target
To:     Jeff King <peff@peff.net>
Cc:     GIT <git@vger.kernel.org>, Elia Pinto <gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 1:15 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 13, 2016 at 10:22:25PM +1300, Chris Packham wrote:
>
>> $ make cppcheck
>> cppcheck --force --quiet --inline-suppr  .
>> [compat/nedmalloc/malloc.c.h:4093]: (error) Possible null pointer dereference: sp
>> [compat/nedmalloc/malloc.c.h:4106]: (error) Possible null pointer dereference: sp
>> [compat/nedmalloc/nedmalloc.c:551]: (error) Expression '*(&p.mycache)=TlsAlloc(),TLS_OUT_OF_INDEXES==*(&p.mycache)' depends on order of evaluation of side effects
>> [compat/regex/regcomp.c:3086]: (error) Memory leak: sbcset
>> [compat/regex/regcomp.c:3634]: (error) Memory leak: sbcset
>> [compat/regex/regcomp.c:3086]: (error) Memory leak: mbcset
>> [compat/regex/regcomp.c:3634]: (error) Memory leak: mbcset
>> [compat/regex/regcomp.c:2802]: (error) Uninitialized variable: table_size
>> [compat/regex/regcomp.c:2805]: (error) Uninitialized variable: table_size
>> [compat/regex/regcomp.c:532]: (error) Memory leak: fastmap
>> [t/t4051/appended1.c:3]: (error) Invalid number of character '{' when these macros are defined: ''.
>> [t/t4051/appended2.c:35]: (error) Invalid number of character '{' when these macros are defined: ''.
>>
>> The last 2 are just false positives from test data. I haven't looked
>> into any of the others.
>
> I think these last two are a good sign that we need to be feeding the
> list of source files to cppcheck. I tried your patch and it also started
> looking in t/perf/build, which are old versions of git built to serve
> the performance-testing suite.
>
> See the way that the "tags" target is handled for a possible approach.
>
> My main complaint with any static checker is how we can handle false
> positives. I think our use of "-Wall -Werror" is successful because it's
> not too hard to keep the normal state to zero warnings. Looking at the
> output of cppcheck on my system (which is different than on yours!),

I think you get a similar class of problems with different compilers
(different gcc versions, clang, msvc). Although this appears to be
mitigated already with the diverse developers in the git community.

> I do see a few real problems, but many false positives, too.
> Unfortunately, one of the false positives is:
>
>   int foo = foo;

On I side note I have often wondered how this actually works to avoid
the uninitialised-ness of foo. I can see how some compilers may be
fooled into thinking that foo has been set but that doesn't actually
end up with foo having a deterministic value.

> to silence -Wuninitialized, which causes cppcheck to complain that "foo"
> is uninitialized. I'm worried we will end up with two static checkers
> fighting each other, and no good way to please both.
>
> -Peff
