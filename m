Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643601F404
	for <e@80x24.org>; Thu, 19 Apr 2018 04:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbeDSESA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 00:18:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43040 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeDSER7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 00:17:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id j11so1975704pff.10
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 21:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kw3ctPGxzSllXMVHtA35ONc+RUtoeJV/wEGPUViMFsA=;
        b=OmHQxXK5Uf8BqYOPjTuxjw4HO94RQlimOTVaAU/zwPvwhR48ubO/6J2/Fak73FsM4W
         h8fFhE2a1/6N8zwWu+4O8Vsv60IDYG48b+1J2T8tnEDX7/juvV8a+xC1wI2nyggGNHsq
         30ZU083A/J3iZr+JXLVUwht/eZZ0EjYJQkdiQYDxpMURbmhJzs2K4fjFurqDWSi3i6cD
         iYp/mzrt49E5/phDBCv0+LT6rKwI42m+KGYZvo3T5erwpDh3SvC750R/CGUecOLCspE+
         ER/AiOAel3ISJiIYB5DJILHjHw7Az3djB7+YZfHzspXgK/7P8BnFmOTJw2IoPoDtc2Nj
         ALAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kw3ctPGxzSllXMVHtA35ONc+RUtoeJV/wEGPUViMFsA=;
        b=DHzplGPSfOTJFk1FxV3NOOL763Z61r1XOVRJlVd9uR/foF9fqNyWqu8eVMsqkIlCQO
         Am5uYJkRg/6g/JbYmivGNTF3P6B2S3BCljOPrpbAIuGzxB0Y2NLFmHPaJla5XyxhQ/4g
         BE1DBsbSSxO/hvd4dEgtT4oBe57l3VnW1Q8BhX9+uW+COmQ6spmreg7IT8+9b73hvdR/
         HpvaNsm14jwh4LjRvSq3IA7tXYHKMB2S6Db+bZfJKvooliphknIo79hApYnNNONqzi0w
         86X7E8Q2j+uFx9s9eYpiA2FQfXWj0sDhsScG1nGktMTU/dVF9p+ChN6Ure6mrgldPgKR
         +cog==
X-Gm-Message-State: ALQs6tAjLIXbRvQECOJoZ91/7CSwrfInkXQuOYjNssutOkAy81EqymdJ
        XEsWcUly8JGGSJNN83b8EeypP5kWfEqcNFmlwXk=
X-Google-Smtp-Source: AIpwx49MqjkwI0CqJSZa5M4BMDwD8HFG2DcF4Q8aQAp91gRm066JeeDp2DUk9uI40/UBW9Z0FuhZuWPWQjPKB67v+WU=
X-Received: by 10.98.31.20 with SMTP id f20mr4425623pff.196.1524111478597;
 Wed, 18 Apr 2018 21:17:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Wed, 18 Apr 2018 21:17:57 -0700 (PDT)
In-Reply-To: <20180418205635.GU29831@zaya.teonanacatl.net>
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
 <87y3hn5drx.fsf@linux-m68k.org> <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
 <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
 <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com> <alpine.LFD.2.21.1804170831190.6019@localhost.localdomain>
 <CA+P7+xrebnWe_6P0uGu2yEmXZ0+qjpykjrv39Nhd2hUPzO_96g@mail.gmail.com>
 <xmqqd0yxl6n9.fsf@gitster-ct.c.googlers.com> <20180418205635.GU29831@zaya.teonanacatl.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 19 Apr 2018 06:17:57 +0200
Message-ID: <CAN0heSrrpvRXGi1hzUuRqXcQCOJQcBcLWAWQKXrivx6tkxAsBw@mail.gmail.com>
Subject: Re: man page for "git remote set-url" seems confusing/contradictory
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 April 2018 at 22:56, Todd Zullinger <tmz@pobox.com> wrote:
> Tangentially (and I don't know if it's worth fixing), while
> poking around the documentation which includes urls.txt I
> noticed that git-clone.txt refers readers to the "URLS
> section below" when the name of the section is "GIT URLS".
>
> I doubt any readers would be confused, but it would be
> consistent with the other files which include urls.txt to
> use "GIT URLS" as the referenced section name.
>
> -- >& --
> Subject: [PATCH] doc/clone: update caption for GIT URLS cross-reference
>
> The description of the <repository> argument directs readers to "See the
> URLS section below".  When generating HTML this becomes a link to the
> "GIT URLS" section.  When reading the man page in a terminal, the
> caption is slightly misleading.  Use "GIT URLS" as the caption to avoid
> an confusion.

s/an/any/?

>
> The man page produced by asciidoc doesn't include hyperlinks.  The
> description of the <repository> argument simply
>

Abandoned first attempt at log message? ;-)

> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/git-clone.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 42ca7b5095..b844b9957c 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -260,7 +260,7 @@ or `--mirror` is given)
>
>  <repository>::
>         The (possibly remote) repository to clone from.  See the
> -       <<URLS,URLS>> section below for more information on specifying
> +       <<URLS,GIT URLS>> section below for more information on specifying
>         repositories.

Indeed. Matches urls.txt and the others who refer there.

Martin
