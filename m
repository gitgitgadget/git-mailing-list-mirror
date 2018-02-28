Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 649D81F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933553AbeB1RUR (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:20:17 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:42506 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933405AbeB1RUN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:20:13 -0500
Received: by mail-io0-f177.google.com with SMTP id u84so4010315iod.9
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fj2AFdSCO2wItYNPpMK1qMJzAqT1JxRSU7sekGU0pn8=;
        b=VU/JIArNskUMa1tEGbi5gajJzYW4UCanPzzDjONmD6f+/DUvJPyo4UzwAJtlmZOJsL
         jYzur7KxDk2Te7yVKNaGavCANyf+iGTDaifsBHUeHBPEy+3GM+UfcDEa9QExZUhgFCA1
         m7TdzDx7Gk0Z8HLo/sexvMqKL0LzLWrv6ZQmG6RyOS1ann5ugEmdlSW/JI+fMcKVprf8
         fJcc9pVyTxXCp1QQ8BOi3YfQ0sZ2nao7WAp0OCvpA4dAMQoWUyday3gCUa3n7Vf1rmPQ
         sMHMJKOSLksJ2I4WZifIAgN59zAt2ydGUBvFp6i4xd0MOhoclJ2uoPLLhtWCtpmAv8AN
         +NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fj2AFdSCO2wItYNPpMK1qMJzAqT1JxRSU7sekGU0pn8=;
        b=t9GGtMFw3cOr9cyoTcjelfp7w9koDtoQkRTSfPuADWKLq/gCt8em6Y30GEg5GSxEKL
         DUy1jq76fXPgX1awkGKjNg3sw0TDRv+5Mor3j3sGMbfL4RumiC4d1s1sY27Obd2HA4ov
         TFKAmffvokcBpK1yAktM5QlagYXuKCyQBG71aAshpdu9Bp9S0uXhKzaJYp5FKLHLz9o3
         PZwEwPBsrEMWHDP6ZlM9pBt4Gft1kiodoIKUZBpp8x6LotCVCe4DjGD6GhlAByC8JVDR
         pMQjZHHrjEOeL78mGLGu84REuVUky+90UKEcFHp/aPWuFK/0vhMxhRRDItvsqK6bTmXw
         GGAg==
X-Gm-Message-State: APf1xPAAiY+VinBNs63++53p9GK+S/GsDG71hrp3mFi0o97t30eS37j+
        86CopK6r9XQnixvDh9AJd+CJPI3CsOd226Nvz4k=
X-Google-Smtp-Source: AG47ELvQlvo3gfR0qpXww/vLgIqmpBT7fE61uUiSAuzuqKdWPYDmOfQkrvVxYDRoaf2tXE5S2gvI1P8bEIpMZd2t4ac=
X-Received: by 10.107.31.133 with SMTP id f127mr10280188iof.234.1519838413287;
 Wed, 28 Feb 2018 09:20:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.137.144 with HTTP; Wed, 28 Feb 2018 09:20:12 -0800 (PST)
In-Reply-To: <CANgJU+WFKqou=ZXcdr8V_ST=opHSBm9ksEVowxRB7o7DDEmuvg@mail.gmail.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com> <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net> <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net> <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com>
 <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com> <CANgJU+WFKqou=ZXcdr8V_ST=opHSBm9ksEVowxRB7o7DDEmuvg@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 28 Feb 2018 18:20:12 +0100
Message-ID: <CANgJU+U+3Lfj0w+8i-un_PO5xrnoaXvs4=BONM9BTDk2SC98vQ@mail.gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git <git@vger.kernel.org>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 February 2018 at 18:19, demerphq <demerphq@gmail.com> wrote:
> On 28 February 2018 at 18:10, Randall S. Becker <rsbecker@nexbridge.com> =
wrote:
>> On February 28, 2018 11:46 AM, demerphq wrote:
>>> On 28 February 2018 at 08:49, Jeff King <peff@peff.net> wrote:
>>> > On Wed, Feb 28, 2018 at 07:42:51AM +0000, Eric Wong wrote:
>>> >
>>> >> > > >  a) We could override the meaning of die() in Git.pm.  This fe=
els
>>> >> > > >     ugly but if it works, it would be a very small patch.
>>> >> > >
>>> >> > > Unlikely to work since I think we use eval {} to trap exceptions
>>> >> > > from die.
>>> >> > >
>>> >> > > >  b) We could forbid use of die() and use some git_die() instea=
d (but
>>> >> > > >     with a better name) for our own error handling.
>>> >> > >
>>> >> > > Call sites may be dual-use: "die" can either be caught by an eva=
l
>>> >> > > or used to show an error message to the user.
>>> >>
>>> >> <snip>
>>> >>
>>> >> > > >  d) We could wrap each command in an eval {...} block to conve=
rt the
>>> >> > > >     result from die() to exit 128.
>>> >> > >
>>> >> > > I prefer option d)
>>> >> >
>>> >> > FWIW, I agree with all of that. You can do (d) without an enclosin=
g
>>> >> > eval block by just hooking the __DIE__ handler, like:
>>> >> >
>>> >> > $SIG{__DIE__} =3D sub {
>>> >> >   print STDERR "fatal: @_\n";
>>> >> >   exit 128;
>>> >> > };
>>> >>
>>> >> Looks like it has the same problems I pointed out with a) and b).
>>> >
>>> > You're right. I cut down my example too much and dropped the necessar=
y
>>> > eval magic. Try this:
>>> >
>>> > -- >8 --
>>> > SIG{__DIE__} =3D sub {
>>> >   CORE::die @_ if $^S || !defined($^S);
>>> >   print STDERR "fatal: @_";
>>> >   exit 128;
>>> > };
>>>
>>> FWIW, this doesn't need to use CORE::die like that unless you have code=
 that
>>> overrides die() or CORE::GLOBAL::die, which would be pretty unusual.
>>>
>>> die() within $SIG{__DIE__} is special cased not to trigger $SIG{__DIE__=
}
>>> again.
>>>
>>> Of course it doesn't hurt, but it might make a perl hacker do a double =
take
>>> why you are doing it. Maybe add a comment like
>>>
>>> # using CORE::die to armor against overridden die()
>>
>> The problem is actually in git code in its test suite that uses perl inl=
ine, not in my test code itself. The difficulty I'm having is placing this =
appropriate so that the signal handler gets used throughout the test suite =
including in the perl -e invocations. This is more a lack of my own underst=
anding of plumbing of git test framework rather than of using or coding per=
l.
>
> Did you reply to the wrong mail?
>
> Create a file like:
>
> .../Git/DieTrap.pm
>
> which would look like  this:
>
> package Git::DieTrap;
> use strict;
> use warnings;
>
> SIG{__DIE__} =3D sub {

OOPs, that should read

$SIG{__DIE__} =3D sub {

sorry about that.

>    CORE::die @_ if $^S || !defined($^S);
>    print STDERR "fatal: @_";
>    exit 128;
> };
>
> 1;
> __END__
>
> and then you would do:
>
> export PERL5OPT=3D-MGit::DieTrap
>
> before executing any tests. ANY use of perl from that point on will
> behave as though it has:
>
> use Git::DieTrap;
>
> at the top of the script, be it a -e, or any other way that Perl code
> is executed.
>
> cheers,
> Yves
>
> --
> perl -Mre=3Ddebug -e "/just|another|perl|hacker/"



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
