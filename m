Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9EC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJGJpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJGJpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:45:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A21205CA
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:45:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s30so6296100eds.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5r8hIkSIJ6J+F/GKs5Mx81tFsOA+1z95bY+YBnQXBH0=;
        b=lNcqudTyQkRZctO058Soca9XAh7v8PDqTBcCtGg6MnIxEQ/aZQkl1R3rM1HUvANnTT
         juIZiPm6vxZuRgPrU9A6M0ST4k5QbgKYwRwYJbk69we3AiAZTDOMaOxEk62TXAshASA8
         yuAnLpFGNfaBtcrA5ptA2OJvjsi67AW6cZknbDsn7hp5nD8iUXzanqj81w8OSiJPA/sM
         ol4bq0v80r1/ZGU/BZMi5HrRKriuEbecBzwoPd0JAlOLr9RXhEjXG8HiraGYbqh0Kqo2
         TVEBKmX+/K347BxmZi65c9dwj7uvMIHbYC/otax6hW8S/TlLmDIK5L6Z4QNQfMKUJPI6
         T2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r8hIkSIJ6J+F/GKs5Mx81tFsOA+1z95bY+YBnQXBH0=;
        b=zlj3HwEfrJDCHOGNLcqTkbFt2MuGoIWsjHNP0DlR9JT6NjUUj2h//TySIvDaFKvIRt
         C2BXlAS2PtwtsuAweYhT71BZwM5+Kb/XOvZueFXedcFFkao2eiz8ce7UGblqgC1HQy5+
         PBPdAazMXQ77VzRmpIbkeEQgn/4hO8VG/5XH4XEJFkFFBLx0XmvJ/dJpKuVAxcz7kWE7
         t/eAba8W04mr7mrv5bdtRYsYTm2O0m/1jhYwVxFJ0FIVQOTStFx9lNfFHiCymJnP9Pxo
         AzRuLCr2KfkO+abazRt+vOdu1yyJkthPMV1IiULjw3EFg7KU6VvEqfzN3tj2fz7B1/gG
         cvAQ==
X-Gm-Message-State: ACrzQf1BEBaEQIGJOEJ+PlWLKfGxcO4NjQKY4cPnGWoFaTL6JUHJEa5+
        emvtw9nXNYxjcjjJs5zWOiMmHYqMuymo9XZ/xo3/f2u8
X-Google-Smtp-Source: AMsMyM4p6a2342+VUBNprFPPAbCohMjVkBbLi4F6TpZ0kfBJICmHWKny9f54RoM3iAQEwjRk1PYGmlWBte1W2fdpyx0=
X-Received: by 2002:a05:6402:368:b0:458:9b5e:fd35 with SMTP id
 s8-20020a056402036800b004589b5efd35mr3796152edw.141.1665135900128; Fri, 07
 Oct 2022 02:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAApTLm9DJW6zARsbJOCEcahkuLHA23tCF=rJ1Vy0J+kufBfTGA@mail.gmail.com>
 <CA+JQ7M9082jsYsVtRCocAkXU5-C-=gs3vOvgP8G3CKbyz872KQ@mail.gmail.com>
In-Reply-To: <CA+JQ7M9082jsYsVtRCocAkXU5-C-=gs3vOvgP8G3CKbyz872KQ@mail.gmail.com>
From:   ddady <ddady1@gmail.com>
Date:   Fri, 7 Oct 2022 12:44:49 +0300
Message-ID: <CAApTLm9ME2GAvqa2+F7ZL8oLjOEdYPrgC2hP3uZLdypP-1fxAQ@mail.gmail.com>
Subject: Re: A possibly mistake on the "Git Commands - Setup and Config page"
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I didn't quite understand. It was a question?

On Fri, Oct 7, 2022 at 10:13 AM Erik Cervin Edin <erik@cervined.in> wrote:
>
> On Fri, Oct 7, 2022 at 8:12 AM ddady <ddady1@gmail.com> wrote:
> >
> > Hi,
> >
> > If i'm not mistaken, the path of configuring Notepad++ as default text
> > editor 64 bit version is: "C:\ProgramFiles\Notepad++\notepad++.exe"
>
> Can confirm this seems to be the default path for the 64-bit installer
