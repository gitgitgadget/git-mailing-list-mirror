Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F6EC433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 08:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiCDIjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 03:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiCDIjS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 03:39:18 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0F19CCCF
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 00:38:04 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id f2so6046339ilq.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 00:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZOzAmyZ8wwy1nEnhnRG1pNNf/Y9M0vXBjZZrJoCBDY=;
        b=RRxFQa62ymYtxztbtg0Z7q1amfR17aqSJ/5AFlPHuoTcmzidpBN3DUoJHm87Hr03wr
         zdFj16OLAf3/NJyW30U24+zJgH2oXO/Glqu+4KKEOjjGPm0bJ4cQYPox8iD305dHBZj4
         NDLdCiaEvRTFa3kTFDhoUKaxns/5I79YG7xhcAqPvwrZI80SeZXWIQKDlHIwN66xYPUz
         s32jsGS2BinU4RWQK+WUoSjBcICe4As5A3RH3CJ4YM1AlgvMl+v66g10wni4KAXWljbA
         OTwYvi+0lY172QHm5KuDcExce/Zi1a2qVyqSOmNgZjEBgi2FJwJa22a3zZbaj44iQG9Y
         8oug==
X-Gm-Message-State: AOAM532I8HWGWe2YWi9/T9mkqRnyvauB7PnQMJ4DRGmlM5/g4EfWR1KM
        feV5fBCPRikff62QEdN4VnI0tJhQjrGYYsYP5GC263XofKY=
X-Google-Smtp-Source: ABdhPJw2GWomkqhGx7OUe0hNneO8M8BgJYEzklAJXXJXhpoSYj2zr8JtOZfQU9Q/K8E5XyXCwFCXjZPADBbcpRNXD5E=
X-Received: by 2002:a05:6e02:2168:b0:2c1:a436:d18c with SMTP id
 s8-20020a056e02216800b002c1a436d18cmr34133735ilv.49.1646383084027; Fri, 04
 Mar 2022 00:38:04 -0800 (PST)
MIME-Version: 1.0
References: <87fso0qphj.fsf@vps.thesusis.net>
In-Reply-To: <87fso0qphj.fsf@vps.thesusis.net>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 4 Mar 2022 09:37:28 +0100
Message-ID: <CA+JQ7M8SF2cmZ7jagH-VdrZeR9Kfcw0GV=A1fpDeDubwJS1B8g@mail.gmail.com>
Subject: Re: gitk external diff on Windows
To:     phill@thesusis.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 2, 2022 at 11:32 PM Phillip Susi <phill@thesusis.net> wrote:
>
> I'm running git version 2.28.0.windows.1 on Windows and trying to set it
> up to run winmerge as the external diff tool.

This is really a Git for Windows specific issue and more appropriately
asked here
https://groups.google.com/g/git-for-windows

But I'll give a quick response here.

> contains "cmd /c" so I tried prefixing the path to the batch file with
> that, and instead I get an error that says:
>
> cmd /c C:/Program Files/WinMerge/winmerge.bat: command failed: couldn't
> execute "cmd \c C:\Program Files\WinMerge\winmerge.bat": no such file or
> directory.

I'm guessing you're running this from git bash, in which case try
cmd //c C:/Program Files/WinMerge/winmerge.bat
See
https://stackoverflow.com/a/21907301

Basically a song and dance has to be done to work with Windows quirks.

If you're still having issues, it's best to follow up in the Git for
Windows discussion group
https://groups.google.com/g/git-for-windows
