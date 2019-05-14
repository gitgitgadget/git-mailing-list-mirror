Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3671F461
	for <e@80x24.org>; Tue, 14 May 2019 19:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfENT5Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 15:57:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35639 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfENT5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 15:57:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so157602wrp.2
        for <git@vger.kernel.org>; Tue, 14 May 2019 12:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XKlGpTHjcnLqPpEYGSp0GsxyijHoRmQuGMdThkdbss=;
        b=UjG+Gp18O2KZgH7JZ2Gh8IOss3lOcbid3K0edGqIn5Gj40GjxblppCQYcTIFEIU8m3
         H8D685VfK5QCVZsRXoKQL5UpxsYwa0Sg0N8CJHB2Q9XMes3DqKpwG+uUBPX5SZpFBGnq
         /cjCZZaX0kBVb3UHaJzw/MNkyxM2y4EZBUBE3wif3iaoDvQxWRN27OON062kd3py4HYc
         IpBgW0RXajQ3SpEdS14JDtBR/21GJ7iLIoVm1PC3ruNC7Kc28iek0YG16dui1k/DJHdD
         6GrNduHX7myZp6td5W6ziGxUX4I/fmtRYYK6SRV+7js2F3cg1PS6ZNjmCEToXr5wCpiF
         6Vlw==
X-Gm-Message-State: APjAAAU3CFLHx1QJey6hZUDTDXiR/GfWSXWOSpS+j6kaAMVypMOcuE0V
        voNXjaFma5xW6hR3rPZyFawUjI95DGsJ6uPdKmo=
X-Google-Smtp-Source: APXvYqwny8o5yD9QEvbxjB5cPejbRUi8H8zvIoYdDLEsmUxbn4pfKBPffzqcAXLRKoaEAcqcif/j/1o+Ua3NPrx3zOU=
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr4375065wrm.217.1557863841840;
 Tue, 14 May 2019 12:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.193.git.gitgitgadget@gmail.com> <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com>
In-Reply-To: <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 May 2019 15:57:10 -0400
Message-ID: <CAPig+cRoyOJrEuVY109NKafTCUc399p9tk64L9sZok=AOZ1MPg@mail.gmail.com>
Subject: Re: [PATCH 1/1] stash: document stash.useBuiltin
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 5:19 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The stash.useBuiltin variable introduced in 90a462725e ("stash:
> optionally use the scripted version again", 2019-02-25) was turned on by
> default, but had no documentation.
>
> Let's document it so that users who run into any stability issues with
> the C rewrite know there's an escape hatch, and spell out that the
> user should please report the bug when they have to turn off the
> built-in stash.

See a few nits below, none of which are necessarily worth a re-roll.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
> @@ -1,3 +1,18 @@
> +If you find some reason to set this option to `false` other than

s/`false`/&,/

> +one-off testing you should report the behavior difference as a bug in

s/testing/&,/

> +git (see https://git-scm.com/community for details).

s/^git/Git/
