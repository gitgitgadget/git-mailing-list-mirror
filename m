Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749DC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 11:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C0C61154
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 11:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhJFLrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhJFLrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 07:47:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0DBC061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 04:45:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e7so2253181pgk.2
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y9MFLdH3lZ15jJe+lrU5wGndfFBrsku/HU1X/I/od/o=;
        b=LgiMosDCt24WXvULf5oV4Ky00zcG60jiropde0MpkEiup68uSiHct1DrkHvVHewNL9
         Mize7+b/En+laoBkJUOx/JFwaW6vcm6Gbkof9RqUpH9FEgPgwdStaRF6nyJ970SevuZM
         Ws0NhqnV+Zroj9DjxbS99P2t2gbSgn+xBt7I448Y7YMagBssr3LpUuRmqu/dq1/fFhLU
         j1yYB6RHqQqJhDz2stvn3hfxe+MQOr9c8sZMcAzHvDSHrvGhZujEdiKVtjbVbBOnvR0v
         w3dZQ22raYs7JGCPikYQDKfCfdbvROMiOHKEuzT8U0hGMRQsq5KhQo7B1x8syBYD3jk+
         727A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y9MFLdH3lZ15jJe+lrU5wGndfFBrsku/HU1X/I/od/o=;
        b=ORjOE9874DxHtO/abDcWD/81PEDerAgxsbYydB61xvoTeoq3nNqBEpgrO0YFSax0V+
         y5yNQe5gE9HIUsVJUnVF18m+zxDX9H7HRORwAoK/+whFKiVgX3jiOZlyBU/l7fk/i+sO
         aEc0Svd1+T5Mvi1amM56/9k1oV/luxf3isTQEYH62uGKFIB1K/af5KuyLrlOIAvvvgRk
         +O7j6zONPHGWNxBFTIOjm4rBqo5oKyR9phPwWZa3xow/KjveFSUf4wnRX3c/NInksavr
         We2MZvOTFbNj13WnggsTRKKLtPubXOyIcpjdDciC9PRMxPznGoxuIPciuKh7nAWXYQ9Q
         0EXQ==
X-Gm-Message-State: AOAM530JE/Qf1WqYl8OgENmKe8rHOp9im4whcnm4woK2q9GCJeJeKjso
        uxH3J4iOoBQCDI7rCN8IvyiOiobB7lmBT/YfYm7/mybO2N/6Bw==
X-Google-Smtp-Source: ABdhPJwRc4mP5jrn0lgT/wZ4A780RS6p/nU6Q2AThzQRVHrpoJluF1o8PY8ztmoTKaIhkl93fEhOCKcijFom75W9NxU=
X-Received: by 2002:a05:6a00:ac1:b0:44c:4dc6:b897 with SMTP id
 c1-20020a056a000ac100b0044c4dc6b897mr21074892pfl.25.1633520744568; Wed, 06
 Oct 2021 04:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1078.v3.git.git.1630087821429.gitgitgadget@gmail.com>
 <pull.1078.v4.git.git.1630090303445.gitgitgadget@gmail.com> <87sfxpvxcs.fsf@evledraar.gmail.com>
In-Reply-To: <87sfxpvxcs.fsf@evledraar.gmail.com>
From:   Mugdha Pattnaik <mugdhapattnaik@gmail.com>
Date:   Wed, 6 Oct 2021 17:15:26 +0530
Message-ID: <CAA4dvxgXNPDRB6okD8bdS_Tu=EEgr5pphxK1u4QCJjJYb=TaMw@mail.gmail.com>
Subject: Re: [PATCH v4] submodule: absorb git dir instead of dying on deinit
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om> wrote:
> shouldn't the post-image "! test -d" just be a test_path_is_missing?
> I.e. should this pass if .git is a file? Probably not...

I agree, this test should not pass if .git is a file. I'll change it to
"test_path_is_missing" and send an update to the patch.
