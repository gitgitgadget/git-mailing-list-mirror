Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D9C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FA7613C1
	for <git@archiver.kernel.org>; Thu, 13 May 2021 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhEMTRX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 13 May 2021 15:17:23 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44797 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhEMTRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 15:17:23 -0400
Received: by mail-ed1-f44.google.com with SMTP id t15so4489757edr.11
        for <git@vger.kernel.org>; Thu, 13 May 2021 12:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gQOOjKm9mTtar9xDMLE2NuhgzjxzOUrLbQYs9Pwh3j0=;
        b=rZhBHDeAqtBiu7OZbNMUI/a0l3AsAefv8sSp0kFIDCDPsk4jj2EgLgYBWFeZJ8roiQ
         K4PN6PLqtTRMrZa+9qw5F6M/VfnvVWux709a9hZ2huWqLOOyL2RbYR4dH2SAhrhswuQR
         6IZRdTbErhwB+Nx+BT008iK06MZ8Wq+WiRDci3t3OLBrPVeR6MOZedx2EH7G75EJd7ax
         sSHM7z1nZG8M3MnnsagMIaqZAqvy7v6FJ6dUpL5HX5R4Ufa28swt0ChcLKa2lkNd3M/u
         ozz1oTXNJmtiNoQ2UauM+l39GNvEtFzxl0BWufoxG84ZRzytgP4JLwNGomzmLPsvCM+Z
         5/VA==
X-Gm-Message-State: AOAM5323QiskBs6HPJlCLuwQyphFti8d9B/7pBq2koWFuFVY2u3my6Hx
        UQeSPGZgUGV0qToTc67PawlC7++qknp+HXMo4kdTuRTNZxA=
X-Google-Smtp-Source: ABdhPJyd1htRbsxjYsI8qceSA7G8dScuADif42QAkKhLIQXMquXZvKOzgiNWx/TsRT6A90W9FbK8aDsyj3s90TEofBA=
X-Received: by 2002:a05:6402:51c9:: with SMTP id r9mr47997945edd.94.1620933372282;
 Thu, 13 May 2021 12:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620928059.git.martin.agren@gmail.com> <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
In-Reply-To: <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 May 2021 15:16:01 -0400
Message-ID: <CAPig+cSKod_dL7Cm+=T_TPdTxxcV6mz2d+ktm4i1SEUJxQWUqg@mail.gmail.com>
Subject: Re: [PATCH 3/6] git-check-ref-format.txt: avoid single quote
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 2:18 PM Martin Ågren <martin.agren@gmail.com> wrote:
> Asciidoctor renders 'git cat-file' with the single quotes. It's somehow
> tricked by the single quote in "srcref\'s" earler in the paragraph. If

s/earler/earlier/

> we drop the backslash, we'll regress with AsciiDoc. Let's just rewrite
> things a bit to avoid "srcref's" entirely.
>
> Add backticks for monospacing around these refs and command invocations
> while at it.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
