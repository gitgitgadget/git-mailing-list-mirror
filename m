Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F41A2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 14:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759914AbcHEOzh (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 10:55:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36853 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759905AbcHEOzg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 10:55:36 -0400
Received: by mail-io0-f196.google.com with SMTP id y34so24425872ioi.3
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 07:55:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sgj4NBa954fJpisrCVQ3qvwRiVS/ynDvucFxSI59vXg=;
        b=kUohqbr4/N/DCezfldltr7Udl4u37p6f5SSOzms3QEbdnDhxxJ4W5v4XMJ8IJALuVH
         p8DwiPrB+WPH55RdE6jK9NmO+pdJUOvbK/48SVUMSKZTL5xdw+pfpmxra17xfjFJ6lHe
         IfYICw1TkICXXZ6gzbxr1QqPB9dVwOHXWPa8LUbbyrDwARGknxAV2dK3BVurX/bJJANk
         x7JWGp479kRHOLQPKSQLGJrtqu/Mk368dmTZr6S7hJy1Gz+4mxxkJmc8ckM25N595skr
         DUt55bz8NGsv6GL8OZ+9RTHkJjUGtS/7W6i2AKayAP58xfX9Hr9CA6aCTuSo2ji+sYM3
         Xn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sgj4NBa954fJpisrCVQ3qvwRiVS/ynDvucFxSI59vXg=;
        b=axCQSO5uPtAwtXP3GbkMF68jnNcaLBQ6IYnzDnAvcKGpSomb4sFqMi/vUJqBwHfLBX
         9eh9PIJzyM6faz7RjyORl+5L8/UYuRq2mfOs37PE8fGu3h1z6DCviTR3SehYnQkC1w3I
         a2pmjmwpSEldKIdfDiJ2etvt/UDCcGIm3o3FdXwSrH6NWkSwksJT+2QHgxpgkoAiGkSk
         sOvHNnNio42o4LFQwG/GRWrlM7rprpwJCQqF7xTqsFPvmCIjV6xJtqCF8XwvWIX/EeAp
         hpSyP8+8f1k9zdOV6FMnDslYkeBKP9Bd+d4+CcUDs9dWYSoamKETYwRy9h/6XEJobpds
         g66A==
X-Gm-Message-State: AEkooutc2FVD18Yj88y+gfWdh4p98GwZGAPMIBckBDlDGcGFJYkej2JNe4aCdG0GQPtElUUjgJZHTfck9kcfAw==
X-Received: by 10.107.159.147 with SMTP id i141mr78006754ioe.29.1470408935422;
 Fri, 05 Aug 2016 07:55:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Fri, 5 Aug 2016 07:55:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608031753431.107993@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 5 Aug 2016 16:55:04 +0200
Message-ID: <CACsJy8Bzcwfvhc9dQ2EehmAJ+kGwC5VHL4d+4Z-GfmM6e2+3wg@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 6:07 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> It would be a totally different matter, of course, if you used the
> branches I publish via my GitHub repository, added fixup! and squash!
> commits, published the result to a public repository and then told me to
> pull from there, that would make things easier. We could even introduce a
> reword! construct, to make the review of the suggested edits of the commit
> message easier.

On the topic of fixup and squash and everything. Is anyone else
annoyed that the commit title is taken for fixup!, squash!
instructions? After you have added a few of them, "git log --oneline"
becomes useless. All you see is "fixup! A", "fixup! A", "fixup! B",
"fixup! A".

Would it be better to let the user control the title? We still need
the cue "fixup!", "squash!"... at the beginning of the title, but the
original commit reference is appended at the end, like s-o-b lines.
-- 
Duy
