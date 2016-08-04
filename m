Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C12320191
	for <e@80x24.org>; Thu,  4 Aug 2016 04:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbcHDEtg (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 00:49:36 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34652 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbcHDEtf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 00:49:35 -0400
Received: by mail-yw0-f196.google.com with SMTP id j12so18610235ywb.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 21:48:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d/bypxUk8gDvK1bC3hUJZCu1ER+IeHjBXNuHtYUBOaM=;
        b=SJTPBVkUSd4uqLW/W8GwBWQsczqx2eTnwXKIfebt0uWoyyxtYk255//oEAUWgTRPgJ
         ZyZdV4CbbU2nzZZyAaZBahA0pPjZ+8gzqYhA5nix3oMLMDO4MJh9SKumuSeGBdttUJgB
         mfluOdJK74+ifftxaDyMVtqC36fX+l6FdZIkFTPj6Ymc6GGYx7jhTYXIomoBv04uAkLQ
         AD3AUmz3E/Avzxi9Q0UwLL63eW7V1SzfOMReaDAxyG9BcDDfO+RUAUcyN1CWCX4b8K92
         +aBtxvmWhcBu4ZL8HZmOHkkA+MnGXRnNtFL2ohshM+dIbBdn0zjUoyU1K1HALIUgoOYS
         Dakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d/bypxUk8gDvK1bC3hUJZCu1ER+IeHjBXNuHtYUBOaM=;
        b=ccgZ6VHs8MYuaGfYYcaD/r9xGDx+jRfBIobywYD7MV+bYPLHmwYC9ykm0fCC+WvVjX
         YxwEUKlsr1l+WAxo7nbUjqBdSnZACpp/g1rkk5KrdazposAz9dluLJTtmlOD5d/fGULZ
         NDDJkve4EjOwAZngSajxLq7m6+tbxdCpYEwfW1MEJhQTYAmJcFo/YA6Bc9BevtGs9Mov
         JFq0WgsGvohdKDAuE6T/FdhcZO1+gablpimqV6YpS13+i8mXbxf8Cb2FmsVfIjKFQxx7
         +fhx1VPifB6SKQo0UhSjduB0lLxrvcKtEVijtYCyHvb9MbcB6wYM2YYDDrC8Adi12EcZ
         qPBA==
X-Gm-Message-State: AEkoouvV2J6LeznfrSYQnX4xztYmxeo/LP6Z0Ye+skeveRgb8tYoJnWqFvb3moMuK4bTPTvvlL28mY60Pzk+kg==
X-Received: by 10.129.46.136 with SMTP id u130mr59413643ywu.234.1470286094637;
 Wed, 03 Aug 2016 21:48:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Wed, 3 Aug 2016 21:47:54 -0700 (PDT)
In-Reply-To: <f7f35993-39a8-b788-d2a7-d030ac442b9b@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <CA+P7+xo6q0pveVQdt1mynfsWq75DzBXsbPcgVYdd5s8rpO+97A@mail.gmail.com> <f7f35993-39a8-b788-d2a7-d030ac442b9b@alum.mit.edu>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Wed, 3 Aug 2016 21:47:54 -0700
Message-ID: <CA+P7+xp8n5s0EkUCXVyqohyuXW0iPd80niq2_CPHTLr00=Ahzw@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 3:36 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/04/2016 12:29 AM, Jacob Keller wrote:
>> On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> It seems odd to be that a line with "199" spaces and nothing else will
>> return "-1" but a line with 200 spaces and nothing else will return
>> 200..? Would it be safe to just return -1 in both cases (if a line is
>> all spaces or starts with more than 200 spaces just return -1)?
>>
>>> +}
>>> +
>
> Thanks for your feedback.
>
> I was implicitly assuming that such lines would have text somewhere
> after those 200 spaces (or 25 TABs or whatever). But you're right, the
> line could consist only of whitespace. Unfortunately, the only way to
> distinguish these two cases is to read the rest of the line, which is
> exactly what we *don't* want to do.
>
> But I think it doesn't matter anyway. Such "text" will likely never be
> read by a human, so it's not a big deal if the slider position is not
> picked perfectly. And remember, this whole saga is just to improve the
> aesthetics of the diff. The diff is *correct* (e.g., in the sense of
> applicable) regardless of where we position the sliders.
>
> Michael
>

I think in this case treating it as "all whitespace" is more natural
than treating it as "200 characters with something following it"
because the only thing we've found so far is all white space.

Either way it's not really a big deal here.

Thanks,
Jake
