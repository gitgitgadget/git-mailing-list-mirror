Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F25C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F73206B1
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 18:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgCOSUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:20:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46089 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgCOSUl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 14:20:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id w16so2008739wrv.13
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 11:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52MIQoKPncyNMM8UF7C16Ce2jDKmb4uq8H9ZOKjKB7E=;
        b=TAUF1UKSj1E4jPVDRgdv4ehdsDzEab3MCYQI6B4yclWJoHNPS4H296fVH6cuGRGMyX
         B0yL4kOSZocARjnD8RulvD+44msXxyV7Mm5UjZRcrcPPVeyVgJlprObbC/ppzS13IK2s
         HyrbMBToA6W1vTiobWHC0FG2ZH6qdgUFtH1IlpEgoNWsaadlZFotVcWtMfZOpJBc9xAU
         iqPZHIRjfZLdBpfP1pHhBdIE58zX+V8DQ1zbc6QCZku6pa/yQFAgL8/TxthiIv/VRN/s
         ttTHDyFP/k+i5IMlGoqO7Tg2VAcjVw8VaGxSt5CZHy86n6eTG5hYM+XDBxydTTCOcAoH
         NsjA==
X-Gm-Message-State: ANhLgQ155cq8qmrPVnoXR88WRW7ZvOHrgdMNuJ5nTYP8B+yTnQUQ1U3Y
        uysG/aq7i94QJ+WmiCX1GPmDrPllBzDe9eKi1kUu5Q==
X-Google-Smtp-Source: ADFU+vssDgYYgCXYIOATPdlzzwnl49oiNW2L85fCfuuEIX6cVUO4uRwEsS/Ks7wuT8jqozF+ALm9Rp1yav+DLBzXk3U=
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr31325386wro.386.1584296439327;
 Sun, 15 Mar 2020 11:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200315180902.13750-1-rybak.a.v@gmail.com>
In-Reply-To: <20200315180902.13750-1-rybak.a.v@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 15 Mar 2020 14:20:28 -0400
Message-ID: <CAPig+cTGqEdr+rjRCfKmcm=ab3vKnUokd6KyrsoBiy=AO9nnOQ@mail.gmail.com>
Subject: Re: [PATCH] t: fix whitespace around &&
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 15, 2020 at 2:09 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> Add missing spaces before '&&' and switch tabs to spaces.  Also fix the
> space after redirection operator in t3701-add-interactive.sh while we're
> here.  These issues were found using `git grep '[^ ]&&$'`.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -348,7 +348,7 @@ test_expect_success \
> -        echo "To be changed and have mode changed" > 07-change-mode-change     &&
> +        echo "To be changed and have mode changed" > 07-change-mode-change &&

The commit message talks about dropping whitespace after the '>'
redirection operator (and some of the changes in this patch do so),
however, this change neglects that cleanup.

> @@ -361,7 +361,7 @@ test_expect_success \
> -        echo "Changed and have mode changed" > 07-change-mode-change   &&
> +        echo "Changed and have mode changed" > 07-change-mode-change &&

Ditto.
