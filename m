Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2280C1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 18:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcHLSQa (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 14:16:30 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34908 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcHLSQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 14:16:30 -0400
Received: by mail-yw0-f179.google.com with SMTP id j12so19626894ywb.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 11:15:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BN/j6gE9OIejqdvhJDY7knjgw6lHc8rDSm1Qd9ethk4=;
        b=FLiZGyX24KZJnw1v43v3o+Q6Av505fxJ4KGfpI6PoOcLS5tiOr8yy6Ax3GvM14xvHE
         9WVwXo0YIhzAyBwiPnlOEOUFJn0nH5a8cS4vHa9D8NNIBiIWz49E5MP6xklXUMm0O0RK
         eTuTzcyCZ7zATN3/rjKJH57hd1Lz4TQRISkdMWx0+XGmzVg89RdrcuHYd1MWyRqHK+Lw
         8f0VWaBURJLmOt1+wV/3uthlc4WZFljzX3JqCWNQvvo2ttycOnq6xaSCND9rAkjxn2GY
         0FDXRgB0hrT1lroo8g2idxnETz5E1Vvt/yzFG/g/b8mIqUY7aYSgugovD/Qk+1CJwEU3
         oYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BN/j6gE9OIejqdvhJDY7knjgw6lHc8rDSm1Qd9ethk4=;
        b=NS3KE8yAhuUnQKG2fWFfRdLAUYcwbIafPqqzF5H9o6SBbeqA2d0AoRPlPPewbNTSkg
         08VzKnt+sbySkDGvf2uDLM1sYI0oo9OThx/wYXLQnduwIfqgaCD7F+yxazil/YoBT8wV
         IK5PHAb84EAaKau3OtxKrynz9hcG90yuAgbEThQkJ0RA+kOkkWOgrSDa4zhPb4W71/Tj
         wylQ5U0G3eASk115gTTKmSUITxkmzkma9NHsBbMJ0CpXX5pBlHd0IY4msm+14OXfWiTZ
         kLsVGc0zsPsYHbp1SEFa8UKMOkJKhH7xqASIv1WpngtxUxSXgWaOIGzowPOTnNrnMiPz
         zV4g==
X-Gm-Message-State: AEkoouuPmq5buGLL0oFefXMA08yGugdaRM6yPe1FrG4bxKEUV15iP/Wn47kKyP3RTKA6Tm6aIhLWfxA/7UGIpw==
X-Received: by 10.129.99.67 with SMTP id x64mr11687176ywb.258.1471025707140;
 Fri, 12 Aug 2016 11:15:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Fri, 12 Aug 2016 11:14:46 -0700 (PDT)
In-Reply-To: <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com>
References: <CAKRjdd4WdVTgbT0gcR=a267+aEwD2Exztrc9gNau1nOXroC=ng@mail.gmail.com>
 <xmqqr39uxa33.fsf@gitster.mtv.corp.google.com> <A7A176B0-08CE-4D92-9756-51A59DF3B9D7@gmail.com>
 <CAKRjdd4V3OfDnzisxBofBUmtds7q7ejUtuV_-s96eUVf7fqwHA@mail.gmail.com> <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Fri, 12 Aug 2016 11:14:46 -0700
Message-ID: <CA+P7+xp7rpVRWgAXTe9sHN9=a+T+x0SnQPUCrR5_E9Qpufo6=Q@mail.gmail.com>
Subject: Re: `git stash --help` tries to pull up nonexistent file gitstack.html
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Joseph Musser <me@jnm2.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 9:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, Aug 12, 2016 at 9:15 AM, Joseph Musser <me@jnm2.com> wrote:
>> Oh, I'm embarrassed. The typo was mine, I must have typed `git stack
>> --help`. I would have expected a syntax error message or "did you
>> mean" suggestions; it didn't even enter my mind that it would look up
>> whatever I typed before --help and assume it existed on disk.
>
> I actually think you found an interesting (albeit minor) bug.
> I think whenever "git" sees any word followed by "--help" and nothing else,
> it blindly turns it into "git help" followed by that word. I think it
> is reasonable
> to expect that "git foo --help" responds with "foo: no such subcommand",
> instead of "No manual entry for gitfoo".
>
> It may not be too hard to arrange; this might be another low-hanging
> fruit if somebody wants to try a patch ;-)
>

What about extension subcommands that aren't core? Wouldn't we prefer
if it still tried to find help for those also? Just a thought to add
to this.

Thanks,
Jake
