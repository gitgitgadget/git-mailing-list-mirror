Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1758C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FEF650BA
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhCPE7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 00:59:51 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:34523 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCPE71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 00:59:27 -0400
Received: by mail-ej1-f54.google.com with SMTP id si25so14289440ejb.1
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8PvElP9EkdVF/MGnSEDVI5lcYIRj58gTwEtSn802Ac=;
        b=fTrJC+oSfKsMKugihk1l8ifj5pOiVFR+kdwe2Qe6Ube+p9rtbCoJarGiSPxKqSadM5
         0aEI5/1DiwT+S4mdWm35q7s0YMqCuFGwRZKhKWgOpa0K5imjaUwx96fCYq9zlNqs2Dnp
         fnUe7yqY/I0gLIFUj7KvbIXEhTd1IzLLm3zIkDwEJvFvgubb+91j0fZPoI+GeuF4d8SS
         M2qyZKKIDi4wz71kvNT9DUM+knavPv8SXOxNwJZuRZ41ZVpPVoGTPF7gGrfQcazP9ElE
         wAyO9vItq9a1sOjOqTuL8efvJfuMGKNABFgguSsE8hOXQN1Spx9LA9UAvBvb+4vrQnBA
         1LWA==
X-Gm-Message-State: AOAM533cbIAx0XRN7KGy0DKcILlGX99oB2JVlsa1VzD5uX2yT+gz3n3K
        YjskkbovcxJ6NKV2AW2vutVunJugpRewGISV+Ag=
X-Google-Smtp-Source: ABdhPJz+BXZ7UP6bNFFfztlyBzopN6T+jEU7YdPns06RlfXLKTOvPdfbQyzEIllqXHDY3jdmv98MooLCDhGW9x6xkow=
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr27720840ejr.371.1615870765813;
 Mon, 15 Mar 2021 21:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615856156.git.liu.denton@gmail.com> <c889973be754336005d0155ce670f16e322df9c3.1615856156.git.liu.denton@gmail.com>
In-Reply-To: <c889973be754336005d0155ce670f16e322df9c3.1615856156.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 16 Mar 2021 00:59:15 -0400
Message-ID: <CAPig+cS900W=tu_=2dA4hGjRXnNDTEc=Ne4Rb=y9wy_C_4Js7w@mail.gmail.com>
Subject: Re: [PATCH 1/7] Makefile: mark 'check-builtins' as a .PHONY target
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 8:57 PM Denton Liu <liu.denton@gmail.com> wrote:
> Then convention in Git's Makefile is to mark targets which do not

s/Then/The/

> actually generate any precious files (such as static checking targets).
> .PHONY enables the target to still run, even if a file is erroneously
> created with the same name as the target.
>
> Mark 'check-builtins' as a .PHONY target.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
