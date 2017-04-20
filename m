Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2C11FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 16:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033463AbdDTQnD (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 12:43:03 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:34555 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033350AbdDTQnC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 12:43:02 -0400
Received: by mail-ua0-f177.google.com with SMTP id h2so57579852uaa.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oURIA0ZOmo05K/xS4XAPzm4CttkLVsIJgEPx6a9hVsE=;
        b=fVyco5oiy0XIXNpU3pq7BhQHnJf0GoNyI3Le6X3jaxLqBVIjkksfOnPdJL6gUsnAun
         iuqP1VX+eTjO8rE/srtU6+3bM00uZM0mVscgZFYyuEA55ktUPRR70UV4Xyi5afsJUjDo
         bgwMGclmVo5MjgZ37R49U0/PaCXlUZctwmX4Ct4cRpjobRkm+o7hnYZRDb6dSwkGR8XP
         lrSm1V/eSG0g3+rr+vIURlFL3mYr4xj84HL//4Kgc31PIe6XzV2gL/50FV5gL6GO4k9b
         4KsSaTSwsLR0MzKODcvRILmxxaKX800wgkl/jU5SQTer7wJ2mGO4IhAq61MHfrZdrqnG
         eGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oURIA0ZOmo05K/xS4XAPzm4CttkLVsIJgEPx6a9hVsE=;
        b=NbdfgFuDdajf4CKIZVIWtunGAmVWlg7+SeR/WL9wWNeIwDeoA6jt6wSTcEy0ROKGSU
         hq/uiRjmeWn+gGapY7U3SFR9jLBQy1mq6QwR+kW4MxLM/2s/81XVDZGppmItOdRPJOzR
         vmhARB3YJgAzOfaY9GWJ1njecxD7Keci5nOk64xYRbUTEcYfu3wiEDFDwE0nOrxrDpL5
         UJ/Bhhhb/fi0DkZUoTJs4/RLpVc+zqEdxz6hUdioCvK+T1S8MScrndjD3DfKdSFfBHZz
         qUtcQ+FYBQ4Xc0kRHvhfJK5ddUqtFAzbHZCNJmQNtkvq0wul594tg5+grtnWU5v5uzhY
         3hwg==
X-Gm-Message-State: AN3rC/4lan/E/R/HASVgScY1PZBcFckNeuIgvvb0IBYSDf7b1Ry7AoxR
        ylsKxJw0kP1GqMHeJAjRIHi+I6fprQ==
X-Received: by 10.31.110.194 with SMTP id j185mr3619898vkc.0.1492706580183;
 Thu, 20 Apr 2017 09:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Thu, 20 Apr 2017 09:42:59 -0700 (PDT)
In-Reply-To: <20170414200829.ahqignx3pkhbuepg@sigill.intra.peff.net>
References: <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
 <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net> <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
 <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net> <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
 <20170413175701.5ogpe7qbflbkgljm@sigill.intra.peff.net> <CAM0VKjmK0ib+sjf0sMPeiK7DrwHq1dJ58ZhDdp6HZsuQdb-eRw@mail.gmail.com>
 <20170413191236.3usecfgkjujhblo6@sigill.intra.peff.net> <CAM0VKjkVUPPsvpAu1WXeNg7sv1_V=Uxhhevf9fVkZvk9WERwwQ@mail.gmail.com>
 <20170414200829.ahqignx3pkhbuepg@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 20 Apr 2017 18:42:59 +0200
Message-ID: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test script
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 10:08 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 13, 2017 at 09:35:08PM +0200, SZEDER G=C3=A1bor wrote:
>
>> >> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> >> index 13b569682..d7fa15a69 100644
>> >> --- a/t/test-lib.sh
>> >> +++ b/t/test-lib.sh
>> >> @@ -763,7 +763,7 @@ test_done () {
>> >>
>> >>                 test -d "$remove_trash" &&
>>
>> I'm not sure under what circumstances the trash dir could be missing at
>> this point...
>
> Yeah, I don't really see the point of that line. Our whole goal is to
> remove it anyway.

It turns out it's necessary, see below.

>> >>                 cd "$(dirname "$remove_trash")" &&
>> >> -               rm -rf "$(basename "$remove_trash")"
>> >> +               rm -rf "$(basename "$remove_trash")" || exit 1
>>
>> ... but when it is already removed, then I think we should not exit
>> with error here.
>> Nothing that a pair of {} wouldn't handle.
>
> I suppose so. It might be worth being picky just on the principle that
> if it _is_ gone that's unexpected and we'd prefer somebody notice and
> figure out why.

OK, agreed.

However, we do need the above 'test -d' for this to work, because 'rm
-rf' doesn't consider non-existing paths as errors, so we wouldn't
notice that the trash directory is already gone.

>> > Replacing it the "exit 1" with a "die" that has a message is probably =
a
>> > good idea, though.

test-lib.sh has a special 'die', different from git-sh-setup.sh's
'die'.  I'll use 'error "uh-oh"' instead.

>> If we can't 'cd' or 'rm -rf', then they will tell us why they failed
>> anyway, most likely including the name of the trash directory.
>> Do we really need more error messages than that?
>
> I just meant something like "tests passed but test cleanup failed;
> aborting" so that the user has a better idea what is going on. But since
> it shouldn't happen, maybe that doesn't matter.

And we do need an error message, because 'test -d' would remain silent
when the directory were already missing.
