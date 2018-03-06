Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673481F404
	for <e@80x24.org>; Tue,  6 Mar 2018 21:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbeCFVFk (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 16:05:40 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:41601 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeCFVFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 16:05:39 -0500
Received: by mail-qk0-f170.google.com with SMTP id w142so36484qkb.8
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=etAH955r3W9Xmv2DcY5e3j7w/ZPENrC+4WMxejqlXak=;
        b=ONVESOiSDJ8zngdOebmW/NFhYKXvS8TkxyNAdbARppVVbAZgN93vJjoy59YJmmX/Zw
         X58cLkVFMWmA7ThNXxaqvU05ZVCrhurSslzlTw/sc/qUlcPZDNnsK29x+ka5cBxyCiTi
         LblLv0w7rW5ro+QRyr/9k2mrsWDA03+stbvGZFxFAEB0D1ytXycJDyaYsg4VAEpqH0Ko
         8houyV27IWQLAsipinSZO1qsphFCJXX7sUJv+QNryPl9/eXIdhbjid0Nt2wb3sRmo28D
         5vQN0k/YQpcZQekHOr5sdcQHNnW3KJtaZSSSiEPrLutEInz0xs6eIjC8nS4WnZB0hrAp
         RPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=etAH955r3W9Xmv2DcY5e3j7w/ZPENrC+4WMxejqlXak=;
        b=qHBg/QlhJGJGMjhz1lrhJCp5qWbJgb5Wi+9xiAONvVypEKoMjXjxiX4hdIa+CgGk9x
         BvXO/rmiiBBvrCo5WAAiuPwJ7iwk7GGiaZZuWrET44hiXaQPHxg9OpzjONf/SkcD/llZ
         o7lS3mfxBpHxizDOxXdlXMtiWtsUEqpOTOMQ2LjMeRnTutjqd9sbFhxXhKdARW1XTZJV
         m89R3HkA0gnmsZaIE8EH0JsdVP/HTT+70kf8MhNAm2sbcrurw8RWb+LommwRZJRInSKy
         AE23xyTYUpvH2SGM8l/5Hoyyt8ihm/x+jKb5GM4OmJXKqp33thClcqNMVsD6I1QU1Ibc
         cGuA==
X-Gm-Message-State: AElRT7GDlaqHDNnC0yDq+fbljKG1Td2zEahTdGWmDPvEktzCkZ3j3KhS
        ET2MpCn87Hk4ytEAC7lX7Uwsh3fo/WcyHkyQdTQ=
X-Google-Smtp-Source: AG47ELsE0fvVC2kb+VBDVHqdTQS4hpzH98i4O4FQ98VKTD/GqY+zSktcglJOBOnRWH0xCEzTZNDNbPFAHeTDs6IWwPg=
X-Received: by 10.55.133.131 with SMTP id h125mr30583334qkd.79.1520370338500;
 Tue, 06 Mar 2018 13:05:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Tue, 6 Mar 2018 13:05:38 -0800 (PST)
In-Reply-To: <20180304201418.60958-1-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Mar 2018 16:05:38 -0500
X-Google-Sender-Auth: fqWN4rlj7zATfVi8yH-vGTfKIC4
Message-ID: <CAPig+cTZGVqWSUpRuHdGwDEq5FBwzpW4j=v_1VXe_Z2+YCTrOQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] convert: add support for different encodings
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 3:14 PM,  <lars.schneider@autodesk.com> wrote:
> Changes since v8: [...]
>
> Thanks a lot Eric for your great review! I think I fixed everything you
> objected with one exception. You noticed that the current code only
> checks for BOMs corresponding to the declared size (16 or 32 bits) [1].
> I understand your point of view and I agree that any BOM in these cases
> is *most likely* an error. However, according to the spec it might
> still be valid. The comments on my related question on StackOverflow
> seem to support that view [2]. Therefore, I would like to leave it as
> it is in this series. If it turns out to be a problem in practice, then
> I am happy to change it later. OK for you?

Fine. As this is not a correctness issue with the conversion itself,
but rather an attempt to detect misconfiguration by the user, it can
always be revisited later if someone comes up with a more solid
argument that one interpretation is more correct than the other.

I did leave a few review comments on v9, but I don't think any are
necessarily worth a re-roll. If anything, and if they seem actionable,
then perhaps a patch or two atop the series could address them (at
some point).
