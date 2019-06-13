Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D841F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfFMRnf (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:43:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39527 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfFMRne (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:43:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so11001413wma.4
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Nnof1SUVoV0WHT9za8T8p2Hpw+ZiBomKR8AlJ5sYlIY=;
        b=ig5a5WaaI3n5FEfaEodHf9/fJpHK2FI1iFDVAyYknIXtSwFvyD3iV+F4sf6LxLU8xQ
         IlRk29dbCsIhw7OcpxXusOozTZ94GqyEyDvhlT2IAP1nsuuftnyJcsZtEfaANCIBPbTE
         6em3Nw1+bb/Hy9rFcJGxvrSmpzbp2MqIUtWpaxU5NUX1lii0HFivjsnXeoDkfT6d5q3C
         1r6k1tgu3rOvJSUncE13747C+dYtNmYsPSyBMp19DXh+La8qBNJV2qsIWrG1kwhm2/5A
         GmBNz+4QZXsUKtrZmaAB+jZjlb+oiAumToHdLeuWTGT1Qn8qVO+26VD7PSEH8NdYTpV7
         Bdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nnof1SUVoV0WHT9za8T8p2Hpw+ZiBomKR8AlJ5sYlIY=;
        b=pw8eGm7/3gEWlAAcwpQFTTqTCts0j+p5y46CoObXLI7fPgHqZ56VMvjASui7gHypb9
         VEQNxm+EvoJTCDRQRj4NZV8cLb0I1tH2tbNwThdC9/mzlGki4ejNWZ4+f9yQBfd2GDip
         bDSffAZtOtLnvpL94EBYYj8IQ5V7XLjuF+ra1kXhWGqvmyCpY7RXwnO/qiXVH+UgME0F
         746yH6uDE7GFxxbxgWhcEXMwLE/Ado1JEBay9xAjMlKF+4pbRNgwNKbq9/NK/Ye1BdZS
         m4WkMg9U50OMIkAFYQvmcZOCjC5nhBz8X5ie1bPEKgy/OEsxBuDOgUifIBgkxlCu3/l2
         wTHA==
X-Gm-Message-State: APjAAAW9w4YsI1eL3UWUeMD/LKKpQwMr/aRcaDZXOV7r4uhel9gnx0HR
        VFPtJ3o7QqAT3FirC2ANAt4YYOgl
X-Google-Smtp-Source: APXvYqxp26gtQtTHQ8621JPa3eC3CmXsHsCPKaiVs70C1NczqTaBlOP5zy14rbwyiKrS4CJhE9jHDg==
X-Received: by 2002:a1c:a541:: with SMTP id o62mr4741271wme.84.1560447812359;
        Thu, 13 Jun 2019 10:43:32 -0700 (PDT)
Received: from szeder.dev (x4dbd2f68.dyn.telefonica.de. [77.189.47.104])
        by smtp.gmail.com with ESMTPSA id w14sm171028wrt.59.2019.06.13.10.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:43:31 -0700 (PDT)
Date:   Thu, 13 Jun 2019 19:43:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] ci: split the `linux-gcc` job into two jobs
Message-ID: <20190613174329.GE31952@szeder.dev>
References: <pull.266.git.gitgitgadget@gmail.com>
 <ac102169ec6f47b8be1fe69b4798de385f102af8.1560430430.git.gitgitgadget@gmail.com>
 <20190613153354.GC31952@szeder.dev>
 <xmqqv9x9wkba.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1906131844440.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1906131844440.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 06:51:04PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 13 Jun 2019, Junio C Hamano wrote:
> 
> > SZEDER Gábor <szeder.dev@gmail.com> writes:
> >
> > > On Thu, Jun 13, 2019 at 05:53:51AM -0700, Johannes Schindelin via GitGitGadget wrote:
> > >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >>
> > >> This job was abused to not only run the test suite in a regular way but
> > >> also with all kinds of `GIT_TEST_*` options set to non-default values.
> > >>
> > >> Let's split this into two
> > >
> > > Why...?
> > >
> > >> with the `linux-gcc` job running the default
> > >> test suite, and the newly-introduced `linux-gcc-extra` job running the
> > >> test suite in the "special" ways.
> > >>
> > >> Technically, we would have to build Git only once, but it would not be
> > >> obvious how to teach Travis to transport build artifacts, so we keep it
> > >> simple and just build Git in both jobs.
> >
> > I had the same reaction.
> 
> So basically you are saying that the cover letter was the wrong location
> for this:
> 
> 	For people like me, who often look at our CI builds, it is hard to
> 	tell whether test suite failures in the linux-gcc job stem from
> 	the first make test run, or from the second one, after setting all
> 	kinds of GIT_TEST_* variables to non-default values.

Is this really an issue in practice?  In my experience there are only
two (and a half) cases:

  - if both the 'linux-gcc' and 'linux-clang' build jobs fail, then
    it's some sort of a general breakage.

  - if only the 'linux-gcc' build job fails, the 'linux-clang'
    succeeds, then it's a breakage in the test run with the various
    'GIT_TEST_*' test knobs enabled (unless the failing 'linux-gcc'
    build job's runtime is below, say, 5 minutes, in which case it's a
    build error only triggered by GCC(-8), and, as I recall, is rather
    rare).


> 	Let's make it easier on people like me.
> 
> 	This also helps the problem where the CI builds often finish the other
> 	jobs waaaay before linux-gcc finally finishes

This is not the case on Travis CI, where the runtime of the macOS
build jobs are far the longest, so this change won't help anything
there... on the contrary, it would make things slower by spending time
on installing dependencies and building Git in one more build job.

>       too: linux-gcc and
> 	linux-gcc-extra can be run in parallel, on different agents.
