Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E6C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B2C611C3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbhI1Hrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 03:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbhI1Hro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 03:47:44 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2BC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:46:05 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id h30so21095047vsq.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1TLaZuR4BEllVXr3xlLV5fz64IZXsUyZAySjmVw3o0=;
        b=OKpgV0jaIx51m3tsriPKAZANygtzeXEhKrucAtwgiWK+g5Hv6TPgUHGrAkQMz517fI
         cRIfGTIIZ9Pfpd9nRPsT6Dz5orLsgJx8uOPYIiuFKXDIjXmTXapYdSQX/IDb6TrxVuO+
         AHTKpM+56xPRG1PapeDMV33VVhRUIvEN0U1G51lre/7EuZoSo9EZzU9REzwGPjyBCKLr
         bi8gYBN70VkkODgGAS8EWxKSWn/CtaLGOuSqbP+uFf3C5UB5kVdCDg0iVhXVb/44kQho
         svErl/7dwnanv+32uq9DERsw3G7zZ1KheV8HHaW+y/21Py0WC2cUtvo7X63yberWt+VF
         YUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1TLaZuR4BEllVXr3xlLV5fz64IZXsUyZAySjmVw3o0=;
        b=ALxnqNpNxBRloGnKx35St3+I4VPngyK/NUMe5HQVSW/c0JFgei09NP7bxWLohETS4E
         LV2Qk13DnU9lxZPY95od1zuwpnVjjywfCjGLZuXJqWnuNuC7GjEp7dSgvueAISrg9IdQ
         iRFKlAREkDBAcyUHfn2qPojJLZ1iDI/Vr2TyFPgdVhigoKTedUZa9HZjKpOTlPad3odn
         PaIt6Q/JMAO6YcinjDGUOcAVDnjjaEoNABEPL+4dTUbxxnkIzosSy+kdRbSeVQlO//Uf
         JM6i9ndRox4BiWX/0D6gINdwWZCYWm2JyOecQEWf/Q78IywIkB+eLZ72jnlVVg+T6T9y
         fu0w==
X-Gm-Message-State: AOAM532PxiE1t+b1u4emCAzCcKiRU3G0RelP32bvYIGBAgt9ursHx2Jv
        cY+OUTaF0su6saYSmhRxF1OCKgtC/YgHzr++8uanCD3yE0v+3A==
X-Google-Smtp-Source: ABdhPJxb36/tpZGEZOnTojveSn9GI6vYGwgNX9EeV4haDxhoeNjhhR5cdzr5fs8D16YjlJaskC/pQGvGZ7ld52rit4E=
X-Received: by 2002:a67:fa41:: with SMTP id j1mr3446631vsq.11.1632815164914;
 Tue, 28 Sep 2021 00:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKcQ8=cyq46=eF8NZtUifmfHgWUphmHPYh4s3oQrHjiX2nqEmQ@mail.gmail.com>
In-Reply-To: <CAKcQ8=cyq46=eF8NZtUifmfHgWUphmHPYh4s3oQrHjiX2nqEmQ@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 28 Sep 2021 00:45:53 -0700
Message-ID: <CAPUEspinqCF7Y+Zc3VwE2wL6P8Mj7VVkjKvQk6XSzdufMmjjWQ@mail.gmail.com>
Subject: Re: Issues with newest version of openssh 8.8p1-1
To:     Kevin Kendzia <kevin.kendzia@googlemail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Something like `ssh -vvv user@host` would probably be useful to see
where the key negotiation breaks for you, but it is unlikely to be a
problem with git.

My guess is that your host key is still using RSA with SHA1 and you
haven't updated it by following the instructions[1] OpenSSH provided
with their 8.3 release

Carlo

PS. I upgraded to OpenSSH 8.8p1 and had no problems connecting, but I
am not on Arch, so that might be another possibility

[1] https://lwn.net/Articles/821544/
