Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E6D1F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 11:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeCZLzW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 07:55:22 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:43668 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeCZLzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 07:55:21 -0400
Received: by mail-ua0-f176.google.com with SMTP id u4so2512191uaf.10
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M8xne344BcLL107S7B+meQifsnCIupUqJIOiqxxrSos=;
        b=enZ4i2iC3z01f01tctOIehraKVEC8uU0rWmc3UOcuq94zUPjvHv1C9oUU53J9kMX8S
         bVK5fGZX2myEcinNEdV005spjzBBeVLond3WyP//OzBep779ol1oigO2IEF4EM6H+lAo
         pqHT2PTIzuq6Cv4choapHsYoTZZs7J1ItnlMKBK01jUz6IokgkuvnuM8l5WPyTAM2ea0
         LalQi9NysPGJe7T7GTU2/f4l4KhirNlDdUlJrNm9kJ4E8jvXNtulKDZDcQWsuC0V6DUu
         lo77DniOcavUF2Za9MBkgKOEkJTL5apQAlwbXO6V/ooUf++3rwpIyMKCXwzSdYMP9FFC
         gomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M8xne344BcLL107S7B+meQifsnCIupUqJIOiqxxrSos=;
        b=N1FoOkyjTvQrrMqx7B1KvMFIZtP3eoRn1NxM/dIPIr3oyaLgtkjPuzeTJnax18AJSB
         jOhmQp3JuK2srJi9J1N7RopGA9L57rKH64PbRq+Fjm/eXgUSVJ0sHknQI8AdG0NFYN52
         x05EhCGoPmsqXoQgHi+n6zafKBGiO8W7U8jc262QP+6LEDCSM5hpKx1IfEhKxC/qsHUC
         sIl8qNBP1mJ24zS1VI6j23p3elIXnQQxE10Q3H9PbeXZ70CbxAd24+AX8JcEpc5f++TW
         QQVa9g96+qLCLrgrvITRfSc+tl0o1v3PMDF5O0Th5kxsSvkGiJVlyx+A8p6i3g5umhOb
         JOTw==
X-Gm-Message-State: AElRT7GXq8ZE2nkmob83cXUE0HPok+rvosnaMxoxwr90Th4H+WSTN9mw
        rq6dpfbS7mRYSqAk81Ey55cYfQ1/NwZ5U+C1Of0=
X-Google-Smtp-Source: AG47ELv+GvV5DZmz17sStmQ9AnWeztANQIAnO2R3IfFkJ6wQfxJ5gWkAnMkeSirmmzaMxAKoSJRJIcawZ/8/mGw4T54=
X-Received: by 10.176.67.229 with SMTP id l92mr15999256ual.27.1522065320936;
 Mon, 26 Mar 2018 04:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Mon, 26 Mar 2018 04:55:20 -0700 (PDT)
In-Reply-To: <xmqq7eq2k840.fsf@gitster-ct.c.googlers.com>
References: <20180322141604.15957-1-szeder.dev@gmail.com> <CAM0VKjm3WKkxjEN09Dv1wUnuBf8CSsUvmLjmSVb1fbHTyAdXEQ@mail.gmail.com>
 <xmqqbmfek8ml.fsf@gitster-ct.c.googlers.com> <xmqq7eq2k840.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 26 Mar 2018 13:55:20 +0200
Message-ID: <CAM0VKjnVM6sjkZjQNLtr+rm34=pPfihWzrk6L+r=ky5UZ_JsrA@mail.gmail.com>
Subject: Re: [PATCH] completion: clear cached --options when sourcing the
 completion script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 6:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> I'd say we should just add !GETTEXT_POISON prereq to the problematic
>> tests.

> IOW, this is the minumum required.

Thanks for already committing the fix, I couldn't get around to it.

> By the way, shouldn't we be running the body of these new tests
> inside a subshell?  Otherwise a dot-sourcing by an earlier test of
> these new ones _will_ affect all the subsequent tests.

I don't think it matters.  All new tests first initialize the variable
they are interested in before sourcing the completion script, to avoid
false successes caused by the variable being empty to begin with.

And it shouldn't matter, either, because in the end the users will
source the completion script into their main shell process, and it
should just work no matter how many times it gets sourced.


>  t/t9902-completion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 4c86adadf2..b7f5b1e632 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1511,7 +1511,7 @@ test_expect_success 'sourcing the completion script clears cached porcelain comm
>         verbose test -z "$__git_porcelain_commands"
>  '
>
> -test_expect_success 'sourcing the completion script clears cached merge strategies' '
> +test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
>         __git_compute_merge_strategies &&
>         verbose test -n "$__git_merge_strategies" &&
>         . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
