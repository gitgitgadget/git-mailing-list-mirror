Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7DB1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 17:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbeLTRYJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 12:24:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35904 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeLTRYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 12:24:08 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so1440564ioh.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ed2LMmjkwS4WcYFJtkvXu6+M4u1H8/+og3JeFcnr4gU=;
        b=iSITfYIxSLROUGsfixDlc2ms0NA/C8O7P75rWqOkK3NULOwgcgBmYC2RtfVX/IKv75
         h3+jc3/SyGnMJR+3lil2Mq/8UV53FW8nRIOIWHA65k4PuFEjtGcgphYeLPC6zuw8+XFI
         ZjoZv4/dokupTEy1lHlMBCsBdFs9Xeg3S0X9ikPCrbxB+xOWGnJwcgBx1BUBcoVMcY/y
         Hj5WFHpTAxN+l69aV+wAJ2SAzyKvM+xVsCgFCe0YJpHDnjr/KqT/T7/fctddu5QGyI8n
         WwcFTYdq70C4f+zGObfqcCJeBQY47rjbo5SYP62dzvIugW8A8kLR0QCXaW6lD0TOvubf
         tL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ed2LMmjkwS4WcYFJtkvXu6+M4u1H8/+og3JeFcnr4gU=;
        b=jUpISy3cv0WDpkFvVJXTLNwdnCQ5wC8Pnb59tFgeDkDYFOOIp5nXWLsazbKNjhSqO5
         NRZI941YKLkDICzx7IDuI30Ao3CrMzSvvTq10FrTa3nXD1BvSXHqE1zU6fdALy8dgWqZ
         6XSakDWmGxIhaD9WvoJwg+E0yU5n0R9We0/1FJweCN+jFyNop5GhRiCTxDeV31sXxJ2Y
         Dr+R4BCazxMzFwzAFC7P2LJi/FwaMGBAoPaedsYZIURYXpdA4Mob0aCF9NImj5A/PfLY
         fSkULSLmbSxBNfzi1zdHSNhUnLqS4F9W+lG/YNAhiwyYlNiyJ7clBfMz7kOnUTsoHOvT
         K6Sw==
X-Gm-Message-State: AJcUukdpOyJH/h/kQSpkJ76nivtlmuMNtq7Kvdtg/u4ClAEadUnSKZtU
        8Oj6V5evBjdEj7UDcG4K3wQYMWgoYE8jOvPVkEFkIA==
X-Google-Smtp-Source: ALg8bN5foRzwA+8ZGO6IxPs33RPbEqTn8XguVqJZs8DHQ3wijSrAqR4b4YUHtTf8ZP0fVDmF66ltdlO4cQ+Ci6G7oA4=
X-Received: by 2002:a5e:d70f:: with SMTP id v15mr937306iom.236.1545326647952;
 Thu, 20 Dec 2018 09:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <CACsJy8CScTBbYJt_LLp-rBdmJubEQOZqkPQeszzax9YpbCPUkg@mail.gmail.com> <20181220171725.GB6684@sigill.intra.peff.net>
In-Reply-To: <20181220171725.GB6684@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Dec 2018 18:23:42 +0100
Message-ID: <CACsJy8AFwSgL-YAc2YU2XfqKFkXf-W+2V7tMy3ZOYvm_zhv5Bg@mail.gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with --no-index
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 6:18 PM Jeff King <peff@peff.net> wrote:
> > I wonder if --follow-symlinks would be a good alternative for this
> > (then if the final destination is unmmapable then we just read the
> > file whole in memory without the user asking, so it will work with
> > pipes). --follow-symlinks then could be made work with non-"no-index"
> > case too. But --literally is also ok.
>
> It's more than symlinks, though. Reading from a named pipe, we'd want to
> see the actual contents with --literally (and not "oops, I don't know
> how to represent a named pipe").

Yes, but I think at least --no-index it makes sense to just fall back
to read() if we can't mmap(). mmap is more of an optimization than a
requirement. There's no loss going from "oops I don't know how to
represent it" to "here's the content from whatever what that device
is". Symlinks are different because we have two possible
representations and the user should choose.
-- 
Duy
