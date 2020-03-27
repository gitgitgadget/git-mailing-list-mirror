Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ECFC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE4C2072F
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucWazxBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgC0SLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:11:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40027 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0SLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:11:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id w26so12377403edu.7
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQcpfMYpSkE3oGIuxzKeOWln900hVt228E4j/nSuMfE=;
        b=ucWazxBhTFtoIibGHylp+ErJx0q4jKRPzIvGPWngIO7apYehxCxQzLZvYjVSnelWZJ
         34fxjSO2Fwz/19LZrYSDYY2ifJXbA1MpSJqg8+EFxRxSfigaBLW31ugbHjlOYwMcfViO
         Vk+Sxx3c/zNIPDFOVrZeFzoKLqbKU9X6rE4SVUuazd2rbwYX2YpaZgc9x/cTWlqO45u+
         NJHZwgJ9DLKT1H4dwtcoExfUbSOL2YEZHArG55JG63um7ktmXfLuRUkrXC1at4QSa3HS
         4k+WJbfbOcw25BARayPrEaJzFfv+HBjqNorvJJumvRi80oDYjunswrC1qkKy85A+YlyG
         IpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQcpfMYpSkE3oGIuxzKeOWln900hVt228E4j/nSuMfE=;
        b=NbKnmGE6hXivAJd35G6mUZm8mmF02rPlbZ9NtEVN/WRtlS8mkhnrLEl5PkZlFda9BP
         o52YjX6JO3RyDpWgtRwXymv91QOwe/Q59f7PW2UBIuUgOSvSi+jsT9Iz4PkdkqSjmYOv
         kSpBIMSQfYmFa+c4gv5tHfPGeB3HwGLEU5MPwOGBMlvE80jlFLM+41wysW032w14sueb
         rMON1nLXShZ6LDuLy6QTKCgoOv8587MRF1x428LNEExdXSYuQdd76jqpKQFDu5wlkm0J
         ZnUVBnn1B2J1wyBkXQg7w7BJQgA2dP190pC+Aa96amrk1TZcbjImbmCwxpSDD02cn9T9
         qR7A==
X-Gm-Message-State: ANhLgQ3RZHb6uAvrADVgPI+8H7SN4Nb9CNkbEV18R2yu09Sbgp5UjNmi
        L3q7l9Jo7JhzMvQiVdvbzrpmJZ1zbeV7Y5bvsQ0=
X-Google-Smtp-Source: ADFU+vtCAdRM/MmjJnr3cCk20O+54lYXbrzQfxsONZjmMbmkDRsENKLkVPhBWjC8ny/5tXpOc7RVwvcZuNmb7w0YgOA=
X-Received: by 2002:a50:fb02:: with SMTP id d2mr352156edq.384.1585332668591;
 Fri, 27 Mar 2020 11:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
 <pull.587.v3.git.1585269403947.gitgitgadget@gmail.com> <xmqqeetdhdxo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeetdhdxo.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Andr=C3=A1s_Kucsma?= <r0maikx02b@gmail.com>
Date:   Fri, 27 Mar 2020 19:10:57 +0100
Message-ID: <CANPdQvLiiMTnd9ZOJvroECgG6ZzrtxS2ew_FY=CbXq4npT02ow@mail.gmail.com>
Subject: Re: [PATCH v3] run-command: trigger PATH lookup properly on Cygwin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Andr=C3=A1s_Kucsma_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 7:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> The name of the ASCII character '\0' is NUL, not NULL (I'll fix it
> while applying, so no need to resend if you do not have anything
> else that needs updating).

Right, sorry! I have no other updates.

> Otherwise, the patch looks good.
>
> Thanks.

Thanks for the help!
