Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EF12095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdCRTOQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:14:16 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:33761 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdCRTOP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:14:15 -0400
Received: by mail-it0-f43.google.com with SMTP id w124so19969482itb.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DeqzywJRIKFOeXWw9sKlxRxj3/zi03dONjY/ftkxAZY=;
        b=Bhmr02xAzfqnl9Wrt1IELnKx1rdYCjbOonqUsoszG/cYqMkGKWNh36OH5KmJ4vUGAX
         x9UJQEtF4zIMKj7gAY36Gc/FFpEUDdBoeLGGD7JaGq2zDDsXmkT8s57BVYfR2cYflmdA
         Xs1OnCWlCUVWajhJP+vd9tzy7KkmagJwYX/N1QWLVngi0sfrDaH0iyCZRdQf1n4MW8F4
         pO7DBR3Ml4qtBPQ7zAta5j7l5Gt2T2DE6brnEjYMpDP40JJc8jf30WaRL/swRb+1fc3O
         qaDJri1TJNmDcJ9w6nYJ5ohbkX6PRaioWsSjNwm7rybkHqXX2pjtflasi9HtMQD3gVOg
         UcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DeqzywJRIKFOeXWw9sKlxRxj3/zi03dONjY/ftkxAZY=;
        b=ShqiTKOtrvod5lQZKwGIbdH736qntUibtj67XSiA76zMfjqlNzMQXJAun1zaVdonCH
         qd0/ZGxA6Lw+0s5ApnQpkFbs5ja2L0MAEwIiR6ZmwYIzDxX70KabVsKq4doKW/6IBLfk
         Ua8vv+OJiXphYxN1BhZQBeel9glYNzcUHEjMikZ1JNqood4IXI4TBPOW1k9wp3QcVxT6
         OGWsdV93Q4+1j35/nZLfd/Y36UEgcLbtpM9VMj5rTMAbD4jk7rvBgh41lTOg8lNC7dBy
         BxHwkdeTFxGZw3HOE5SGqwxZhqcug7IAXfsW4srP1oTX6Y/7VJmKWDHnMJU7M6OHkiBP
         YqJg==
X-Gm-Message-State: AFeK/H0acbQ4mYL/ZdOvwMJJX5aGOe7nEHCLbjUoK9tzjqReXh67/6mz02KobJ6Olo6CYPxUUbueEpBV7B8m1Q==
X-Received: by 10.107.57.2 with SMTP id g2mr22917053ioa.117.1489864412767;
 Sat, 18 Mar 2017 12:13:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 12:13:12 -0700 (PDT)
In-Reply-To: <xmqqr31u301u.fsf@gitster.mtv.corp.google.com>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-3-avarab@gmail.com>
 <xmqqr31u301u.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 20:13:12 +0100
Message-ID: <CACBZZX4Zs=00QXv5eaafQd8-n7OakcL3WeQh8XxiMo-9a+kAzQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] tag: Refactor the options handling code to be less bizarro
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
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

On Sat, Mar 18, 2017 at 7:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index ad29be6923..0bba3fd070 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -454,10 +454,10 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
>>       }
>>       create_tag_object =3D (opt.sign || annotate || msg.given || msgfil=
e);
>>
>> -     if (argc =3D=3D 0 && !cmdmode)
>> +     if (argc =3D=3D 0 && !cmdmode && !create_tag_object)
>>               cmdmode =3D 'l';
>
> So with this change, if we cannot infer that we are creating a tag
> object from other options, we leave cmdmode to its original 0.
>
>> -     if ((create_tag_object || force) && (cmdmode !=3D 0))
>> +     if ((create_tag_object || force) && (cmdmode || (!cmdmode && !argc=
)))
>>               usage_with_options(git_tag_usage, options);
>
> And then immediately after that, we complain by detecting that we
> know we are creating a tag and a non-zero cmdmode is in effect
> (i.e. 'l', 'd' or 'v', none of which is about creating a tag).  The
> way we used to detect that we are doing something other than tag
> creation was by seeing cmdmode is set to anything.  Because of your
> earlier change, that no longer is true.  You need to separately
> check (!cmdmode && !argc).
>
> By following the logic that way, I can see how this change at this
> step is a no-op, but I have to say that the code with this patch
> looks much more bizarre than the original.
>
> I am not sure why you want to do the first change at this step in
> the first place.  Is it because you'd want to take over (!cmdmode &&
> !argc) condtion to default to 'list'?  With the change in 4/8 and
> 5/8, you are ensuring that cmdmode is set to 'l' for these new cases
> before the code hits the check to call usage_with_options().  And at
> that point, you can use the original "are we creating and !cmdmode
> says we are not?  That's contradiction" logic without making it more
> bizarre with this patch, no?

Nothing about this patch is needed for the rest of the series. I just
tried rebasing it out now and all tests pass & everything works as
expected.

The reason I'm submitting it is because while this works *now* and
there's no cases I can see currently where cmdmode is 'l' after the
current `((create_tag_object || force) && (cmdmode !=3D 0))`, during a
lengthy debugging session when I was hacking on a subsequent patch in
this series it took me a long time to track down a segfault later in
the file because surely it was impossible that I was in cmdmode =3D 'l'
with only "git tag -a".

Partly that was late night hacking session blindness after having read
the !argc and assuming that the -a would be counted towards argc.

But I thought it was very a very bizarre pattern to set us to cmdmode
=3D 'l' when we're not in that mode at all just to, as can be seen in
the diff, get around a slightly more verbose one-time if-check.

So I think it's worth it to include this for less confusion in any
subsequent patches to tag.c.
