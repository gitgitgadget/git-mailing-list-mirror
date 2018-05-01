Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2401A1FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeEAVVU (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:21:20 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44085 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeEAVVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:21:19 -0400
Received: by mail-io0-f193.google.com with SMTP id d11-v6so15089420iof.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DwaPhyOldE8nWGj3rvDNEVscPo4xCcc8cTMScXv/ZRc=;
        b=jCdZVyhilsKaYTGhYBjbcIYf4+WVUlWNt2NuEB5PsswvM7WYoW3USgYuxZcijb9DAd
         WgpDLWrI/CZK440yrJ/EZLLPie7rPjbfpAQK/dUIQ8e493I+nPLUOS7/RHlAbkGeiwsf
         kJ+e3Uu1QFsNr4U86JZrPXrNlKOfCvFGaf6rvZyZscp9U7ViGFhJTx94CLDEsUS8asiX
         z/EYmR9Nx9GGApajJCOM6hWqRNNgtexE8/ZRhawe9yKuRV9Lh3uP7nL8lBgSYcHDCvsW
         wPFT6+ypxYdG4j/64PBGuHqW1GZvGlXRGcbxW3kq4hkf7s9sjOCawDhXFPRS5rJKabdF
         GGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DwaPhyOldE8nWGj3rvDNEVscPo4xCcc8cTMScXv/ZRc=;
        b=bI6jz+uUBMEhiOCDZ48QlNKh7q/2y6ybX4y7sxYa+DEQtOhnNwyDtxDmsZvJVxXEX5
         Ez745Rx7SXauvxWEbOKpKRqm/7h7aye5kRZulO+3YtpGmCGl/Laa9D/AZ+RO5U3dF751
         aVOBeIKJaldgekpPwwPrBdzFEoU8eSdJ+haFvfJKZJc3JODpFxiFcCCPyRHvZNiwDLHM
         1bWstNHqEbHfvtYeckgTuPFkpldGYcd9T/6XC5+hKv6BNXABZUrJvPqPstEJmWPxQ49a
         SkWjI8Dt/fG7Jw3e/HFifUoizC4/NF4BCWkCmyKsB+uwg3Ao1BzRxnHybdkTacQCTnna
         XdVA==
X-Gm-Message-State: ALQs6tDMq5ctPLY0IyxDZUbNj6DJEitzgVGs3rq7bnAhmgksV8GtwNRw
        9Mp0nR1GNEZoobPRY2W0gpzgQNRuVWdZu7SR1L31HwQb
X-Google-Smtp-Source: AB8JxZrtEYMTIsDLwxiNGeeBYwD071cuDP0VqmTiQXAlhCymjHhp5Qz30TTQqUIVk8KfCF40aXFqWyqiabZYMgQWSms=
X-Received: by 2002:a6b:9492:: with SMTP id w140-v6mr261026iod.243.1525209679244;
 Tue, 01 May 2018 14:21:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7c91:0:0:0:0:0 with HTTP; Tue, 1 May 2018 14:21:18 -0700 (PDT)
In-Reply-To: <CAPig+cSbOsdibX588ObTG5_O=Mmp1+pbxiaUFMx-P0jFLLUuHQ@mail.gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180501180908.17443-1-kcghost@gmail.com> <20180501180908.17443-3-kcghost@gmail.com>
 <CAPig+cSbOsdibX588ObTG5_O=Mmp1+pbxiaUFMx-P0jFLLUuHQ@mail.gmail.com>
From:   Casey Fitzpatrick <kcghost@gmail.com>
Date:   Tue, 1 May 2018 17:21:18 -0400
Message-ID: <CAEp-SHWwOin9dbLpYaX+5UFRWpGP=k7zHU_a54AEMc6C9FDCAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: Add --dissociate option to add/update commands
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I will clean up the braces and commit message.

I have to disagree with the 's/reference/dissociate/' comments. It
appears this section of option descriptions mostly copies from the
descriptions given by 'git clone -h', which outputs:
    --reference <repo>    reference repository
    --reference-if-able <repo>
                          reference repository
    --dissociate          use --reference only while cloning
It is perhaps not the best description, but it means to say when
--dissociate is used --reference is only in play for reducing network
transfer, not keeping alternates.

Those expansions *are* certainly off-putting, they make a long line
even more difficult to parse. I just searched that file for ":+" for
those types of expressions and I think a patch to fix them would be
fairly short. I'll look into making that cleanup patch.



On Tue, May 1, 2018 at 4:25 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, May 1, 2018 at 2:09 PM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
>> submodule: Add --dissociate option to add/update commands
>
> s/Add/add/
>
>> Add --dissociate option to add and update commands, both clone helper commands
>> that already have the --reference option --dissociate pairs with.
>> Add documentation.
>> Add tests.
>>
>> Signed-off-by: Casey Fitzpatrick <kcghost@gmail.com>
>> ---
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> @@ -1075,6 +1075,9 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>> +       if (dissociate) {
>> +               argv_array_push(&cp.args, "--dissociate");
>> +       }
>
> Style: drop unnecessary braces
>
>> @@ -1208,6 +1212,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>> +               OPT_BOOL(0, "dissociate", &dissociate,
>> +                          N_("use --reference only while cloning")),
>
> s/reference/dissociate/
>
>> @@ -1575,6 +1584,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>> +               OPT_BOOL(0, "dissociate", &suc.dissociate,
>> +                          N_("use --reference only while cloning")),
>
> s/reference/dissociate/
>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> +               --dissociate)
>> +                       dissociate="--dissociate"
>> @@ -258,7 +262,7 @@ or you are unsure what this means choose another name with the '--name' option."
>> -               git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"$progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
>> +               git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"$progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"$dissociate"} ${depth:+"$depth"} || exit
>
> I realize that you're just following existing practice in this script,
> but it's a bit off-putting to see expansions for the new --progress
> and --dissociate options being done via unnecessarily complex
> ${foobar:+"$foobar"} when the simpler $foobar would work just as well.
>
> Just a comment; not necessarily a request for change. (A separate
> preparatory cleanup patch which simplifies the existing complex
> expansion expressions would be welcome but could also be considered
> outside the scope of this patch series.)
>
>> @@ -493,6 +497,9 @@ cmd_update()
>> +               --dissociate)
>> +                       dissociate="--dissociate"
>> +                       ;;
>> @@ -550,6 +557,7 @@ cmd_update()
>>                 ${reference:+"$reference"} \
>> +               ${dissociate:+"$dissociate"} \
>>                 ${depth:+--depth "$depth"} \
