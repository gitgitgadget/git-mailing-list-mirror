Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB133C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 22:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhL1WCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 17:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhL1WCd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 17:02:33 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D8C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 14:02:33 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id o185so30487070ybo.12
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbBvb6Xw13mL2XSzkz4tW/KsU7zTQTrUckhVb7Os9uA=;
        b=IrzVEP98vif+TzYyWYVOOM43ibglAoxD+QN1gUZ1tVHSvqj1WHC2K5BPWDmrjXOWwm
         KVMBSodsrNpoWZR5joRQwV1UZbjFfW8EMNTywX6Fo/eFjS/6CyOUefH4itKKiLyrr2t5
         CV2VpFXPrhuq2s4DmR7xjfxYQGoK0NZT/Jv4rkTcMW0RNvX6W7JBSETO9KSbSqqcn3KW
         K2YaKlPEg/GOb/DiE1eZABru/jIKCV9DsI+MJWL01kFhVZ1fm1Q1SqjSPaltPsXNbihY
         v+3hFjy2OjOaVpJ3V12hErx5ozmTSRkoQ95/Cr7lb59CgA5uHQkDRS7StRxoJdxiBbUg
         p0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbBvb6Xw13mL2XSzkz4tW/KsU7zTQTrUckhVb7Os9uA=;
        b=HEzSCei6UGUWvYpYw8Iqba+lVOBlDJpVToE+9rgGuwvZ0ivlYDRkpJ3tQAxInp9uoa
         R1BMf6SA/pFMnQ0XjnFkgfA/jxwKO9m1iCcfMWSKRIehdrl13beU10HHstRree6ZM4LM
         ciYzOyUT3vgcHPdBGUiN056PaX5I3r80fTPsyfgOxROcbZbmm16rV63Tcv7Sc93aGoqc
         KC+obNBsHLdDosZcD+1TGQ1v5E5nqYi+EycjMZyd1mMgXa4XJ3muoEtsYSlONfS351On
         fApDxO/McymjYCoMCcYdS7PixURPWSeZb/q7Q8JM7pke3Bv7XiUUrqZUCkK0NQhg55qr
         QJLg==
X-Gm-Message-State: AOAM531fIJSYODl9B72goFy1EZzuPl0LZAjtRh2Uq2uYe+OBOrWfJlZ/
        IfWOQ66iuW3KhyZ2yqmBEKF1F91HqFqpfZzwJAnUm2IRfUQ=
X-Google-Smtp-Source: ABdhPJwApk9IWlyDQlsGP7/nLS/N75LngvKBiMyIs7NGQ9KW5TiK5kcHEy7lgaTOujc8Nxso2NIu3gr/n9JfwyB2rnw=
X-Received: by 2002:a25:348d:: with SMTP id b135mr22144626yba.427.1640728952122;
 Tue, 28 Dec 2021 14:02:32 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD0ffHduEjAjEVrdstWMeLTqi-+4Rqs8fbUeULMpKYJ8Gw@mail.gmail.com>
In-Reply-To: <CAP8UFD0ffHduEjAjEVrdstWMeLTqi-+4Rqs8fbUeULMpKYJ8Gw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Dec 2021 23:02:20 +0100
Message-ID: <CAP8UFD1W+y6SYHA_EUEwAo3cWE=DmJLGxG54McW9cNtSr3AUAQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 82
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        Fabian Stelzer <fs@gigacodes.de>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 9:21 PM Christian Couder
<christian.couder@gmail.com> wrote:

> Jakub, Markus, Kaartic and I plan to publish this edition on Monday
> December 30th in the evening.

I mean Thursday December 30th in the evening.
