Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E651FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdFMRJt (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:09:49 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:37951 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdFMRJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:09:48 -0400
Received: by mail-it0-f46.google.com with SMTP id l6so33006604iti.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VY5+oiSIXTA06K+P5aGM89cReOCqP5hAG+TQt3cEzKY=;
        b=NqrrVwm1ex7hysdYGFaiRfLYzqehBInZ9261pkv3U0j7N4iZSpw3G3vglt1pvv4DNh
         a3PjN94vibxfaS277Oc1t89jhbBWDhutkkrjwu/8rWDTx/lW8+jME/F26iyvhh/DARNR
         5nI+7cscVryf5bdtl+l0F2t5XzGhlaWAY3CgoCvifkpSeUgw8FnAoA/h7ceEmilHTP6/
         OWPgyXN4c5S1fsF5506Pnu+Rhyf+MZ83oCIJqZP9p+5FgDyGxr/Ho3ciwJXpXnoTDLhR
         xJUQnAGEtLE06gmGFcAsI8VyRKLGbYLUcAabd25uuM5Be15WXXWfqecsSh8noICo+I/A
         8eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VY5+oiSIXTA06K+P5aGM89cReOCqP5hAG+TQt3cEzKY=;
        b=IYKvRvXUj2JurUZcY+k1P0Y4JzCTuNIA9eWDUjSyJKygjKTezTg6D/qrLAsFYSnD9P
         YOUSEn7gEDsFPQ0ZIrKmt3S1yyb/Xkq9tELf0jzWAFftgxuDIVg1xLz/Vh1+pT9LDDO2
         bjlumGGWt3MFkZGAposXataDAjUBRhsGzbVMQ8/LZDw14/q/gasIjgcUDXF2ua4mk4K2
         QnXckO4ekzhNoYCQ1pJMaR8mfBmcKEclODJ2t43r6zxsy0GUmPDowVT/xnH3TJEm86bx
         FdeVDqg+PZq76S44mdD2ry8vzD0OmlwxPjpmQhfIzsrXMd0uxy/6Prb5x005y/qrC6lw
         mDxg==
X-Gm-Message-State: AKS2vOxPhfnPXiMAQIPGW+lQhkalonfHvthKokEsTzAUEtjzwFFSpRIP
        OfUGbROqQJXCmVrt70H9KiaX1ib8QCLBdN8=
X-Received: by 10.36.164.67 with SMTP id v3mr1165806iti.71.1497373788100; Tue,
 13 Jun 2017 10:09:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Tue, 13 Jun 2017 10:09:27 -0700 (PDT)
In-Reply-To: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
 <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 13 Jun 2017 19:09:27 +0200
Message-ID: <CACBZZX4O=G13hY5C5OV9NHjUVT7HL2x5OZSB8qr3r3qjqMff+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] config: create a function to format section headers
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>, Alex Vandiver <alex@chmrr.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 6:17 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
> Factor out the logic which creates section headers in the config file,
> e.g. the 'branch.foo' key will be turned into '[branch "foo"]'.

+CC Junio: This is to be applied, Sahil is using submitgit which
apparently doesn't CC you by default (I don't know if there's some
option for that he missed).

Also +CC Lars who hacked up -m initially, Alex who hacked on some of
the logic of git_config_rename_section(), and Johannes who also hacked
on some of the guts of that code.

Also, in the interest of full disclosure. Sahil's a co-worker of mine
who I've been mentoring on how to submit changes to git.git, after I
added a note to the internal company announcement saying I'd upgraded
git advertising that I'd be happy to help anyone who's interested
contribute to the project. That explains the off-list review & Sahil
submitting a patch of mine first seen as part of this series.
