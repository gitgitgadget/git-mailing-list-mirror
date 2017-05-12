Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61624201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbdELWe3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:34:29 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34762 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932166AbdELWe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:34:28 -0400
Received: by mail-io0-f174.google.com with SMTP id k91so48310718ioi.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iqurio2kipzbzNVd70zkk7rz0nsiQaHslcQL3z5v5r8=;
        b=OEfWVVCmTocL6M/3dwwkemhfPPHjoxSOE3+w4mi1LHSVaBKfkgIvl8RwB+dfGRZ64D
         iZI/ln8M08MZDFLkwzClvKrZyhtn4gycy31y+gjsCc9rdefRU6dOTgvjv/5/FR7EAw9W
         UqwybVrkA8QDx0ot9Zq//q6+Oiz4/EMDBr8tJMP3oJ2e6MFSChhslinEbs/7Wa3obWjd
         I+qKJRbtnM3/BV4EUjmvdkdaRkPU8X+xL5btD8XpJRGUeuzX2cJ7gxFNy8XxPHumiX7V
         bHXIQNUzI8pnkcXvesDZ3X7zgCXFioJDEFY532K79LD/d62jsULsDUsLNsMbWJCAzAeL
         MijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iqurio2kipzbzNVd70zkk7rz0nsiQaHslcQL3z5v5r8=;
        b=NIo68T8Ml3NpgacHhfFk8CwCuJHODjrB7h6mS+dc9AXWzcr/wfoIQhSCru2DCXvdwF
         ExURSWlbh2Ob1+6uDh6oHmfwmB8lYnbPHvMwCBHZltVSZNI10rxOhZA/3pyWU7qJ5m1/
         2BZqE0/jpVK7KEmqoBZ7vf2VCyG9rdHYPEmrsKOjgUFindruXt+BWChljJbcAmhwBX0Z
         nG24x5gU20w0fhacyL3RqMHqhdpnwJAhUV/fQ+zL8Qxei3z1g7QUETXFPEeXLJtN1rQc
         6qb7YHQorwppx0DQKV+LqZeug4imKxDYyt5mdIat/T066bvEJpda0gRwxkcDNOKLsoSx
         xsPQ==
X-Gm-Message-State: AODbwcDTkWO9/HZ2SMlGcJTwjQF1pA8HNTNvMWiVhffe2YMxIDVWvBj+
        xqj4krjXl7rle60fUAkCnOD0eVmoHg==
X-Received: by 10.107.138.21 with SMTP id m21mr6357093iod.80.1494628467672;
 Fri, 12 May 2017 15:34:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 12 May 2017 15:34:06 -0700 (PDT)
In-Reply-To: <45b9e2d1-0840-d163-468f-588253cb8527@google.com>
References: <20170511193753.19594-1-jonathantanmy@google.com>
 <CACBZZX74dsTJtAQdrMmEDPKOVdEaiL4dGrmz9OZ3jQhhmr5xEA@mail.gmail.com> <45b9e2d1-0840-d163-468f-588253cb8527@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 00:34:06 +0200
Message-ID: <CACBZZX4zSmFrWfksAoDTyaRHCXEGBLXbY_8wxzNVyXgLq8N-KQ@mail.gmail.com>
Subject: Re: [RFC] send-email: support validate hook
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 12:31 AM, Jonathan Tan <jonathantanmy@google.com> w=
rote:
> On 05/12/2017 12:23 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> I hacked this up last night, it also addresses Junio's comment about
>> GIT_DIR:
>>
> [snip]
>>
>>
>> Changes there:
>>
>>  * use catdir instead of string concat, I don't know if we run
>> format-patch on any platform where this matters in theory (e.g. VMS I
>> think), but the file uses that API already, so continue using it.
>>  * Just make this more brief by moving the -x test into the loop,
>> we're sending E-Mail here, no need to optimize stat calls (you did ask
>> for style advice :)
>> * Check the return value of chdir & die appropriately
>> * localize GIT_DIR
>> * "die if system" is more idiomatic than "die unless system =3D=3D 0"
>
>
> Thanks - all these are very helpful. Especially the one about localizing
> GIT_DIR - this allows me to move everything into the validate_patch()
> function.
>
>> Or actually just move this into a function:
>>
> [snip]
>
> I'll send out another version of the patch that puts all these into the
> validate_patch() function.
>
>> I wonder if we were designing this interface today whether whether the
>> existing behavior of  --validate wouldn't just be shipped as a
>> *.sample hook instead. There's also the caveat now that your hook
>> might be OK with really long lines, but the existing validate function
>> denies it, and there's no way to override that. I think a better way
>> to do this is:
>>
>>         foreach my $f (@files) {
>>                 unless (-p $f) {
>> -                       my $error;
>> -                       if ($use_hook) {
>> -                               $hook[1] =3D abs_path($f);
>> -                               my $cwd_save =3D cwd();
>> -                               chdir($repo->wc_path() or
>> $repo->repo_path());
>> -                               $error =3D "rejected by sendemail-valida=
te
>> hook"
>> -                                       unless system(@hook) =3D=3D 0;
>> -                               chdir($cwd_save);
>> -                       }
>> -                       $error =3D validate_patch($f) unless $error;
>> +                       my $error =3D -x $validate_hook
>> +                               ? validate_via_hook($validate_hook, $f)
>> +                               : validate_patch($f);
>>
>> I.e. if you specify a validate hook it replaces the existing hardcoded
>> behavior.
>
>
> I'm OK either way.
>
>> Also, just to check, is this new thing still consistent with the cwd
>> docs in githooks (see e.g. 501d3cd7b8).?
>
>
> Anything particular that you think is inconsistent? It is consistent with
> "Before Git invokes a hook, it changes its working directory to either
> $GIT_DIR in a bare repository or the root of the working tree in a non-ba=
re
> repository". (The commit you reference refers to push hooks, of which thi=
s
> isn't one.)

I don't think it's inconsistent, didn't check the patch carefully
enough, just asking if it was, sounds like it isn't.
