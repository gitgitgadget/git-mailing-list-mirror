Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74F41F406
	for <e@80x24.org>; Sun,  7 Jan 2018 00:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeAGAbZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 19:31:25 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44173 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeAGAbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 19:31:25 -0500
Received: by mail-qk0-f194.google.com with SMTP id v188so10296871qkh.11
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 16:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gGuNFhZojxVO6CRjyTm8aKazUZlntdhUlDn42H+Ayzk=;
        b=oe7S6DJrTU2rji1+Qm7iPEgogW5qDUvWDk1Ofwzl4xJCQFrzihyW07GbJIQV97uUvf
         7VUPpEbUVfOcG7AwK4EHPI08Wk9Z2/yvb0/pxQzHV7tgVAg77MlOq6y82YcQ3oGq8m5k
         dgtDP7AY1CoVE9RGYQskjPmbZNQ4lrUPg28kqsC0kj8NfjiXUCFctH2JBiU3UdUxFflP
         J6dWGvVMcK9RhQQ6aHybsfC2HZR32ytAtRZwmFkOnvwiBniwPJFGtPzS7mMBV92iYVUK
         nstipsyBg5x4CZ9AL773faURE+j2QemKt0dX3s4EgdQsehW5RkYsEHhA3+T2tMrfmxvk
         oR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gGuNFhZojxVO6CRjyTm8aKazUZlntdhUlDn42H+Ayzk=;
        b=V4mVOcxymm4w/qkuW2MgWcVJwIXPpf9lcZQJESZouqjlvk029lyxlvsZ5qkkZapRVc
         dJ07b8X56/B2JlD7cOTO2yURGyrcONzyWRF/5S1EedquGKND3tceC6yYPYFzxt9m7sI4
         bePA35R5WtPR7fc9ReHT248e/OKXkybADlYqH6S42AYB0vvwz7bnWVwbwFoXeyCG08YA
         rkaKQLp26s+202RmvsVtBGjGQQFOWTJk60d8sCyj+1rV1hExhRzCAhdPhmiNzVDwZxXY
         FsgwmSPLrasfWoq0g4Gv9JrUWLzxwF7gfbFPfeZZvlIC3dm4CGppEKUmsb5j+Oh3mUOu
         4YIQ==
X-Gm-Message-State: AKwxytchW6ua+h2uRbjPZNHYzEJ37QpnJgaW8OSI6q0VGjhefcs7UE1T
        X6PiztJm1BzisyPkPfoUuLy3mwS541Glac7cKtU=
X-Google-Smtp-Source: ACJfBouBHGMatk0ok7ScQ1Bs3yItteUP/n6ifRT497siBQR4uLgQQMfupWLmbgcbwZ9WtAgr8mDIAb+Y/0wmZtFHWvg=
X-Received: by 10.55.76.205 with SMTP id z196mr10219053qka.296.1515285084319;
 Sat, 06 Jan 2018 16:31:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Sat, 6 Jan 2018 16:31:23 -0800 (PST)
In-Reply-To: <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Jan 2018 19:31:23 -0500
X-Google-Sender-Auth: aXk-MT9KyG24eQfAAJLbZrkzeyk
Message-ID: <CAPig+cSh=Hv7x1J8nydSrbgbaLR+JLhXMqpR42a0+m=OgL59JQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] Doc/gitsubmodules: specify how submodules help in
 reduced size
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 1:46 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> @@ -63,6 +63,9 @@ Submodules can be used for at least two different use cases:
>      * Transfer size:
>        In its current form Git requires the whole working tree present. It
>        does not allow partial trees to be transferred in fetch or clone.
> +      If you have your project as multiple repositories tied together as
> +      submodules in a superproject, you can avoid fetching the working
> +      trees of the repositories you are not interested in.

"If your project consists of multiple repositories tied together..."
