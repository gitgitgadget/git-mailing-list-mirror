Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2B61F463
	for <e@80x24.org>; Mon, 16 Sep 2019 12:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfIPM0J (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 08:26:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46571 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbfIPM0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 08:26:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id e17so33494711ljf.13
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5f5FXxcGLSg3hWL3+eoVrOo9HMI92PkO0Ptc+dzuTvo=;
        b=HOsPPbsSdpGvJMZneMx8pveEmQ6GQI7Uyhr0JPh568KYJ84XLesI4IjzwiYC7W75sw
         jGaldjX0X6tLmzQRBvxth4vxl20bngPyFegrC7IUPJFX0aD+j8lVE9aWj7TZ8hmlg8X+
         YXv+r6vnmTehOE4TbdhZHOwjIGASM8qx6+TqrtqR4PrsiWlh87RBsgbSkx6AjFp63qpZ
         s7N6RbTy363bxCFVy7Bw4ez7MeMbnjzXnDSv8BFsSQjfXN5SmXQvguh7QlVfznviAeVy
         1e9wsJxK98mjFl0rwgVndb75FuErXIZFKXGp+Y0JzeEKBwga5KbW+0RcpAN9gm5Y/eCQ
         9hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5f5FXxcGLSg3hWL3+eoVrOo9HMI92PkO0Ptc+dzuTvo=;
        b=W9IhmaTbuBdhXfMy2O12IE74L1kZuDz+tvS1SG3ooNx1clOXVe5OPIGB6g58bmQH72
         8H8uXSrYbCvsA+UmuLRWmPmWBz3kTFedO1eevOVyHD23OVI8LQ63S9dk3UO9aYkQVJ7W
         Iy++s2Wgi4p4w68aHx9xkIhrCSBJXWsMtSjjRJr5f3/aVF+AT5Fr0ruunyBgYktBOJ8b
         q35crdVEnuSsm5bWVYobfBSfcWdSok4OwyIsM20p1qZ8oN0iGlD9Ypedj0Yl9otuBMeP
         z+RLc3hdP90yTsTX5BLbJWqKfPmbBqVafTRAERo5NwBfYTSbSipdk9vudk4SFEErZZ7F
         LUpQ==
X-Gm-Message-State: APjAAAWu+kNHzQyVvnhGshehSWPgsnrlpuFbPMgWI+bb0q6YgeQxdtnT
        ouJ+gLbrrCDkpfZM7hA9lAYSARawcU2yajlJhxnH4+54
X-Google-Smtp-Source: APXvYqy6vpBPOt9xEDyLkX69yAWJkt9UOltM86j8S7M7HHmsb5N+BZCdmEFpsHW5bXe07UtnIVLT/AgO/mUp2r2OyRs=
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr183006ljj.1.1568636766056;
 Mon, 16 Sep 2019 05:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=LmC2VwGCdfRuv_G2mXTt2H8XMDGsLnHU_2oHGhvbdNsg@mail.gmail.com>
 <20190914091835.11236-1-birger.sp@gmail.com> <20190914174852.ybddibvye5pwrk4o@yadavpratyush.com>
In-Reply-To: <20190914174852.ybddibvye5pwrk4o@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 16 Sep 2019 14:23:26 +0200
Message-ID: <CAGr--=JWO2XGsiLcE6xemcsevTwEAVJA+OObmWU4fYOq5oytBg@mail.gmail.com>
Subject: Re: [PATCH v5] git-gui: add hotkey to toggle "Amend Last Commit"
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Sep 14, 2019 at 7:48 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> You missed labelling the menu item of "Amend Last Commit" with the
> shortcut, like we do for other menu items bound to a hotkey like F5 for
> rescan, Ctrl-T for stage, etc. I added that locally.

Sorry about that. Thanks!


Birger
