Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A95EC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 21:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCGVEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCGVEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 16:04:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120C8A3AF
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 13:04:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c18so8658832wmr.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fangyi-io.20210112.gappssmtp.com; s=20210112; t=1678223058;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IaOzkJ6B90dYep8qelKtlmvCGBtpGyqeQheIBEPAyLI=;
        b=S4PydzdwViH7sFSdIY5AYp9rX0sv7QtsYDk7o3/Ar94LeUZg3qQYsfMmIW91SD/Ejz
         97L+LyDtc7T8qfahjk4V8DLr+77jGP7RHKK0BPge0hAiZiVJC+V1BcevHz27uk3mv0Zk
         A0fMZW7urnivZjg0YWYOsLivBSHZBmPj9wuf2jBf5HnfjpEIYMgB5bCWOegfeXUubv0x
         wiwbWQUizutgM/e+ihUO66A4TOtNvzQM3wdY2IjkHSDTBypzhcqDM1WGkq3ZarnHa9ou
         OrcvWSW5KBD1HRmnbJFYE4FvtMeU+WtOq+2wpuiIze/QIs6BRmaWOXKPTcSQD4Q0STZJ
         s4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223058;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IaOzkJ6B90dYep8qelKtlmvCGBtpGyqeQheIBEPAyLI=;
        b=kPOAIvLw/qWt7gm4lr2u9rk5Cwy+zhqf5GgFPmFETLSbvYoVN0UdbqLjkqcVc/9cfA
         dTHnG3b1ngTynm+s8aMPEiMB5TKxUCPopBAAEw6jsA1BbUf5m/lJa6GKiA4UMGsx6vM3
         s+9k0Nzp7vsV9moQ9VOXSSRyThUiIiR/+3BshRbh9qhxhHtfsfYWWShtF9OJwmdlTQd+
         DyeicjhbIT37Rv+EED3VDIvGnJiCBR/7a9CLk8Vq6/Ghd6EOM4J0V088U+j6pqQrVgct
         MP7u/Axf0Vp5RDIYGUhRRxl/W1uPhenb8EknUl3MU1GS2DaWMyyApyU47FZg6lNSARXW
         jRng==
X-Gm-Message-State: AO0yUKWU8KJ5KQadbanOJXOflUNf8wr9nZNOs6wK0rEjaqrcbhyi2UvL
        rAAwBIEUMFnDwnawpBwe0KrxRg==
X-Google-Smtp-Source: AK7set9MdtUwGU3ERrYZJ6yP6tZGm0Feo5FNPSqf85NmwQjdYg5HIhyjtn6H2CsFFwQTfZqf3xTkKw==
X-Received: by 2002:a05:600c:4e8b:b0:3e8:c9f7:b09d with SMTP id f11-20020a05600c4e8b00b003e8c9f7b09dmr15143451wmq.15.1678223058057;
        Tue, 07 Mar 2023 13:04:18 -0800 (PST)
Received: from [192.168.0.23] (cpc157871-brnt5-2-0-cust279.4-2.cable.virginm.net. [86.4.97.24])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c08a400b003eb39e60ec9sm13387054wmp.36.2023.03.07.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:04:17 -0800 (PST)
Message-ID: <007e6f051381d86da6881644ce300b6eea944194.camel@fangyi.io>
Subject: fz/rebase-msg-update (2023-02-27)  (Was: What's cooking in git.git
 (Mar 2023, #01; Wed, 1))
From:   Fangyi Zhou <me@fangyi.io>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Cc:     me@fangyi.io
Date:   Tue, 07 Mar 2023 21:04:16 +0000
In-Reply-To: <xmqqcz5snyxz.fsf@gitster.g>
References: <xmqqcz5snyxz.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2023-03-01 at 09:50 -0800, Junio C Hamano wrote:
> * fz/rebase-msg-update (2023-02-27) 1 commit
> =C2=A0 (merged to 'next' on 2023-03-01 at f28c0df111)
> =C2=A0+ rebase: fix capitalisation autoSquash in i18n string
>=20
> =C2=A0Message update.
>=20
> =C2=A0Will cook in 'next'.
> =C2=A0source: <pull.1462.git.git.1677434429160.gitgitgadget@gmail.com>
>=20
This patch is actually a hotfix for a topic added in v2.40.0 RC
2c6e5b32aa (Merge branch 'en/rebase-incompatible-opts', 2023-02-03),
could it be reviewed and included in the release?

Thanks in advance.
