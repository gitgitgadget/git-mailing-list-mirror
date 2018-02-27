Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCCCB1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeB0V2r (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:28:47 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33018 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeB0V2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:28:46 -0500
Received: by mail-ua0-f180.google.com with SMTP id p12so207328uad.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZZqo+WJBBnPqFP0fNcQHznrBhhEvlFFL7XrMxHwzEU=;
        b=lheetfVkusj2Mthv1p5U7Ob0UUojj7mVvttF9zFbQr8jF0ph+3XeVop6vJRx6DJV1G
         K+9IVw9asCqLNLJxZBZMyd4GGKKsGzFP2AkwQxMSNrJSf7Zw5obnW1vZLXElOHSmtj1h
         oqDu9uuC2tZYmWhIA9LUJJwvhTjxcmZe/UKGrvRyzlCQFDx/K1qUCV/vrTBbIJNbSBWN
         fvfZvMej1QnN8Z2tuKXpHmQf+L6fVkHVsOFqwaCdPuhCe/EaWCiMZVoJSfQ5veCRCuR4
         B9cjBAgvQlKCvV0LIr59QjrFXQyMd5uDlod9xUJ8PjgrkfsRH3DRGrRuvyVs54Dp9f2B
         dpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZZqo+WJBBnPqFP0fNcQHznrBhhEvlFFL7XrMxHwzEU=;
        b=dQwhzCdQYEdi2nBvhr+k36mhyXjS+1oxZI94l3N3i1IWGcL95H1WPKOvBMm12ncRyE
         z1M4QjzsX9V838qv9UmwKH/9ABdHH0Aj+1U5jUBPnrFXtV3yF6BuukqGyFOU9mEEVvNI
         J0DbKjD9jPb2L+ycYcKdi2ziIdXiaYT+tKkh3s62aq3N5xDaMbNiS5ua2Nwr8SNrirE0
         YBRoLwjc3aLC0lf5Dbgho3knXvFGcKhdpeyPB/uYDJCNMYtQqvFHnteDNSlIB1xqbR93
         d7WFgRnUmwB3Ex8u0gazQxjUzF6XNAWyHVOJDHfTw0c7MIO15wYslFl4ZBIWb5IAoMq/
         Xerw==
X-Gm-Message-State: APf1xPCK5g2FVPz8AxT/fAsLGtWq3mEoy8q3IVFP40oxNqlVVdjL+c3G
        6SNJ2F7F8C7b8Fx1IXoRXSuyN6gPybZX9V4xglzXXA==
X-Google-Smtp-Source: AG47ELuGNcLz1tcJa3J+22LWN3LPg+NrKQfnuramc8VMrq3XpRpoV2mGisszduPS8YYd/nE3xa88ECrLPyyEqm2xL7c=
X-Received: by 10.176.33.86 with SMTP id t22mr11599068ual.149.1519766926108;
 Tue, 27 Feb 2018 13:28:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Tue, 27 Feb 2018 13:28:45 -0800 (PST)
In-Reply-To: <xmqqpo4qp290.fsf@gitster-ct.c.googlers.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com> <20180223233951.11154-5-szeder.dev@gmail.com>
 <xmqqtvu2p2kx.fsf@gitster-ct.c.googlers.com> <xmqqpo4qp290.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 27 Feb 2018 22:28:45 +0100
Message-ID: <CAM0VKjnVWZ8Ysp5YyfcStgcBuME0q=usT5MKiAcWyxDwAKk+Fg@mail.gmail.com>
Subject: Re: [PATCH 04/11] t3030-merge-recursive: don't check the stderr of a subshell
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 10:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>
>>> The two test checking 'git mmerge-recursive' in an empty worktree in
>>> ...
>>>              GIT_INDEX_FILE=3D"$PWD/ours-has-rename-index" &&
>>>              export GIT_INDEX_FILE &&
>>>              mkdir "$GIT_WORK_TREE" &&
>>> -            git read-tree -i -m $c7 &&
>>> -            git update-index --ignore-missing --refresh &&
>>> -            git merge-recursive $c0 -- $c7 $c3 &&
>>> -            git ls-files -s >actual-files
>>> -    ) 2>actual-err &&
>>> -    >expected-err &&
>>> +            git read-tree -i -m $c7 2>actual-err &&
>>> +            test_must_be_empty expected-err &&
>>> +            git update-index --ignore-missing --refresh 2>actual-err &=
&
>>> +            test_must_be_empty expected-err &&
>>> +            git merge-recursive $c0 -- $c7 $c3 2>actual-err &&
>>> +            test_must_be_empty expected-err &&
>>> +            git ls-files -s >actual-files 2>actual-err &&
>>> +            test_must_be_empty expected-err
>>
>> Where do the contents of all of these expected-err files come from?
>> Should all of the test_must_be_empty checks be checking actual-err
>> instead?

Ugh, I messed that up.

> And the reason why your pre-submission testing did not catch may be
> because test_must_be_empty is broken?  I wonder if this is a good
> way forward to catch a possible bug like this.

Yeah.  'test -s file' means "exists and has a size greater than zero",
so the missing file doesn't trigger the error code path.

> Of course, if somebody was using the helepr for "must be either
> missing or empty", this change will break it, but I somehow doubt
> it.

FWIW, I just run the test suite with this change added, and there were
no failures.  I think it's a good change.

>  A program that creates/opens and writes an error message only
> when an error is detected is certainly possible, and could be tested
> with the current test_must_be_empty this way:
>
>         rm -f actual-err &&
>         git frotz --error-to=3Dactual-err &&
>         test_must_be_empty actual-err
>
> but then the last step in such a test like the above is more natural
> to check if actual-err _exists_ in the first place anyway, so...
>
>  t/test-lib-functions.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 37eb34044a..6cfbee60e4 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -772,7 +772,11 @@ verbose () {
>  # otherwise.
>
>  test_must_be_empty () {
> -       if test -s "$1"
> +       if ! test -f "$1"
> +       then
> +               echo "'$1' is missing"
> +               return 1
> +       elif test -s "$1"
>         then
>                 echo "'$1' is not empty, it contains:"
>                 cat "$1"
