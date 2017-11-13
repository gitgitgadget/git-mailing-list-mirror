Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9D81F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbdKMWMV (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:12:21 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:44252 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbdKMWMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:12:20 -0500
Received: by mail-qt0-f182.google.com with SMTP id 8so21569352qtv.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xx3KuDFu4MU7d/RkiSW9kr884BKPK0lTynwLh68Y4ZI=;
        b=oahvmP8z8EfXFqoCuJh8hiRDo0Y7GCYVou5BM8aXUQUoncpPw+eephLjFkhI/fceNz
         c8ddDwXRlDbjJDxpkxH0BqJLJ92YSR/r+5ObwmuDTuhJAfBm6Q3dcdlsnG8ONcSeS9mS
         4NxWGPJvN0XsJBFCFl0K/xZs6V7yWAQRoi9NyFyT657sCwSe43gD2aFF7UyRWPB8Pjud
         xYlSzMLP61qF5fl+6QziF8CROqXYgKg340EbAi5X8NKVhayWrvqvoPxV7ippNv1uYwdk
         KJ3BInCO99IaVOFGAxt30Z3jbSlohjHc+4UmrmZY9J/xQGF/6Kq+v1ISNQcN7CmMXsZX
         sXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xx3KuDFu4MU7d/RkiSW9kr884BKPK0lTynwLh68Y4ZI=;
        b=jtICQqKL6VzAabGbq2bYvlr+6aBcVYTTZu5tIc7b+RU9S3VSzY8MV4e4q8RBmTqRTR
         zajKN8LdxTiejDb+kdCozv9stLveY9ZtGwYLQQSZVNgaKc8JgHpj0ne0b2fvwZDwKSgW
         x7egpSfWdI7NB1ZdZGq47kGUHbNf24Mixx75N45gzDzo5nfjDGHucd6SYNOtACJu4cDB
         LQhCD+pIQuTs26eYvr6txSQQZBpytfK88yMMQH8Dgkze+mT0iTVozLI2NmSBMtaaV/yS
         bg39KWneOoFgS8YHpKhHTCvdoJMS06Qf9mBA7BOgMMOU8PzbEmHex5u31JkK//DqQFs0
         cRXQ==
X-Gm-Message-State: AJaThX4kuuEhCE/vgEGlBQI6YQ9NmZkQchcZ80UzfmlsYgma42ljL91r
        R6VsR69wSf7rVHLTZxK9gCa5hw7JuOITWZozcuGIByFObAc=
X-Google-Smtp-Source: AGs4zMZ0W61RL2vfr1/vixpxvTrWJ6wVFoNSgsRiTuqnO/FDdi/pG/eVY7m4spRcPMig7aj2qr92ZxQV72IiQDTE1VU=
X-Received: by 10.200.27.225 with SMTP id m30mr14665428qtk.260.1510611139901;
 Mon, 13 Nov 2017 14:12:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 14:12:19 -0800 (PST)
In-Reply-To: <CABPp-BFX-xZf962vuCjJSaB0=sPMT_zNF8+mGPG04dFi5PE6SQ@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-3-newren@gmail.com>
 <CAGZ79kYXbvDL_SoEENf60DsDFA-yEWfvgv8bNv_v+mw042ZH=w@mail.gmail.com> <CABPp-BFX-xZf962vuCjJSaB0=sPMT_zNF8+mGPG04dFi5PE6SQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 14:12:19 -0800
Message-ID: <CAGZ79kYEwOhjMfNH3ovfEnRdU_OYWnGnai8HrZWxoBEC67xKVw@mail.gmail.com>
Subject: Re: [PATCH 02/30] merge-recursive: Fix logic ordering issue
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 2:04 PM, Elijah Newren <newren@gmail.com> wrote:

> Do you feel it's important that I come up with a demonstration case
> here?  If so, I'll see if I can generate one.

I was mostly "just curious" on how you'd construct it theoretically.

> it's actually something newly possible only due to directory rename detection.

So something like {rename/delete} on a directory in the merge, but
also an addition instead of the delete of another file?

I wanted to debug a very similar issue today just after reviewing this
series, see
https://public-inbox.org/git/743acc29-85bb-3773-b6a0-68d4a0b8fd63@ispras.ru/

Thanks,
Stefan
