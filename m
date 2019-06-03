Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9E01F462
	for <e@80x24.org>; Mon,  3 Jun 2019 09:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfFCJ2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 05:28:37 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42096 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfFCJ2g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 05:28:36 -0400
Received: by mail-ed1-f49.google.com with SMTP id g24so16346320eds.9
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 02:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlBhU/oZmKtK9YXCXoKihhmJ/Lq8pvf2jd9ukdHnZXY=;
        b=jxkSyFAN/WRpgJJHA2UKX9vfcYWNEsdjUqOj8aTmwQ/llKxRH8VORg4ODWdtDK3CjK
         ZedcpAst/DGtbw+8la1DwqOlU4QueqkKqXsJC/xPe1nR8GLxxbMS3QIFFXiLf1IL+zYJ
         vDNwpo5f0HP51c9RmTLSJqOBnHM3jdkk2lZrC+50k3oY2ELHp78+Q1sL4ql+jVIQdnLv
         46c7vXSTOA7XDCmDd53pjuMAv3GwvJspkPYZGFaxsbh7j5YJMyraQF3UudET22TElOvG
         SWf8urCzrGgaFFE8DFXTbMWxHeLzWvZXk3m27UQZIuLxPy3R57WfjhhTmdYwSnlmWTPp
         rJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlBhU/oZmKtK9YXCXoKihhmJ/Lq8pvf2jd9ukdHnZXY=;
        b=kT76lOErnhPitDCBh1zjH4hfme+09dDwt5tKSp7qrJdDH+eHL4ezFsRxSYR+Rp+1HB
         GCCu8vUouu4t2uTU97Ku2fCrjI9aNFid8188UAnqaSSz6kXqbOBhIocEtgOowdYcMExp
         rvKp41RXDmBpL65CNA3DorbtBrC3J/ELtbphuO8KywpaMML9opcTFR31sxJS4hudDGQh
         4d1OfeBFhhA3pONDX1x77eOGAYBOdShSyehfbETjb/dP1bmezTqqI4xdFBlEEljdWFeP
         oWG5hoBzBCE+ow53dHlPVQecjFX/rAsLDE/nZQqIqf3vXLtdtM/tMEil63EWNRIvM7Xe
         ITZg==
X-Gm-Message-State: APjAAAWWrmK7gGmocSgNX3URshaKWsMLVdP2RyzkmbYVi8Ey078exVkt
        9DenpdGjPhh23OjDnMyxGOesCvd/fg2XH50fCbjnvz9DAjQ=
X-Google-Smtp-Source: APXvYqwTwJc97XOi63kXLOa0dEbHyGz66rAe5+Kgdh8agqo1gdi4VJrqdPhX8ZteCV3DJJqDNupbXO9zWnr9+CRScw4=
X-Received: by 2002:a17:906:79d6:: with SMTP id m22mr10183491ejo.187.1559554115140;
 Mon, 03 Jun 2019 02:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <BUJFK0ZEKP5I.16DDFWUTXGJTE@homura>
In-Reply-To: <BUJFK0ZEKP5I.16DDFWUTXGJTE@homura>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 3 Jun 2019 11:28:23 +0200
Message-ID: <CAP8UFD1W_tB34N-uAA85+QkHY6kmGWYYM47zceP3=5aTwxwvnQ@mail.gmail.com>
Subject: Re: [Proposal] git am --check
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 2, 2019 at 7:38 PM Drew DeVault <sir@cmpwn.com> wrote:
>
> This flag would behave similarly to git apply --check, or in other words
> would exit with a nonzero status if the patch is not applicable without
> actually applying the patch otherwise.

`git am` uses the same code as `git apply` to apply patches, so there
should be no difference between `git am --check` and `git apply
--check`.

> Rationale: I'm working on an email client which has some git
> integration, and when you scroll over a patch I want to quickly test its
> applicability and show an indication of the result.
>
> Thoughts on the approach are welcome; my initial naive patch just tried
> to add --check to the apply flags but that didn't work as I had hoped.
> Will take another crack at a patch soon(ish).

Could you tell us about what didn't work as you hoped? And how `git am
--check` would be different from `git apply --check`?
