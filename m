Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360AB1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 11:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeKTVyW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 16:54:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40759 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeKTVyW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 16:54:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so1804887wmf.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 03:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=U1idEy9bWvIWpOmPH1JxaQSsc8P7dFa1NCJW3LBWo+I=;
        b=jr5aCSmGOFhqEiP5Af/jSbpRXafKBU3be+CAzH9/wJw64p3KyWVfc4vXhlrRrbqdD/
         8sytcPUL9VXv80duz1dUTAJ8hSJLRpCnYenRInkL04y9Xci8W4YWzIrFceEqoOsJdK3e
         9im5sZHoumwYJ8lEe6nwDxUyC5kJ+uLHWfP9TAUZ2NG5T1pxGDh7LfH6hV8phyD+cIIn
         bbCruu0faY1Nku7RT2KVWzHaQM5hsO/joTnYdC2feWlqfV6Xtj6f4kwXLXE/viacjK25
         t2oZk3WkSkJjWvNR4OqT7sQDW2z04r701XXZXNtwRpCp+WsHfYVaMc9y+P/At0NbADnC
         d0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U1idEy9bWvIWpOmPH1JxaQSsc8P7dFa1NCJW3LBWo+I=;
        b=EglPgtQElqCx1bxcJuWbF6ihzFIKRpde7JNbrGCu8iNJLZOoJw1S5zwoGvAxluNEWY
         GdvZYBILV46CYfJXV/4l8k5NQdvk3V+DWVEW7UnkKIAH5wj4Lmiv+icTZAmNhnSwcUKY
         +v4bqKAE1hTo7Du+ncGYkznDZinlPqpUilJ51tFaexhzm82Blvbmqdt+V7jcq2gQmHYh
         nz9Moz2rNGWygEkU/aeMB5Wqc58IJ12P35UweXa9HAC9JIbL8Vn5Z2sSURAvP2Rf2sVM
         2o8kiCaAej338nnmj3XlSf/VDlnLAZdDULD1pXmKbVa2WYmGy7vU7yWkGsZMWO972lOn
         x8tQ==
X-Gm-Message-State: AGRZ1gJ3DKppVVafgCAVXCaV7+rId55k+hN7dXBLIiosPAF21SWMa5q2
        cSylfREVleepd/ehJSEfLrc=
X-Google-Smtp-Source: AJdET5fK53YW1A2kUqQ26d4UviHwzJhzZlig3n+vJ4BOHZ6ZpnufCyE+ixwCqd2e9cfvcBCkIMW1JQ==
X-Received: by 2002:a1c:681:: with SMTP id 123mr1846402wmg.118.1542713141255;
        Tue, 20 Nov 2018 03:25:41 -0800 (PST)
Received: from szeder.dev (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id o15-v6sm15796373wmc.18.2018.11.20.03.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 03:25:40 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:25:38 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: make 'test_cmp_rev' more informative
 on failure
Message-ID: <20181120112538.GX30222@szeder.dev>
References: <20181119132818.3116-1-szeder.dev@gmail.com>
 <20181119194920.GB7330@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119194920.GB7330@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 02:49:20PM -0500, Jeff King wrote:
> On Mon, Nov 19, 2018 at 02:28:18PM +0100, SZEDER Gábor wrote:
> 
> > The 'test_cmp_rev' helper is merely a wrapper around 'test_cmp'
> > checking the output of two 'git rev-parse' commands, which means that
> > its output on failure is not particularly informative, as it's
> > basically two OIDs with a bit of extra clutter of the diff header, but
> > without any indication of which two revisions have caused the failure:
> > 
> >   --- expect.rev  2018-11-17 14:02:11.569747033 +0000
> >   +++ actual.rev  2018-11-17 14:02:11.569747033 +0000
> >   @@ -1 +1 @@
> >   -d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
> >   +139b20d8e6c5b496de61f033f642d0e3dbff528d
> > 
> > It also pollutes the test repo with these two intermediate files,
> > though that doesn't seem to cause any complications in our current
> > tests (meaning that I couldn't find any tests that have to work around
> > the presence of these files by explicitly removing or ignoring them).
> > 
> > Enhance 'test_cmp_rev' to provide a more useful output on failure with
> > less clutter:
> > 
> >   error: two revisions point to different objects:
> >     'HEAD^': d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
> >     'extra': 139b20d8e6c5b496de61f033f642d0e3dbff528d
> > 
> > Doing so is more convenient when storing the OIDs outputted by 'git
> > rev-parse' in a local variable each, which, as a bonus, won't pollute
> > the repository with intermediate files.
> > 
> > While at it, also ensure that 'test_cmp_rev' is invoked with the right
> > number of parameters, namely two.
> 
> This is an improvement, in my opinion (and I agree that using your new
> BUG for this last part would be better still). It also saves a process
> in the common case.

But then it adds two subshells to the common case right away...  I'm
not sure which is worse on Windows, where it matters the most.

> One question:
> 
> > +	else
> > +		local r1 r2
> > +		r1=$(git rev-parse --verify "$1") &&
> > +		r2=$(git rev-parse --verify "$2") &&
> > +		if test "$r1" != "$r2"
> > +		then
> > +			cat >&4 <<-EOF
> > +			error: two revisions point to different objects:
> > +			  '$1': $r1
> > +			  '$2': $r2
> > +			EOF
> > +			return 1
> > +		fi
> 
> Why does this cat go to descriptor 4? I get why you'd want it to (it's
> meant for the user's eyes, and that's where 4 goes),

Exactly.

> but we do not
> usually bother to do so for our helper functions (like test_cmp).

test_i18ngrep() does since your 03aa3783f2 (t: send verbose
test-helper output to fd 4, 2018-02-22).

> I don't think it matters usually in practice, because nobody tries to
> capture the stderr of test_cmp, etc.

See 54ce2e9be9 (t9400-git-cvsserver-server: don't rely on the output
of 'test_cmp', 2018-03-08) for a fun example, I remember it caused a
spike in WTF/minutes :)


> I don't think it would ever hurt,
> though. Should we be doing that for all the others, too?

I think we should, and you agreed:

https://public-inbox.org/git/20180303065648.GA17312@sigill.intra.peff.net/

but then went travelling, and then the whole thing got forgotten.

