Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7711FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 20:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933180AbdBPU7R (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 15:59:17 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:35530 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbdBPU7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 15:59:16 -0500
Received: by mail-it0-f51.google.com with SMTP id 203so115452258ith.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 12:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/MoqKah7TW/NTcQ+sFCPlAk1Ith7Zzu4WAlSnmge4Ks=;
        b=oU9fdfrrPR3iC84vPydV9o05PVFiUw7FphIkd8qctV5ijR11wVSvwn3bdcAHQwY4uo
         rAMtdCRUliRmU2M8Xml+19Ig00oPrZmzNZGWfgNn0PxuRvAM3zPJhRmpHu/SoWwtYp35
         cxWTvNCTHpEKml6mboYZJnkfv8mGwfsW2nQHbcuYCxe3dw1FXUsJ6H5uPTd3nAUkXbi6
         8LkpVNf6ssKWIYmKsI9ehl10GQgguQQx1oct/ZB0xV2ugFWybbk8JwOIF5jbj+a+asLp
         NWqPfnhEAGLfS+xO/joWqjn2pAxxd+341c6uW3bH/Jo6RaAJbosO8ttEZ16JYNxW4Udj
         XL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/MoqKah7TW/NTcQ+sFCPlAk1Ith7Zzu4WAlSnmge4Ks=;
        b=lCkvU289nGWDzljVHrD2liZy2M/9fsX9WphRLSRkc7s4F9+Bcn5KE+m76kF5l2u8Xb
         8PsbJvcr3W+LqPpe83KSSx/rNVvw2suyTQwwi2pr5vldGifuqxFhg2gTC7IhysxZ20Xi
         eKivx7Y5MQRkPGy7Z8crYpgyRQKZCbChn1YNnqkC4fiKB7mHC2Bc0hH3KdfTPSboQxrd
         T0qMMC8DiP4R0j9kEyrLcBx3zNiqz3Bm/EEeE2LYKWHGOdVLQ8s/g7VohTjTYhqsHJ+W
         cFX41Vb0UQhxZNZeZKUbEyhsaiidnLorouWZt36nE7brvzVcxZZTPfJUtjwoUI8S0lJC
         snRg==
X-Gm-Message-State: AMke39nJrS8wc54V62md2UfPclVggxtu5xDc9MtgQPPZLeFby1v/BSt2Hm8+qCj/HEV9WHNEV9uqmcEGDhE2dQ==
X-Received: by 10.36.79.71 with SMTP id c68mr4339783itb.47.1487278740175; Thu,
 16 Feb 2017 12:59:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.212.204 with HTTP; Thu, 16 Feb 2017 12:58:59 -0800 (PST)
In-Reply-To: <20170216190200.h362e52uxqlkduar@sigill.intra.peff.net>
References: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
 <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net> <CAOxYW4xqk4j6Uu86jq2Vi9Bpgihxfr2Tw-DQLc+7YTZiPmDtiA@mail.gmail.com>
 <20170215215633.deyxp76j7o3ceoq3@sigill.intra.peff.net> <CAOxYW4x93cjMJoXYzSXCwqYVEstSLLcxzad_BPdvxfasrkxapw@mail.gmail.com>
 <20170216190200.h362e52uxqlkduar@sigill.intra.peff.net>
From:   Fabrizio Cucci <fabrizio.cucci@gmail.com>
Date:   Thu, 16 Feb 2017 20:58:59 +0000
Message-ID: <CAOxYW4xF7iJFtYq6RPXROVRciVR970FZUZXhxS-aPx46cq6hVw@mail.gmail.com>
Subject: Re: Back quote typo in error messages (?)
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 February 2017 at 19:02, Jeff King <peff@peff.net> wrote:
> Try the "Quoted Text" section of the original asciidoc user manual:
>
>   http://www.methods.co.nz/asciidoc/userguide.html#X51
>
> Asciidoctor has introduced some new syntax (almost certainly because the
> original asymmetric formulations have a bunch of ambiguous corner
> cases). By default, it disables the asymmetric versions, but they work
> in "compat" mode (and the newer ones do not).

I can't say I had the pleasure of using Asciidoctor 0.1.4 or earlier! :)

> Git's documentation is all written for the original asciidoc. If you
> build it with asciidoctor, it must be done in compat mode. This is the
> default when asciidoctor sees a two-line (i.e., underlined) section
> title, which all of our manpages have.

And I definitely didn't know that, but now I'm glad we went OT! :)
Thanks a lot for the clarifications.
