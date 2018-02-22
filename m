Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CAE1F576
	for <e@80x24.org>; Thu, 22 Feb 2018 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeBVJOY (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 04:14:24 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34364 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeBVJOX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 04:14:23 -0500
Received: by mail-ot0-f193.google.com with SMTP id n74so3813656ota.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DcYeYtYDJMLf/qq6/gl6qYqJqeVxi7HQ+CUlncR4s00=;
        b=BJqEyBxlhAvfCV8BQrRog5WigskV825rYFzuBBge/iXAjPZBmrJypOFJwZyiUJ6WSp
         bI5bpXCOaT5sR5koOIZ5fhvAdvsukNLGVdYCjmkXti2ilxhLeF9CPvBuBW96IVdh+5dn
         7UkvwS8GN4mh8xzRN/u2XzAwSvZNOIwkBgJtnsALcw9CZKlqeLjzlwI644KZ+RuZSbi5
         IGHAUzlHo5HFJDEb9fFSjZlvgLJ152vtxo2nYlhsS13MGADcxPdsZ8dHPYaN2d10QLwg
         TRY87+3OTlHovj3JIVw6Hr8Ku7OB/493tkbUSdrKKRqZFIsg+aupzf8mstF6GHfCFLqv
         wuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DcYeYtYDJMLf/qq6/gl6qYqJqeVxi7HQ+CUlncR4s00=;
        b=pwNacm/rQhsm5IZjnyEeOLaoHuHGtVG84a3VKZbD1ClhZbOTkFHiSKQHmtC3TfJE98
         xh9qn9VllHW/rXsQHDexe47dzv2hZCf0a14Oyc5LtSXBBpkOULPzAjGKnJdhFN6c0Zhs
         RYkEV3WqXKvGL0+4dMquJrhjlxVJCnpt8F8TTqrnQ6F41q4Cr6l1y3YLKQo+tMfQFrtk
         dVh0i2idCRyIKoyUozHTqqdDIiNNaT+cO/nAbaZPZ82i+F7HTnvTlyeWaNIbkpAE39mm
         2BkHpv4nLoOZEYhc27RCrF/XmT7mo0tTpqpX51RNGOZLLX/v+MBVJCS7i+V76lDTZkt3
         v/rQ==
X-Gm-Message-State: APf1xPBlsrLmOazT8Y2Hviz3GmEgTtzrZ9lXmAK2yD6wLDnC58BAX84x
        49KColAaSHDHB/QExOAjFBWD/hHhaRPl3d4HTfQ=
X-Google-Smtp-Source: AH8x224WkNcEMNYvoFvKZxfTFGuyC/CBMQLy9ZmPaP2UwZbIkc4DBASz0yi/UlGgzRL6yYuB9J4Y55s91WD9xfOSIgM=
X-Received: by 10.157.24.42 with SMTP id b39mr4774168ote.356.1519290862318;
 Thu, 22 Feb 2018 01:14:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Thu, 22 Feb 2018 01:13:51 -0800 (PST)
In-Reply-To: <CAM0VKjmFEyr4qHdc1qfW0M_RZ7cM9bCfsn-M4Rapzt6CPhZE1g@mail.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-7-pclouds@gmail.com> <CAM0VKjmFEyr4qHdc1qfW0M_RZ7cM9bCfsn-M4Rapzt6CPhZE1g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Feb 2018 16:13:51 +0700
Message-ID: <CACsJy8CWdJJigQSEjGuhoH1URGY8=YSAHiqhaGBZK7Zr8GZUGg@mail.gmail.com>
Subject: Re: [PATCH v3 06/42] completion: use __gitcomp_builtin in _git_am
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

On Wed, Feb 14, 2018 at 7:53 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Fri, Feb 9, 2018 at 12:01 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> The new completable options are:
>>
>> --directory
>> --exclude
>> --gpg-sign
>> --include
>> --keep-cr
>> --keep-non-patch
>> --message-id
>> --no-keep-cr
>> --patch-format
>> --quiet
>> --reject
>> --resolvemsg=3D
>>
>> In-progress options like --continue will be part of --git-completion-hel=
per
>> then filtered out by _git_am() unless the operation is in progress. This
>> helps keep marking of these operations in just one place.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  contrib/completion/git-completion.bash | 11 ++++-------
>>  parse-options.h                        |  4 ++--
>>  rerere.h                               |  3 ++-
>>  3 files changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion=
/git-completion.bash
>> index 1e0bd835fe..eba482eb9c 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1105,12 +1105,13 @@ __git_count_arguments ()
>>  }
>>
>>  __git_whitespacelist=3D"nowarn warn error error-all fix"
>> +__git_am_inprogress_options=3D"--skip --continue --resolved --abort"
>>
>>  _git_am ()
>>  {
>>         __git_find_repo_path
>>         if [ -d "$__git_repo_path"/rebase-apply ]; then
>> -               __gitcomp "--skip --continue --resolved --abort"
>> +               __gitcomp "$__git_am_inprogress_options"
>>                 return
>>         fi
>>         case "$cur" in
>> @@ -1119,12 +1120,8 @@ _git_am ()
>>                 return
>>                 ;;
>>         --*)
>> -               __gitcomp "
>> -                       --3way --committer-date-is-author-date --ignore-=
date
>> -                       --ignore-whitespace --ignore-space-change
>> -                       --interactive --keep --no-utf8 --signoff --utf8
>> -                       --whitespace=3D --scissors
>> -                       "
>> +               __gitcomp_builtin am "--no-utf8" \
>> +                       "$__git_am_inprogress_options"
>>                 return
>>         esac
>>  }
>> diff --git a/parse-options.h b/parse-options.h
>> index 3c32401736..009cd863e5 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -144,8 +144,8 @@ struct option {
>>  #define OPT_STRING_LIST(s, l, v, a, h) \
>>                                     { OPTION_CALLBACK, (s), (l), (v), (a=
), \
>>                                       (h), 0, &parse_opt_string_list }
>> -#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), N=
ULL, \
>> -                                     (h), PARSE_OPT_NOARG, &parse_opt_t=
ertiary }
>> +#define OPT_UYN(s, l, v, h, f)      { OPTION_CALLBACK, (s), (l), (v), N=
ULL, \
>> +                                     (h), PARSE_OPT_NOARG|(f), &parse_o=
pt_tertiary }
>>  #define OPT_DATE(s, l, v, h) \
>>         { OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,    \
>>           parse_opt_approxidate_cb }
>
> Shouldn't this hunk go into a commit of its own?  Or at least it would
> deserve a mention in the commit message.

It's not a standalone change. It is used by the OPT_RERERE_AUTOUPDATE
below, which in turn is used by git-add. Together, --rerere-autoupdate
is removed from the completion list of git-add (and also a few more
commands).

Now that you mention it, the only command that completes
--rerere-autoupdate is git-merge. Since this is "auto" I don't think
people want to type manually. Maybe I should separate these changes
_and_ remove --rerere-autoupdate from _git_merge() too? At least that
it will be consistent that way.

>> diff --git a/rerere.h b/rerere.h
>> index c2961feaaa..5e5a312e4c 100644
>> --- a/rerere.h
>> +++ b/rerere.h
>> @@ -37,6 +37,7 @@ extern void rerere_clear(struct string_list *);
>>  extern void rerere_gc(struct string_list *);
>>
>>  #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
>> -       N_("update the index with reused conflict resolution if possible=
"))
>> +       N_("update the index with reused conflict resolution if possible=
"), \
>> +       PARSE_OPT_NOCOMPLETE)
>>
>>  #endif
>> --
>> 2.16.1.207.gedba492059
>>



--=20
Duy
