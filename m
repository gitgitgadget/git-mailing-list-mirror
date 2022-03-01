Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE226C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 21:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiCAVPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 16:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiCAVPR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 16:15:17 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119165C349
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 13:14:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s14so23771355edw.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 13:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QRy62WhhKOhXw5zzp12D9REUGfE9dcv+pYvjb9P14I=;
        b=ZyVyX2CiqLvt1uzjkFWWk56BLML1+8iP43b1hb0VPQQi5qKwu77WjAMz4NMwejPnvk
         JGd21wyxcTvy4nTTZAlwnw4/MGtGyZNRX33NPsEpAA2x2FhNlqF8Lne6tqBd1ikC2eNN
         ieSB7QN96DSbWP/gNJ84VsmefWhMzGxWBeToEyL7T6xSEW8yi3lsNM/72UFUpUbMgS95
         MPtNisPUKQiZNUD9QxhfUbs7lv7Fextb260OoN0OlQkfv+leGvT2lJNhwOiUVfv1QbOt
         ef7tseri6r7CV1lLo2Vlnv1XqLrN6nSUv+cQI+gElqiMJOyPV1weUaIoZ7pAyNLGxPaz
         FdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QRy62WhhKOhXw5zzp12D9REUGfE9dcv+pYvjb9P14I=;
        b=ks9Af775pKNXZ4KOJtTKLAchZIJRWpzrHT0CfNS8GBXlgc5rCRUJtEpDolrV+HAILE
         lkuizxQoUZUGBJgmEmj2di3FvY3hHwNLbgEl92d9bSf2Aze/CIw4sFZ5VCx6EZFZs2Aa
         UPqrkqQrJ3lcIT10ypww2K5HgLST92KS3h9cUNcHeDfzfOf8W5V004TYkJqzEkTiw3G9
         +xpbna0ktsGN/Vw1/wAkkqUvc8GQOYui0XD+RPfD/n9uYCXmNZF/BeXNWUelogLBxo/K
         OKNUGocwCUm99GHHjWWtoUtlna2AD4M3esxBWjyqUE7KMmqPUv24tYxat0WxL096/oRG
         MmxQ==
X-Gm-Message-State: AOAM533zKgtoMuBxpA2PVUrr50ON6dKU9orUN9WynPtS8JVPyPi1hW/e
        pel+fb/FZ7FWpF5hg1hHq742WdA1Cx7mKuLL3ox+tTNsZWfuOw==
X-Google-Smtp-Source: ABdhPJzTuDNpTgI87tnqVETW5FhPFEWOf3iKeIff8ohHz7g2/qbOC8/Q2xezFZjd2U3CQhSY6QuZNMo1JSHPTMwCm5s=
X-Received: by 2002:a05:6402:26cc:b0:415:b6f7:bfa with SMTP id
 x12-20020a05640226cc00b00415b6f70bfamr191457edd.42.1646169272604; Tue, 01 Mar
 2022 13:14:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
 <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com> <7cdef0ad5fb6fc1a16ee1cee27b9dec0300c8c1d.1646127910.git.gitgitgadget@gmail.com>
 <37f66fae-911a-62f1-4711-c9f6c7794911@jeffhostetler.com>
In-Reply-To: <37f66fae-911a-62f1-4711-c9f6c7794911@jeffhostetler.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 22:14:20 +0100
Message-ID: <CAPMMpojoe8DgUteRAfuXCHQNFH6vnwj-Twze5i3A62JsvTUWVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t/helper/test-chmtime: update mingw to support
 chmtime on directories
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 1, 2022 at 5:34 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 3/1/22 4:45 AM, Tao Klerks via GitGitGadget wrote:
> >
> > -     if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
> > +     osfilehandle = CreateFileW(wfilename,
> > +                                0x100 /*FILE_WRITE_ATTRIBUTES*/,
>
> https://docs.microsoft.com/en-us/windows/win32/fileio/file-access-rights-constants
>
> indicates that FILE_WRITE_ATTRIBUTES is defined in <WinNT.h> which
> we get from <windows.h> which was included by "win32.h", so it should
> already be present.
>

Grr, should have asked the compiler instead of VSCode's autocomplete.

Thx, fixed.

> > +                                0 /*FileShare.None*/,
> > +                                NULL,
> > +                                OPEN_EXISTING,
> > +                                attrs & FILE_ATTRIBUTE_DIRECTORY ?
> > +                                     FILE_FLAG_BACKUP_SEMANTICS : 0,
>
> There is a weird error case here.  If the GetFileAttributesW() call
> at the top fails, it returns INVALID_FILE_ATTRIBUTES (aka -1).  So
> the (attrs & ...) here expression is questionable.
>
> I'm not sure that there is a best way to handle the earlier failure
> (other than returning an error at the top), but we do try to limp
> along (for some reason).
>
> So maybe make this something like:
>
>      (attrs != INVALID_FILE_ATTRIBUTES &&
>       (attrs & FILE_ATTRIBUTE_DIRECTORY)) ?
>          FILE_FLAG_BACKUP_SEMANTICS : 0
>
>

Yikes, I didn't realize how negative numbers looked in binary (in C).

Thanks for this catch!
