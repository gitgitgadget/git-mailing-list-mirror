Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E693C761A6
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 06:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjDCGZI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 Apr 2023 02:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjDCGZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 02:25:07 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C17665BC
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 23:25:03 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id bs13so8617801qkb.0
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 23:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680503102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyBhGjHCOIp+oowuMt+8Vox+DPxXY1JxUxiEpTqrXxU=;
        b=b9mIOx6JbWssClDdvs6V3sZYcurgiypZ4CD9iqTmYWU08iXzY5xChu+l7wRSGpd0QI
         FyGq6zQ9wb97kdYlXyIfpFTjqPkOQxKAxGUmIQ1kWfCt1L5SYKDtK6ph87mRNyoAnlkC
         rrJ1TXvsf2S7VDGMi9uwWUKlAPw/YPV5pKhmFA2Lepfy8BUUfSKa60AUxHlZHQ+hdclE
         d37CZHatI/0+18atvGC9Ur3SNGsNn3qktbVDbYd5mu56AMHu5xygfBnXOnrSKnChmJEM
         dpKDQ2frJxulhcnGl4lKRuZuNd1uw42mdobkyYmIlXjO8xe/3ViPPEtAe9EC1p5i2Q49
         jwnA==
X-Gm-Message-State: AAQBX9d6tBoKH5tZ6w9xr0kKHNNn/TxeHHUF5VBB/cRUb8tht9eN2TNk
        d78A2L53royyklNipupdtNyOh/g/EEHmwKUeQ12DLdyOND8=
X-Google-Smtp-Source: AKy350a2XsZQnrrFttBoPgQjY0f+jpn/CQzkiSOHpysDmkkdYUKa8cJHGFgE7gQ1e3PTxpyXUlccrgL1BdLK3PHIBCA=
X-Received: by 2002:a05:620a:a98:b0:748:60ff:dff0 with SMTP id
 v24-20020a05620a0a9800b0074860ffdff0mr7633740qkg.8.1680503102068; Sun, 02 Apr
 2023 23:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230402113607.2394-1-edwinfernando734@gmail.com> <20230402191709.19296-1-edwinfernando734@gmail.com>
In-Reply-To: <20230402191709.19296-1-edwinfernando734@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Apr 2023 02:24:51 -0400
Message-ID: <CAPig+cTq9mmLGmmNWQ0E73nsmwu+Lj1jDfvnniUe-O6iQrisnw@mail.gmail.com>
Subject: Re: [GSOC][PATCH v4] t3701: don't lose "git" exit codes in test scripts
To:     Edwin Fernando <edwinfernando734@gmail.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2023 at 3:18 PM Edwin Fernando
<edwinfernando734@gmail.com> wrote:
> Exit codes are lost due to piping: "git ... | <command>"
> Fix these issues using the intermediate step of writing output to file.
>
> Signed-off-by: Edwin Fernando <edwinfernando734@gmail.com>
> ---
> Apply my changes on top of the latest commit in upstream history.
> Test 76 in t3701 fails. This commit breaks the test:
> a9f4a01760 (Merge branch 'jk/add-p-unmerged-fix', 2023-03-19)
> Identified by checking out commits in:
> "git log --oneline -- t/t3701-add-interactive.sh"
> I don't know if it is normal to have broken tests in the main repository.

It's not normal to have broken tests in the repository; they should not exist.

However, it's not clear what breakage you are seeing. In my testing, I
don't see any failures, either in a9f4a01760 or after applying your
patch to "master". Can you provide more information about the failure
you're experiencing?
