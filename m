Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94751F424
	for <e@80x24.org>; Sat,  7 Apr 2018 08:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeDGIiX (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 04:38:23 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38723 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeDGIiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 04:38:22 -0400
Received: by mail-qk0-f195.google.com with SMTP id 132so3783192qkd.5
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MXGJwirFGCKENllc9uJcEoltGWEKjA+J9ru8LlniiOI=;
        b=T/jYSaSDh7Z17NmaFtMZ3ywSzJHeckqVPXRto4rSLBPxNsS4Je3OubpdBofyMkKVTv
         YI4LlCIhhWh+VFqYY5dKdF5p7JYm8SfxDLSaj2dyaVRVdq/1eMXOGemDfxPsoR3Bnrfu
         g6pHbDaffZuGy2wxxdWNNhFvlGhT5CziLbHF21CuGOCOEi1WPA97Rt6ozZtde6O+/FjF
         nZqeiIbD0kp2QJa0Vdtl0+R1HQpZMw5piLa/2Cs/JmaQCjXnBwCLEdn2BcOvpGmlV2d7
         a4QQ9B0uslL14EYEdyglcyqbCEq5hvCAwffVj1i4IGXMgkbwyrdMCxJkbgcmPzd0nAvb
         h3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MXGJwirFGCKENllc9uJcEoltGWEKjA+J9ru8LlniiOI=;
        b=p30iiU3LwPfCVaJbzDY/Wjup0r+ulcAOv0ntT+DWf9DcN8axKvEkmAKUXsHcknatVB
         QO0TFLPt2wDjdYSxf9lb1SkeglwzPB5lq+nYWidUUpJSl8cxmj7PxwSSpQW+njLC4mxi
         Kzq8cGYgNX3MkJlo0ja2GN3Ojuor5LAfP24larH+9SLxEbHU4V1E3rcyNXKU3JV9jOQq
         TuITo041VcKOoMySjko7CC7oGXJv9TivFocA0WAT+0WOJrNMUhogwTqT1FTKthDsvb+Z
         +Xmrup+pC05FgojL2ogJCYUOpJWLPdwzOADI7le/S7wPNbLQJKBOwrqgPdYYlIpnRC9v
         3a8A==
X-Gm-Message-State: ALQs6tCr9EW81uEqESP5Mt/6n4rhYwUYTbkRtaI5E03VoY0w6iLUnmdD
        dOhHv7twmAoQUn2Y8l/TDGExFIGoB/Vzd8ZKhs4=
X-Google-Smtp-Source: AIpwx4+Khxn8iLVPTmR3nrQ/yVIU1BzB6ApjB9YG8ZhUoHrzOh8Hir2VDA021LWitgxF/ipjdtz79RgVLEs5PfIo2dw=
X-Received: by 10.55.182.70 with SMTP id g67mr38809325qkf.314.1523090301546;
 Sat, 07 Apr 2018 01:38:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 7 Apr 2018 01:38:21 -0700 (PDT)
In-Reply-To: <20180407004916.GC78042@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com> <cover.1522996150.git.me@ttaylorr.com>
 <20180406063013.GB662@syl.local> <CAPig+cRKaxECLHb1id6Mcd0O3uOiDzdGB4ZxPt1UpwUDi9Xb+g@mail.gmail.com>
 <20180407004916.GC78042@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 04:38:21 -0400
X-Google-Sender-Auth: Knc6iFv0fFIvNG4FYeqGWklAVI8
Message-ID: <CAPig+cR5szdsE79-S4So1kGhe5EVHFDFJnPK7R59kBwn79KtJg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] builtin/config: introduce `--default`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 8:49 PM, Taylor Blau <me@ttaylorr.com> wrote:
> On Fri, Apr 06, 2018 at 02:53:45AM -0400, Eric Sunshine wrote:
>> On Fri, Apr 6, 2018 at 2:30 AM, Taylor Blau <me@ttaylorr.com> wrote:
>> > +test_expect_success 'uses --default when missing entry' '
>> > +       echo quux >expect &&
>> > +       git config -f config --default quux core.foo >actual &&
>> > +       test_cmp expect actual
>> > +'
>> >
>> > +test_expect_success 'uses entry when available' '
>> > +       echo bar >expect &&
>> > +       git config --add core.foo bar &&
>> > +       git config --default baz core.foo >actual &&
>> > +       git config --unset core.foo &&
>> > +       test_cmp expect actual
>> > +'
>>
>> If you happen to re-roll, can we move this test so it immediately
>> follows the "uses --default when missing entry" test? That's where I
>> had expected to find it and had even written a review comment saying
>> so (but deleted the comment once I got down to this spot in the
>> patch). Also, perhaps rename the test to make it clearer that it
>> complements the "uses --default when missing entry" test; perhaps
>> "does not fallback to --default when entry present" or something.
>
> That location makes much more sense, as does using --default=yes to
> ensure that canonicalization is taking place. I've updated that locally,
> as well as the preceding test to make it clearer that they are
> contrasting tests:
>
>         - 'falls back to --default when missing entry'
>         - 'does not fallback to --default when entry present'
>
> Though I am not sure about "falls back" to mean "uses --default". I am
> not sure which to pick here... what are your thoughts?

It's nice for the titles to show that the two tests complement one
another but the exact wording is not terribly important. Taking your
original test title (slightly modified), perhaps:

    - 'uses --default when entry missing'
    - 'does not use --default when entry present'
