Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2D21F424
	for <e@80x24.org>; Thu, 12 Apr 2018 08:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeDLI6Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 04:58:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52888 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeDLI6W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 04:58:22 -0400
Received: by mail-it0-f66.google.com with SMTP id f6-v6so6371326ita.2
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pm68hKBEU78f45iLXPJakhuh+zj5t4cHbTGxfPe6Wn0=;
        b=BPiN7QXn5LCMU790h2l+G78Uffm1b9+s13wftEpW7iYzhtSYJoXus3Cx/p4QREFIoI
         nciy9Fn8GymEmjS4crylCz9hYAtXqFxvnj/NyA0TK95jsr2do4ximpMLh0arBLHq/X+G
         HhoJY3RbSF2Ua7WBnV+mGNCPYGcZlGuIkJiye+9BhIlyMJo4gjkGxp3i1SBNwfCTe+51
         bWpydl0JNIPe7/QuU1a81zrfmZYBgXMPbuw5UDRNawhpfqVkCAqw05oxLO7CFAK1pWb4
         mu8/S/sqQjwiH095oJp2Lypgw6yRRU8Lz6blo1NNsgQ+ysCq75CSHUC+i1esGqyPNmNE
         vghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pm68hKBEU78f45iLXPJakhuh+zj5t4cHbTGxfPe6Wn0=;
        b=MSp3QcSnXdFMYqoqFkY1gnhGoDflOqkMJS5dNv8BdI1B6euqO5QZjq0pn6cjNrn+3+
         7fuSWJM5nGv5oywKdodhX6+LmL+DvroDSxw0Bv2TZHzJ5Kijc6+dCVVhTkDL6MDb/25O
         x6bHJOMzau8ad+DryVhXo81BblXCacjdLfG2GYvh7WN+WZR9k+vFiYK/Q0z0c++UFeCx
         sB4ibZcJZG4e7lx8uIJqF+5cAZbCXy3kpxlxA0fj3NLakA2XCztsLWdXn1PLoNVtc8z3
         JjuqgKEY+O0TOBr+Q2eGuaQthOn8PPFArQsHrCVyh+3UKIVvmCETxZQhqJfKzKoNkabS
         BgJw==
X-Gm-Message-State: ALQs6tAmBYBR1ORgfe7L5pwlqsLIVFjJo4khWbO8QmsIPkutNtBLOs+t
        k2OgNhsCCfYDGovOO/Qq+AodxilTLNU1ddzpr+g=
X-Google-Smtp-Source: AIpwx49Q51OjSCH0V3geye0utNEaiP3kF3O07dx91NxdcBGnWPBV08yS7UFfxygpF22pTMpcNUX0suqneBf1Vkh+fpg=
X-Received: by 2002:a24:6747:: with SMTP id u68-v6mr6980itc.21.1523523501996;
 Thu, 12 Apr 2018 01:58:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Thu, 12 Apr 2018 01:58:21 -0700 (PDT)
In-Reply-To: <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com>
References: <20180411225534.48658-1-haraldnordgren@gmail.com>
 <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com> <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 Apr 2018 10:58:21 +0200
Message-ID: <CAP8UFD3j-MGY7jHQK52zVLYMB=1vhCSFKxrvQ1JsRW-Rmnn8Qg@mail.gmail.com>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Tiago Botelho <tiago@gitlab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 9:49 AM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> I think it looks similar. But if I'm reading that thread correctly
> then there was never a patch created, right?

(It is customary on this mailing list to reply after the sentences we
reply to. We don't "top post".)

On the GSoC idea pages (like https://git.github.io/SoC-2018-Ideas/) we
have been suggesting "Implement git bisect --first-parent" and there
are the following related links:

https://public-inbox.org/git/20150304053333.GA9584@peff.net/
https://public-inbox.org/git/4D3CDDF9.6080405@intel.com/

Tiago in Cc also tried at a recent London hackathon to implement it
and came up with the following:

https://github.com/tiagonbotelho/git/pull/1/files

I tried to help him by reworking his commit in the following branch:

https://github.com/chriscool/git/commits/myfirstparent
