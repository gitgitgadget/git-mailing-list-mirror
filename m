Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC931FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 09:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761596AbdDSJIj (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 05:08:39 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36726 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761553AbdDSJIe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 05:08:34 -0400
Received: by mail-lf0-f47.google.com with SMTP id c80so8833346lfh.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8uNfHdgDIZgcu+kD8Hqet2t1R9vIuZUVUAfpiAJyGcc=;
        b=Lj+SXDeFyDv7MVXJH6R0gRVoQDArTPkazYPgRjoA8LWuwkiSDVWUgJTVDZl5Ja2MO/
         G3FZubIuGBQa89utKtMy7S25h60Dbkx3X5KFRj23/hGE9Dzr9+5eXB8JqOs0IO/nC6Wx
         FAiz6y+reaQIZ9jCPObqZGEa2tq46Rakh+KzmJBsh8cUikdqHoYTKWl1LhFOVYuO7AwR
         lKQE19abCLh8kI1mZh4H37WlT1KJ+i9/fuktigfjDm+t8baJl+whP9KuJ0I7aWTn1W5O
         mmj/Lvc/xylnu98yWjxaMohye0jI3bjjaLCP5vTPUjOT63D8JcmonyQcbD3ZlXJZcdg4
         O11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8uNfHdgDIZgcu+kD8Hqet2t1R9vIuZUVUAfpiAJyGcc=;
        b=rJ8VP7iD5DK64vESYqgASxXQhO4LtpksT6ETTdahZprXxZSoI0SbbncJd8tTNxoWJ3
         iMuajelbnN40Aj0sEpVep7ppNSN5+nwatR4pcN4U/NORBVGEWGZEdxy30H1WwgoWZO4L
         Or8iN2drKhzK35EWrIXiWvjw/9Fb12Us3GsnA9U0uUyuKCqvHRoh1W+8gRoyLNELCctG
         6ZRBcJoYxXC++RN+h15zQIlI8SB9qMiBcPgDlfAeYiLRozS2YowLOs6aV7vm3bDdqiVA
         vW5R0+b6mzWGJDmHZE3piYztOG6LtFTg/S5vfF4l8z1qEBYE94VXmb9GJcHZvwWL5Cm/
         3U/g==
X-Gm-Message-State: AN3rC/4iHL2eXHL8tXdlniKdtmcUutvH1Fzg8ZUDp+1lMSaPoBLzxL9I
        +tYzpvx7ra+werkqUlEwy0VbyK2Otg==
X-Received: by 10.46.22.10 with SMTP id w10mr588342ljd.35.1492592912588; Wed,
 19 Apr 2017 02:08:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Wed, 19 Apr 2017 02:08:11 -0700 (PDT)
In-Reply-To: <CACBZZX5wHvWgqjBaiD4pJsVQug=+-4xRwkvfZ0uZ=meE3xR6NQ@mail.gmail.com>
References: <20170418170914.9701-1-avarab@gmail.com> <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
 <20170419014143.56io56xn6mawy5xi@sigill.intra.peff.net> <xmqqh91lce6y.fsf@gitster.mtv.corp.google.com>
 <20170419025016.we3tfuvgppuamc7g@sigill.intra.peff.net> <CACBZZX5wHvWgqjBaiD4pJsVQug=+-4xRwkvfZ0uZ=meE3xR6NQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Apr 2017 02:08:11 -0700
Message-ID: <CA+P7+xp-VzyqH2Sn9i0fO4rwszEo6NbTMsdTah+Z+zrc5VR4_g@mail.gmail.com>
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 12:02 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Apr 19, 2017 at 4:50 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Apr 18, 2017 at 07:40:37PM -0700, Junio C Hamano wrote:
>>
>>> > It might even be possible to detect the existing line and
>>> > have parse-options automatically respect "--foo" when "--no-foo" is
>>> > present.  But that may run afoul of callers that add both "--foo" and
>>> > "--no-foo" manually.
>>>
>>> True but wouldn't that something we would want to avoid anyway?
>>> That is, "git cmd [--OPT | --no-OPT | --no-no-OPT]" from the end
>>> user's point of view should be an error because it is unclear what
>>> difference there are between --OPT and --no-no-OPT.  And we should
>>> be able to add a rule to parse_options_check() to catch such an
>>> error.
>>
>> I meant that if you have something like this in your options array:
>>
>>   { 0, "foo", OPTION_INTEGER, &foo, 1 },
>>   { 0, "no-foo", OPTION_INTEGER, &foo, 2 },
>
> I may be missing something, but don't we already do exactly what
> you're describing here? See commit f1930c587 ("parse-options: allow
> positivation of options starting, with no-", 2012-02-25) from Ren=C3=A9
> Scharfe.

Correct, but if you pass the NONEG flag to the option then it will no
longer perform this type of negation either.

Thanks,
Jake
