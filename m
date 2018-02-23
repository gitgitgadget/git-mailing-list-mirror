Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CACD61F576
	for <e@80x24.org>; Fri, 23 Feb 2018 10:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbeBWKl3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 05:41:29 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:46754 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBWKl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 05:41:28 -0500
Received: by mail-oi0-f43.google.com with SMTP id x12so5666727oie.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n9t17GtpUO3gDUNKOvbykSucGIEhGLI9ts7eUV3w7fE=;
        b=eFbcScJBXQgAYIXKM8jyx3pij5uqFYTYmZr0CHcXWRCuLTxbuPiKChp26LqxMVSaW7
         NQu9Xhi1xbFPEviTGPClDHBPn22LqJUefOCMrsuq1ZXz8eN+wW7Xp8JN9a9Sd4t81zNi
         urInkWs3dyeqLDQHm8zTeiQm4fka3NHTbF6ji3xugmN5+PhNyZPDKPEY0urkyeAU4eY/
         iyxgqG78910cWSZ7OVmuGS1VUR1+NW/J5I6ZdIi81U4poTczKFHjOYZhoHBmY8xMUZhe
         8kFSnv3VDEJVLm5Ci4Np0Ncnd2ajPXPwhlXSm4fsllpmhDjjFne7tStvlOb1fmHOxLqn
         Ks5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n9t17GtpUO3gDUNKOvbykSucGIEhGLI9ts7eUV3w7fE=;
        b=gOEAAiqPkfTco3dKUMPIhRSHGWUXyz/bvBcZD2kLbnEru1RHcGzNXnk4gnn5tVk16P
         kBw/9W1g0+PMUQJjefapej0uSbBAXJ+nUiVnBq5msSQW2bojpY+1fDiDLI0jKEvosATx
         Caz0L+vsSrX66/oQ5pAeQF+/8fBJR5ScURhDr9me6VJIKO+bnDpTCLM5g9gIhK1csYSu
         jW3B3QYmcieN/YScwyuB1WKmLMm9KTgW/+6+iVq6WjWvf35RMguVUmZiGIRp09h8j6oo
         bBcHZUDeW+r+P6z7c3gbP2gT4NcxbYIzMbYGfZDmzyVCUtX9jxavnlxDz2E+fjk0U0uD
         9FlA==
X-Gm-Message-State: APf1xPB92cYU4+qReU40DpzQQWWgf+hkVdBtj4VYRG9C0+RtfS+0Jflq
        Ri12fo7I3o6I0o8ee+6oUPJKnIwfyFUahujZsS4=
X-Google-Smtp-Source: AG47ELsNA16aKmvLJZk/Z1V6XnzpGgNEJx3L9yib7/B3S6HVoKtXD8omq2EVWT/pk4NHsCkg3ln5/gTdOZTCBko+PcU=
X-Received: by 10.202.206.71 with SMTP id e68mr653121oig.34.1519382488296;
 Fri, 23 Feb 2018 02:41:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 23 Feb 2018 02:40:57 -0800 (PST)
In-Reply-To: <CAM0VKjkOpQ-bxQJ0FQtqOycKQEfEHywVEuwAQyKRZs9VsDtb1w@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-30-pclouds@gmail.com> <CAM0VKjkOpQ-bxQJ0FQtqOycKQEfEHywVEuwAQyKRZs9VsDtb1w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 23 Feb 2018 17:40:57 +0700
Message-ID: <CACsJy8CEFC56VzQcCzzZKkhvttQc0kUZXDZ55oZXgu=qOuQoUA@mail.gmail.com>
Subject: Re: [PATCH v3 29/42] completion: use __gitcomp_builtin in _git_notes
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:15 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> On Fri, Feb 9, 2018 at 12:02 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
>> index c7b8b37f19..60127daebf 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1835,7 +1835,7 @@ _git_notes ()
>>
>>         case "$subcommand,$cur" in
>>         ,--*)
>> -               __gitcomp '--ref'
>> +               __gitcomp_builtin notes
>>                 ;;
>>         ,*)
>>                 case "$prev" in
>
> Hmm, after this patch is applied, this part of _git_notes() looks like
> this:
>
>         case "$subcommand,$cur" in
>         <skip>
>         ,*)
>                 case "$prev" in
>                 --ref)
>                         __git_complete_refs
>                         ;;
>                 *)
>                         __gitcomp "$subcommands --ref"
>                         ;;
>                 esac
>                 ;;
>
> Note that '--ref' option passed to __gitcomp() along with the
> subcommands.
>
> It would be great if that option could come from parse options as well,

Yeah. This is where Eric's option annotation thingy comes in very
handy. If we can tell git-completion.bash that "--ref takes a ref",
then we can do __git_complete_refs automatically.

I'm not so sure how to fit all things together yet. Just like you said
below __gitcomp_builtin is very much completing options, not values.
Worst case scenario, --git-completion-helper could generate the whole
"case" block to be eval'd here, but that also means non-bash
completion is left out.

So I'm not going to do anything about this yet. Not until I study some
more (and your notes here are very helpful)

> but we can't rely on $__gitcomp_builtin_notes being already initialized
> at this point and the current __gitcomp_builtin function tightly couples
> initializing that variable and completing options.
--=20
Duy
