Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2EBC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D547921707
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgD1QKE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Apr 2020 12:10:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37860 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgD1QKD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 12:10:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so25359100wrx.4
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 09:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Sln0G56S/a0tKf7Ah9GvHlRitaBZFF2dGMelvUyMeA=;
        b=KY2g8lIknhXYrmC17oKgwM/YisqS9DJSbdOeEY1HMplIzgYR+l7Nshe6ppXiCVC1Yh
         i56jG+3J0iYP0sPqCHOXYnM1qKcV4KcRO1lUHeotaLJlZUKhGxhqHo7qvViXFu8s+Y6H
         P19fyHomWvtx8HahbpRBSXJSQ7FwmjWgJ3rXx0j8NlIFC9obiMYK8v5dkRx7qgWeI0QC
         8mvecma9Qi6q4nAA5NeTUuYs6WxkvhN6dw2aWyJfAoTbZY05TL8n2AG95uJF3q3Trhg6
         fWuTTBHvQWL2SW99DwzSFr5HFO8NojC2eHWXwqG+52cdDBY0EVdPpibubn96Rfmke8SI
         bwIA==
X-Gm-Message-State: AGi0PubJ8Trk0R7WzRgn413HEYXxD1UWoeVVnaqCov74NjlHGWdDt/YM
        k7jij2Q8muYviTnlufxhOjhyYgG+DuA8B+umMiLpZDHj
X-Google-Smtp-Source: APiQypINCUtdZ+cZ+eagiIGke1GrglqR3Ry8Ky0LQgAOifzpchgNZ3BYfw8WB2KjIc4WmZ4+/9o1CiDnBUac5EQjcUM=
X-Received: by 2002:adf:afdf:: with SMTP id y31mr33616279wrd.120.1588090201767;
 Tue, 28 Apr 2020 09:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200428104858.28573-1-carenas@gmail.com> <20200428105254.28658-1-carenas@gmail.com>
 <20200428105254.28658-2-carenas@gmail.com>
In-Reply-To: <20200428105254.28658-2-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Apr 2020 12:09:50 -0400
Message-ID: <CAPig+cR8YGGXLcdiv1SHF5wQ305RgG1S0JhheVgF9fYstKxaQA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] git-credential-store: skip empty lines and
 comments from store
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Dirk <dirk@ed4u.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 6:53 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> git-credential-store: skip empty lines and comments from store

I don't see anything in this patch which makes it skip anything at
all; it only introduces a new test.

> with the added checks for invalid URLs in credentials, any locally
> modified store files which might have empty lines or even comments
> were reported[1] failing to parse as valid credentials.
>
> add corresponding failing cases
>
> [1] https://stackoverflow.com/a/61420852/5005936
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
