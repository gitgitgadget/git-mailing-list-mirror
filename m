Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731F01F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934855AbeAIS3z (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:29:55 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:43594 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeAIS3w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:29:52 -0500
Received: by mail-ua0-f174.google.com with SMTP id l12so9832942uaa.10
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JmOiL8MM+ePodlkNyylsYIFq7RtrN4jDtIwM6I1GyWw=;
        b=AlBVcKD2oQXwHJgoL6oFsHV1Yv/znhCrCvqkKvVuSFPPwIEmSLN8HUyw7OaOAlC+4j
         hoglm8pDXgk3hG5a3NcTN+GHEhcCCuDz6H0DTKSQ7TYot8WoEoWFePSzpfzE+TTsXFoR
         4+rhgU8U1b9FDXf0ZnXBW8JsZUaR8PUDgCJwXAM6Duc8S/kvvptbOXna/o5qM9t0fIsT
         5lP7Sts+fQMf2TSToXJiJPwemlAEgKis/mL84leCL//A0UhK1y2QUsz+jhnPU/NSUfQv
         frXsiviV18MtfMgOVKXIYlgabHqnK+JEuid/rWsWxDAKhJ77zgTpRhjhluLvy4GvEiCV
         tk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JmOiL8MM+ePodlkNyylsYIFq7RtrN4jDtIwM6I1GyWw=;
        b=BHTj3du0iqfPqNwfgbVpk5zVxrmT5U8js7PknZay7mP9SBeBJDAnWsPl1uRBUX1JNy
         5ove2AP0QMIuD8+k0S88+R/iwjX6vEv0mUjZyg3NaUzJ+rG+jUneMTN6r3gW0Y39SgXS
         DMeWwoO5yBk/9eV4Wmhu8iXxGjBtwgEwRNmq3Uf4DRwRBC8wxB/KWPY2M4jZAsPoqOfn
         3mP6DhAq32XgHRVWs6ZzXg0JBmv9z9Ou6c+KqpMLZLFVsS755rzxuQTGcar/YozkKDY6
         bCdwgTkPFB8GvECe7RuJygDAap66WeV7LdLL37DkaVL7FfPKzpMRVDzBlW/gROy5wNtk
         BKDA==
X-Gm-Message-State: AKwxytewV1k+v3C9GiLvg3yLFZ84TEVdWngrNhT1fV4YyXHn4bx8PhHV
        31zCFhxRw6sNil2Dw2/A4+LuobeRu3j8PXH6mL4=
X-Google-Smtp-Source: ACJfBostvuChaAjHtIw9pnINEyiOc1G2vk0vgDNMjNreTusiqS6Po4/CqDu795dM/nh/1hMyqy/anfteOZWxD0zrZR0=
X-Received: by 10.176.73.209 with SMTP id f17mr15490147uad.87.1515522591067;
 Tue, 09 Jan 2018 10:29:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Tue, 9 Jan 2018 10:29:50 -0800 (PST)
In-Reply-To: <xmqq7esq7v4j.fsf_-_@gitster.mtv.corp.google.com>
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
 <20171221191907.4251-1-newren@gmail.com> <20171221191907.4251-3-newren@gmail.com>
 <xmqqbmi484tw.fsf@gitster.mtv.corp.google.com> <xmqq7esq7v4j.fsf_-_@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Jan 2018 11:29:50 -0700
Message-ID: <CABPp-BEJS+59FD-1WduHMmtnBBrgS7xDWJm8Z5URrthDp-0Bwg@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: do not look at the index during
 recursive merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Krey <a.krey@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jan 9, 2018 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:

>     > I haven't come up with an addition to the test suite, but I suspect
>     > this change is conceptually wrong.  What if a call to this function
>     > is made during a recursive, inner merge?

Eek, good catch.

>  merge-recursive.c          |  2 +-
>  t/t3030-merge-recursive.sh | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 780f81a8bd..0fc580d8ca 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1954,7 +1954,7 @@ int merge_trees(struct merge_options *o,
>         if (oid_eq(&common->object.oid, &merge->object.oid)) {
>                 struct strbuf sb = STRBUF_INIT;
>
> -               if (index_has_changes(&sb)) {
> +               if (!o->call_depth && index_has_changes(&sb)) {
>                         err(o, _("Dirty index: cannot merge (dirty: %s)"),
>                             sb.buf);
>                         return 0;

Yep, looks good to me; sorry for overlooking this.

Elijah
