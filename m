Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A013DEB64DD
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGBQLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBQLA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 12:11:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F614E61
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 09:10:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5440e98616cso2075341a12.0
        for <git@vger.kernel.org>; Sun, 02 Jul 2023 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688314257; x=1690906257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYNWER7Jyr1JZOHhPcIhrhpV3MGKaJVs6NKoe1EI+Qc=;
        b=gpp5HUeNoHz6h6u/9aWY7OC8RSnfHmt7+lQ/nM8NTxLUFyOUYtTo+m99xpq6aim0lD
         pP51NttHtzMaiiood8kYH08oxxPPlh+mAdXwahzxWxYwjcr/LsOMi6aI0AKT2ST7PuOn
         w+MiBMRwUjqvf+3KZWbu23qjDsOiM8MiL3SXPeFWQ45XLzESNnmgHNr94rjZPGeirSx/
         AXxlSrFOWLJCqHtJdsoM1DEuKN3R8RDMB9WFd6dbQjYxlY3MN06hOEeB4+nLyyijnWro
         yvTqP20IKUnJoxP41+SJUIpl/Xm9hQ67hdxeiOqRZz4kVZ2aHnYWX5Z/lApjVV61u5/9
         hqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688314257; x=1690906257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYNWER7Jyr1JZOHhPcIhrhpV3MGKaJVs6NKoe1EI+Qc=;
        b=ZuI43ViwuOFDHOuNXW9n4wE/VIq4fbzGajIVDF/hioCzoMJmm0Y4i7k3qtqROb407A
         L5i/W1nJV9FFZ4p9kSBUkXjzBttMOSoGI1qhQ3o4NJcVD+jLKv9PN2/F2HPTn5H0K8fL
         qj7xrL6SU5IXMLSkDiGiVFiLZ89/vP4TrYtTwzvc3rgH5tJT6T0m7GuSVjcEbmGOuPVd
         ngLggXXNlTS5QxJmbSG6BKH1jk4Au+2Tr860+e1UieSWlUDSbi61zA8y5DyTsRrdh1I7
         pQvKFd3Ua0PGTbQ7x0owSVbqgvNOkU03jd8Ri3z4z+h7BIuTO70m56xocoNExLZ27KPv
         z7Lg==
X-Gm-Message-State: AC+VfDyR1RKFKBFwmNWTyUagmZNE/q5RAfHMtzRiAOo19d6WvGcfBEQV
        W94qFCj5fL3nAdSeQWq2tYtYuQstDoVIAfrapCc=
X-Google-Smtp-Source: ACHHUZ7JoBo5Ni03aDN4zwZzPSEQsBkLcY4qHxOR5P5htn1weOrbsw6YeEhHoYtXbiQ2nIC9vTjCbVEJg/GDS7EURRw=
X-Received: by 2002:a05:6a21:9985:b0:125:4d74:cd6a with SMTP id
 ve5-20020a056a21998500b001254d74cd6amr17445144pzb.3.1688314257480; Sun, 02
 Jul 2023 09:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <CH2PR07MB7334359246A319C195383C50FB28A@CH2PR07MB7334.namprd07.prod.outlook.com>
In-Reply-To: <CH2PR07MB7334359246A319C195383C50FB28A@CH2PR07MB7334.namprd07.prod.outlook.com>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Sun, 2 Jul 2023 18:10:45 +0200
Message-ID: <CADo9pHjpN10XytixtBO6Ous5BfdzZ8u=Qz5AAdKJfbbhMXXQBQ@mail.gmail.com>
Subject: Re: Who are you
To:     ross thomas <rossrecovery93245@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://github.com/bittin

Den s=C3=B6n 2 juli 2023 kl 18:07 skrev ross thomas <rossrecovery93245@outl=
ook.com>:
>
> You on GitHub.?
>
> Sent from my iPhone
