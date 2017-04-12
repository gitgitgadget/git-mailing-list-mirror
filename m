Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEA291FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 22:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbdDLWDX (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 18:03:23 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35542 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdDLWDV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 18:03:21 -0400
Received: by mail-ua0-f194.google.com with SMTP id g30so2815250uab.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tqfEhBvdvKM/GraGEpNSgjNf/vsDRreJgQdXXrkOWqk=;
        b=iZyEBWTgTi730HPcuCmftAkzWoao+nectxjOQGjLf9eeab7aAi24rCLaiRhtj5NEQC
         LbPTKHEswBztMRGWF7rcNoYgbujDbWTNAirtlAghuF8UOkv8rWsjf2ume6ZOSC1ZRdgI
         3klYbNy0IYzR+dbNwYdsdPgSsJvZr9W0elsy0jxdCmlB3kPzM0s2LJGpykb/CYAVMNLH
         JNnari7BhajZGn+TNl9yBmf89KTTAS4Wu5TSqZWdB2anFhMoL9fZGE+x+Gd6U4sQdTAw
         JJJMqPk7suXwtVOdGZjV+r58tfpqOs5kaWTQjW0x4ujQI309TuO1Ur3qlkuABsXEy4qM
         vQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tqfEhBvdvKM/GraGEpNSgjNf/vsDRreJgQdXXrkOWqk=;
        b=efHlUs4anjlF+1HZZ2eerG4LbOO2bXT0IIFkMDht42gyc4DDF35X+r5VfFqUTckJy9
         YC04xulnocJ6XX/5aKi+InyFS2o4HU6U6pIl/30otl4LIREi+fkgs2yb9tqjFbdfjvk8
         hbm7Y8SX7Iw0jeV31R8HwcfSigWvJyGrokV/mb2OyF7ACfUjyIC19waxcyuytNg0v/j4
         raLZM6sUHG0BfxtPRSMK/EVvV8yq4ugJw0lJa8uvlJGbXGgiG/NTMGvBU/1bTuGuFHNC
         +rfFa/FzoV/wSUqqHZWsFmEuI8z1EcW+KUnTzrTngWqhRiDpgSuNY9oZQpK6vF5VPn4l
         uEyA==
X-Gm-Message-State: AN3rC/46Qm/f43DvZcVH0v6ma/lGwvSHTkHMRDTZwZFspNonhVxxJsbEv4C2prOU5/lT6XuuWUe4C4Rjg6X/CA==
X-Received: by 10.176.82.238 with SMTP id w43mr2733498uaw.171.1492034600419;
 Wed, 12 Apr 2017 15:03:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Wed, 12 Apr 2017 15:03:20 -0700 (PDT)
In-Reply-To: <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net>
References: <20170410125911.6800-1-szeder.dev@gmail.com> <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
 <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
 <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net> <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net> <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com> <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 13 Apr 2017 00:03:20 +0200
Message-ID: <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test script
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 2:50 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 12, 2017 at 02:27:05AM +0200, SZEDER G=C3=A1bor wrote:
>
>> >> I wonder if you could make it a general test-lib function, like:
>> >>
>> >>   run_and_wait () {
>> >>         # we read stdout from the child only for the side effect
>> >>         # of waiting until all child sub-processes exit, closing thei=
r
>> >>         # fd 9.
>> >>         does_not_matter=3D$("$@" 9>&1)
>> >
>> >
>> > I'm afraid this won't work on Windows when the invoked command is git.=
 FD
>> > inheritance between MSYS (bash) and non-MSYS programs (git) is only
>> > implemented for FDs 0,1,2. That's a deficiency of MSYS, and I don't th=
ink
>> > that was improved in MSYS2.
>>
>> Oh, that's a pity, I was almost ready with v2...
>>
>> Unfortunately, this makes the general helper function unworkable, of
>> course.  Though in this particular case it wouldn't matter, because on
>> Windows daemonize() is basically a noop and 'git gc --auto' remains in
>> the foreground anyway.
>
> That makes it tempting to use in this scenario as a one-off with a
> comment.

Ok, I'll send it out in a minute, and Junio can then take his pick.

>> I think we should stick with my initial patch, then.
>
> I'm not entirely opposed, but my understanding was that it didn't
> actually fix the race, it just made it a bit bigger. Which is sort of
> unsatisfying.
>
> I couldn't get the original to show a failure, though, even under heavy
> load. So maybe widening the race is enough.

Just to be clear: it's only an occasionally appearing error message.
There is no failure in the sense of test failure, because 'rm -rf
$trash' erroring out during housekeeping does not fail the test suite.
