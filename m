Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE5C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861D661502
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhJEHOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEHOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 03:14:14 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8269C061745
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 00:12:24 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id p2so89123vst.10
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoiaFIoZoofQip47oggBW5GxQle41cXvc9xlzIBgWT8=;
        b=WPf6+Dj2CyBILvZTo95nChr2k/G2uv9Qeb+Rtvr8y/pe21wiAncVGgP6slThEQnK/8
         5LSLSPBCA/lHSspEpnBx7NKsTGa7KwNxCayGbhCn8jKuADdFaEROjmfCHhyQIWnubLnz
         iKuu9TEiGKnK68tlZ/jDwbimQK9zTN+yZfzH09G9WDIckHWXYFZhu0TKgGsNUMQKLoQc
         bNTWOhtcBdhaDCgZUbGt6wjsgfjyZVghVE4yraTTQfotZlYj4hTe3NBN/IUnevJKKdKz
         W9PmQ9UdXHA3qqSMVn+SgHh3gVa/H405rvVgGqJvE9DEInqR7N5HuoZowFRPFBc068Ki
         1SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoiaFIoZoofQip47oggBW5GxQle41cXvc9xlzIBgWT8=;
        b=juSnAr7wGl4QggZycKRh9bkTgEWHISo9n7I2Yj0px0x+pVZ/pEtSg13Qx2LivWw2YC
         AvRLPt8RDJKyQmO0Nb+cSk+EbvXY7ZBYf9V/ifUGsHc+wx+CHuoceqaMMSpTjKCoo/u5
         UoMhe4G6i4VcmNLQF1YvogvQHbvws/PHR4XAAbxnIB1kMCRqnm49U4iUGbtJqFSoyinY
         BpAPlQQnQr82iotEn9TgJyYkshrKL/FMJgXjMNlgH+lNh150TusAKCGRDLCDWmR18Ea2
         vc1ZDh58B6dzcRm40QW6E387Dj1VuCQduD11itMcEyLg+M/KH1Ie+TdFVjO0x6sX+LkA
         J47A==
X-Gm-Message-State: AOAM533sMQ79VzKHg88Nex+NHqBmDzN6Hr7ni7Gi1jnd6C769U1jXh2u
        gpFDBePC/KyoH+VIHiu+0bO6Uc0aaXJbKoAKWDLdRV694xVQdw==
X-Google-Smtp-Source: ABdhPJzuDpMJSheiWjCjF5SuUFFTLeUMHdEWN+Gkn4F23ICA+5FSdXRRL0tnjxb46dwgFTzxcPBwmFFaV8A2ls1lL6A=
X-Received: by 2002:a67:d51d:: with SMTP id l29mr16824753vsj.46.1633417943771;
 Tue, 05 Oct 2021 00:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211005063936.588874-1-mh@glandium.org>
In-Reply-To: <20211005063936.588874-1-mh@glandium.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 5 Oct 2021 00:12:12 -0700
Message-ID: <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on msys2
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 4, 2021 at 11:57 PM Mike Hommey <mh@glandium.org> wrote:
> A possible alternative fix would be to e.g. add `#define _POSIX_C_SOURCE
> 200112L` to git-compat-util.h and add `ifndef __MINGW64_VERSION_MAJOR`
> around the definitions of `gmtime_r` and `localtime_r` in
> compat/mingw.c, since, after all, they are available there.

something like that was merged to "main"[1] a few months ago, would
that work for you?

Carlo

[1] https://github.com/git-for-windows/git/commit/9e52042d4a4ee2d91808dda71e7f2fdf74c83862
