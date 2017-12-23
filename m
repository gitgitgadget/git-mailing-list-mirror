Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEAA1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 12:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbdLWMWy (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 07:22:54 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:40348 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdLWMWx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 07:22:53 -0500
Received: by mail-ua0-f174.google.com with SMTP id i92so21246479uad.7
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 04:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UCrvw82d/NnthR7ETINfUMODEOjMsk8ERtzMeE9bAyg=;
        b=D4QcZWv9evVL91fv36VIWpfOs6/9RPJS1aRntqE1+bO5HS5UbbkMBQgKZMZ1jLhGwy
         jxeZnpOm0xVoarS2/1OVjW297ky0JAz3u548pvUoHB5oH9GAyAIwAR/5JQxfmhsjz3q9
         DDTakpGQXVZu2w73+ZnPKtrUbP3pG1vdAQnrRF4y8zo71m1uiQQw1YessJ0m0mAHiM99
         62OLR/8evfK6s4zrOIDe4tdReXOakcXWcsQzaJFoot4VUPTQ9OftuzRy+zL0cWknKdqw
         krrlZ8KWd4Ct28BkcX+Y7d6wIi16sWNdjYgrI1KY5aCfMubKi5l67Ygqml5QOnZjs/Gu
         ufjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UCrvw82d/NnthR7ETINfUMODEOjMsk8ERtzMeE9bAyg=;
        b=WnlIqnskGdX0CJOy/AANsWfeCnoOz1nkrMDY+9tZH5sS58ABI/Ov2323hDBklkxI5O
         p0OOwD6lN5Ag3DiTUxXm9G02Vq0uqD1yPYpKtSSbobFiPU7xKkfKXXjvGMRQyJVzx2zh
         hcVcSPW09zaBK58uObJ4P8fZ59Ez1WhLSUN/vTIWUID204T/KINPuyQnJTVEur+p8BMt
         Nh9ao3A8V0CiPJE0pmosya7HO/mxOPile+a5Bp1gLIONR9aBA2DM725P3wl5So7++V8k
         kJ9gLvuaHg5n/g4F/DdO87HWW5Q56DEiWYauBKG+qcjv4WRsrh7MjPPGqVyNJRLjVX8g
         XXPw==
X-Gm-Message-State: AKGB3mJXukrsLvHy5a2P2r97RAl9Rr0pcYUWy5axSviYQBvf7L8qj2ZW
        7gFsQ5K5ioM2C5w995lWwiUdZzFWL0wTNhZ4Vw8=
X-Google-Smtp-Source: ACJfBotmQ2A+A8oW9DNukuO+FUK1ewyyVrIG6xTwlUWvW36OYmBNMcI9wSrhkuMplerVobcZh1Psye76SHQj3p/LTXM=
X-Received: by 10.176.1.134 with SMTP id 6mr17879733ual.180.1514031772339;
 Sat, 23 Dec 2017 04:22:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.112.3 with HTTP; Sat, 23 Dec 2017 04:22:51 -0800 (PST)
In-Reply-To: <CACNzp2mdEmAj_6an-4is6_1LnqAZs=huakJhUQrJ+DxyJWY0mA@mail.gmail.com>
References: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
 <CA+P7+xojknncFrP5qCB4EKG0MAoTUqFWS5g3Bj+Jq2_RO0fA3A@mail.gmail.com>
 <CAEW+b66pCqTBz6o_aTK0byyKsDc8HRfHuqKf64Ob6pBtL9w2Lw@mail.gmail.com>
 <CA+P7+xpt1cW-uokayYFJ5cr88FKBcn_RT3v7iLHyu7kZaS=wbg@mail.gmail.com> <CACNzp2mdEmAj_6an-4is6_1LnqAZs=huakJhUQrJ+DxyJWY0mA@mail.gmail.com>
From:   Cristian Achim <brancoliticus@gmail.com>
Date:   Sat, 23 Dec 2017 14:22:51 +0200
Message-ID: <CAEW+b64=CiUg97xJN2k_hvxYf9coo+VfPZ+REEyj0bR6x1nprA@mail.gmail.com>
Subject: Re: Usability outrage as far as I am concerned
To:     Anatolii Borodin <anatoly.borodin@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Basically somehow at the point when I investigated stuff on the usb
stick I found the repository at the top level of the usb folder
hierarchy. Therefore git got confused by what I was doing at
usb_subfolder which is lower in the folder hierarchy and that is way
it was having amasement inducing reports when trying to do a pull
saying that pull is not possible because of unmerged and newly added
files.

Thank you to all that replied.
