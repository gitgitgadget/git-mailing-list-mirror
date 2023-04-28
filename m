Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F2FC7EE22
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 11:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbjD1L26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 07:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbjD1L25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 07:28:57 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750264EE4
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 04:28:54 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-44048c2de4cso3339857e0c.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 04:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682681333; x=1685273333;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD6KV0fQhZayvj5QGf2ZT7PMJRsu6DFj0mb1psk1qhY=;
        b=Qhb93l4J8cI5QnVoocIvwz/oZbKQjuQfaQqA6t19T4dlZel2AXhESBWaijNGnCBGMo
         iBFZoHDtrMiGeDdnd9O6AUHsRNlSskmzAjxGPOrzPfVL2VUnabjpyrndmyq3KLEDRqhj
         TIJXvsENgSVq5dr0SvWAdkFiD50/e3V28aRU4cxVv/74if2dielMMgUkW2fcuDXT0wWX
         kBXdUub2Ls6R7bKnIU2mGiJDyaD8Anzao1wEhA7p4+nNLQn02LhTg+hC7AkWbVq0Tvv8
         MbUOgTufoHME8HCnAHuKKt1DN7bHlSb/BJZXeGHI7leiZxveTio7Tb+3K4PQYZCMxcc3
         44ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682681333; x=1685273333;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD6KV0fQhZayvj5QGf2ZT7PMJRsu6DFj0mb1psk1qhY=;
        b=HNV0RB6jW/THbcE4RCdKjPcIo4QEB+NUFPkTq0wFgBZLQNgm3sSpivM0pitLUO4IiE
         y3QW5XDM9uDzbV47RNSulCDVqtSNHrQCW0DS0kek5bn8bm2UME+YPl47WO/HB8eEujwZ
         VvIfU4WTpDDvccEPZLRONiScTjDvMZTpGXhtqiHLq+mLo1Rp+AmlqNbP25EV7jnhsb/x
         BKyIj3i46ru52tpnR9ga6IjXOHFhBmz4iNWB3bsu5EE71gojvv/Scop9imOtsIlRDTD3
         fuiAau5YMmFhvf1u94Q3FpktPU2UkXt3t4GDrhKeyLhNk6u/wP1wKmOy4odlteTO3uS7
         2KEQ==
X-Gm-Message-State: AC+VfDwym7KLMTLxCrT4ClCGfR3PoPsluPIFzKFkurjyoqcN6j+ARfxl
        lV/AhrjVe6RQ295cBHesbvOEyOxdtG1BjpLr5JMvnIQqVBIl6A==
X-Google-Smtp-Source: ACHHUZ5O8xDVjS8zPo6WsTbVL7vrGVKhpKwolVTCMCjJ7mrPUELQ3r9paP/v06BjXAngA+eAO1QySxTSrtAgxRqnq0c=
X-Received: by 2002:a1f:4352:0:b0:432:6e87:e6a9 with SMTP id
 q79-20020a1f4352000000b004326e87e6a9mr1653913vka.12.1682681333526; Fri, 28
 Apr 2023 04:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221001104609.18453-1-j.witteveen@gmail.com>
In-Reply-To: <20221001104609.18453-1-j.witteveen@gmail.com>
From:   Jouke Witteveen <j.witteveen@gmail.com>
Date:   Fri, 28 Apr 2023 13:28:42 +0200
Message-ID: <CAJ2ouawTq0b=1-+471u0c6XJZPVwM4f+dg0uNu4-B19332jSiA@mail.gmail.com>
Subject: Re: [PATCH] send-email docs: Remove mention of discontinued gmail feature
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 1, 2022 at 12:46=E2=80=AFPM Jouke Witteveen <j.witteveen@gmail.=
com> wrote:
>
> Support for "less secure apps" ended May 30, 2022.
>
> This effectively reverts 155067a (git-send-email.txt: mention less secure
> app access with Gmail, 2021-01-08).
>
> Signed-off-by: Jouke Witteveen <j.witteveen@gmail.com>

Half a year has passed and this patch is still relevant, yet (as far
as I can tell) not applied.

Regards,
- Jouke
