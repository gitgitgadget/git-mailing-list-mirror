Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E9AC55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1863E2224A
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 20:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKMU5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:57:00 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36923 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMU5A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 15:57:00 -0500
Received: by mail-ej1-f66.google.com with SMTP id f20so15621024ejz.4
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 12:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtiCdy28SEXD6RJfUAW0RmgvHWmvMEuXaiKBZJ64lDY=;
        b=O/n52//pnluab47C07QEK7/QHm+zsAX4woS1vdXH0C0o31f30QmdnF9RIoXhV7fXvO
         NZFLISSGLF1M0gzSriiaiUDZ8bUy9GYnU8DykcCplElVLPGVP9+HjkwKExc7DQ1xTY5L
         Xen7N/uTGUXaTGr7Gy0mdeIbXji6cUkiTwZTCa3NXXTVpYQMZHUbxr1RxHZOUDyMtjwt
         6ZNEyNOHp2DStVdK6L+55ZoG8piRDmedKR6kVQt3V+3iaJ5BmVOaDPfLgDwh/4ORUoMy
         fHtUQpeC7jW2NQpu0dLs44XV1V5hceSiUfDrkD0ADf8kM9F3enmIstWmlvAwBpyfeOnd
         PT7w==
X-Gm-Message-State: AOAM532Qh6np+4W17RIo29F3fqpIDeOd0pyF9QSr7Wybq7DUNJ7gbeHN
        7nB+ABWJ2eaS9Jsvq2MxJlYvmOX3iYTtu0vDApU=
X-Google-Smtp-Source: ABdhPJw1GTVSpgAGpEkz60Wwflw0cBz7ExsnSBCONThURr0gh424zoKlALawIY2t/vkXzodkN7Dc3NUfVlRJYtWfRT4=
X-Received: by 2002:a17:906:c041:: with SMTP id bm1mr3740045ejb.202.1605301018545;
 Fri, 13 Nov 2020 12:56:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com> <1629bcfcf82dbc2ed9889a0e9ea2d08427901c4e.1605276024.git.gitgitgadget@gmail.com>
 <CAPig+cQQrucwE-KSndQ5kCjG9Q1MtjxraAmA95+OQe=6bdks-Q@mail.gmail.com>
 <d9c51446-c223-dce9-692a-959f841d506f@gmail.com> <CAPig+cTRJb-fn2R6rJO1hkeCc_ehVhkNufO4=LhtPQudVeonnA@mail.gmail.com>
In-Reply-To: <CAPig+cTRJb-fn2R6rJO1hkeCc_ehVhkNufO4=LhtPQudVeonnA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Nov 2020 15:56:47 -0500
Message-ID: <CAPig+cR1QnqnZjWFSTP5NuzaeedRThxnvKbqU_U_=d+p2DOOyQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] maintenance: use launchctl on macOS
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 3:53 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Another thought I had was simply checking for the presence of the file
> and skipping `bootout` altogether if it doesn't exist. That would, I
> think, obviate the need for mucking with stdout/stderr oppression.

Erm, s/oppression/suppression/.
