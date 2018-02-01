Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ED6A1F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeBAKWQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:22:16 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:35200 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeBAKWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:22:10 -0500
Received: by mail-ot0-f177.google.com with SMTP id a2so5018980otf.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 02:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1dIq39/GX7c3rdxJ6Rm7Qr1CF7239pAep5bCW0go1zs=;
        b=Hj8FMjtOWQFwjNemdoBECo3OdHZxxfhUMMeYp1UJd6ilMOmpdLD9rvPWAj2aifjDKz
         jRM4tMIpog5chGz0dn9noEMDMaRlHow0vm3P1JGwSr7XhUHRooqSeYaBXAIiC+RzUUwn
         SK8SKkOi43VgpRr5an/jMNU6Z87/xWxPKgH8/arqUYm4+dAJzGrXumYU4uS/PXD/on+m
         6BrYugBc5CJnn42gRlHScug7B2c5l1lnjE16j7w5scde/SdgmmnOonyxvN1uOWbG9U+d
         bqmPKiBiGntGNzcAieYNxI2lpZHqODr115n7pA7ilh7a74DTvr8Z3nCignO1HLCaq1VL
         xhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1dIq39/GX7c3rdxJ6Rm7Qr1CF7239pAep5bCW0go1zs=;
        b=r0GT5hGN1hypYrNQ6qUJdTuK/eauSUXMujyVVMgPgXwbNQX7uXL+RewytttQkT37YM
         HCxrw6MYVM4Mht7/qHvmUPug+i/XI0Lbtw6oFdPdu9XIH4SNHXzM34UBIucAQIEcHxxq
         bhaID2fHL2CxvTpQ1yHuvy00f387cZRDh3TpaBZW9TwmqfgECA9RUh74Z2rkHgAU4297
         BfOtc2XTnxJ49L0beyG+YJbVvjp7x8iK8aYf6KgPprJTqYTMrMcIullIpBgcc/eC6MnK
         Pa5MlqmEysicxsCxe3CFq9fvxPQMlDowb0vqC8QkeckUV3yoxCQGc7/hR1qbB9Eptc5v
         Y0lQ==
X-Gm-Message-State: AKwxytej7NQC871iz7rZvzGkbtYFaf2uC8b+uXCliMzmMnD7SgTSAIpQ
        qcYK4SbDR3SUuFxo8DJqSvDV7SlaG7hdOeUqnkI=
X-Google-Smtp-Source: AH8x227v7vWuiN2z64p0kzIztxkKhEXNlC1WF9cLuO4LOYbwcs9o0FN6OeoiAO8XZ+lMVSrGpJrOigRx6l0iH4I/SfA=
X-Received: by 10.157.53.5 with SMTP id o5mr6142041otc.181.1517480529206; Thu,
 01 Feb 2018 02:22:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Thu, 1 Feb 2018 02:21:38 -0800 (PST)
In-Reply-To: <CAPig+cSLYDJaxCyAH_zK0cat2-60OZGWGy_ZLHwitHfZ7oA78w@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com>
 <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
 <CACsJy8B0D=u5fGA2QWuG6QG-fmReg=GayC54+pSFjXHDrnKh3w@mail.gmail.com> <CAPig+cSLYDJaxCyAH_zK0cat2-60OZGWGy_ZLHwitHfZ7oA78w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 1 Feb 2018 17:21:38 +0700
Message-ID: <CACsJy8D5iGVDHKoMeQjm+Seea_pTixsb8Xq6D1w17Y9M42iAPw@mail.gmail.com>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 4:54 PM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Wed, Jan 31, 2018 at 7:05 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Feb 1, 2018 at 4:04 AM, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>>> On Wed, Jan 31, 2018 at 6:05 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
>>>> Dangerous/Unpopular
>>>> options could be hidden with the new "NOCOMPLETE" flag.
>>>
>>> I wonder if this option should be named DANGEROUS rather than
>>> NOCOMPLETE to better reflect its intention.
>>
>> It's not only for dangerous options (I forgot to mention this in the
>> commit message, I will in v3). The --continue|--abort|--skip should
>> only show up when you are in a middle of rebase/am/cherry-pick.
>> git-completion.bash handles this case separately and only put them in
>> the completion list  when appropriate. --git-completion-helper must
>> not include these or the trick done by git-completion.bash becomes
>> useless.
>>
>> Interesting. So we now have two classes of "no complete". One can't be
>> configurable (--continue|--abort|--skip) and one can. I'll use two
>> separate flags for these, though I'm not adding the configuration
>> option right now.
>
> I don't see that as convincing argument for two classes of "no
> complete". Since git-completion.bash already special-cases
> rebase/am/cherry-pick for --continue|--abort|--skip, it is not far
> fetched that that special-case treatment can be extended slightly to
> also filter out those three options from the list returned by
> --git-completion-helper.

I agree that is possible, but it's a bit tricky to do the filtering
right in bash (all options are sent back as one line instead of one
per line, which is easier to process by command line tools).

On top of  that, I think we want git-completion.bash to be fast, the
more commands we execute there, the unhappier Windows users are. It is
too possible to do this kind of filtering just once, before caching.
It does not fit well to how I designed __gitcomp_builtin so I need to
sit back and see how to sort that out.

Long term though, I think we would want more and more completion logic
built in. One of those things I have in mind is to let
--git-completion-helper (or some other new option) to provide
completion for possible option values (e.g. true/false, values for
"git merge --strategy=3D", "git status --untrack-files=3D"....). That may
also include completion of --continue|--abort|.. in C code, something
like this roughly

# separate command blocks because we still need to cache them in shell
if [ -f .git/rebase-apply ]; then
    __gitcomp $(git $cmd --git-completion-helper=3Din-progress)
else
    __gitcomp $(git $cmd --git-completion-helper)
fi

which means eventually we have to flag these options differently.

Having said all that, these are the things I imagine we _might_ do. I
have not really thought it through and nor do I have a clear plan
forward at this point, so they may end up being just rubbish thoughts.

> So, if that special case is handled entirely by the completion script,
> then that leaves only the "dangerous" options, which requires only a
> single flag.
--=20
Duy
