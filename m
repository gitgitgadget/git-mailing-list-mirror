Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAECD1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDYMzY (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:55:24 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:40584 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbeDYMzR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:55:17 -0400
Received: by mail-io0-f176.google.com with SMTP id t123-v6so26677214iof.7
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cu3QoBQgQvGNhVfwwkh+hyohg7AnFIU4MNF1S8yteks=;
        b=t0X4sS18Rca0J9WId3s+CFPXirSMp/bNK8zWu+a7ehslzN3+NVU0+OBk0npTfRshPm
         gqfrvR5GyaYi+tHQajJAanGHeNlwuQXIn4ACoMwEEMUvk//EwGtsR0bZQ9Z0Ih8lL+6W
         HOG6wAsRYeynwd3Z4V+muxtNHvhCu7RK8X4k1wgYrArcX9kTM+VZ4nDiKpYdisqezTiw
         h7AhIJiXhz9z1tNgJW1Tyuf7NFmURzlb4aGGtbTXTqzviEyr6T0GNo3hEXX9icZ6ptzc
         Zl7OnA5tVFwCn4F5Jl80Kn1BnQMpLAn06D+Ja+r3RSYriP3lqGCRYtaHMSHFhVTuBLE7
         Dslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cu3QoBQgQvGNhVfwwkh+hyohg7AnFIU4MNF1S8yteks=;
        b=fKtehjWohVTM52bip2Kl/WJnLxQTD0f224jrj0SPt6VwusgkBpgBsutzvIUdYD6khH
         PICWAMitMy1CFHwrlWttT09BKFQgbQtM3Fh1Rk10gqhYJG30QmriDWFKLWSCByxpk4P/
         mSRmNC/pFUsLRkQ3ViAJD7GIQXpb/fIKolvjDulogBi7fCELqysH4MckHs/YFCbDFw5a
         hY4QRq95S7eFEPGgKNgc48VKMXfqCrkFOdvClLy/LiqTtl7fUWE1YYjrhRhOhBnk7GA2
         aJ9rSjGZNYYrgt2x0Z4N8AN8VLzch8Gpcbz35UudMgzBzDIQYQr+tEVgVbmCSVnEpwm6
         JsDQ==
X-Gm-Message-State: ALQs6tCkZGcoPqyLqSU4LKo/3goB4qkspuQa2sRgr45teptGcAIdqDXX
        LuRlvCaIG11wOrLPuZ1CluzgKz77dcz5svSxdLI=
X-Google-Smtp-Source: AIpwx48yL2H1TFyOQ42MNnB6cLFbdklily75fOvlMMj6Jg0hyYrb0YHi/l0Dsa1fvYEnM0YJVOH7ktCz7hVqJfjGxXI=
X-Received: by 2002:a6b:bdc4:: with SMTP id n187-v6mr30479799iof.147.1524660916204;
 Wed, 25 Apr 2018 05:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Wed, 25 Apr 2018 05:55:15
 -0700 (PDT)
In-Reply-To: <xmqqd0ytb4le.fsf@gitster-ct.c.googlers.com>
References: <20180420121041.32558-1-chriscool@tuxfamily.org>
 <CAPig+cSDYVGpaV-beNVG57r3YfQ=Ey5zuyHRkk_tf86NNRdY6w@mail.gmail.com>
 <87h8o5ensj.fsf@evledraar.gmail.com> <xmqqd0ytb4le.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 25 Apr 2018 14:55:15 +0200
Message-ID: <CAP8UFD1nkNEbbERvyhSGfSLBDNfD8QcmrYNRy_3J4Mrb7z2ekw@mail.gmail.com>
Subject: Re: [PATCH v1] perf/aggregate: tighten option parsing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 5:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Not necessarily worth a re-roll.
>>
>> Not that it matters in this case, but just as a bit of Perl rx pedantry,
>> yes his is tighter & more correct. You didn't consider how "." interacts
>> with newlines:
>>
>>     $ perl -wE 'my @rx =3D (qr/^--./, qr/^--.+$/, qr/^--./m, qr/^--.+$/m=
, qr/^--./s, qr/^--.+$/s); for (@rx) { my $s =3D "--foo\n--bar"; say $_, "\=
t", ($s =3D~ $_ ? 1 : 0) }'
>>     (?^u:^--.)      1
>>     (?^u:^--.+$)    0
>>     (?^um:^--.)     1
>>     (?^um:^--.+$)   1
>>     (?^us:^--.)     1
>>     (?^us:^--.+$)   1
>>
>> I don't think it matters here, not like someone will pass \n in options
>> to aggregate.perl...
>
> Hmph, do we want the command not to barf when "--foo\n--bar" is
> given from the command line and we cannot find such an option?
>
> I thought that the location the match under discussion is used does
> want to see a hit with any option looking string that begins with
> double dashes.  I would have expected "tigher and hence incorrect",
> in other words.
>
> Somewhat puzzled...

I guess it might be better at this point to just "use Getopt::Long;"
(along with "Getopt::Long::Configure qw/ pass_through /;") as git
send-email does. It might avoid mistakes and subtle discussions like
the above.

Thanks for the reviews,
Christian.
