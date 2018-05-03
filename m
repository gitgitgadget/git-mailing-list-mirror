Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8770A200B9
	for <e@80x24.org>; Thu,  3 May 2018 20:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeECUGJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 16:06:09 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42137 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeECUGI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 16:06:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id c2-v6so24570078qtn.9
        for <git@vger.kernel.org>; Thu, 03 May 2018 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oe1boJUHuCMQDUB92XOf6q/qnVAdG6ErtM2+Hy/3r9c=;
        b=SsDLF3dfxRXxEIzWLo7loRAAkm62uYmBjB6GmvOmM119drAaNeDalhwY1U0xqYQ6p/
         RhFpeFCpUJaZ3sFY8xQG2Ax59Op0L2wZfAHed/VVSEuthqmCaDTXMvnFMYyaiXMoSl5X
         P+al59+kFRdNz/uh8a/uHTxJW/2ZT44cY9MM7xraOb3iSHjYoglelzYWBraiVOz+6AUw
         tH4zgt+6+ifZlTSgBpRMYMZD/YXc7wU7g5VWBwxXRCKgkejiIxpbZBdPcBRo823ruqSL
         RiquitaEnDdQ0towQfLWv+4PNwruUMjYCq9YrZXX0YhXmifOLzxHFE/tb5Sg12vCeQ2R
         prDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oe1boJUHuCMQDUB92XOf6q/qnVAdG6ErtM2+Hy/3r9c=;
        b=VDZRm+jnJfiE7ny8oN4iGdnGLfO9lICwq88sbT2JTf3Zc/0F11RaljeTcj2+UdF7KD
         Qwp67n+XeoJ/H9giEELZHE9pq9H9nV/C0H6aX3L7BtdKVvQYyHDBeudW7BnI98hP1Y9e
         hJOOwChQvNhawYaqFOQYlA18/IjutiNmhlz48ORprFS7/sSZqoMe4sQN2dtWGXF3aerH
         2JQ7NmaL5lk99c2o629PYsc9B7ZtIQyqEg7A8JSC4QB+kO4H+YE6cAkQC4n0vfo0SGc3
         61eatpMDR3hOnm8Ma0QhnUFZu4WCJpjk5r3+dYvlxDP3LcdhSNOCYJEaKIHhoNCkDO4i
         zzmg==
X-Gm-Message-State: ALQs6tCMpv3bs6Y/drv0d1VRM6TPnSHwlYEX5SCMfzn7H93c4/e+LLlf
        YPKOXYSIiEK8hVNZNaF+diGLOkWU+ptXo2Hr9fg=
X-Google-Smtp-Source: AB8JxZqd29esNZ1vh8iMWRuw2S7MkKZSll6gosONyUqHj4kyYac4KnKRumkUmxg9WqnJku5RPJUnQiZ3jA39plzyNwM=
X-Received: by 2002:a0c:9e5a:: with SMTP id z26-v6mr21132574qve.109.1525377967374;
 Thu, 03 May 2018 13:06:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 3 May 2018 13:06:06 -0700 (PDT)
In-Reply-To: <23493ba1-1704-1e8c-f448-95540a36f886@kdbg.org>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org> <23493ba1-1704-1e8c-f448-95540a36f886@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 May 2018 16:06:06 -0400
X-Google-Sender-Auth: ruM4m0Jzh3EFprO-Gl8yIfsQSAM
Message-ID: <CAPig+cR8M3NPrJdsinakLoiFWS=adv1B7QH7Bwp-9ePr_44N_g@mail.gmail.com>
Subject: Re: [PATCH v2] git: add -P as a short option for --no-pager
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 1:15 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> It is possible to configure 'less', the pager, to use an alternate
> screen to show the content, for example, by setting LESS=RS in the
> environment. When it is closed in this configuration, it switches
> back to the original screen, and all content is gone.
>
> It is not uncommon to request that the output remains visible in
> the terminal. For this, the option --no-pager can be used. But
> it is a bit cumbersome to type, even when command completion is
> available. Provide a short option, -P, to make the option easier
> accessible.

s/easier accessible/easier to access/
--- or ---
s/easier accessible/more easily accessible/
--- or ---
s/easier accessible/more accessible/

The patch itself looks fine.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
