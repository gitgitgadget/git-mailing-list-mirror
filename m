Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B33215F4
	for <e@80x24.org>; Tue,  1 May 2018 01:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeEABxf (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 21:53:35 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42758 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeEABxe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 21:53:34 -0400
Received: by mail-qk0-f196.google.com with SMTP id j10so8064867qke.9
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 18:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xEOnRxJEC9zZlsRcfKkXfWum5TRTyzlrC+hNLf5/u40=;
        b=Etc4EEXwjHGRhkw5rbp17E4J4uYubzql2N/pMZmQgjjYrsyjfJi64Sbya5XJ/hzBeO
         QtsqD/rdm5LM/1oT3ppGOWUxsVAM0H00nsS9fNkd11s5IjTDQf/ofKJ+Pfj+ysY/woVH
         28cKNNRdEPWUCpI18tlRpljB1W9SpN78iWMoXu3YEiO6RZDjCZswIppMwLAqb1FRIjs8
         v/AV2FC7SO062MxaFyheMiuPoIB6hEinFAXaQW0MMnVEPKdUY95QNj8I48S7Y5h68rm0
         9ZG1m7jXGG3R8zdS62WwXsNM7bfVOzYQ76gC6bZHfRjnx5wcTQ8oYnUZuoTWXS2qzHd9
         rLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xEOnRxJEC9zZlsRcfKkXfWum5TRTyzlrC+hNLf5/u40=;
        b=mGDdKaN7d4mDUnhpj2WfgIFXtU/fRMQJ/SSdDYlHtwikSoACEozjxlCeYlH0xzwn1t
         cxMyo2vwN6LuqPiYkBTAMVw9j2pnJ+Z9LhTG5C2DHbC7Jr6VbvFaSxSXfUKoztZ2dNwa
         hGfh+UTKMqbyhitESqmsMktlaS4nqA8mgx6J0CAJv9uC1Aado1S20FZQbXU1blRweYpB
         010fV8DoZM9/44HR3WqvDDXaOQm0L5lp0NbTPA/Ypva4Vq9uon01Vz0H221aRZ09QlaR
         ROhwyDH3O52AFKHzN+kjp5sZ509MEG2K57XipbklDSxOT/G3XbeRKhFKVUxtVglpD5cq
         srSw==
X-Gm-Message-State: ALQs6tDna9BumlDvNfMewP114x0gSh1PxNTR4o8A4A1vIrMeISW5D+Uc
        R6k0RYvR+Q0/8QqL13G9V2FzqnxqPWpUqzvunPI=
X-Google-Smtp-Source: AB8JxZpX6npIDKyoUkjz/CG16OS51XtMdIzdn+dEg7IwvZd5AlyvIEu3Otk74iR9o5x3i+SajkM0kEQWvcy6MH33QL0=
X-Received: by 10.55.108.198 with SMTP id h189mr2137668qkc.2.1525139613991;
 Mon, 30 Apr 2018 18:53:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Mon, 30 Apr 2018 18:53:33 -0700 (PDT)
In-Reply-To: <20180501000214.833766-1-sandals@crustytoothpaste.net>
References: <20180430020930.GA13217@genre.crustytoothpaste.net> <20180501000214.833766-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Apr 2018 21:53:33 -0400
X-Google-Sender-Auth: tKVkC9Nrvz7-G9PayEIuohc6ETk
Message-ID: <CAPig+cRucJfzm8Z0XhPa0CMw+LiBdY_b5=bMz0LkezJxvC9qJA@mail.gmail.com>
Subject: Re: [PATCH] format-patch: make cover letters always text/plain
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Patrick Hemmer <git@stormcloud9.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 8:02 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> When formatting a series of patches using --attach and --cover-letter,
> the cover letter lacks the closing MIME boundary, violating RFC 2046.
> Certain clients, such as Thunderbird, discard the message body in such a
> case.
>
> Since the cover letter is just one part and sending it as
> multipart/mixed is not very useful, always emit it as text/plain,
> avoiding the boundary problem altogether.
>
> Reported-by: Patrick Hemmer <git@stormcloud9.net>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -1661,6 +1661,15 @@ test_expect_success 'format-patch --base with --attach' '
> +test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
> +       test_when_finished "rm -r patches" &&
> +       git format-patch -o patches --cover-letter --attach=mimemime --base=HEAD~ -1 &&

Nit: "rm -rf" would be a bit more robust against git-format-patch
somehow crashing before creating the "patches" directory.

> +       ! egrep "^--+mimemime" patches/0000*.patch &&
> +       egrep "^--+mimemime$" patches/0001*.patch >output &&
> +       test_line_count = 2 output &&
> +       egrep "^--+mimemime--$" patches/0001*.patch >output &&
> +       test_line_count = 1 output
> +'
