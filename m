Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF80207B3
	for <e@80x24.org>; Thu,  4 May 2017 10:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdEDKZG (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 06:25:06 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:32975 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdEDKZE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 06:25:04 -0400
Received: by mail-io0-f171.google.com with SMTP id p24so16726113ioi.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tGvnRBit88354V+NkwyMqufLCpbrmKWXFnnXO+gOT0k=;
        b=Egl+kKpdH36fPkk9RSl683rppFj4roAymowUU+ysuvo8K1Nohs2YqwB8E0h6NH51CE
         J87HrnHEKk4vlx7i0qk5ga7NZXq7bU4xa7MPtSPbWAZx11HtV5ILcj+FBMf0waTlT4mk
         TCyK8Xhb/UF8KtX4yD9OmmfrZcKXOuIxsGbbOyKEBLAVw5wKrYJOPMRWQkbH6HbFWBP3
         yj3KX39jz+Kmck39JN1VfISD+8AC0R7iphmrkDInOl605cRO8PiM8bKYyadTrPzvaT95
         mH268jmzDJ6DJ1eH/jjW83cKGlZEzmksWsDRKp48sbYtEZzvfPUIA1tQdkd/olzcMYRf
         jMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tGvnRBit88354V+NkwyMqufLCpbrmKWXFnnXO+gOT0k=;
        b=bej7j1uLAX0a5bnxoR7EVcDB+czM2zghhWRbXexaEryPfQBjx10TAXplN8OxvbNlx8
         1i2hnVnwKq4pJye8QXL08660taCYXPNOF0Erzy9WGoLxu/3scU30nBl5wTahKLd7ama+
         h+lg/w5L9DIv4m3sCr/Km/kfnQicAuZwNa2SQI0qjLbpKJ1DKYCV6EDamkpchH2jDT7v
         mEUcXhk8Aa193O7OeYcWjP3zoMkMfV77k0ZTewMv1FpPbw/NbQX9DqoWdsJubdtHHr9U
         0xTmam6dsDDmQhsDQ6vURZndO1y/xvKSBO8O3Yh1a87RjaW/2fs7814B+tqJ3BZU6Y1N
         ngCQ==
X-Gm-Message-State: AN3rC/4lF8Rhc+q5KtkfQRQ71HwsYwKcNBGTTOMX/PNkg+ftdrVFA91M
        JgL51S6uzkHeE/9mSUSRxgGIG9/vXQ==
X-Received: by 10.107.138.9 with SMTP id m9mr37657782iod.80.1493893503149;
 Thu, 04 May 2017 03:25:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 4 May 2017 03:24:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705041104070.4905@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox> <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 4 May 2017 12:24:42 +0200
Message-ID: <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 11:11 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Wed, 3 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> [Just replying to you & Duy in the same mail, easier]
>
> It makes it harder on everybody else, though, as two slightly different
> discussion points are conflated now. Also, no single online mail archive
> will be able to render the thread correctly (assuming that you edited in
> the In-Reply-To header to loop back to Duy's mail).
>
>> On Wed, May 3, 2017 at 11:45 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > At this point, I feel that someone should recall into our collective
>> > memory what happened when we made a change similar in nature that
>> > broke existing build setups: by requiring REG_STARTEND all of a sudden
>> > ("you can easily flip the NO_REGEX switch", as if everybody should
>> > know about those Makefile flags we have).
>>
>> And as a result grep/log -G got faster by default,
>
> Sure. For those developers where the build was not broken.
>
> Software maintenance is always a trade-off, and with software as popular
> as Git, maintainers bear a special responsibility to *not* break builds
> easily, as it is more likely than not that anybody who wants to build Git
> is *unfamiliar* with the specifics.
>
> That is the main reason why we have a configure, even if we try hard to
> make things work with a straight `make`: people who are happily oblivious
> of our discussions on this here high-volume mailing list will be able to
> build Git without even consulting the documentation, just by doing what
> they would do with any Unix-based software: ./configure && make

And they still will. That sort of invocation will not build with
PCRE[1]. This change to v2 by default only impacts builders who are
already going out of their way to customize their build with
USE_LIBPCRE=3DYesPlease.

I don't think your comments make sense in that context. We're not even
talking about the advanced user/newbie developer who wants to build
git for the first time, we're talking about the user who's already
involved enough to start scouring the Makefile & tweaking the various
flags there.

Changing the current advice from "if you want PCRE enable this" to "if
you want PCRE enable this, we use v2 then, turn this other thing on if
you want v1" is a *very* small imposition on people already deeply
customizing their build to the extent of turning on the non-default
PCRE in the first place.

Yes that's a trade-off, and I'm not denying that some advanced users
will notice / be annoyed by that change. I just think the end-user
benefit of bringing v2 to the attention of distributors who are doing
such customized builds outweighs that.

>> and more importantly since v2.10.1 which includes your 2f8952250a and
>> made a REG_STARTEND engine a hard requirement nobody using git is
>> mysteriously going to miss grep results because of some stray \0 in the
>> string being matched.
>
> That is a misinterpretation of what the REG_STARTEND flag is supposed to
> do. In *some* implementations, REG_STARTEND allows NULs in the haystack.
> Some other implementations do not allow that. It is ill-defined.

We have a test in t7008-grep-binary.sh that'll fail if REG_STARTEND
doesn't behave as I described. Actually I think I got the history a
bit wrong here, I marked that test as succeeding in commit 7e36de5859
("t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND",
2010-08-17).

So I think since 2010 either distributors without REG_STARTEND have
been enabling NO_REGEX=3DYesPlease giving users the right behavior with
a \0 in their haystack, or their tests have been consistently failing
for 7 years, hopefully the former is the case.

>> I agree that I should drop the patch to make v2 the default from this
>> series for now. Clearly it's controversial, and can be considered on
>> its own merits once the supporting code is in. I'll do that in the
>> next submission, which I'm planning to send after v2.13.0 comes out.
>
> Good. I am really glad that we agree that the move to v2 should be a
> two-step process, with the uncontroversial "optionally use PCRE v2 for
> speed and robustness" first.
>
> Once enough users like it (and speaking for myself, once I heard from
> enough users how good it is so that I can justify to set aside enough tim=
e
> to support PCRE v2 in MSYS2), you will find it much smoother sailing to g=
o
> to phase 2.

The v2 API is not a user-visible change. It'll help performance, and
over the long term subject users to fewer internal PCRE bugs in v1
that'll never get fixed.

That's pretty much a textbook example of the sort of thing users will
never even notice, but which is a good thing to do anyway, users don't
notice most of the incremental performance improvements made to git,
but they matter to them in the aggregate.

So I think if your criteria for working on integrating v2 is users
noticing it elsewhere and asking you for it you'll likely never switch
to it. I think that's a bit unfortunate & a strange way to evaluate
whether you should turn on incremental performance improvements, but
whatever, your build & your users.

Regardless of that, I think it's a different question whether most
other distributors of git feel the same way. I'd hope that most of
them would be happy to take a performance/reliability improvement like
that, most of them likely have v2 packaged already so it would be
trivial for them, and if not they'd either be happy to package it up
for such an improvement, or alternatively change USE_LIBPCRE=3DY to
USE_LIBPCRE1=3DY.

1.  Which I think is a bug as noted upthread in
<CACBZZX5_45KnU7qzW2ojJiznmfkef44YGL8-CYkHFLOvhLSASg@mail.gmail.com>,
but this behavior is what users use/rely on now.
