Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFFB202DD
	for <e@80x24.org>; Sat, 21 Oct 2017 10:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbdJUKtR (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 06:49:17 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:54543 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdJUKtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 06:49:16 -0400
Received: by mail-qt0-f194.google.com with SMTP id z19so21232785qtg.11
        for <git@vger.kernel.org>; Sat, 21 Oct 2017 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Vybq+pEnjic9Je8guMi0/x1CuVAZLUfsz9qSeA1ypOQ=;
        b=XLVXzE6PlOUMEEBnOTU/GfIeCA6K5hschyTwKIi8h4Jgx6NlDfYmPKYN9xq5DJY14M
         DgNuNRY9HrMwQNufCfPTAY6keI60QoCd6XWhuHLEOHrPp3QfN1r7W/VsyC7zF03LwlSp
         NRQv138/EYtI7VJYHosMja+/p7srxipeVQ9k3CEdunWyP6E3KSrfKUqlDdnAGU8xRuSe
         1bGMo+S+7c3d185D5avXxEZMYgsQNuz/3aLwFptMwDj4shjYjVQgXa5eUi/i+5V2EYUA
         2/ZFGS24QNoDyRYYmWcxdW3/NdO0/cUc7OgMmzpc1Chko/gvfVvUhba2iJfAsWhYYm4C
         OhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Vybq+pEnjic9Je8guMi0/x1CuVAZLUfsz9qSeA1ypOQ=;
        b=pBDN01Y0KEyUzY6L8Kc/y9X11DR4tJrqGAqugtm1K07FGfB8wC5o0Jox3OXGxorUd6
         YsRZgPseMtod7s0xckyN+0fkIp0gW9vuaNh+uHX2ihmK0teeQxtjI+9D3WtyukZzXpIs
         NWi9xV2vd2rC//B6wOw2K+/sbY1oE75AZEX6ySl37U/Gj7azxEzXksJ2OdtH1VuDr9AO
         f50DY4g/ey3XwS65zAJY+r8u50j3MLd6+tVD3gzBOub7uZMrDkNqc4ZLcM7DghNmGQkX
         S3QPNeZojgNGh36zYO/jMbW05tpJWxDK9HcY6Rc1cU/NScshvnOF6y9JVZgeg/b0CW2C
         /eig==
X-Gm-Message-State: AMCzsaWi7zn5NXD3K3mdUfw4zDd5auUjIVImpyx/e00UtSvBVcg1ws9E
        j/MELkqekVmDf8kDW2a3gALgNtCLZJt9hVIte7M=
X-Google-Smtp-Source: ABhQp+T9ZFoxR4pBHVnnqcrch8FxBUxVbuaX0fWnK4jbj/P54+V/jzl/qYGBYOjPv0rtZIYqpEl1uIK0hDzw2v0M1KE=
X-Received: by 10.237.34.82 with SMTP id o18mr10924104qtc.19.1508582955932;
 Sat, 21 Oct 2017 03:49:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sat, 21 Oct 2017 03:49:15 -0700 (PDT)
In-Reply-To: <20171019174936.izojvrh5w35s3adi@sigill.intra.peff.net>
References: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net> <20171019174936.izojvrh5w35s3adi@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 21 Oct 2017 06:49:15 -0400
X-Google-Sender-Auth: KKCfo09Bk6gSgph2_5_DUfArmt0
Message-ID: <CAPig+cT3=BNcM+WZWhpAq6Ch=5xC47oW_S-9=YfEQL7rRkyPhw@mail.gmail.com>
Subject: Re: [PATCH 4/4] worktree: handle broken symrefs in find_shared_symref()
To:     Jeff King <peff@peff.net>
Cc:     Andrey Okoshkin <a.okoshkin@samsung.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 1:49 PM, Jeff King <peff@peff.net> wrote:
> The refs_resolve_ref_unsafe() function may return NULL even
> with a REF_ISSYMREF flag if a symref points to a broken ref.
> As a result, it's possible for find_shared_symref() to
> segfault when it passes NULL to strcmp().
> [...]
> We can fix this by treating NULL the same as a non-matching
> symref. Arguably we'd prefer to tell know if a symref points

s/tell//

> to "refs/heads/foo", but "refs/heads/foo" is broken. But
> refs_resolve_ref_unsafe() isn't capable of giving us that
> information, so this is the best we can do.
>
> Signed-off-by: Jeff King <peff@peff.net>
