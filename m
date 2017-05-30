Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459E42027C
	for <e@80x24.org>; Tue, 30 May 2017 18:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbdE3SvO (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 14:51:14 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36211 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdE3SvN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 14:51:13 -0400
Received: by mail-pf0-f180.google.com with SMTP id m17so80019858pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D0oApLwDW7FmeknkD/iAXfb3ydJsPzBfpY1CoZSi9Lk=;
        b=AeHZEXMAPtRQOdm2x0Uvo5FVBhEZH9l45+SlaXZiATXiTCUJ//Nz3/9qf05ORKH+tl
         qnCanBu136BU69SgV5e/RXF7i30lcVeTSnmRnvdL8UJU7clTfSYHcEJeKdTkRgE3ukpX
         z099ls6nTh9rEZHohutSFVsNmUIUyC7FgvSTEI16dIhVBMP8vKb5DylHLDaI0Jp6nt2G
         Lanjp/ieTGLOiAX34vZWB4OmyR51lKcldyzwDcK4qUKUvtx/YDzRZQ4qvcec0TBpD0ur
         ofILAcULf7kCUQd2KMJzcWAvDS4j7C7ELq1CMkbnG2tg0tx+DBy0J0d3/QjpyEumscLR
         Nw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D0oApLwDW7FmeknkD/iAXfb3ydJsPzBfpY1CoZSi9Lk=;
        b=DnlBnqUa4Vr1E1wRT7SbA1R2XDyeLZw/5UAd17toafT5fZ8ZpM3z5StpE1o2PlvQ1Y
         ijnjAoB2Qna9MOzSCxS1WGquJ/VIo4uGFPW07eGnr7a/PeTGFHRuvmA6F4XLdkv5GGsC
         fbtvAWi5R6aB7tYGWkvV1hpd7KFapXQDLuTpv4dpOdtdiQQS7CjQsS1MSnwRhI4WaKX/
         ACY0BX3c6SOZAAGyF/NUcXvW2GE5xzEoPQc3HQwrE4qFvn3Aq/nQ+Atk6wOOXCdbMUpa
         Z9eehrfeMFjOGjG5Zn9D0eBPcgPrGy6g2GQJWTdJR20OxBZREJCAmDxRdF/CHydwqKTu
         u/mQ==
X-Gm-Message-State: AODbwcBlX3DTRNJRLr5QgyJ2F9hfyvTGcOjZsT4sV0a3j4xJvQ4lJBGS
        VHYDvMNwmOtDxeCvWH7F37iDAzK+/zQFHxY=
X-Received: by 10.98.205.65 with SMTP id o62mr25087427pfg.105.1496170273038;
 Tue, 30 May 2017 11:51:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 11:51:12 -0700 (PDT)
In-Reply-To: <20170526033510.1793-6-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com> <20170526033510.1793-6-gitster@pobox.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 11:51:12 -0700
Message-ID: <CAGZ79kb2LJ-aqDq9o7Z015aNYo0zoK5DdwDGyABOe1V8ifF2wg@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] config.mak.uname: set FREAD_READS_DIRECTORIES
 for Darwin, too
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:

Do we have any reasons for that, or pointers on the mailing list, that this
is a good idea or needed? Does it fix a bug or enable a new feature on Darwin?

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index a25ffddb3e..1743890164 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -110,6 +110,7 @@ ifeq ($(uname_S),Darwin)
>         BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
>         BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
>         HAVE_BSD_SYSCTL = YesPlease
> +       FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),SunOS)
>         NEEDS_SOCKET = YesPlease
> --
> 2.13.0-491-g71cfeddc25
>
