Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDFC1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbdBMWiB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:38:01 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:37906 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdBMWiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:38:00 -0500
Received: by mail-it0-f50.google.com with SMTP id c7so6817569itd.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 14:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sgbz6CdVEYjY8Ni7FgqX84HDDVlq5nm1YJN4SiD4+Is=;
        b=JLFVyU0MTB91odHo2EhxKBA6eAZps+v92i2kR9cxbZzd9fSBUQ0l8a8Fdjq+hnTopW
         7F7WTgCK80HdSgHusd7ivi1Zo6tug1xaonWnYfAn0xUirgxC3VG8YRrS01No0H0bVj3b
         SG8UsqktS7ARmcxsqAXo+5fmIb4hYwpzYJef3imhQBOSGHppmdOyoAH/g9aOSuWEcCee
         LWbH6BWSdrA8DZeyolYZR5JBqisfmITCAN9+5cT2C9ActwJ8WRBS2vR7tC5Esd78dVSL
         iJtXgVSE0FevGa4YAC2zU/Amt7F0AatJm11fquXzCUl2vufMrN9w2Oau4DzAO/rx5YxR
         QnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sgbz6CdVEYjY8Ni7FgqX84HDDVlq5nm1YJN4SiD4+Is=;
        b=LZRBKrzlm8PpQZCiNwTC1JU+YUCyoA89GL6d62IMWXkbXK/VT3usLlI/BSgr9NoEHx
         q5Ku6hcAWmI+A8CNPzFjKKrjU0mXRMcQ4DeoT8jIAwOKASWsYPBUKrXUhvFLRUglbKQl
         Va79/2ddZwlZxCCUKXc9Va5saoUqQnhbnAh5ASVE8zG4qIwtJnXrGnrnsynRn6jMLFPF
         QIInymtwaz1Qi+TZmeR/Vlr6j1paRI9jBnujd1JRuMcIgZkgJ4E52M9wP/LFd+scb31B
         0Zv2+QdvqZQCwGB3WopccbfgND/JoPWlvrcguYInuxmbeAQ2ToxKrTVUOm/QUvHvELxy
         IpDg==
X-Gm-Message-State: AMke39kjCTZjW2RUPbe28YO9QcxSmuewpe3bReS7jwfqetuhvt8iuiIXNahVQw81s0BkDn/FmR2waucXHvHojUq2
X-Received: by 10.107.3.160 with SMTP id e32mr23412362ioi.52.1487025479489;
 Mon, 13 Feb 2017 14:37:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Mon, 13 Feb 2017 14:37:59 -0800 (PST)
In-Reply-To: <20170213152011.12050-7-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-7-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Feb 2017 14:37:59 -0800
Message-ID: <CAGZ79kYkc-_=RiK1uJ+ndhQu=B8u=UDVusXZu-dYe7KnGNye3Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] refs-internal.h: correct is_per_worktree_ref()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 7:20 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> All refs outside refs/ directory is per-worktree, not just HEAD.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  refs/refs-internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index f4aed49f5..69d02b6ba 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -653,7 +653,7 @@ const char *resolve_ref_recursively(struct ref_store =
*refs,
>
>  static inline int is_per_worktree_ref(const char *refname)
>  {
> -       return !strcmp(refname, "HEAD") ||
> +       return !starts_with(refname, "refs/") ||
>                 starts_with(refname, "refs/bisect/");

you're loosing HEAD here? (assuming we get HEAD in
short form here, as well as long form refs/HEAD)

>  }
>
> --
> 2.11.0.157.gd943d85
>
