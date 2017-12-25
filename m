Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287251F404
	for <e@80x24.org>; Mon, 25 Dec 2017 11:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbdLYL0i (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 06:26:38 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:40724 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbdLYL0i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 06:26:38 -0500
Received: by mail-oi0-f49.google.com with SMTP id w125so22498797oie.7
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lMCqr03/XAzqEnLPJMK4eF+6Juc9phVl52f/T8FeZTs=;
        b=Ia4VmKl3+Cy7W94/98pZ9+FJ0sLjq9rWy4+WiY7Huk/vt9ALnEDBRz+XTXWOmPgemg
         4q413aODphv2ZlRD961yxLM63IHIS9ZSqMZAKytdpP65hQt0qr+lz12ltbeRMLFXjmqV
         ysYXQczahXDwGirYf7xVwXSxKhs9Q9cZ9ypO9FYVsKy0JYtHYklLX6q7/TA9vuppImAB
         3yHrmdxrZZs9uh9+MUJPvVzm5GaMU9QqgoBljGdXsWge14Z0jSzFDdCIxmDfT7eyatBn
         fH0yHsncaWxRNjE9moDKjY23DXCEHpR2ghFjlaNXjUQlqUyELQA2GxrpkYKJVGMUhd0d
         KneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lMCqr03/XAzqEnLPJMK4eF+6Juc9phVl52f/T8FeZTs=;
        b=fVkzIFyblK+PK2Tnv29eXf6RFVnbXSRpRtzJs62ly7qWJ5u4o3Ya+S7awQJj/DHIaC
         jWuWkTGvSCFXd02TIFgvZERavITJRAF0PCXvVy+dTDdLAjL5WASuulkEz3yCXYFymny8
         7WzzNA0SnIwJl0mhh1oaMXuhq7c6QTZtrV3AD8CQyG+bm9KrK/V0YKlvRXV8wcuoKom+
         /otKbadOnPs4wWP7p0ma0VGLse3eo0bZGtpv3c0hwitrQbABbx7M3HzvAqvUaXLf9jhE
         Cuir5htcbBWi8ZSEMUAELJ+cjTv7OEgOknZWEGt21rCRFSvv7XfNaIzoLqJvS+sVd1TP
         5k8w==
X-Gm-Message-State: AKGB3mIKDUGI5vbS7jZkA2ps4fphC3zkTNVJZKXiQnE+YgqYpxJH7Xws
        L1DoRWP5Jx0tTQqUW97zxQ9vNshRH0KlYQR74ys=
X-Google-Smtp-Source: ACJfBotJds2+0nm6k2DauubFKs2qi5on0pkWdZiU9JqW5sWZHAojgXO+DEUf5I74aD7g9q5GF8p4hZhpITOyPEkclVY=
X-Received: by 10.202.82.196 with SMTP id g187mr9511010oib.183.1514201197369;
 Mon, 25 Dec 2017 03:26:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 25 Dec 2017 03:26:06 -0800 (PST)
In-Reply-To: <20171222140032.21180-1-avarab@gmail.com>
References: <20171222140032.21180-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 25 Dec 2017 18:26:06 +0700
Message-ID: <CACsJy8B1FNpq-AYJdcs_gVOxdPSnh-kNaeVykLSSDL1+EW9YjA@mail.gmail.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache bug
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 9:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The untracked cache gets confused when a directory is swapped out for
> a symlink to another directory. Whatever files are inside the target
> of the symlink will be incorrectly shown as untracked. This issue does
> not happen if the symlink links to another file, only if it links to
> another directory.

Sounds about right (I completely forgot about dir symlinks). Since
I've been away for some time and have not caught up (probably cannot)
with the mailing list yet, is anyone working on this? It may be
easiest to just detect symlinksand disable  the cache for now.
--=20
Duy
