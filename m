Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16348C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 15:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiKPPMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 10:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKPPM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 10:12:26 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27E450BA
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 07:12:25 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id mi9so12059466qvb.8
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4FCJ0uYjhkoD1UY1Uxok6Jg56vNWrt5jxBnoMH8QIM=;
        b=EUr6paGO+gcHrRb/kkRcZVa/1jGhrf0xrlzBb1KsCYC6srHAyOJqCWYUt3JL60X11R
         ZzUBfuq1mq0LI7pfrLs3r/IOwXzdCW05qkwOj3Q0pXW/TtOeXTPaYla1CIMWEQBfTF6E
         XbCB9rgDx90HRnG2+pqGkfh6izGcxUNlerqODtP5NS5/lMP0CbFvW0yAPlmjVfuzjiZ3
         dh8RcKax2CZtR8ALceajWxCYMOFfty4wF+/Io73QYOiG3XrWrR2nnSxn/u2/52hewDie
         pw5dhef2yhSZa3kSfqeD6QWOXhjTDWR9sxrmt2+kjv1uDqVw/VFgU26niZNiGEHIPIXw
         ZOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4FCJ0uYjhkoD1UY1Uxok6Jg56vNWrt5jxBnoMH8QIM=;
        b=pdOaRjFa2qzsmeiR7GC3BxsmRgBjOxKFz7eIvtf3WkW8MGvFsviCVc7AIqrtIysgrK
         GQWjReQLbHoaHn9/4/d0ybWHucoknYQtypfL82Zy/o32RPoaYipEAtzv6iE3sZD/NHM/
         DWO0y1BMgYY1P6cGPp79TKaqX8peZ3EHCABx5VWTSWOezWMPXGf5X+DJAw7mEa3OR1Cn
         rFnc1m+Ab4fxOsiylnoIwgA1szq7RLOMzoWJHeeuFmVXrGq6qSHCJpIWNB1n6aTD6PnC
         mm9ji6h7bhTmE0ecyU7kUmwvSkGLce+/m+ovgbxG/PySqGJ3VjqkuMEW4inWO+ApUMTi
         drsg==
X-Gm-Message-State: ANoB5pmbKcXLHwlpAo3Ow1qNpDGLP0IhJ0CeiwyQfeoMF+uVWGUt0CFN
        Q2EscjdpgqkKSw4dP4yCJOkw2wElKGw=
X-Google-Smtp-Source: AA0mqf46ERlCf2QEjgTuZQ5/kKNjcsxqYy4uS44jk3C2TFQwVoIEALC8hzvANp0Avc4Nry+ofxSIew==
X-Received: by 2002:a0c:fb0f:0:b0:4bb:5ac4:126d with SMTP id c15-20020a0cfb0f000000b004bb5ac4126dmr21285633qvp.108.1668611544416;
        Wed, 16 Nov 2022 07:12:24 -0800 (PST)
Received: from [192.168.1.3] (64.67.147.80.res-cmts.hol.ptd.net. [64.67.147.80])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006cf8fc6e922sm10255045qki.119.2022.11.16.07.12.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:12:23 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git <git@vger.kernel.org>
Subject: Re: Large repos mini virtual meetup
Date:   Wed, 16 Nov 2022 10:12:22 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <6312F969-9F30-4E0A-B06E-8C34D24BAF48@gmail.com>
In-Reply-To: <4D2B0F7C-3ABD-44B0-BDFC-D5960BE261DD@gmail.com>
References: <4D2B0F7C-3ABD-44B0-BDFC-D5960BE261DD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

A friendly reminder that this will be happening tomorrow! Details are bel=
ow

On 31 Oct 2022, at 11:18, John Cai wrote:

> Hi everyone,
>
> From our contributor's summit back in September, one theme that emerged=
 was the work around scaling Git for large repositories. In an effort to =
gain shared consciousness around the problem space, surface opportunities=
 for cross collaboration, and deduplicating current efforts, I am organiz=
ing a mini virtual meetup where we can share about common problems we're =
trying to solve in scaling Git for large repositories.
>
> Anyone is welcome to join! Here are the details:
>
> Google Meet Link: https://meet.google.com/zid-azpu-apa?hs=3D122&authuse=
r=3D0
> Google Doc for notes: https://docs.google.com/document/d/18Mh6WokkSb3t7=
xeLsTdAUrSd8xfxZ4Myc-X25sG8b1Y/edit?usp=3Dmeetingnotes
> Time: Thursday 2022/11/17 11am-12pm PST / 2-3PM EST / 8-9pm CET
>
> Thank you!
> John

Thanks!
John
