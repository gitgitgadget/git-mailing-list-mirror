Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301D41F404
	for <e@80x24.org>; Thu,  1 Mar 2018 15:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032066AbeCAPas (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 10:30:48 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:40718 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032227AbeCAPag (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 10:30:36 -0500
Received: by mail-it0-f52.google.com with SMTP id e64so2060954ita.5
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L99peoNp9tMqtqlyLOluSWzSe2fn72xtlzmvC7Lx9nI=;
        b=O23dfmCBG0H1VxmOPWWoREmDKq//Z6kMFG7ybAANcpjqdk2ukk+m/D2A03Uwk/LWRc
         dSVtnOxfT7LR7zBMftO1VmAX2X4I+jwQSQ1u40eC0FgUZdMHl4Ggsxyhd4ds+v0drrAx
         /Og7jDnLir+Lf5bbXC4O0NHi95i6met5clgAG7j1mUALxyk1xM/eEWOr6gVs41v6za5E
         nam1c78jARAK9NDgRxuvkM3+lbwgQ/0QhqxPD6uGIfwh2UhkvgH2sO3BjJwWpwuDh45S
         04KW++xRT9FTwIIeflA11F4DPPjxQCICkhqgNHoVk4SY+5fGIw2UOJ2MBw8tKMGH/wTV
         FoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L99peoNp9tMqtqlyLOluSWzSe2fn72xtlzmvC7Lx9nI=;
        b=GiHpHmoEd0zq+1uuUEo2aqAodW4ht/iHeVWEvHsdMX7qDvdDMAXDw0fgbPAEojOHGv
         orpwYcqS0SgpL15qerw8ynEXPVGZaczI1FWfiZby75DCxYRZGDiJodrHrmnlmv330kpe
         TV6pMBwkOb/jig2Fz0RRFDBciwAarsy0c9R59me3kUFS37jwkmKvl1qEpl0JHDVqrao6
         wMubWO0xXEZ+pBFQJbStPgXTZIkTDARsUGzV9DKVkghxM5mUXgLOq6pKkkpGM0u7p3f5
         m3ifezhW7BNlC0EmfcExtcvJDamkQHNrrzOe2/qbLfEBVeXloM9iRkIZ0pSvnFlrDRsp
         flWg==
X-Gm-Message-State: AElRT7EDUriKrtxMLE8yHQOBFXOAZAdTyhoETKmU0+2BsWogTV00SCh+
        Pri108P1MmYFejkUqLLbU1fx7FyZVAY5y2tqw/k=
X-Google-Smtp-Source: AG47ELsrBfuqPZgiMUKIfKNdsHvRx6BCTIAK9JENbKi4WMKLo+y/xP5q/ljGKEuTMHYBTqIAXWNUZAblcgOnXZuSYDw=
X-Received: by 10.36.33.17 with SMTP id e17mr3083193ita.44.1519918235447; Thu,
 01 Mar 2018 07:30:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.144 with HTTP; Thu, 1 Mar 2018 07:30:33 -0800 (PST)
In-Reply-To: <20180301150835.GD24907@sigill.intra.peff.net>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net> <000501d3b0a4$29162a80$7b427f80$@nexbridge.com>
 <CANgJU+VYkmUhJT=CHQ4HTqoV4gWhr9P4-65BfrY-RWgwJJhEUA@mail.gmail.com>
 <20180301073629.GC31079@sigill.intra.peff.net> <001d01d3b169$95f4b0c0$c1de1240$@nexbridge.com>
 <20180301150835.GD24907@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 1 Mar 2018 16:30:33 +0100
Message-ID: <CANgJU+W+K5O=NQv_UA9GPFFB=KQd1W2jExPd4kqC=SKBULVHhg@mail.gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Git <git@vger.kernel.org>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1 March 2018 at 16:08, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 01, 2018 at 09:28:31AM -0500, Randall S. Becker wrote:
>
>> > It's not clear to me though if we just want to tweak the programs run in the
>> > test scripts in order to get test_must_fail to stop complaining, or if we
>> > consider the unusual exit codes from our perl-based Git programs to be an
>> > error that should be fixed for real use, too.
>>
>> I'm living unusual exit code IRL all the time. So "fixed for real", is
>> what I'm looking for. So if we were to do that, where is the best
>> place to insert a fix - my original question - that would be permanent
>> in the main git test code. Or perhaps this needs to be in the main
>> code itself.
>
> If it's fixed in the real world, then it needs to be in the main code
> itself. It looks like git-svn already does this to some degree itself
> (most of the work happens in an eval, and it calls the "fatal" function
> if that throws an exception via 'die').
>
> So I think git-send-email.perl (and maybe others) needs to learn the
> same trick (by pushing the main bits of the script into an eval). Or it
> needs to include the SIG{__DIE__} trickery at the beginning of the
> script.
>
> I think the SIG{__DIE__} stuff could go into Git/PredictableDie.pm or
> something, and then any scripts that need it could just "use
> Git::PredictableDie".
>
> Does that make sense?

To me yes. By putting it in a module and 'use'ing it early you
guarantee it will be set up before any code following it is even
compiled.

If there is an existing module that the git perl code always uses then
it could go in there in a BEGIN{} block instead of adding the new
module.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
