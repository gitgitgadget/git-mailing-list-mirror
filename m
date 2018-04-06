Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDB51F424
	for <e@80x24.org>; Fri,  6 Apr 2018 07:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDFHE5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 03:04:57 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43192 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDFHEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 03:04:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id s48so156543qtb.10
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 00:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=q8H0F1BY5wff89MJz6ksR3dJsiQ8MBdN8QRSGoAhG9U=;
        b=bgccltWpr4m1n2Yx97xOi3R1FC+WsVNhmWl8F5o2RXOi2Ax0+QEQKKP2/wB8UomJ/Y
         oXeH5KgzbN1cSlRX+nQs1OtFFM2QvHlalD3JCKasu+NceJNDL9VlvwftE3cVZseR0jot
         apLjd+5yAX5AkjjlIbKUddLe6Ol4S/muy33cLuMjRNMlJSM4EA0VZHxUT4/AUsqmPKLf
         BPPHaLdsCVgD62autHCsgLPIQYzKH4w5UHeqQCsQE8B5vv6/9uv4kU510KOFKawBArcK
         OcOuZ0IKSBPuyI2YE7rVz+Oh8jBYdSWC88d3UIR+q+E/kIpZbmEfidn57pHTyGXwJXmN
         HQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=q8H0F1BY5wff89MJz6ksR3dJsiQ8MBdN8QRSGoAhG9U=;
        b=pn12EOOHVBn8nk5RKcWxAfc43eN8u602hjKAWXpIegOtOX0Ask08ufyOkYsVuraIM8
         xDYuTSlvpnrBPomdA1wMbrjKScuqCPsCW2n36GypFR+Vt+7NIkpi5vTf5h9AVxMWlOsg
         oYbhYo/sNon6YEme1UAePGAKTkRGg4I/3EkuE/s9gnfx702ApGsvAjWiXVsMzTfYNV+K
         B1YstSQSIIKBqIsfU70XZ0/FsUjRDVBfTvATv44Da0EUXB2dZs+jb2j1t7heG5E/xNhY
         GwthiZte6GAb+OkpAa1MVQ3Jb/Qf9o+1BgykwN1uIpluILc9toVca7PSw7t75rD7xiAS
         MT9A==
X-Gm-Message-State: ALQs6tA2LNdHHfjAtpTLuRPGpMmC+3UhkRC78hMW2SWsXW34VJDxrdTG
        ADswjl1zjWv1m2/tSVxPB5vXagamedEAJWs9JWE=
X-Google-Smtp-Source: AIpwx49h0nY5CWG/zgnh6CB34HsfJ/YJpjolu9uJZIFfjJvDWXSLUunHoeDq7PFJz0HEHn7oaZRMhPXx5JtsNQ9ip8k=
X-Received: by 10.200.50.174 with SMTP id z43mr35095933qta.250.1522998294134;
 Fri, 06 Apr 2018 00:04:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 6 Apr 2018 00:04:53 -0700 (PDT)
In-Reply-To: <20180406063915.GC2908@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com> <cover.1522996619.git.me@ttaylorr.com>
 <20180406063915.GC2908@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Apr 2018 03:04:53 -0400
X-Google-Sender-Auth: 2m53blJxyB3RfWVx9TyBbGp1ln4
Message-ID: <CAPig+cQPB+74T3YenoZ_oVFGh2c38AbcFdc+yjw6f32Ojestwg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 2:39 AM, Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> In this patch, we support `--type=<int|bool|bool-or-int|...>` in
> addition to `--int`, `--bool`, and etc. This allows the aforementioned
> upcoming patch to support querying a color value with a default via
> `--type=color --default=...`, without squandering `--color`.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -38,12 +38,12 @@ existing values that match the regexp are updated or unset.  If
> +The `--type` option requests 'git config' to ensure that the configured values
> +associated with the given variable(s) are of the given type. When given
> +`--type`, 'git config' will ensure that the variable(s) are of the given type
> +and convert the value to the canonical form. If no type specifier is passed, no
> +checks or transformations are performed on the value. Callers may unset any
> +pre-existing type specifiers with `--no-type`.

Sorry for being such a stickler, but this is still too mushy. The
first two sentences are saying effectively the same thing. One or the
other should be dropped or they should somehow be combined in a way
that says everything that needs to be said without repetition.

If necessary, iterate over updates of this paragraph here in the email
thread until a polished version is reached rather than re-rolling the
entire series every few minutes.
