Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B0720285
	for <e@80x24.org>; Sun, 27 Aug 2017 19:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdH0TJR (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 15:09:17 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38520 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdH0TJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 15:09:16 -0400
Received: by mail-pg0-f68.google.com with SMTP id t3so4691256pgt.5
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2F0Q76mVjppvZyjZMYoQJfKOFvGUKddHJEB8F6Pczlk=;
        b=TYkM+yfH2OkL4LvZZke2P8Lqr2EZD4dlGuYK/JrUU1CYJchhh0jwWmpWhiG/nwtO0g
         SdVjle/fFs4OobL1LKGwOEa70sPShUu+XEUb6wggAqMTpSOp8zOhxNnUW7B7Mtqzsijs
         7oq0bP4WmekKMc2rRGmupx3bOeK3oPlPowe4idp2YEBEyF/2AEJK4qaZpAws8WGH4zII
         cm+F45nyn40+boBQVuUCQGafR7XFkj2gDm9qatglk2AwFPX1JuLl5SlJPj+lriKxB0gL
         DtHxIcG8XUF3gfLIMq3TvI7F4jJydeINcI7jhzz0+1Dq+lRH1fhe7ncY6A2wNUXNHApa
         aMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2F0Q76mVjppvZyjZMYoQJfKOFvGUKddHJEB8F6Pczlk=;
        b=KAerqbxParDp3mRNMc7ihL0vPdno0g1fuftefFqEezrZ10Ke88XKVmuObo9bahQmGh
         4raB8owxN0fWrghEGZzjO5d+o/zZOzryoWeB/lqlOb3WDiZo6+FqINC1mRfLjnsZ5CSx
         5oLMLXXpEAEq1V7IKbsKdmWi/dn8UjsAusKsdgCyYK83rt7g2GLiRfJg9CRteNgLm8Wa
         Q1Z1d61BjybHv+FImzMqQkaVnOWg4hAeuui5U32Eytk8L3Tq4mUmhMsdWtr2VFxXNd83
         m4cT9LjreCpWuqf6Aqs5SEmRz1Jn3fuz75gEM8W8YvsdkHD5ZWiJj+sxlG132XiKc6Lt
         81+g==
X-Gm-Message-State: AHYfb5hIys4OjSYMSiLXJCn9vHsCFQmP/eZSggpI2+PKcCKBLTjQCzOP
        SbGuyFQCu7xm6H1sMU/Is3zD0tk9JQ==
X-Received: by 10.84.210.109 with SMTP id z100mr5839873plh.45.1503860956314;
 Sun, 27 Aug 2017 12:09:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Sun, 27 Aug 2017 12:09:15 -0700 (PDT)
In-Reply-To: <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
References: <20170827073732.546-1-martin.agren@gmail.com> <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 27 Aug 2017 21:09:15 +0200
Message-ID: <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 August 2017 at 20:21, Lars Schneider <larsxschneider@gmail.com> wrote=
:
>
>> On 27 Aug 2017, at 09:37, Martin =C3=85gren <martin.agren@gmail.com> wro=
te:
>>
>> The static-ness was silently dropped in commit 70428d1a5 ("pkt-line: add
>> packet_write_fmt_gently()", 2016-10-16). As a result, for each call to
>> packet_write_fmt_1, we allocate and leak a buffer.
>
> Oh :-( Thanks for detecting and fixing the leak.
>
> How did you actually find it? Reading the code or did you use some
> tool?

Valgrind found it for me. Most leaks it reports are "ok" since we're
about to exit, it just takes more or less effort to realize that...

Martin
