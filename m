Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435F81F404
	for <e@80x24.org>; Fri,  9 Feb 2018 12:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeBIMI4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 07:08:56 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:36531 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeBIMIx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 07:08:53 -0500
Received: by mail-ot0-f170.google.com with SMTP id m20so7527949otf.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 04:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i/Ruenp++8Eu9SdAkG1m+XTYlT/qA2wMki2J2U2+vRg=;
        b=pj497gO9bn0q03CDG+eOnjSjdHvxwM2Y4It+w4E22S2Azkfs7OT5If1sQohMhjwC6M
         Ah75Up64lh2cxi//fAbos0YRnXr3c3r/aABoZeh9oK/XxKvCqmW69pkHV6TpiWQiLQY2
         IrVNvlpy2xhTMrnQbacliT7bbLyAJ3xb9eDsNyAZIRv2r618y25PHClX//Xpwm4vL+O0
         BsIEieL7xleflVTZPdfV3iU5NDBJTIJMVnUBVM+j89bJZhIC0CTQ27pslHgPVJUwSFCv
         Aa4UZdIU7SFmzrmcrQzZskB+kr2H+Xby/H+K6XY/QLB/mwE2WK4QjwJpWrGhYPktktT+
         0juA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i/Ruenp++8Eu9SdAkG1m+XTYlT/qA2wMki2J2U2+vRg=;
        b=Nbld4+BkSap6ypap0K0qZufDx9w16BrfqDaLuc8+juLF+ZkrVwV+Xnvpbqa7dF7EBv
         b7YIYTkCWCzOaHA7ev8bbLGjdi8N8C/UJC7jQv1COxZ4zO1epFiEMXgtkJVKqBFzO9Hn
         CgAPuh27n0yYQCXxbj33tLcAEnHiHFVX+N6nyKbLHk4W9QC08/RltMrn8UHF+pvcojNN
         hNz++5OlTsFrdytNGfVMnJW1rdzjls6tpd807fRyzy5luPfib6Sr1UrxY8YyNBKhXbf6
         uGD3SCzCdXqq6Q9JJVu2lWroi+BEysQIEnimLDeE/WiQ9SjVf69TMgXuP14ZJXyXc8df
         CRkQ==
X-Gm-Message-State: APf1xPA8sHmjet37P4HQ0Fsuk49BNwygCINadPd5mum673xwW1q20V9X
        86E7gxGoSNzilPtNEOynL4ajYHqXlgurgJPXEoM=
X-Google-Smtp-Source: AH8x227aacFh3XMfKX1xUZsVsZ4JGCuQE/O15BCZQEKMJLmRdqujkd2qVx35qhavQCVhcHBERZ+VbQLsliujfW5WCSg=
X-Received: by 10.157.31.47 with SMTP id x44mr2099102otd.165.1518178133208;
 Fri, 09 Feb 2018 04:08:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Fri, 9 Feb 2018 04:08:22 -0800 (PST)
In-Reply-To: <20180209112727.GG2130@hank>
References: <20180121120208.12760-1-t.gummerer@gmail.com> <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-2-t.gummerer@gmail.com> <20180205021202.GA17847@duynguyen.dek-tpc.internal>
 <CAPig+cRLohiqR_Drh7P0q3XbvC22WLjNwH0YLZo3dqFzZZuAPw@mail.gmail.com> <20180209112727.GG2130@hank>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Feb 2018 19:08:22 +0700
Message-ID: <CACsJy8Dp1j5GJtHGowK+Vk4KBBUtqOkTfx3U0PNN9DmKO1e-mA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] worktree: improve message when creating a new worktree
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 6:27 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> This would loose the information about the identifier of the worktree,
> but from a coarse look at the man page it doesn't seem like we
> advertise that widely
>
> ...
>
> So given that maybe it would even be better to hide the part about the
> identifier, as it seems more like an implementation detail than
> relevant to the end user?

Exactly. I'd rather hide it. I haven't found any good reason that a
user needs to know these IDs unless they poke into $GIT_DIR/worktrees,
but they should not need to.
-- 
Duy
