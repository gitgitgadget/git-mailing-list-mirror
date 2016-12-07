Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E5320259
	for <e@80x24.org>; Wed,  7 Dec 2016 14:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbcLGOHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 09:07:39 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:35299 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbcLGOHi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 09:07:38 -0500
Received: by mail-io0-f170.google.com with SMTP id a124so712730942ioe.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 06:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4sEkz4k01CzJD8TcbDeFRi1ICblMg9MTMQ73e8N8Bl0=;
        b=bvlysiQ01jPAdRfZOzqNvc/0nKI8R+ZGt8nX9UMYgo/sxe/CQlZ0kTmvKqZsMTT5WY
         3bjE9nJlijR2BtC0fWKRRbGFHEf64MixNZXb90Z38as8lEfVurTsYbTEmh7LZEwF0nlb
         YJs78JzQIh69grJAaKQklBUSCcoeubErcj6RYPEQpcJx3QWCcsYlSkNo6BB7LtoEqF2+
         otZbjVdXlGngSdBVGQlc4ue0n24ZMd5f007ALzGn/kZtp4QB6KqDgNxLwuMVsPiFj01y
         C9XLYbIu9P7vVK+fZp83f1b1+mUt2QO3n05aRoBjSqwRWqofZrA1f9KpZdSCiNq1DHVM
         j0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4sEkz4k01CzJD8TcbDeFRi1ICblMg9MTMQ73e8N8Bl0=;
        b=CNaWF4Z19uFCjF971ghYVVDVLkMCXZhzsYE1OepYj736w/ALlW6SuPVRGg15Gs8VYN
         V5Fv/L5QVF17IcnbOlbjuoldeqhWb/SeFQmQ3EFdKKup6BGImGXZd7Y/vF2gZSfCPWOu
         u2geG0xU4aIBpVvgzcuzzQZ85VWDoOFu0abvQjs16w8T6S01DnBaAny3HlSy+1ULMmk8
         J5sLeX4SiJcX73qxS22ncAhl+jOf5F4W+9hxK6E+lugz/thTJk+6hGimDeF6vV88g+ng
         7wInicZfhTprlGgOU0PucFiTRCSP/658UIHjD00J/wUIsXoqKcqm7Zg0y2zXRAW19jHy
         98zQ==
X-Gm-Message-State: AKaTC03VxOzgpt6khMNtaIOevBMRjtOoc1FWx4yBcm1UBPCEmB0hO26ZC3RCkzz9guyQrKxfzHXM0AruY0zKQA==
X-Received: by 10.107.59.9 with SMTP id i9mr60376125ioa.176.1481119657840;
 Wed, 07 Dec 2016 06:07:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 06:07:07 -0800 (PST)
In-Reply-To: <xmqqshq029o7.fsf@gitster.mtv.corp.google.com>
References: <20161204220359.30807-1-alexhenrie24@gmail.com>
 <xmqq37i25iy5.fsf@gitster.mtv.corp.google.com> <CACsJy8Cy+iWw4NhR7B_fZhBMMYt2QxdMeFsC=++LLnrTLNWfKw@mail.gmail.com>
 <xmqqshq029o7.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 21:07:07 +0700
Message-ID: <CACsJy8Aug-q6uFKAHpvnvt_9ZhH85q5YcFgK4Cf1bZSnC7Khag@mail.gmail.com>
Subject: Re: [PATCH] clone,fetch: explain the shallow-clone option a little
 more clearly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 1:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Dec 6, 2016 at 1:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I however offhand do not think the feature can be used to make the
>>> repository shallower
>>
>> I'm pretty sure it can,...
>
> I wrote my message after a short local testing, but it is very
> possible I botched it and reached a wrong conclusion above.
>
> If we can use the command to make it shallower, then the phrase
> "deepen" would probably be what we need to be fixing in this patch:
>
>>       OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
>> -                     N_("deepen history of shallow clone by excluding rev")),
>> +                     N_("deepen history of shallow clone, excluding rev")),
>
> Perhaps a shorter version of:
>
>     Adjust the depth of shallow clone so that commits that are
>     decendants of the named rev are made available, while commits
>     that are ancestors of the named rev are made beyond reach.
>
> or something like that.  Here is my (somewhat botched) attempt:
>
>     Adjust shallow clone's history to be cut at the rev

OK mine is "exclude the given tag from local history".

BTW the clone's string could be rephrased better because we know
there's no local history to begin with, if we stick to any verbs that
involves deepening or shortening.
-- 
Duy
