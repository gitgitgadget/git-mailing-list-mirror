Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817DE1FAA8
	for <e@80x24.org>; Mon, 15 May 2017 11:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934164AbdEOL3J (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 07:29:09 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35791 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdEOL3I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 07:29:08 -0400
Received: by mail-ua0-f195.google.com with SMTP id e28so9747908uah.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gQ+5F1i1Q/nxLBbD9km8UZgmNYku5iKlSswwWAhfqgg=;
        b=NU8sBN4ynOXXqC8bmaYdRkVC3zlBql/iaNLuimUGoreXMba97yShHwU1OMgoIghONT
         pbqhj/Lg46imxa4JCuOAp8T/Tn3j5W+n2+dzEYwJVgMH1rpfQzInmcZu/DmEk8eY6a1p
         rax2ZTE+hgOzxjovMpPjeDOPmB2UtXx3L/on37V/hNkhmvFoRfu40PJbzFfs6tgXbU34
         0gSAfEs0K6y5SSxRrvaMLk0LShC558kPmh59fohzaLhP66ggsnJG7FXEZMpDUXtpqDRS
         4Yu3wt+BZXPiKX0CkytdZ7rRBO6KsjNxbeZ3MgdXvvEdyHTvowayRnXzAt3eXiDjO5Y+
         SC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gQ+5F1i1Q/nxLBbD9km8UZgmNYku5iKlSswwWAhfqgg=;
        b=ktc8VwGf4QUNAb9vA7Mej51ZB+Rr0QpAm/KQLEfLdcPJfNr2CN6oWFRkf0X+Wz74o0
         cxPLZV1/w7T25QzWR/NTjETwBeAqYDFtioDh1cfnZY2vl2wReYbgmQNt7pP1pO1q1P8F
         OAzJJZgo6mGWgmrcTLWkqhAwNWKuILrGmzCrBhxHMKJ2a5SNAITAsZC0T8K6wg4yEEaG
         4v9bturWFjRPIxaPl94WGF5/ZZ/Ef6l7Grgj67oOWi1/yxuaoWDd06+Z6dmuKfrVPzIh
         vRYD8PQ9/rz96rBR9sSv41xxb6KmCE75ysIjLyNtocq0yih3Ni/HgpoqVQgpiclE2y12
         ufyg==
X-Gm-Message-State: AODbwcBhu+VRkWG1ROwhOS7pDbfpJr9DuS7Zn3AZvRfG1DhV0j80taiV
        Z7C0316OU2fOjb5t7/sz2VwM54L+iA==
X-Received: by 10.176.2.98 with SMTP id 89mr2774250uas.152.1494847747939; Mon,
 15 May 2017 04:29:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Mon, 15 May 2017 04:29:07 -0700 (PDT)
In-Reply-To: <20170515110557.11913-5-szeder.dev@gmail.com>
References: <20170515110557.11913-1-szeder.dev@gmail.com> <20170515110557.11913-5-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 15 May 2017 13:29:07 +0200
Message-ID: <CAM0VKjkr+EBEErQZxW-prrcdAyF4D-icU_ao9vvO3yJ1HWhmhw@mail.gmail.com>
Subject: Re: [PATCHv3 4/4] clone: use free_refspec() to free refspec list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 1:05 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> From: Jeff King <peff@peff.net>
>
> Using free() on a refspec was always leaky, as its string
> fields also need freed. But it became more so when ad00f128d
> (clone: respect configured fetch respecs during initial
> fetch, 2016-03-30) taught clone to create a list of
> refspecs, each of which need to be freed.
>
> [sg: adjusted the function parameters.]
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 4144190da..4bf28d7f5 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1120,6 +1120,6 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
>         strbuf_release(&value);
>         junk_mode =3D JUNK_LEAVE_ALL;
>
> -       free(refspec);
> +       free_refspec(remote->fetch_refspec_nr + 1, remote->fetch);
>         return err;
>  }

Erm...  I should have given a bit more thought to this last patch,
shouldn't I?

First, the unchanged commit message is now (i.e. by using the parsed
refspecs returned by remote_get()) completely outdated.
Second, while it properly frees those refspecs, i.e. the array and all
its string fields, it will now leak the memory pointed by the
'refspec' variable.  However, why free just that one field of the
'struct *remote'?  Alas, we don't seem to have a free_remote()
function...
