Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22532095B
	for <e@80x24.org>; Sat, 18 Mar 2017 16:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdCRQKV (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 12:10:21 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35798 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdCRQKU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 12:10:20 -0400
Received: by mail-ua0-f196.google.com with SMTP id u30so7730875uau.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aRTM2huEBn2IUkA30uZTRceUuoWS8E9KbfnlQILeWHM=;
        b=FFb6MV089q6qtW/jt4S98dJoyuLqhFgDQM+soozMuygxUB1fmZtovZvrRpQzwRPuwP
         v6hSegjavCaMv7JxsUCfB/KqqizVvPB7Qi5rwOJJmMN5U4vY3stiX/XzFSA4cBEyCiiR
         qPq9OM/BpwxVk7YbKnpeASNYoxWvCiI7ebR502E0WEa33jpUcRvcTbdI6aCA/Xmr3U9a
         bSP2z7F5/01EmtoEZOtgerAo6KIw6mm0wi/DL15r/I20ydItW76prg4AyIzvfaJOmiuM
         YpCcaQv3LzS2WpSIqMzni0D9YGj3qf9KgY8djXuT0jA5kaALdHlC2/CiEks7l3ofzzG5
         Wfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aRTM2huEBn2IUkA30uZTRceUuoWS8E9KbfnlQILeWHM=;
        b=mPu2gvV8DFC3lk80scEJRvsu10xpb2xU9WnB9uvU2RQ+NwWdAXpzArZW/O5vgEGwug
         m7BSNbXwz8WZQtuLEIkK9uFmEhnmapFGeuVL+FK8sc/L7HlgsWSvedw57w/WR+857aGg
         5OW6p6ar1wRWZuHm7ngEavkSp3msyVsRHAyL8oryhJhMUResCLHUaQqpSydtnyCYDCbD
         bx06FBzLx+KXmZm81h/jd/Gegrt6Qc0vLBx8SVR+dWliWL9RGAQCD2H0HN/CJOw8IzHR
         wCZWqsGkBYh7raslmP2waheICxy1HICFp05olkbaB9c9Gev0bJVZoxaIDx530GHRfA/M
         iiAw==
X-Gm-Message-State: AFeK/H2SzrEh1beoaxtioJf6+/cwbotFnO7J1WnkV59WuA3V5Pov+x3nZ2RRf8i6HN22G1uqrMaHrF/NzmmiSw==
X-Received: by 10.159.32.79 with SMTP id 73mr3594371uam.121.1489853418782;
 Sat, 18 Mar 2017 09:10:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.7.150 with HTTP; Sat, 18 Mar 2017 09:10:18 -0700 (PDT)
In-Reply-To: <20170317145504.utysxd4qqaqetm7t@sigill.intra.peff.net>
References: <20170317144646.9349-1-szeder.dev@gmail.com> <20170317145504.utysxd4qqaqetm7t@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 18 Mar 2017 17:10:18 +0100
Message-ID: <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com>
Subject: Re: [PATCH] tests: create an interactive gdb session with the 'debug' helper
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 3:55 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 17, 2017 at 03:46:46PM +0100, SZEDER G=C3=A1bor wrote:
>
>> The 'debug' test helper is supposed to facilitate debugging by running
>> a command of the test suite under gdb.  Unfortunately, its usefulness
>> is severely limited, because that gdb session is not interactive,
>> since the test's, and thus gdb's standard input is attached to
>> /dev/null (for a good reason, see 781f76b15 (test-lib: redirect stdin
>> of tests, 2011-12-15)).
>>
>> Re-attach the original standard input in the debug helper, thus
>> creating an interactive gdb session, which is much much more useful.
>
> Yeah, I think I've had to do a similar hack manually. This is an obvious
> improvement. Though...
>
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index bd357704c..9567dc986 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -154,7 +154,7 @@ test_pause () {
>>  #
>>  # Example: "debug git checkout master".
>>  debug () {
>> -      GIT_TEST_GDB=3D1 "$@"
>> +      GIT_TEST_GDB=3D1 "$@" <&6
>>  }
>
> Your stderr and stdout may be redirected, too. That's usually not a big
> problem because you'll be using "-v",

Yeah, I didn't consider using this helper in non-verbose mode at all,
and the resulting behaviour is not quite pleasant, indeed: gdb starts
in interactive mode, but as its stdout goes straight to /dev/null the
user has no idea, and gdb does not quit on Ctrl-C.  A possible
solution would be to forbid using the 'debug' helper without '-v',
like in the 'test_pause' helper just above.

However...

> but perhaps this should add:
>
>   >&3 2>&4
>
> to be on the safe side. That covers running without "-v", as well as
> cases where the test script is redirecting output

That wouldn't buy us much.  First, file descriptors 3 and 4 are the
test's stdout and stderr, i.e. any process started within the test
would be connected to those fds anyway without those explicit
redirections.  Second, fds 3 and 4 are redirected to /dev/null in
non-verbose mode, so it would still not work without '-v'.

Perhaps you meant '>&5 2>&7' here (and in the bash example in the
commit message of 781f76b15 (test-lib: redirect stdin of tests,
2011-12-15), for that matter)?  Those redirections do in fact make
'debug' work even without '-v'.  Furthermore, those redirections do
make 'test_pause' work without '-v', too.

So this is what v2 will do, then.

G=C3=A1bor
