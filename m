Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356F620986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbcJDSAd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:00:33 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34049 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750700AbcJDSAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:00:32 -0400
Received: by mail-wm0-f46.google.com with SMTP id 197so36696162wmk.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/sh6t1Fulo0lSH3KXIscQAJOUAuOKzUhLUtv5fdGf0U=;
        b=T5/s84BUHz/iwwmhau8BWVLpbEPF9vUzN8I/DnxEcYBEGutcvtRDz7lkiim+WM3Aka
         zNK8izGQ5qWiLW0PCGCKUE/XknJk4YOgjRNHVHCVxHB//CJ2/LEh8qnuUZMEuFGFxPZP
         fwvoN7x1kwfX/TeYzyq13BepYz0mftZ1hDEqUsh7ARwZk3rdSKykKP+xI6cOmdVg+GMD
         8atMe1jhYou9m/V9NDNO0VCMdKqaihw9yXrqvKJ5mJlzfaB2ZX7LQ8xsnAi3PZ3W6jIY
         gu3++PYJ85VY97KdGFsTbMau4sdwP9HvuEQK9+12BIMmySn3P4V/XGSRTN+w+iHtqx+Z
         5qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/sh6t1Fulo0lSH3KXIscQAJOUAuOKzUhLUtv5fdGf0U=;
        b=jJKStdL00RSJxqfQhOXNVSTvQHctNSR0kHdBAQi0ixqP69wtaGg30DGvL9dWIQtJOo
         T8ut/6UbaH6TitEIb24TvJxWMtQ0yAok1Ea4He6kws4aPVDd2W5bjK+Xk6iR98aPZXvB
         0sdHJvZjyVrLBk8vATqoz22/M3H54ibT68fWjmgxuXd7/mdPtrEkk07whv3nPZXjtaVy
         7+C24MdIHeBSxLsqChvegfEi7Akc1u29gPMSjF/HGBMmGofo3DIf4MXM9iatpIQeLwYD
         0EXvI1kb7kjpzLAngOUTD9LUWOfshHm60nPA1NqWLsTqVnXlOWnem+/Wivkbz41CHgcj
         LP3w==
X-Gm-Message-State: AA6/9RmRDeOu04lr3eapku8pW1kHN6mCxVDtARaa0SAsc0SNcM8xZ55R0Y2E+9qKThaQ/6tExM7BJn0esZNryA==
X-Received: by 10.28.184.199 with SMTP id i190mr15008386wmf.43.1475604030695;
 Tue, 04 Oct 2016 11:00:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.109.75 with HTTP; Tue, 4 Oct 2016 11:00:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610041915320.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx> <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <20161004161130.GX19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610041915320.35196@virtualbox>
From:   Ray Donnelly <mingw.android@gmail.com>
Date:   Tue, 4 Oct 2016 19:00:30 +0100
Message-ID: <CAOYw7duf6VbtB3eL-z2b6TL+Wc7PRuARpfi-nwANnF9N0-2NBA@mail.gmail.com>
Subject: Re: Regression: git no longer works with musl libc's regex impl
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Rich Felker <dalias@libc.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, musl@lists.openwall.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 6:16 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Rich,
>
> On Tue, 4 Oct 2016, Rich Felker wrote:
>
>> On Tue, Oct 04, 2016 at 06:08:33PM +0200, Johannes Schindelin wrote:
>> > Hi Rich,
>> >
>> > On Tue, 4 Oct 2016, Rich Felker wrote:
>> >
>> > > On Tue, Oct 04, 2016 at 11:27:22AM -0400, Jeff King wrote:
>> > > > On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
>> > > >
>> > > > > 1. is nonzero mod page size, it just works; the remainder of the last
>> > > > >    page reads as zero bytes when mmapped.
>> > > >
>> > > > Is that a portable assumption?
>> > >
>> > > Yes.
>> >
>> > No, it is not. You quote POSIX, but the matter of the fact is that we use
>> > a subset of POSIX in order to be able to keep things running on Windows.
>> >
>> > And quite honestly, there are lots of reasons to keep things running on
>> > Windows, and even to favor Windows support over musl support. Over four
>> > million reasons: the Git for Windows users.
>>
>> I would hope that in the future, git-for-windows users will be using
>> musl, via midipix, rather than the painfully slow and awful version
>> they're stuck with now...
>
> Git for Windows actually uses the MSVC runtime, which is blazing fast.
>
> You are probably confusing Git for Windows with Cygwin Git.

To be fair, Cygwin Git isn't *that* slow, though I look forward to the
day when MSYS2 can use the native-Windows/GfW version instead
(including your rebase-in-C changes)

>
> Ciao,
> Johannes
