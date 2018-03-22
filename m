Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA291F404
	for <e@80x24.org>; Thu, 22 Mar 2018 05:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeCVFNa (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 01:13:30 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:43241 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeCVFN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 01:13:29 -0400
Received: by mail-oi0-f44.google.com with SMTP id y27-v6so6326130oix.10
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 22:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TfulljaKRnIJmE/ox/+0/YK+UDjjoJyMIMUE3jOsaTg=;
        b=aKMn1nvItu5e3sgSqNkEopOfPbJ2b/+bbKiwkpIM6XNirh2CcQHHMTlM+KY4G7X1tP
         2f4C7F+uPJ5rud3b8S7PicqGhOsmt2NTgJT+tt1V2Umt5Am5/CyXgZH4znWPtkrUWWI2
         z+n5gMFqaMPL7MTKhRBMndOVeif1arOXrKCd9rr0h28zD5RcYUvuAnaSUjO1gYHGn5dt
         fAPjlAROwpUHiWdOUXc3ZqwiF+6MZ4OOi7aQvpgsRTrO9g/efEyBhZKlcPl2iwuPkH24
         hjowk4+aShFgL2YLy2Wm5lPos0ba8wFaFXkIZz+OGCRR70AosCRhurtZ6Ngs0kICUlVb
         OCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TfulljaKRnIJmE/ox/+0/YK+UDjjoJyMIMUE3jOsaTg=;
        b=dm7nO3q5Qd0L3sTjrHVfIdmE4KNN+KeVf+sVxxq0Dr5Nu5h2hfpk/Bybd751zvtX9f
         TM73LkygXoUwZG2NpY4UIq/vcdiS2Z4u6Rig6t/Aiw5BRvupWJXA6nlb0N8UzlOP9LqJ
         TJvzq+tnQdAab0ifD+tS+P/IeMr8tmmVg2dJiujSD7M0nGhtqMGK/QG0tigTp0mMYuVy
         ms+Bo70TqHdjE70eYTMeh2eGYfDWaFillUJSvT+j/tLBqK7Mj4EQzgbTTK7R42tt4lhF
         MAx07ZFNJ51aLcPIbFwt6aT5L4ihbZGAzksJ4ua8VQoChQA/v0tkwFH7f0rW9EUhg+ew
         up5A==
X-Gm-Message-State: AElRT7GC7CjgK0dO2tBlFPZ8+F3o/yVnVsYpXrsETxm+mUbMU6kKyzjh
        T8+lhE+HSseGJhetb1ZbKhgwFA35OsHPx7o8Aoc=
X-Google-Smtp-Source: AG47ELsCnqZNU42Mcl+hRWXBHBIIni2tk6Afa3mJg99Ktq2ThPdQ3XMEJFWuk+GUx/9SrirISIhSmj9MG8/ZRFWCPwc=
X-Received: by 10.202.206.13 with SMTP id e13mr14024503oig.34.1521695608588;
 Wed, 21 Mar 2018 22:13:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Wed, 21 Mar 2018 22:12:58 -0700 (PDT)
In-Reply-To: <xmqqd0zxno0j.fsf@gitster-ct.c.googlers.com>
References: <20180321193039.19779-1-pclouds@gmail.com> <xmqqd0zxno0j.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Mar 2018 06:12:58 +0100
Message-ID: <CACsJy8CWWSixQpXDh+q108j4xF8vpm5gsj2u3gJEgW=2bnXQHA@mail.gmail.com>
Subject: Re: [PATCH] completion: add option completion for most builtin commands
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 9:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> These commands can take options and use parse-options so it's quite
>> easy to allow option completion. This does not pollute the command
>> name completion though. "git <tab>" will show you the same set as
>> before. This only kicks in when you type the correct command name.
>>
>> Some other builtin commands are not still added because either they
>> don't use parse-options, or they are deprecated, or they are those
>> -helper commands that are used to move some logic back in C for
>> sh-based commands.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  contrib/completion/git-completion.bash | 276 +++++++++++++++++++++++++
>>  1 file changed, 276 insertions(+)
>
> Wow, just wow.  It however looks a lot of boilerplates, e.g. looking
> at these, we notice ...
>
>> +_git_blame() {
>> +     case "$cur" in
>> +     --*)
>> +             __gitcomp_builtin blame
>> +             return
>> +             ;;
>> +     esac
>> +}
>> +
>>
>> +_git_cat_file() {
>> +     case "$cur" in
>> +     --*)
>> +             __gitcomp_builtin cat-file
>> +             return
>> +             ;;
>> +     esac
>> +}
>> +
>> +_git_check_attr() {
>> +     case "$cur" in
>> +     --*)
>> +             __gitcomp_builtin check-attr
>> +             return
>> +             ;;
>> +     esac
>> +}
>
> ... the only thing we need for the above three is a table that says
> "use blame for blame, cat-file for cat_file, and check-attr for
> check_attr".
>
> And that pattern repeats throughout the patch.  I wonder if we can
> express the same a lot more concisely by updating the caller that
> calls these command specific helpers?
>

Yeah. I almost went to just generate and eval these functions. But we
still need to keep a list of "bultin with --git-completion-helper"
support somewhere, and people may want to complete arguments without
double dashes (e.g. read-tree should take a ref...) which can't be
helped by --git-completion-helper.
--=20
Duy
