Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6E921F406
	for <e@80x24.org>; Wed,  3 Jan 2018 14:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeACOl4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 09:41:56 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:32922 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbeACOly (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 09:41:54 -0500
Received: by mail-wr0-f178.google.com with SMTP id v21so1798903wrc.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3vvsvJ7T3EQ4MdYVQ1x91BYcWYsje1u72eg7sAk0dwA=;
        b=m2VnCZ7jlcj3b/XLYd1dl8xjBUQWnk080LQkISb8HvgZFTgJ1LXCEKX9oKX1BRFn/z
         CMPB+TOv4iL/GKMJ5UVYqeVVyKHWYzoN6iicGWWIV/FGIaNMxGOEWp+56Ly7BNT1s5D1
         zmSIG17gHBBBOHFur8TXjsAWofEGCoANYC3Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3vvsvJ7T3EQ4MdYVQ1x91BYcWYsje1u72eg7sAk0dwA=;
        b=M/1ynn4PXbIid/zz4DL2UMYXzESM6YPXn34omFKzerBFUjgWe5F68MQd9U3hx89N8P
         TCLVYXnUeEyJHoA2b8ivgAH1KfErXPMPg7Ycp6ikmY2bQJZPF6WcLAfSVEAdVi0Qg3if
         T/0Hn8pQeyYLAN9Q95adBFCpDitPPHjAPowYL8+Sq/oknVkm2hI1qCb/M66YTKrYYCdP
         AsnziURF+aQyqoR4GVeR2nsvt+brzLZjUgoQ6uQ8BhitMV7ohPDDHuYvY/ZvqTYn4jZT
         +AEGd8K0msvhiYgIDFLPlHaJ2RtpZX/h22dj5myayN684BWs4fzmqvJS65w/bTgrmsJ3
         y4eg==
X-Gm-Message-State: AKGB3mIknmC0pFThLG2PVjUH3NuVzd62H+oZK1hd9uiCBz7ipvW6Xw2t
        7fIfoD/CxN5zI8TP2Gmc7nbPYw==
X-Google-Smtp-Source: ACJfBosKp5gGjmlRtDxlBJDsA5BmgFMJdatuNiHlmMQKDYxy6lJPICosqEyTObVi7m3V5WM18ruUAA==
X-Received: by 10.223.133.4 with SMTP id 4mr1657412wrh.192.1514990512855;
        Wed, 03 Jan 2018 06:41:52 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id a16sm1746125wrc.7.2018.01.03.06.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 06:41:51 -0800 (PST)
Date:   Wed, 3 Jan 2018 14:41:49 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 7/7] wildmatch test: create & test files on disk in
 addition to in-memory
Message-ID: <20180103144149.GE29210@dinwoodie.org>
References: <20171223213012.1962-1-avarab@gmail.com>
 <20171225002835.29005-8-avarab@gmail.com>
 <20180103130232.GD29210@dinwoodie.org>
 <87h8s3cbmn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8s3cbmn.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 03 January 2018 at 02:31 pm +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jan 03 2018, Adam Dinwoodie jotted:
> 
> > On Monday 25 December 2017 at 12:28 am +0000, Ævar Arnfjörð Bjarmason wrote:
> >> There has never been any full roundtrip testing of what git-ls-files
> >> and other functions that use wildmatch() actually do, rather we've
> >> been satisfied with just testing the underlying C function.
> >>
> >> Due to git-ls-files and friends having their own codepaths before they
> >> call wildmatch() there's sometimes differences in the behavior between
> >> the two, and even when we test for those (as with
> >> 9e4e8a64c2 ("pathspec: die on empty strings as pathspec", 2017-06-06))
> >> there was no one place where you can review how these two modes
> >> differ.
> >>
> >> Now there is. We now attempt to create a file called $haystack and
> >> match $needle against it for each pair of $needle and $haystack that
> >> we were passing to test-wildmatch.
> >>
> >> If we can't create the file we skip the test. This ensures that we can
> >> run this on all platforms and not maintain some infinitely growing
> >> whitelist of e.g. platforms that don't support certain characters in
> >> filenames.
> >>
> >> As a result of doing this we can now see the cases where these two
> >> ways of testing wildmatch differ:
> >>
> >>  * Creating a file called 'a[]b' and running ls-files 'a[]b' will show
> >>    that file, but wildmatch("a[]b", "a[]b") will not match
> >>
> >>  * wildmatch() won't match a file called \ against \, but ls-files
> >>    will.
> >>
> >>  * `git --glob-pathspecs ls-files 'foo**'` will match a file
> >>    'foo/bba/arr', but wildmatch won't, however pathmatch will.
> >>
> >>    This seems like a bug to me, the two are otherwise equivalent as
> >>    these tests show.
> >>
> >> This also reveals the case discussed in 9e4e8a64c2 above, where '' is
> >> now an error as far as ls-files is concerned, but wildmatch() itself
> >> happily accepts it.
> >>
> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >
> > I'm seeing this test script failing on the pu branch as a result of this
> > commit when building on Cygwin.  Specifically, the test fails at
> > 9d45e1ca4 ("Merge branch 'bw/oidmap-autoinit' into pu", 2017-12-28), and
> > bisecting points the blame at 2ee0c785a ("wildmatch test: create & test
> > files on disk in addition to in-memory", 2017-12-25).
> >
> > I've copied the verbose error output for the first error below, and
> > uploaded the full output, including verbose and trace output for the
> > unexpectedly failing tests, at [0].  (With 42 failures among 1512 tests,
> > there's a lot of it, so I didn't want to include it in an email.)
> 
> Does the fixup above in <878tdm8k2d.fsf@evledraar.gmail.com> work for
> you, i.e. changing $10 in the script to ${10}?

This fixes some but not all of the failures: I'm now down from 42 to 24
failures.

Updated verbose test output is at
https://gist.github.com/me-and/04443bcb00e12436f0eacce079b56d02

Thanks!

Adam
