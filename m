Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551571F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbcHCUEH (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:04:07 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37891 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757964AbcHCUEG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:04:06 -0400
Received: by mail-wm0-f47.google.com with SMTP id o80so351910593wme.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:04:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S3NDiRdgNc0G0M4MnW31nSkSlGW3tN5GOt3NQaIJc3Q=;
        b=qQgj0cypJ0iLE7KsRmivPdL2gr5eTwnwFsgZI7uye5SjzQwfjaJ0298z/SmPhixt8o
         1Do8WTVnhroyrS3jEhFofpx4f2Vi0gQyJ5xfCLK/wQzzrU1N4DfXq0tUyY3BgSgm35kl
         Ly1rK4gdkKiL4UJsHrNt8vajF0CSudkiQGLP3WzeVKOZ1mlCuxXkRQRIvALrDEw4kUK9
         lmcsSWWpkUVDNqX40Kq+oSGHpXyP6YHFg8aub/ksC9+ThRPUOE7rdenNRjqK7+BGFGyq
         aHI852IUMe5G8zlpUoiHM3JoCiXvSgtU7x5mRP6nt0nFRC51CfhJcO2tByOewUMJaoJp
         qsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S3NDiRdgNc0G0M4MnW31nSkSlGW3tN5GOt3NQaIJc3Q=;
        b=S+DeEAIN1JRU+DmVXCajbBDpSCMiwqGPaLPq+PTEqX2+5dr0M9pGLocfhuS7l65kC4
         WMTDDStihPVRcN2vlBGRdwN/+fXf1wZqMRFGIKjezG7c2aS/iBI/vWVVkJRzH9b4Z4d4
         wl6GoSYqim5YNTOYtuQ1hHg/VmP6i8KdH9r/UyUPGeWi/SfCh7gdWZzcHpk46pGQ35+J
         N9SLXKk2YUc5jGW3vwwErl6M6ffjEW6q2Vq2SWMDkoQqB+ERl2JY+tKR5CCxccQdk/oC
         pT1LV2QAb+wceNzTut5k4EEMy863KFPpCAOTzypRdGMPr8VVlA9WiXPtljk7F5vr7b7J
         L+YA==
X-Gm-Message-State: AEkoousEFMW0uR0TJHeDR39v1tlUglSzJP3eBqMxIJ4TkVPubxDdCidwTcaDJgkG4h8NF2YU77OO0YcfVCTM9A==
X-Received: by 10.28.153.202 with SMTP id b193mr71647376wme.62.1470254170634;
 Wed, 03 Aug 2016 12:56:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Wed, 3 Aug 2016 12:56:09 -0700 (PDT)
In-Reply-To: <20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
References: <579CEF77.9070202@web.de> <20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
 <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com> <20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
 <xmqq60rkglym.fsf@gitster.mtv.corp.google.com> <20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 3 Aug 2016 21:56:09 +0200
Message-ID: <CAP8UFD2ooGO+E05qNAkpR5cNDXjTLWh2NSO6NBZv-LctZOFSaw@mail.gmail.com>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 9:13 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 01, 2016 at 03:31:45PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> >> *1* I have a slight suspicion that this is cultural, i.e. how
>> >> arithmetic is taught in grade schools.  When an apple costs 30 yen
>> >> and I have 5 of them, I was taught to multiply 30x5 to arrive at
>> >> 150, not 5x30=150, and I am guessing that is because the former
>> >> matches the natural order of these two numbers (cost, quantity) in
>> >> the language I was taught.
>> >
>> > You might be right. I was trying to figure out what is "natural" for me
>> > in these cases, but after thinking about it for 2 minutes, I'm pretty
>> > sure anything resembling "natural" is lost as I try to out-think myself. :)
>>
>> Do native English speakers (or more in general Europeans) think of
>> the apple example more like "5 apples, 30 cents each", and do 5x30?
>
> I think in my head I rewrite any multiplication like "N of M" as having
> "N" as the smaller number. I.e., it is conceptually simpler to me to
> count five 30's, then 30 five's (even though I do not implement it in my
> head as a sequence of additions, of course; I'd probably do that
> particular case as "half of ten 30's").
>
> I have no idea if that's cultural or not, though. I'm pretty sure "half
> of ten 30's" was not taught in schools. All I remember of grade school
> multiplication is them insisting we write down all of our steps, no
> matter how trivial the problem would be to do in our heads. :)

Yeah, I would be tempted to write all the steps too like this:

"An apple costs 30 yen and I have 5 of them" means:

Cost(1 apple) = 30 cents
Cost(5 apples) = 5 * Cost(1 apple) = 5 * 30 cents = 150 cents

so it would be more "5x30=150" than "30x5" in this case for me.
