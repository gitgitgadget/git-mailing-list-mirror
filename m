Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5E420248
	for <e@80x24.org>; Sun, 10 Mar 2019 23:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfCJW5v (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 18:57:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43841 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfCJW5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 18:57:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so2268548pfh.10
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=v0iYUTieLEKM/UwCKc0n32n83QYMs8XFV/kOzYpkyM0=;
        b=jwC7yN/orrEzbSL2qdiFneuqjtIJfJ05wQEn0D4kVpWc2FUAMLRwdpG/ngb+2apZy0
         skPILpoRVZ1lbUMyoMoOitudqHEYRGtj+tAZHRjmofKv/K6kV8EvtTGItLipB2eQcobc
         5a7TBXmNK38sRFn9mYF0+G8EuzDVhalBU3HZO1rysLtblVTqZb13bjKXG12NN2LXFB8Y
         pVjLBSjcmN7hs79IYrmaL48FUlTL2bGiJGkS9uCdtDSARoq5WLkaFNvNLYcOKMDHyudt
         y01NMg0MV79qxjf1105kpY2rSuOUwI//sTKdqjv0yVKDTdOirVySmnMajX7cnlIt+TTS
         hM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=v0iYUTieLEKM/UwCKc0n32n83QYMs8XFV/kOzYpkyM0=;
        b=HjqkvHzSOMWFIYr4i0d+0dYWRS2lg89l50wY0W8wTK1ZMplDt1Vr9wD20dK8ta/3XE
         9VevNU6/AsrlfwQ0U3gD5tAXwlIYMRl/MhuMnFHrqO05mNH45zMbO0yoGDOAfTl3odo8
         RLNBWt8o61xL+naJI4XbeBuXTSXngm2B3nJxB95TEEtgL9wsS6/KlquEc9QmfWa7Hq4Q
         8k4Om85OvAZ8Iu5ya6+kOAZ/zhF3/JYKV4yVcoRyYyL6qPF65RBao1I65LW+hi5qyuHG
         Cj9KCd3R6e7n91kXsM54+bWjAQuFbqaEPjGPVMSmAfIrkruuwu/Rz+eUX7+hS1GjjPGq
         NOOQ==
X-Gm-Message-State: APjAAAXqcUiYmmbihvbQngtlXRoI+q1Kd38U3m/1b70qzZ94vqX1fjGP
        Ftxgu1xDdwcf6kAWVZ8s55k=
X-Google-Smtp-Source: APXvYqxC+3eQliHs44jBIeuxReOQ8z58oZHwtDz1vpPhZQ3ErcD6z91kPi0kiZv8atCcKjn/eh2uag==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33mr937299pld.71.1552258670328;
        Sun, 10 Mar 2019 15:57:50 -0700 (PDT)
Received: from ?IPv6:2607:fb90:8066:1583:a2ae:f28b:247d:d87? ([2607:fb90:8066:1583:a2ae:f28b:247d:d87])
        by smtp.gmail.com with ESMTPSA id m64sm9412219pfi.149.2019.03.10.15.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 15:57:49 -0700 (PDT)
Date:   Sun, 10 Mar 2019 15:57:45 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190308095752.8574-11-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com> <20190308095752.8574-11-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, pclouds@gmail.com
CC:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <3A57DE38-A5A7-468B-9509-4244C285896A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On March 8, 2019 1:57:41 AM PST, "Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y" <pclouds@gmail=2Ecom> wrote:
>"git checkout" doing too many things is a source of confusion for many
>users (and it even bites old timers sometimes)=2E To remedy that, the
>command will be split into two new ones: switch and
>something-to-checkout-paths=2E The good old "git checkout" command is
>still here and will be until all (or most of users) are sick of it=2E
>
>See the new man page for the final design of switch=2E The actual
>implementation though is still pretty much the same as "git checkout"
>and not completely aligned with the man page=2E Following patches will
>adjust their behavior to match the man page=2E
>---
> =2Egitignore                        |   1 +
> Documentation/config/advice=2Etxt   |  13 +-
> Documentation/config/branch=2Etxt   |   4 +-
> Documentation/config/checkout=2Etxt |   9 +-
> Documentation/config/diff=2Etxt     |   3 +-
> Documentation/git-checkout=2Etxt    |   4 +
> Documentation/git-switch=2Etxt      | 259 ++++++

>+<new-branch>::
>+	Name for the new branch=2E
>+
>+<start-point>::
>+	The name of a commit at which to switch to before creating a
>+	new branch or detach from=2E

The wording here (and a few other places) feels awkward to me=2E I don't r=
eally have a better wording but maybe:

---
The name of the commit to switch to when creating a new branch or detachin=
g HEAD
---

The original has weird tense when using detach=2E

There were a few other places like this where the wording was "or detach f=
rom" but where the verb tense was confusing

Thanks,
Jake
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
