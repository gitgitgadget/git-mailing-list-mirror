Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13B91FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 20:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdJXUma (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 16:42:30 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:57205 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdJXUm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 16:42:29 -0400
Received: by mail-qt0-f171.google.com with SMTP id z28so32160796qtz.13
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XHyYmTuDHcTa+o5YUGKZvYznNan9e4kb5b7l3V34jus=;
        b=pTxcIHSO8kCI0srHeaJuTFX+x2zOjdW9anffZp9MihfQGtkJ485dIL6++5DMd4nx8J
         nb7MAGsV9J6TD0aWYfQQm0Q4deipebMsENwj3NXFbcffuPFcKp+OaWb51AdO+E5IG/vW
         2KxzGkDTiVTtIwwJfVZ3FBNSe22hLztKdYA349JtdyIuZ5K3nL7cF1nC57EOwI1o9zXa
         o62VgVntKfTBvmstPvgFXneD6PKNjPDXUH3PNk+a3Y6Mi0btG6RGFoldt9S2L69FpO4Q
         ECafvEKfg7cdyzfserydH1P78f5x1cbTEvX0wAiTyfmrANsLnZIzh2dLn84TYZkFxC26
         kvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XHyYmTuDHcTa+o5YUGKZvYznNan9e4kb5b7l3V34jus=;
        b=plqmbRZ03PsZsw6qEMFNC3IZNy6AqHKtPgEAAIT7AOlw+WsCc0xkMJ2ZPfmP/R5ITO
         vTZ2NsmfyPZDjLvc8V3YhPdkDVwMOSfcFuSSNKLdlTY3TQJAvon1LmXAvYcbMtjQadzb
         z+WE5JLDkPfIeUHVidpMg+qjmpqtgYVvLaOmRUZ9LBA5N8qMeHLb/XfeILOIVqq8tK1Q
         CcGd862sdTevsWVKFaQtKc6AzYenYCWoE3QOXg9+0BBua/GqI8jd1vemVLcWTmyKbJu2
         T8flzzeGJ4wkPjyJd226TmYDrHWXImaqEN5XTcoaR970Ht41LZkrsS/6w2+ht2ERHy1d
         qlCA==
X-Gm-Message-State: AMCzsaW0ROo5RQHMNqG0xchQald9J76Lr759aWdV4LhVsTYsuQO19e39
        RindPk7ZKw6RmhZS7mitPFfLOgITHf79mWglJS7rlg==
X-Google-Smtp-Source: ABhQp+QnOg7jYxAPQemsAMnAm8EVLRkB/W/hhm0F7dlFuqH6eeOPPvHspxS+vMilOt1lQperBkwAVtfWThIf+ZL5y5E=
X-Received: by 10.200.8.53 with SMTP id u50mr28416204qth.260.1508877748814;
 Tue, 24 Oct 2017 13:42:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 24 Oct 2017 13:42:28 -0700 (PDT)
In-Reply-To: <9f5c5cd5-9491-3163-60d4-ad36d75981ce@web.de>
References: <20171024185917.20515-1-sbeller@google.com> <20171024185917.20515-3-sbeller@google.com>
 <9f5c5cd5-9491-3163-60d4-ad36d75981ce@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Oct 2017 13:42:28 -0700
Message-ID: <CAGZ79kbJS68qL0=WTZVBfmSDXCii0HT60TGxx2MSiH_cK_tBCw@mail.gmail.com>
Subject: Re: [PATCH 2/4] xdiff-interface: export comparing and hashing strings
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 1:23 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

> xdl_recmatch() is already exported; why not use it without this
> wrapper?

It is exported in xdiff/xutils.h, to be used by various xdiff/*.c files, bu=
t
not outside of xdiff/. This one makes it available to the outside, too.

>> +extern unsigned long xdiff_hash_string(const char *s, size_t len, long =
flags);
>
> Documenting the meaning of their parameters would be nice.

I'll do that.
