Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD0D1F404
	for <e@80x24.org>; Sun,  4 Feb 2018 19:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeBDTgQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 14:36:16 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45884 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeBDTgP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 14:36:15 -0500
Received: by mail-qk0-f193.google.com with SMTP id z12so30146796qkf.12
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=aNdpdqc10Dgta18RXDZiwZk3rKnTbc1zMvGlqSLF8Yo=;
        b=LYqZgSBiyzwA7Uv7XhVZds2HOjyu1gOdhny5t+HIsU3m3V78S+A9/+W8/6H5VKcNzw
         86vkXJOxhJMQwLulkB7Jjzx09RE3Qi0SoGyF9p/LsCMJiNIHNCgUMHGDA5pzOHdpnbB9
         0HL17f9op6ZFROrVY9Knq/Am+3QVHymvcHd2tEQUanj5RPZ2mThRk/msfBEdRqIgxT8H
         /Yj7v78Rm9VrAgI0a6M7LgKJDIBV1R40Q6wBg+BgiQhZHxXg9h1vWYhVja7CoswlKxg3
         GwDznFPPWpt6owoGE7zUAdM+WbEkGkUmUg09aVElWDU6qXVFvk/KgyEy3sj37aaZJ2CR
         z+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=aNdpdqc10Dgta18RXDZiwZk3rKnTbc1zMvGlqSLF8Yo=;
        b=KgA7jVO6w7FAqSpBgOPMovTbC9o1KCsh2SFl/qBE16h6N781eMKcCxBrUfBDcJk6qG
         HhQTmW3gtnM7wb/s6pS4TNoeGeDKmN15AFzVHvI5jJYbjr97zh/IKXIoWxs4zrzRPt07
         bXGtEZN24uKkz6nzW6eSlYQ6m6avnAKKCO3Gux1go/4aw9DXHG5f/AEkVwu/x0/NO6Gp
         +GHb7Po43Hj5RlfclVBMDxD9saQT1ApJaPnlYXA7Hg/VGYfJVjDYoiN/1PcmGoZi55pR
         XUEIsNKRs0F8mMgrH6VHSsvM+xmPB62itHGY1jnuFzEs2gGDGSjeNPjp3zNZIo/1o+aM
         zctg==
X-Gm-Message-State: AKwxyteSUiI7L/H+65N3ypADyRg2dvTiw7Mdjef4mfbm1PYipA9lESBE
        MGT0MpCj/RNUkRyYnUltgSJ8U7oVCELRyZeZd4KN4w==
X-Google-Smtp-Source: AH8x224frgS2ixpxBZc/B24GRPCFGFebCMiG+qKUn7LqkVJoTUmq4cD5I6UsMpsThu68vi6fvAp7h4cb2SIeso9CPAw=
X-Received: by 10.55.123.69 with SMTP id w66mr70237743qkc.326.1517772974582;
 Sun, 04 Feb 2018 11:36:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sun, 4 Feb 2018 11:36:14 -0800 (PST)
In-Reply-To: <20180204183037.23162-1-mail@lucaswerkmeister.de>
References: <772ae5fc-5f92-3494-613a-a44c0073e8d7@lucaswerkmeister.de> <20180204183037.23162-1-mail@lucaswerkmeister.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Feb 2018 14:36:14 -0500
X-Google-Sender-Auth: S4FUwrLmFvY9D-JO7qBpc-lcIN8
Message-ID: <CAPig+cSOH-V9aZDALOEX56ENXChexOVWzsgKgtvDULryqP0Kyw@mail.gmail.com>
Subject: Re: [PATCH v4] daemon: add --log-destination=(stderr|syslog|none)
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 4, 2018 at 1:30 PM, Lucas Werkmeister
<mail@lucaswerkmeister.de> wrote:
> This new option can be used to override the implicit --syslog of
> --inetd, or to disable all logging. (While --detach also implies
> --syslog, --log-destination=3Dstderr with --detach is useless since
> --detach disassociates the process from the original stderr.) --syslog
> is retained as an alias for --log-destination=3Dsyslog.
> [...]
> Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
> ---
> Notes:
>     Fixes log_destination not being initialized correctly and some minor
>     style issues.

Thanks. With the 'log_destination' initialization bug fixed, this
version looks good; I didn't find anything else worth commenting upon.
=C3=86var's micronits[1] could be addressed by a follow-up patch (if
desirable), but probably needn't hold up this patch.

[1]: https://public-inbox.org/git/871si0mvo0.fsf@evledraar.gmail.com/
