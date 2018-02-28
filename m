Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2271FAE3
	for <e@80x24.org>; Wed, 28 Feb 2018 16:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeB1QqZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 11:46:25 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:52989 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbeB1QqX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 11:46:23 -0500
Received: by mail-it0-f48.google.com with SMTP id k135so4213686ite.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9h3TBOqPMQohH0qKgQBVFriCIV/ZUxMVkVtDsidi7M4=;
        b=o2NzhZyBEkgnh/poC2shIvWPW8Aet2Bp8TVYypPHuUZYxHHkrBoWUT0zi4F5Q4MVBD
         Yuq6MeQzc6lAWeR42wiOjZvaLD4QewmgA0aRol1s1/gH/iMkthqmg1uzuIFq5THpP+ZR
         hQvH+e6gXn2ay5FO23RN8XzWLfMjoC+uCIhq9clnqw+OePdUhBCQIWvregwa/1yVWL+m
         Zh99ulwRNoEp8LTelFBH8mvXP8GkatQSZMDJ8iIvzAxJUfr4NOGu6UpSbiOJblHG7DDB
         oYVhZAPEBBRDVkiPTHEBBp72iKKhPy5UDLZQrW1YwBU7dotlsxIVoKepT1RCs/DAuAk4
         zREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9h3TBOqPMQohH0qKgQBVFriCIV/ZUxMVkVtDsidi7M4=;
        b=opnozRJqtBmfaBg1MN7ZPQauh4ciuqK66QGNTFObHG02pWMECA1Z5uVTGNr79hYHig
         bRMkG7oZaeJAmlyGZVwJd01zl2zUdxtmopc9iX1Cmbq/LHNxF6gw7t92ufRl2wiVl8G0
         Mk/9Ey4XhEt7UhsJ7UhFyyB3ogDnbqrTbm+dbW7OC8MRsvounSOKD5mIp8dNXgRD/go7
         OK3VZP2GyQ5c+rDUEGKjW459zsLS0p29Usn9yIXxwBJgDSGWQJZtoUVelCgS8KyxhlIL
         t2O7QLnj1dWhGkcHWURXouxxlzWcPKdk+snJnI7+FLfBhM13znbQUZvFNN6EEeaN/ZIo
         txPg==
X-Gm-Message-State: APf1xPA9KgjiYMPwOfUCFohtDC10FDmnDuoq1B/tz6J/PBqMxzqHzALx
        gpxX4CqwSml9MSBgUQwcEIsrG61geeoHsJoFpbw=
X-Google-Smtp-Source: AH8x224ZrhVVeQ1m2lJTXPVJuA7nyz+36KzxAPDO1f2TPUeK8otgLpasQPhVgd2HrffLGN7tvdnyitM940qUIIpkzhQ=
X-Received: by 10.36.112.196 with SMTP id f187mr21042324itc.122.1519836383186;
 Wed, 28 Feb 2018 08:46:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.144 with HTTP; Wed, 28 Feb 2018 08:46:22 -0800 (PST)
In-Reply-To: <20180228074918.GA32127@sigill.intra.peff.net>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr> <20180228074918.GA32127@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 28 Feb 2018 17:46:22 +0100
Message-ID: <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git <git@vger.kernel.org>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 February 2018 at 08:49, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 28, 2018 at 07:42:51AM +0000, Eric Wong wrote:
>
>> > > >  a) We could override the meaning of die() in Git.pm.  This feels
>> > > >     ugly but if it works, it would be a very small patch.
>> > >
>> > > Unlikely to work since I think we use eval {} to trap exceptions
>> > > from die.
>> > >
>> > > >  b) We could forbid use of die() and use some git_die() instead (but
>> > > >     with a better name) for our own error handling.
>> > >
>> > > Call sites may be dual-use: "die" can either be caught by an
>> > > eval or used to show an error message to the user.
>>
>> <snip>
>>
>> > > >  d) We could wrap each command in an eval {...} block to convert the
>> > > >     result from die() to exit 128.
>> > >
>> > > I prefer option d)
>> >
>> > FWIW, I agree with all of that. You can do (d) without an enclosing eval
>> > block by just hooking the __DIE__ handler, like:
>> >
>> > $SIG{__DIE__} = sub {
>> >   print STDERR "fatal: @_\n";
>> >   exit 128;
>> > };
>>
>> Looks like it has the same problems I pointed out with a) and b).
>
> You're right. I cut down my example too much and dropped the necessary
> eval magic. Try this:
>
> -- >8 --
> SIG{__DIE__} = sub {
>   CORE::die @_ if $^S || !defined($^S);
>   print STDERR "fatal: @_";
>   exit 128;
> };

FWIW, this doesn't need to use CORE::die like that unless you have
code that overrides die() or CORE::GLOBAL::die, which would be pretty
unusual.

die() within $SIG{__DIE__} is special cased not to trigger $SIG{__DIE__} again.

Of course it doesn't hurt, but it might make a perl hacker do a double
take why you are doing it. Maybe add a comment like

# using CORE::die to armor against overridden die()

cheers,
Yves
