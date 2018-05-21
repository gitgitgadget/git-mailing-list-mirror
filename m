Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929321F51C
	for <e@80x24.org>; Mon, 21 May 2018 12:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeEUMai (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 08:30:38 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52759 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeEUMah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 08:30:37 -0400
Received: by mail-it0-f65.google.com with SMTP id y189-v6so20822944itb.2
        for <git@vger.kernel.org>; Mon, 21 May 2018 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rbEEjwkbEKi47/Le9Z6isOi6SGX8lswgKHYNuM1E5PY=;
        b=qYiLNj/L1XPCI+CJVgxd1B6VAJln06moDXWwt6cmQdqnzK8DYk5bD4IgUjhUZsAbnf
         HKUC0psXEMfAFpTrEauKg/r1scLdIZzkJrEyZaZ7Ra7+DUpYEZw1lIjEvr7tzjy/6b09
         1/f60NS6c+SAm8l1FBS/Xt0tMjbpM34rkEjx7+6MtiIJMGGnpVy7Rs8xlEvuQl9s3ScJ
         5QWrBkKs3y1uYvv/ntaNnkqOEHAfjTr/x4F1Bal8Pa+uIByZBaxpEMRtWoNUTbKALuIW
         5307aJrm7oRmAlReQI0XCwb9r/1ycSPejaqp5ZkMyguTKXoc0UgQFGWbXv0C4yk5grW+
         TTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rbEEjwkbEKi47/Le9Z6isOi6SGX8lswgKHYNuM1E5PY=;
        b=g1eWxGepIl4BxYLMhCG7Sn3AfKM82wgJ/YW2HdGrp3XtPQyCoJTrNyiMpsRwb+gq6o
         e4WzyUPLV19ac+FCUHSjDpW4NPVR8caCqxnsPakLDIl1jg8Fdvvg7WoMePTpwTSRKRcV
         RypYwHBg7o6Lf7T6e5fuzWrHTUkZrqMUz00zDIrNYaRlJVA9AaNUbg/moG8xqUWuI80t
         QhP7KXb06w5RnqCYvWjQt/m+CDGs/Jay1f3A2uNUAWKsN/dKiaeuw9jz0P6D9lH4oP2w
         JkI/vedAMJqR9A58JytdZ+T45AQMfGXp/t11veJ8XC9MibenYpA464mR7dwQg45X5VF7
         k5TQ==
X-Gm-Message-State: ALKqPwdcEknEkJmwd73tms3sXWFfK6plewyslpaZRzvmqTSVyou1+3pe
        MGT5FVpvCh2hulmn+e9k9p+kz1SGjbh0SPoTOUM=
X-Google-Smtp-Source: AB8JxZqtLV9Gs8y0eGZ/DOog8IFroOK6j3P0R4C3l0m5gWI5s6EZtLsBJ1TrJe6n5GD3BeGIBlxv/T0Xm6Itk0Ajvrc=
X-Received: by 2002:a24:dd94:: with SMTP id t142-v6mr17071685itf.81.1526905836409;
 Mon, 21 May 2018 05:30:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Mon, 21 May 2018 05:30:35
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805211126140.77@tvgsbejvaqbjf.bet>
References: <20180521055143.14701-1-chriscool@tuxfamily.org> <nycvar.QRO.7.76.6.1805211126140.77@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 21 May 2018 14:30:35 +0200
Message-ID: <CAP8UFD3FZP3UqoSwL4z5haxfzPkONCX7m=o6PhfVDMhrasSAwA@mail.gmail.com>
Subject: Re: [PATCH] t: make many tests depend less on the refs being files
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, May 21, 2018 at 11:41 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 21 May 2018, Christian Couder wrote:
>
>> From: David Turner <dturner@twopensource.com>
>
> I vaguely remember that Dave suggested using a different email address
> these days...
>
> *clicketyclick*
>
> ah, yes:
> https://public-inbox.org/git/1474935093-26757-3-git-send-email-dturner@tw=
osigma.com/

Yeah, I actually used "David Turner <novalis@novalis.org>" in the --cc
option I gave to `git send-email`...

> So maybe update it here, too, to
>
>         From: David Turner <novalis@novalis.org>

...but I thought it was better to keep the original author and
Signed-off-by as they are in the original commit:

https://github.com/dturner-tw/git/commit/0a3fa7fbd7f99280b5f128be3e1ed04e04=
5da671

Now I am ok to update them if it is preferred.

>> So that they work under alternate ref storage backends.
>>
>> This will be really needed when such alternate ref storage backends are
>> developed. But this could already help by making clear to readers that
>> some tests do not depend on which ref backend is used.
>>
>> This patch just takes care of many low hanging fruits. It does not try
>> to completely solves the issue.
>>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>
> This is great. I am all for making the tests better ;-)

;-)

>> diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
>> index 3f2d873fec..b8567cdf94 100644
>> --- a/t/lib-t6000.sh
>> +++ b/t/lib-t6000.sh
>> @@ -4,11 +4,10 @@ mkdir -p .git/refs/tags
>>
>>  >sed.script
>>
>> -# Answer the sha1 has associated with the tag. The tag must exist in .g=
it/refs/tags
>> +# Answer the sha1 has associated with the tag. The tag must exist under=
 refs/tags
>>  tag () {
>>       _tag=3D$1
>> -     test -f ".git/refs/tags/$_tag" || error "tag: \"$_tag\" does not e=
xist"
>> -     cat ".git/refs/tags/$_tag"
>> +     git rev-parse --verify "refs/tags/$_tag" || error "tag: \"$_tag\" =
does not exist"
>
> Line longer than 80 columns...

Ok, the 'error "..."' will be on another line in the next version.

>> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
>> index 0680dec808..886a9e3b72 100755
>> --- a/t/t5500-fetch-pack.sh
>> +++ b/t/t5500-fetch-pack.sh
>> @@ -30,7 +30,7 @@ add () {
>>       test_tick &&
>>       commit=3D$(echo "$text" | git commit-tree $tree $parents) &&
>>       eval "$name=3D$commit; export $name" &&
>> -     echo $commit > .git/refs/heads/$branch &&
>> +     git update-ref refs/heads/$branch $commit &&
>
> I think we have to be careful here to quote both "refs/heads/$branch" and
> "$commit" here, as a bug that introduces spaces into $commit or $branch
> would have been caught earlier, but not now, unless we quote.
>
> This goes for all introduced `update-ref` calls.

Ok, they will all have quoted arguments in the next version.

> Maybe even for some `git rev-parse --verify` calls.

Ok, I will take a look at that.

>> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
>> index 8f5c811dd7..c3b89ae783 100755
>> --- a/t/t9903-bash-prompt.sh
>> +++ b/t/t9903-bash-prompt.sh
>> @@ -148,7 +148,7 @@ test_expect_success 'prompt - inside .git directory'=
 '
>>  test_expect_success 'prompt - deep inside .git directory' '
>>       printf " (GIT_DIR!)" >expected &&
>>       (
>> -             cd .git/refs/heads &&
>> +             cd .git/objects &&
>>               __git_ps1 >"$actual"
>>       ) &&
>>       test_cmp expected "$actual"
>> --
>
> This one looks wrong.
>
> Upon cursory review, one might be tempted to assume that the file is now
> written into .git/objects/ instead of .git/refs/heads/. And the patch
> context provided in the email is not enough to see (gawd, I hate
> mail-based patch review, it really takes all my Git tools away from me).
> The trick is that `actual` points at an absolute path:
>
>         #!/bin/sh
>         #
>         # Copyright (c) 2012 SZEDER G=C3=A1bor
>         #
>
>         test_description=3D'test git-specific bash prompt functions'
>
>         . ./lib-bash.sh
>
>         . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
>
>         actual=3D"$TRASH_DIRECTORY/actual"
>         [...]
>
> So the remaining question (which probably wants to be added to the commit
> message together with a hint that `actual` points at an absolute path) is=
:
> Why not `cd .git` instead?

I think anywhere inside ".git/" should work, so I guess
".git/refs/heads" was chosen to make sure that adding anything after
".git/" does not change the result.

I think I can drop this for now and change it later in its own commit
with related explanations.

Thanks,
Christian.
