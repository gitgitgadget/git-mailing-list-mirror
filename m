Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B682022A
	for <e@80x24.org>; Sun, 30 Oct 2016 03:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbcJ3DQp (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 23:16:45 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38174 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbcJ3DQp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 23:16:45 -0400
Received: by mail-it0-f45.google.com with SMTP id q124so46055613itd.1
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 20:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v9ht4Mw87zOxxpktiNi6FGvBrnc1Ws1I1d3jYudZ4RM=;
        b=v+GdflbTgsJJf4Hv0pFaajcjdudy+FmyHyd+ZnaiAe/R/u8mCtOfJF//4eCuSuCkFT
         HUDyo8YZqIafcXalyovn1wHOOqCKh3CCfWlFunXXxWpuelv4t8qZ5r4VfTqJR/qmpSPB
         sN6XTqOwft2PNRJu0ci9phHi17XA4aK8gNj9BZf+nnbSqqVY5Ao4FMfeNX0cltFYKjYO
         YP9yA0WHFAJD/dQ9qWnAHOKPXipnnuJOhKhZzVuCbQMBFQTb6DOBNPWyE6MlT10xAaVf
         jpoMj2mjpg0Xpu61gY9fFiOD7t3oo1KEmeT5yNmzded57RSfDbHJV2T6XEjQ/fZ7hBx3
         HBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v9ht4Mw87zOxxpktiNi6FGvBrnc1Ws1I1d3jYudZ4RM=;
        b=B3GQ4Zi71fWMGYR9eF135JeojMlzQw+ZFJ6Op7EudEDuD0x85dITo9tc5ZqVbHngXC
         WL4xf50X2F+Sugs78LY+/j1xOpFHi1OSI8PV3B84eCqkHFmXhfvh3mk3c/9T2htYnpna
         KrOp6udep6TCLIPVLU/yEd78fzZlJPHYQtjWtFSNna0HBnPpbp9XMMbPg/PNmOewKmXX
         +KOc3vxfdRhSpuZh+OzGH9S1wxheJYjTVmk+ljkWVQ/zzA9lH9sK+1jkVzorsgkT1fgR
         UOunYNOME5TkZNMQ6R6gwt0sKJwSTGE1lmiwFKX0mloy9X198mq6pcC5ckHUZ8JWvk1o
         gjGA==
X-Gm-Message-State: ABUngvctWtls0rGXeTCU9tXjBi5sdk/0vRiq1HqYhKxGZfkG+N19LGd+4z5fCl4Suxahc99+oTL47v8oWPTfAQ==
X-Received: by 10.36.206.71 with SMTP id v68mr4525304itg.50.1477797404422;
 Sat, 29 Oct 2016 20:16:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Sat, 29 Oct 2016 20:16:13 -0700 (PDT)
In-Reply-To: <cc23eece-d693-9e40-78fe-3bafe6bcad3a@pelly.co>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net> <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net> <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
 <xmqqwpgt2ng2.fsf@gitster.mtv.corp.google.com> <cc23eece-d693-9e40-78fe-3bafe6bcad3a@pelly.co>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 30 Oct 2016 10:16:13 +0700
Message-ID: <CACsJy8CJMbLeyWV-V-DaQC2L9yfJnKp5e=F=HoL+9P-7bJ_yfA@mail.gmail.com>
Subject: Re: Expanding Includes in .gitignore
To:     Aaron Pelly <aaron@pelly.co>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 4:32 PM, Aaron Pelly <aaron@pelly.co> wrote:
> Or how about a new githook that can intelligently create or return the
> details? This would be my least favourite option unless it was
> configured in an obvious place.

I wonder if smudge/clean filters can be used to recreate in-tree
.gitignore from .gitignore.d/*.
-- 
Duy
