Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B48EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 15:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbiBWPEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 10:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbiBWPEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 10:04:35 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B6AC900
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:04:07 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id t22so3480732vsa.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4z+g5RSEanj7BQvkvG+gV+G+QBIK3Exa8sFAQMjCHM=;
        b=EIz3pWROAIppQLTztnoj8/mbFnwJHcoAGAaUGLxy60rPIEJuSIESJNgdzN/I2eNgge
         KB3m0U8b8sUdgPe9wt5MWD/XCTcA54WjKjFU7UNj+NhZ6trErsvXmLTh4YN9/quOkB9U
         1xTOKe43QSA6DHTCX/n9gVwhJavAo37YV8nqscqzEqDmLLJ5ff+6r/MdOz4OziztnHbK
         RnphBy0GXV+2recEgJ9I7HFOBr4BRP8GhfAJtMYkPRanOSusX1RWfGmp5nVqiaYracS1
         brxlRNHRmSphgLXry/aqq1QjCcILYl3+FfqHzpo07qB3Q/GntWjJDuO2TIcA9Y6ekmCS
         v6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4z+g5RSEanj7BQvkvG+gV+G+QBIK3Exa8sFAQMjCHM=;
        b=nEqcJHR7tydfEfIRjVxRVjFi7X7TJplGAeaQfKnePljlAZgujBdWOaDMXCIFsJo0DR
         8i3AZN/0QMBGv4ewVXwnJzoYOY6IX+QON9AEd8Na9TXn0WEdEKnCa6d6qOoD6Zao3gdY
         YsABPtvue5HU2X6POjUpIooq2cH1yKVLRNyvXpDJ23EAFK6urkNu/n7IHna5dpoYcE86
         v0LXGF71U6vnxbUDNOpYrZ66jBc0Dcdz5l36XU0qgm+buirxTOT/L5xp8cMYaDUXhWeX
         uVI66IveY0xSRYhM15bRFEwl/D2aKMkiZqjz38iTJ+o25omQAlOgoGY0U5Zmfmmv5cL9
         q+Yg==
X-Gm-Message-State: AOAM532oMiDeKTl0hIgBMxkFHWNFagceuSoCfLCHTCjcH8/LMt2SlSwI
        dbTF0sMLwwWgmLdF8feEomPbgFUrrkMt2BOWcPQ=
X-Google-Smtp-Source: ABdhPJyhC32A4Fw4QilRCQ/X4ajndsUPGnTK+trqjjdiupMIoCMnD2WnfrxwvFP1HwiE4+f5nNqf6ca277OfY2BGg3s=
X-Received: by 2002:a67:ac09:0:b0:304:f097:e6fb with SMTP id
 v9-20020a67ac09000000b00304f097e6fbmr12710788vse.85.1645628646565; Wed, 23
 Feb 2022 07:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20211125125720.231039-1-ms@kilabit.info>
In-Reply-To: <20211125125720.231039-1-ms@kilabit.info>
From:   Halil SEN <halilsen@gmail.com>
Date:   Wed, 23 Feb 2022 16:03:55 +0100
Message-ID: <CAOeUTuuyftWB=PaA9HPDnyxsb40R3Z6GD65TB92jEW+38goqRg@mail.gmail.com>
Subject: Re: [PATCH] gitk: fix error when resizing gitk
To:     Shulhan <ms@kilabit.info>
Cc:     git@vger.kernel.org, paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Shulhan,

I just stumbled upon your patch while looking for the patch
that I sent at the beginning of this week for the exact same
issue.  It turns out you sent your patch two months ago.  I
should have checked before debugging :face_palm:

If you would like to check it out, here is my patch in [1].

I see that you have fixed resizeclistpanes but exact same issue
is present on resizecdetpanes as well.

I am not sure if the conditional logic is necessary because we
are sure that `sash#` includes x, y positions in ttk mode but it
includes only the x position if not ttk. Also setting the y coord
to 0 might have unintended consequences.


[1] https://lore.kernel.org/git/0b5b8fb591e434a2a24b1f58d1ce3fc7da48a28e.1645386457.git.gitgitgadget@gmail.com/

Signed-off-by: Halil Sen <halil.sen@gmail.com>
