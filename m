Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266511F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 12:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeKQWky (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 17:40:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32882 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeKQWkx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 17:40:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so2730493wmb.0
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 04:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XMa5Z8qGxxCnR2FgJt8COIK6i2zPZc9UiIMtBE2hCS0=;
        b=u1hAclYpZjX8zA60V439/p0b0/PbKeZs/s+ZkqScbIGXTCXuMYXw5kXg7/N0pXYelF
         YZ/NDluwa51zigi+dzBkI75FAc1jJGkMZ+AAfY2QY4UMLMZZ5kxfuLmvw2bRImOutAgz
         SGKsKK+jBxhSoxMEnHWS+u5PweEC/A/YN/QgF8Qztul2fc9vlb40ocsp7jc38MIaRcEt
         jZnM0OMR7nvc+kdsFtzI3sP6dozb+Ec1YrF6aJOgdt0+XYf273iDSwEtuZ1T/uwnfxl0
         0K/fsIRG1Y3I6hyXrW6GrIoDZpPupzzYO6ungZDmcPAzJlMAwugyKNN4iqiaSIWzdpwy
         KLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XMa5Z8qGxxCnR2FgJt8COIK6i2zPZc9UiIMtBE2hCS0=;
        b=iOPNx9+GIYF0z3DdON6nS9/5NQioeu7Mx4zSCtoh/WG1nCmFzs8a4zkjBXPruEMry2
         CfGvKprX/xmhP7c5xbX9kVLCqMTcTra+k05Z/Aah7dbLBGy0u1tOqvTMFT/BKrK5IH3Y
         v/cueIh+Pev+FT5clqkXKGzMGJa1Y97ks1r66jyI7CZ9DzSH7Xk1Knoo5NkurL3/Qanl
         eE6unglNtUJx4DZ1cLE/sqa2sWmEdcbTXtxvNwJ/fwCoMLgZHDivc5hzPIuwxjYOHx9n
         bb/3kH0lxio5nBOqNDZipZbJAkKcVtkVPN/aZiqelOyjduUJOJjt3KwtbRxzza1S3ZD/
         6PZA==
X-Gm-Message-State: AA+aEWbgbjXqgvfr7SEgVU8l0KfNjp4/jGz08m9FdMMpuTcit585HByc
        JaY9y005pI00af+QWHg/doo=
X-Google-Smtp-Source: AFSGD/XUebPJAwZdJMgbXyL2Z+/aRMtOMBRbVFnpFv4aXNv7z2OwV6yxFj9svJ01h3GGbiA8Lv3t+g==
X-Received: by 2002:a1c:e910:: with SMTP id q16-v6mr1475355wmc.148.1542457460358;
        Sat, 17 Nov 2018 04:24:20 -0800 (PST)
Received: from szeder.dev (x4db06bb4.dyn.telefonica.de. [77.176.107.180])
        by smtp.gmail.com with ESMTPSA id 6-v6sm23498489wmg.19.2018.11.17.04.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 04:24:19 -0800 (PST)
Date:   Sat, 17 Nov 2018 13:24:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same
 permissions
Message-ID: <20181117122417.GP30222@szeder.dev>
References: <20181116173105.21784-1-chriscool@tuxfamily.org>
 <20181116182934.GN30222@szeder.dev>
 <CAP8UFD2tC9B_m=NmK4DTCJP=o+L+RKy9C_2ra9fgeNMzOuCZ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2tC9B_m=NmK4DTCJP=o+L+RKy9C_2ra9fgeNMzOuCZ3A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 08:25:43PM +0100, Christian Couder wrote:
> On Fri, Nov 16, 2018 at 7:29 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > On Fri, Nov 16, 2018 at 06:31:05PM +0100, Christian Couder wrote:
> > > diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> > > index 2ac47aa0e4..fa1d3d468b 100755
> > > --- a/t/t1700-split-index.sh
> > > +++ b/t/t1700-split-index.sh
> > > @@ -381,6 +381,26 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
> > >       test $(ls .git/sharedindex.* | wc -l) -le 2
> > >  '
> > >
> > > +test_expect_success POSIXPERM 'same mode for index & split index' '
> > > +     git init same-mode &&
> > > +     (
> > > +             cd same-mode &&
> > > +             test_commit A &&
> > > +             test_modebits .git/index >index_mode &&
> > > +             test_must_fail git config core.sharedRepository &&
> > > +             git -c core.splitIndex=true status &&
> > > +             shared=$(ls .git/sharedindex.*) &&
> >
> > I think the command substitution and 'ls' are unnecessary, and
> >
> >   shared=.git/sharedindex.*
> >
> > would work as well.
> 
> If there is no shared index file with the above we would get:
> 
> shared=.git/sharedindex.*
> $ echo $shared
> .git/sharedindex.*
> 
> which seems bug prone to me.

That's just a non-existing file, for which 'test_modebits' will print
nothing, which, in turn, will not match the modebits of '.git/index'.
And the "there are more than one shared index files" case is handled
by the case statement that was snipped from the email context.

