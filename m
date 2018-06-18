Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498881F403
	for <e@80x24.org>; Mon, 18 Jun 2018 16:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755308AbeFRQJi (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 12:09:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38424 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755249AbeFRQJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 12:09:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so16635607wmf.3
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xfkUsZ1P3JJ/lTaTD2ab7fZWhbXsYRTLEjj9gnUgzMg=;
        b=rNdoi2JMxkA5LN+a5hEf8ykZCdYFeay5MKGQhaxYKgSvpanZvRhuQfjVHjQ3F0MT96
         8Ud2rUu+Rpx3IQl457xnyUr4hpaPEyRgB7Pe2f4Lu3j5yeWOaIZGg2EbYw+fP4OB3tWa
         RUwfuLuFV6cERZuBySprC7riZK8K/h+25AyX1H1CWnHfPb/bWmtT7d0nzlt6FuGFLuGE
         RKdEdPFYdEFaSXd6Q4GopU/1Ve2xjXYbyyfrdWOfdu9JNoJXzi/9vDThd8HWD49fMeLO
         EFoIQSmvYUBrD9hr0tFAKysenLR7vgOp3pfRjGL/7qtHJ867NO6GOLmNZWKbaeC23Z0d
         epkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xfkUsZ1P3JJ/lTaTD2ab7fZWhbXsYRTLEjj9gnUgzMg=;
        b=TGtXzZzG/+7EEkq/UHEGaZ5PVP9E5cp6aVN4sALQJ7p7njgs8LOF75LottufnKokFz
         Ez6G+TIA9Wx0BEVqbjfH57pn9q1XDnTeAxLynDjethLNf2pazJDhxE3tAP5RQohs59JD
         tGHDAWaHCDPNxJ8rd85ZY9/nyePzK4oONU0P6BQ1m0HavASJJYP5/FdUPpTsQjdfmYLx
         CU4beKF2B/GkwX0rmIZBt3KT7/ESMoiw0+otSXxlfvTdv23S9G+BjECVG9FvG6SmoKpi
         cvIU+R4Ii6xkWzksM3WKFDEfToTa/+7u2EtEdlo24Fb3jEuTYv5m5kRDXsbkzAHL0DLQ
         Efyw==
X-Gm-Message-State: APt69E371+J1EZbTvmT7I8UoR95ir/6LpTJL7mxAur2vuWub0uIcf4s4
        8sIWCTwUdP+FtWhiLdTAHjuL+59O
X-Google-Smtp-Source: ADUXVKKm3oghvjJ54/Lj+IwDILWjjlsP0KIhXHCZQo96hOkBshmJ1tcoDq+20QLA+O/deyeZG6fwig==
X-Received: by 2002:a1c:d7c3:: with SMTP id o186-v6mr8827866wmg.67.1529338175588;
        Mon, 18 Jun 2018 09:09:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m58-v6sm30238309wrf.61.2018.06.18.09.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 09:09:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, simon@ruderich.org,
        Git List <git@vger.kernel.org>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
        <20180615022503.34111-1-sunshine@sunshineco.com>
        <20180615065805.GA15146@ruderich.org>
        <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com>
        <a079d636-e70d-f383-ae87-ab890a636441@gmail.com>
        <CAPig+cTMEfu=x2dhUww3x2uk9-ANAK6eepC3hOsx4FE+1jTgBA@mail.gmail.com>
Date:   Mon, 18 Jun 2018 09:09:34 -0700
In-Reply-To: <CAPig+cTMEfu=x2dhUww3x2uk9-ANAK6eepC3hOsx4FE+1jTgBA@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 17 Jun 2018 14:00:26 -0400")
Message-ID: <xmqqk1qwxeip.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jun 17, 2018 at 1:32 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> On Friday 15 June 2018 01:13 PM, Eric Sunshine wrote:
>> > On Fri, Jun 15, 2018 at 2:58 AM Simon Ruderich <simon@ruderich.org> wrote:
>> >> Should we put the part about MacOS's make into the commit
>> >> message? Seems like relevant information for future readers.
>> >
>> > No. The bit of commentary mentioning MacOS's very old 'make' was just
>> > talking about a possible alternate way of implementing the change.
>> > That alternative was not chosen, so talking about old 'make' in the
>> > commit message would be confusing for readers.
>>
>> Interesting. Documentation/SubmittinPatches reads:
>>
>>     The body should provide a meaningful commit message, which:
>>     <snip>
>>     . alternate solutions considered but discarded, if any.
>>
>> The consensus has changed, maybe? In which case, should we remove that
>> statement from there?
>
> Whether or not to talk about alternate solutions in the commit message
> is a judgment call. Same for deciding what belongs in the commit
> message proper and what belongs in the "commentary" section of a
> patch. A patch author should strive to convey the problem succinctly
> in the commit message, to not overload the reader with unnecessary (or
> confusing) information, while, at the same time, not be sparing with
> information which is genuinely needed to understand the problem and
> solution.
>
> Often, this can be done without talking about alternatives; often even
> without spelling out the solution in detail or at all since the
> solution may be "obvious", given a well-written problem description.
> Complex cases, or cases in which multiple solutions may be or seem
> valid, on the other hand, might warrant talking about those alternate
> solutions, so we probably don't want to drop that bullet point.
> Perhaps, instead, it can be re-worded a bit to make it sound something
> other than mandatory (but I can't think of a good way to phrase it;
> maybe you can?).

Yup, "if any" is a bad thing to say, as it does not set the bar for
that "any" random garbage idea.  A phrase like "when appropriate" is
a relatively safe but mostly useless cop-out, as these guidelines
are written primarily for those who don't yet have proper yardsticks
to gauge what is appropriate and what isn't.

I think it maybe better to either drop it or make it a sample way to
do the second point, i.e. if there are seemingly valid alternative
which may entice readers, explaining why the alternative does not
work well and the solution you chose works better *is* a good way to
justify the way you chose in your change.  Off the top of my head,
something like this?  I am not very happy with the text, though.


 Documentation/SubmittingPatches | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 2488544407..4294d0f068 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -125,10 +125,12 @@ The body should provide a meaningful commit message, which:
 . explains the problem the change tries to solve, i.e. what is wrong
   with the current code without the change.
 
-. justifies the way the change solves the problem, i.e. why the
-  result with the change is better.
+. justifies the way the change solves the problem, i.e. why the result
+  with the change is better (e.g. explaining the reason why an
+  seemingly obvious alternative does not work but the solution in the
+  patch does may be a good way to illustrate the nature of the problem
+  and how your approach fits it better).
 
-. alternate solutions considered but discarded, if any.
 
 [[imperative-mood]]
 Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
