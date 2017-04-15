Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F17820D09
	for <e@80x24.org>; Sat, 15 Apr 2017 11:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbdDOLfA (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 07:35:00 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35446 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753705AbdDOLe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 07:34:58 -0400
Received: by mail-oi0-f46.google.com with SMTP id f22so109665100oib.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bu/wJiWBcPzBn2p127Gs8CIzpfxTbQYUzobjP4BHjvE=;
        b=Zv93FPuH42yM2QX55vAW4D49eNIWXANC7Flvar007U2sqQOT40IEk13+9OD0AT/j4Y
         vOKWWhujxgIJyg6XeHaViz1Bj86AqZ6bq2jLq0si1CNx72PIVBjLrIQsebDeBLAIDxgI
         3teldppdKozk232i6cPohCLfk8cQAkXp4ZtHbvis6a3ztjcOoYtHg6YVXHRwYIPqGJgG
         +axMKP0dUbJKoZ/U7kHdhtzHCks5zCSK+05IKk9bbC23WIJid9imxq/G8OgV6NF1nZiA
         Zqh0w+UdSH3gm1od/SeLPSHV09wXtXBWX1ypTLB2FAoEru8oUSRl0B7d/m3WxPezQqK3
         6fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bu/wJiWBcPzBn2p127Gs8CIzpfxTbQYUzobjP4BHjvE=;
        b=CDX9GVUtsVdv8yEhYwXMAdIAHkWNZXNq5IToIEbUOX3pIj+GSYSUHQGyHbq1o7FEwZ
         cfaeBNIXVimt9AvGUWwtPz1jKPty8v1I4Odg/vhQFk4510DTy4ZU38TKUahdFbrUASyv
         XlWRTdToLKbHm767dBHS77FBRTZ3k4B6BVQ2cXAVI9xVKbkDuKov/paZowd3JjvFi62X
         ib6v/hUSBeZYWVFAaB5/x1ipqKQVBsje7RhYKFeOEtSL43H5b4dbKwYmEhSl0dk+veVz
         eBEaF6yJD569c1pbcghxweV4hnIHnpimPf8hatwc/agNIzyzW8swg1E+oq2hYmxlf7dR
         BYHQ==
X-Gm-Message-State: AN3rC/6YuYyWbeGiZNKVhlid+lOgRtnygqD9LHSaCGRK5NaicV6C6MeZ
        7lswui8cBjb8FbqohoGnqi6dDIsYaQ==
X-Received: by 10.202.104.12 with SMTP id d12mr968949oic.146.1492256097985;
 Sat, 15 Apr 2017 04:34:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Sat, 15 Apr 2017 04:34:27 -0700 (PDT)
In-Reply-To: <xmqqmvbim6vi.fsf@gitster.mtv.corp.google.com>
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
 <20170412135805.29837-1-pclouds@gmail.com> <xmqqzifim8co.fsf@gitster.mtv.corp.google.com>
 <xmqqmvbim6vi.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 15 Apr 2017 18:34:27 +0700
Message-ID: <CACsJy8A=Pi8uaEumhddzySEywxAS8vau5mv-sEewmuwNUvZp_A@mail.gmail.com>
Subject: Re: [PATCH] worktree add: add --lock option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "taylor, david" <David.Taylor@dell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>>> -    unlink_or_warn(sb.buf);
>>> +    if (!ret && opts->keep_locked) {
>>> +            /*
>>> +             * Don't keep the confusing "initializing" message
>>> +             * after it's already over.
>>> +             */
>>> +            truncate(sb.buf, 0);
>>> +    } else {
>>> +            unlink_or_warn(sb.buf);
>>> +    }
>>
>> builtin/worktree.c: In function 'add_worktree':
>> builtin/worktree.c:314:11: error: ignoring return value of 'truncate', d=
eclared with attribute warn_unused_result [-Werror=3Dunused-result]
>>    truncate(sb.buf, 0);
>>            ^

Yes it's supposed to be safe to ignore the error in this case. I
thought of adding (void) last minute but didn't do it.


>> cc1: all warnings being treated as errors
>> make: *** [builtin/worktree.o] Error 1
>
> I wonder why we need to have "initializing" and then remove the
> string.  Wouldn't it be simpler to do something like this instead?
> Does an empty lockfile have some special meaning?

It's mostly for troubleshooting. If "git worktree add" fails in a
later phase with a valid/locked worktree remains, this gives us a
clue.

>  builtin/worktree.c      | 16 +++++++---------
>  t/t2025-worktree-add.sh |  3 +--
>  2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 3dab07c829..5ebdcce793 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -243,7 +243,10 @@ static int add_worktree(const char *path, const char=
 *refname,
>          * after the preparation is over.
>          */
>         strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> -       write_file(sb.buf, "initializing");
> +       if (!opts->keep_locked)
> +               write_file(sb.buf, "initializing");
> +       else
> +               write_file(sb.buf, "added with --lock");
>
>         strbuf_addf(&sb_git, "%s/.git", path);
>         if (safe_create_leading_directories_const(sb_git.buf))
> @@ -306,15 +309,10 @@ static int add_worktree(const char *path, const cha=
r *refname,
>  done:
>         strbuf_reset(&sb);
>         strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> -       if (!ret && opts->keep_locked) {
> -               /*
> -                * Don't keep the confusing "initializing" message
> -                * after it's already over.
> -                */
> -               truncate(sb.buf, 0);
> -       } else {
> +       if (!ret && opts->keep_locked)
> +               ;
> +       else
>                 unlink_or_warn(sb.buf);
> -       }
>         argv_array_clear(&child_env);
>         strbuf_release(&sb);
>         strbuf_release(&symref);
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 6dce920c03..304f25fcd1 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -65,8 +65,7 @@ test_expect_success '"add" worktree' '
>
>  test_expect_success '"add" worktree with lock' '
>         git rev-parse HEAD >expect &&
> -       git worktree add --detach --lock here-with-lock master &&
> -       test_must_be_empty .git/worktrees/here-with-lock/locked
> +       git worktree add --detach --lock here-with-lock master

I think you still need to check for the presence of "locked" file.

>  '
>
>  test_expect_success '"add" worktree from a subdir' '
--=20
Duy
