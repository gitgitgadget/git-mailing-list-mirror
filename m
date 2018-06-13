Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EF71F403
	for <e@80x24.org>; Wed, 13 Jun 2018 07:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754452AbeFMHja (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 03:39:30 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36800 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbeFMHj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 03:39:29 -0400
Received: by mail-ua0-f193.google.com with SMTP id c23-v6so1083441uan.3
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eP69fKj0BJc+fYDafIZYFkuDEnKZjpngj9Ci6i2Luuw=;
        b=fFJG0t6mSB320V97B61IRLmxV4XX6OeO3w14kAAWRTtNIGvd05UQZewatRx7ot0vpV
         +WP8W+JiuJQjTQBFsn1pCeI91kJ8oN99rO6SJeeaBy4UEIpMv88qDTfHqBpfPZOw0K2/
         s4TiuJkMuHk3FsDJuAC2wO/um1lnOKBFFXVCaB2Te2eOgPmtLnp1DBGdMsKH2tgbyr76
         hPyeiBddZwzS/IBREYDAy2c0wlN9H+h/iyQsG6mFMaKiSjGYPOB2Wc0tcyAyHWTKf4Dq
         xIkPACoYbesEPqe4vU0f5HQNn/fp6aPA6nPWuuhzF+0zG5R5x4uUyc9elAcNwRb/Ymt2
         /aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eP69fKj0BJc+fYDafIZYFkuDEnKZjpngj9Ci6i2Luuw=;
        b=FuFgmqmm356syxBt7U8yb8Ac/unCsm14cHk55RzJ2kFYExvEsX4Cue7Ms/jh6U1PVs
         EykrVNy0CmnPeXGMpz31RteXzTq4oT9yQFZXlFZAxvqy0ej/38whBO41j2t7C12bIQPP
         BMT9VkGgCUw2UTgacMs5SQ64TrNu1kkcsdK9P+pEjj7s8XXFruEpkBiPyj4Z97uiIdnN
         8yT75KCUHPC0L6K9edPY2lGy9iQ1GSge0KI1SzpmyA5n5uj+HcNTNNd1WI7navk3SN8X
         4lHl5oxIHsT7xmeuZeGY9WPGiyTL+m7ZmqaNMU0a0KLAisxx68CTgDYV5D3wDR+1EdFC
         /Pmg==
X-Gm-Message-State: APt69E2XNvzR5niY60LJm7TixHApWMdrUxOvhC0g5AosTW3McF/Q4AC6
        4O6rVK+xbbh5/EHUZDTwBtFLwFu5CF70b6z/7fY=
X-Google-Smtp-Source: ADUXVKJzF36cqHb0qtWaVp8+fz0KqNckCA1EG78ZKtgdqJISW3wY9ExnbOzm5LOJ9iI2J5uvS167Uq5ZccQYOAfDAps=
X-Received: by 2002:a9f:3ac4:: with SMTP id q4-v6mr2531213uag.123.1528875568333;
 Wed, 13 Jun 2018 00:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180610194444.GA1913@Sonnenschein.localdomain>
 <20180611203541.GA6@606faba9ba17> <20180611205704.GA1399@Sonnenschein.localdomain>
 <CAGHpTBJFwToEwnk4P17AJ+z-55Nzc04OBbTvsbFRrkXJpfXAkQ@mail.gmail.com> <20180612085119.GA5@aaaa10152750>
In-Reply-To: <20180612085119.GA5@aaaa10152750>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Wed, 13 Jun 2018 10:39:17 +0300
Message-ID: <CAGHpTBJ9WiWdJw=SgxJpWqP9CucANatafx6iwCRCRY15wTBsVg@mail.gmail.com>
Subject: Re: [PATCH] checkout files in-place
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     =?UTF-8?B?5YWr56We5ZKM6bq7?= <drizzd@gmx.net>,
        git <git@vger.kernel.org>, Nikolai Kosjar <nikolai.kosjar@qt.io>,
        ivan.donchevskii@qt.io
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 11:51 AM Edward Thomson
<ethomson@edwardthomson.com> wrote:
>
> On Tue, Jun 12, 2018 at 09:13:54AM +0300, Orgad Shaneh wrote:
> > Some of my colleagues use an ancient version of Source Insight, which also
> > locks files for write.
>
> If that application is locking files for writing (that is to say, it did
> not specify the `FILE_SHARE_WRITE` bit in the sharing modes during
> `CreateFile`) then this patch would not help.
>
> Applications, generally speaking, should be locking files for write.
> It's the default in Win32 and .NET's file open APIs because few
> applications are prepared to detect and support a file changing out from
> underneath them in the middle of a read.

I agree.

> > It's less important than it was before those fixes, but it is still needed
> > for users of Qt Creator 4.6 (previous versions just avoided mmap, 4.7 uses
> > mmap only for system headers). Other tools on Windows might as well
> > misbehave.
>
> I don't understand what mmap'ing via `CreateFileMapping` has to do with
> this.  It takes an existing `HANDLE` that was opened with `CreateFile`,
> which is where the sharing mode was supplied.

I'm not completely sure. The file is opened using CreateFile[1] with
FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE.
Then this handle is passed to CreateFileMapping[2]. For a reason I don't
understand, when mapping is used, the handle is never released (until
the file is closed), but when it is not used, the file is being read, then the
handle is released.

Maybe Ivan or Nikolai can shed some light on this process.

Anyway, with Qt Creator 4.7 this should be a non-issue, so I'm reluctant about
this change here.

> I would be surprised if there are other tools on Windows that have
> specified `FILE_SHARE_WRITE` but not `FILE_SHARE_DELETE`.  Generally
> speaking, if you don't care about another process changing a file
> underneath you then you should specify both.  If you do then you should
> specify neither.

The problem is that even if you specify FILE_SHARE_WRITE and FILE_SHARE_DELETE,
the file can be unlinked, but it cannot be created with the same name
until its handle
is closed, unless you rename it *before* unlinking.

- Orgad

[1] https://github.com/llvm-mirror/llvm/blob/371257e/lib/Support/Windows/Path.inc#L1045
[2] https://github.com/llvm-mirror/llvm/blob/371257e/lib/Support/Windows/Path.inc#L836
