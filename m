Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375B52095D
	for <e@80x24.org>; Mon, 20 Mar 2017 09:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbdCTJRx (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 05:17:53 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35619 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbdCTJRL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 05:17:11 -0400
Received: by mail-it0-f45.google.com with SMTP id y18so25337844itc.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/LZnBudyj4fQy5/b7eblv8hGLFASZwjH+wLf6ZCEmhc=;
        b=O1EzN5kuAvuw2PjSUgPlXdGpZpfcQ/WSjV+fbM+0Yyi8ivRutAZRK8/6RdF7s6w7Kb
         d/UwsXumXYa+R9OBIS2MdhNEXWvlXuq7paXKMXkf7dnHG5qq56OB4mIA58Okc4FQyzG8
         PdipDgx+D7hrwbxfEsNjVW9qlaTufYq+O5ujxCvBms3U6Ra4uYuU/jJg4yrWW2pSmXqn
         0jgZ90bh9VAI+GMixwFIcxTaRaD1Rx7U45BFYFBoYLRwOMNrQ7Zp20f/6uoGA+56xgoB
         g79JDBxDQnVDI/GbPgsgX28UjVdVwNqVWfduedXZp3dlm1uoDXFdadfUEcqivwYsd7bB
         pgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/LZnBudyj4fQy5/b7eblv8hGLFASZwjH+wLf6ZCEmhc=;
        b=B6wxNheQhGXIxgXkIe8TZlhddMi4BXYoYrW/aiw4qBETxoxB0uHwO//rjyU90bNWYi
         L8Y0Qj7U+WwZIMx3waU468CLIQUUGacnA0i+jXk0Z1K1hPzJaHIKqONVSiVxQOWybMjj
         6xvv/SGx1cAgWqsRvsj7gXZObN3NsPSsrFYxfLbgiHZdWsgkUzfilXxVvv48TGhc4YqX
         oBks+a7OXyULwpgn/L64JemdNJfJ11wUsHtKiAEcavF+XbstGRYqqAQrHL+ytujeUv89
         wGEugkDftxkNOKgr9PyuuF5RvGbQi/h2G6oQb+g1sOcnx7vev3xO+cFSjX2wrZQSxvac
         ymEA==
X-Gm-Message-State: AFeK/H0IUsE9I+XaaW1lOHYS8awO5vhgWrD1EDCSE5y8qb3z+JeR012LbGULWNmWwa0adYCFklIw6Lezw5oEuA==
X-Received: by 10.107.150.201 with SMTP id y192mr30207523iod.33.1490001429968;
 Mon, 20 Mar 2017 02:17:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 20 Mar 2017 02:16:49 -0700 (PDT)
In-Reply-To: <20170320035549.smzgu2jkaxrhuxl4@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-5-avarab@gmail.com>
 <20170320035549.smzgu2jkaxrhuxl4@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 20 Mar 2017 10:16:49 +0100
Message-ID: <CACBZZX41W40PzSdxsPU+=NP==LuYdAUcD2n4Q381opn63DfcqA@mail.gmail.com>
Subject: Re: [PATCH 4/8] tag: Implicitly supply --list given another list-like option
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 4:55 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 18, 2017 at 10:32:52AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> With this change errors messages such as "--contains option is only
>> allowed with -l" don't make sense anymore, since options like
>> --contain turn on -l. Instead we error out when list-like options such
>> as --contain are used in conjunction with conflicting options such as
>> -d or -v.
>
> Yeah, I think this is the right approach.
>
>> This change does not consider "-n" a list-like option, even though
>> that might be logical. Permitting it would allow:
>>
>>     git tag -n 100
>>
>> As a synonym for:
>>
>>     git tag -n --list 100
>>
>> Which, while not technically ambiguous as the option must already be
>> provided as -n<num> rather than -n <num>, would be confusing.
>
> I'm not sure the existing behavior isn't confusing anyway (most optional
> arguments are). But I don't mind being conservative and leaving out "-n"
> for now; we can always convert it later if somebody feels strongly about
> it.
>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index 0bba3fd070..3483636e59 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -454,8 +454,12 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>>       }
>>       create_tag_object =3D (opt.sign || annotate || msg.given || msgfil=
e);
>>
>> -     if (argc =3D=3D 0 && !cmdmode && !create_tag_object)
>> -             cmdmode =3D 'l';
>> +     if (!cmdmode && !create_tag_object) {
>> +             if (argc =3D=3D 0)
>> +                     cmdmode =3D 'l';
>> +             else if (filter.with_commit || filter.points_at.nr || filt=
er.merge_commit)
>> +                     cmdmode =3D 'l';
>> +     }
>
> Makes sense.
>
>> @@ -483,15 +487,16 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
>>               if (column_active(colopts))
>>                       stop_column_filter();
>>               return ret;
>> +     } else {
>> +             if (filter.lines !=3D -1)
>> +                     die(_("-n option is only allowed in list mode."));
>> +             if (filter.with_commit)
>> +                     die(_("--contains option is only allowed in list m=
ode."));
>> +             if (filter.points_at.nr)
>> +                     die(_("--points-at option is only allowed in list =
mode."));
>> +             if (filter.merge_commit)
>> +                     die(_("--merged and --no-merged options are only a=
llowed in list mode."));
>>       }
>> -     if (filter.lines !=3D -1)
>> -             die(_("-n option is only allowed with -l."));
>> -     if (filter.with_commit)
>> -             die(_("--contains option is only allowed with -l."));
>> -     if (filter.points_at.nr)
>> -             die(_("--points-at option is only allowed with -l."));
>> -     if (filter.merge_commit)
>> -             die(_("--merged and --no-merged option are only allowed wi=
th -l"));
>
> I'm not sure why these go into the "else" clause here. The other side of
> the conditional (i.e., when we are in list mode) always returns. I don't
> _mind_ it, it's just surprising in this patch.

Changed it. It was a wart left over from an earlier version of this
that didn't make it on-list where the else mattered.

> While we are re-wording the messages, we may want to drop the periods at
> the end of the first three (or keep it on the fourth one, but I our
> usual style is to omit it).

Done.

>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>
> The tests looked reasonable to me.
>
> -Peff
