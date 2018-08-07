Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76BB1208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 19:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390903AbeHGVOL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 17:14:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44775 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbeHGVOK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 17:14:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so14256511ljq.11
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zCfRkynu2l7AsQ5fcCjK3xoCe2C7eYzTNcw/sRDvILI=;
        b=C58B70n8lDgMbYzz3zIQWC09Wl0BvkCKk4xGo1RisUSm7iiE4NL4EzA4AaNtuC8zXx
         tIbpL47jolSMTSsYF0V5ogavQR9iz5f3k2ZZ9MqqayvMlc93ez+lSq1YnmE3DNRZ7br7
         BnnwEkMmnrctA6ih94dp/hXj5w/7gp4MQAEl6vcm2pU1Cs7+uX0HTzix2hRU2dWwl/UK
         Jmo+MiQQdPmXWvYPZUn7+XeGM5Yn3OXab3Sy3T3kUO7Yp4BHrMCIw2ASQKhB4NJaVjFK
         6PcUt0iXhDDXbIx1HLkJUXy2hbC/c04LPc4nooeQ/aCUVHoDeVv2rIYeT2O4r1BGx3Rx
         bSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zCfRkynu2l7AsQ5fcCjK3xoCe2C7eYzTNcw/sRDvILI=;
        b=cyf7b4NU3CmWk0mVfyVJ9z/aEds/NRiBXCDAM2cjKGlj5AE6EvcpgqeZw7S/lMlvnY
         jUjDygtGaqu+ba8csp1+XSZNYJ+P5eLWDfvCcUfq2tKSa+b+7FE0TPAcCFoXtkNgNy+R
         MQDVvxt+L7gBdRnIAdP2IXCeoxVumVpkDKFXykPK/f0ACxfZ2+mikPW3xluBiYcefOKD
         huv+X5UWIOpEdplotCCWYcnKTv8KFfhHudcfjq1ReJdYkfHTcdpUYm/G6Nle7Cyr4dUz
         /EbfDZ5v1zkTuPWBLEuOorqryzdy7wXJhBAGrCahMgQfsenMT4gJ3s4AoC0F9yvXJHRy
         a1aQ==
X-Gm-Message-State: AOUpUlG0JfZJ8Fwj+Zw41Wg6+Cs0R4WGr3umZn3uDXObK2ketHKWfiHG
        v7fxYWbiKehzBXz3k6nPouAozruFUph3PhCBD10=
X-Google-Smtp-Source: AAOMgpc5s9dzqYP/e3bMxalvjJL7+PTWf8kkwOaFJuZYUfZ1fF9+vFCrT6q9s+7dA5On4tyKtWPfrxCCL/UvUQByl5c=
X-Received: by 2002:a2e:8807:: with SMTP id x7-v6mr16047886ljh.98.1533668305407;
 Tue, 07 Aug 2018 11:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180731225612.24075-1-szeder.dev@gmail.com> <51083CBF-E805-4408-8973-E5C85100E319@gmail.com>
In-Reply-To: <51083CBF-E805-4408-8973-E5C85100E319@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 7 Aug 2018 20:58:13 +0200
Message-ID: <CAM0VKjkdf7Rn7nxZQ5DScT_nYAbK76SFuWRUrcUJb23utKWf7A@mail.gmail.com>
Subject: Re: [PATCH] travis-ci: include the trash directories of failed tests
 in the trace log
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 5:12 PM Lars Schneider <larsxschneider@gmail.com> wr=
ote:
>
> > On Aug 1, 2018, at 12:56 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> >
> > The trash directory of a failed test might contain invaluable
> > information about the cause of the failure, but we have no access to
> > the trash directories of Travis CI build jobs.  The only feedback we
> > get from there is the build job's trace log, so...
>
> 100% agree that keeping the trash directory is valuable.
>
> > Modify 'ci/print-test-failures.sh' to create a tar.gz archive of the
> > trash directory of each failed test, encode that archive with base64,
> > and print the resulting block of ASCII text, so it gets embedded in
> > the trace log.  Furthermore, run tests with '--immediate' to
> > faithfully preserve the failed state.
>
> I feel that might be complicated to work with.

It works quite conveniently in practice, that was one of the points of
the next paragraph.

> How about this:
> We create an publicly available Git repo (e.g. github.com/git/git-test-tr=
ash`)

I'm not sure I understand.  A publicly _writable_ repository?  That
sounds like asking for trouble.

> and then we push the trash directory of every failed test run to
> this repo. Then we link the commit in the logs to help people find
> them.
>
> Wouldn't that make it easier to access the trash dir?

With this patch, if there are any trash directories embedded in the
log, then the log will show a command near the very end that you can
copy-paste into a terminal, and bam! in less than 3 seconds you have
all those trash directories downloaded and unpacked.

I'm not sure how it could be made any easier than that.

> > Extracting the trash directories from the trace log turned out to be a
> > bit of a hassle, partly because of the size of these logs (usually
> > resulting in several hundreds or even thousands of lines of
> > base64-encoded text), and partly because these logs have CRLF, CRCRLF
> > and occasionally even CRCRCRLF line endings, which cause 'base64 -d'
> > from coreutils to complain about "invalid input".  For convenience add
> > a small script 'ci/util/extract-trash-dirs.sh', which will extract and
> > unpack all base64-encoded trash directories embedded in the log fed to
> > its standard input, and include an example command to be copy-pasted
> > into a terminal to do it all at the end of the failure report.
> >
> > A few of our tests create sizeable trash directories, so limit the
> > size of each included base64-encoded block, let's say, to 1MB.  And
> > just in case something fundamental gets broken and a lot of tests fail
> > at once, don't include trash directories when the combined size of the
> > included base64-encoded blocks would exceed 1MB.
> >
> > Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> > ---
