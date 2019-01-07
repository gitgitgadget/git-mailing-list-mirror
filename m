Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717C81F803
	for <e@80x24.org>; Mon,  7 Jan 2019 17:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfAGRP4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 12:15:56 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43512 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfAGRP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 12:15:56 -0500
Received: by mail-ua1-f67.google.com with SMTP id z11so358857uaa.10
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0/BNR4a2PBcog4RL/K7BAhywqHRYhDNH3hVvKN/ZFI=;
        b=USv5DTG0g16Mn2N5+3LkAOCBttOmQCRHOJay+GiH0XBbchRocrRvja/MrFTTvPeFdD
         zTXThQ3ZVyU82HeMVo8i+3d1e89Lx6TIrnhIQ9G/cydLiIMLi1nqZXnMVp5eTI6KnB4X
         pZABLoG0/30l5H4yOqOZZr0Cdw4FpKyiuxqrcwfN4yL+aBbBo2snYjGiTNGG2QCWY4+9
         /8vyLmZdxg3LudbrzVGBKpgjtOtTuGpii9d1B5MFUlVfoyM6XaHxs2EC3+tJswkLAv87
         wse3XbdjIuf7dvtzGSLKkiFaawTa4L9nPE+ouQQCE6oXD7YNG66oeRXaNS6OsxV/XibO
         Bpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0/BNR4a2PBcog4RL/K7BAhywqHRYhDNH3hVvKN/ZFI=;
        b=FqF3UwJ9PJmUM5KBhEUqWMIss4y186ZGw+HvxqhzOUSaFT33zj9EibY/z8VeyxEOef
         kmWtuQtctC5OaxdpcwY4SX1Dkm+CnIog/lAxjLAylDZ2sCYO5eF3NZTP6BHQPqIQOWYz
         5wv4JMb8H2sbSc8ik05F+purQMdvjSVwuOxf4qp09uc+fNECobUG+TZD5hcF2+N5AsBo
         f0bn4JjjBJ5TxldokVn8csyyv9rovP1VzCX25M2c/Hq+Car2XB2XLVgbk5wmvrrrX8Nk
         Zv91tgGY/7fzf0aeR46CcyUAcD2n06SYskn5/4e2u+FYwZBLnLzbkourN2bi1ODi+prO
         2JYg==
X-Gm-Message-State: AJcUukee+x0YoUibn7c4ZZBX7t/5eHTrUG+ytbIUR24AU0cG8t+an8KT
        cVTlHi6QuqICSmVINak1azqAu18KVVgy+51/doJIxw==
X-Google-Smtp-Source: ALg8bN5oAz6K2BQ4S7rugSdnW3cd/7ldrpa5tJk9YGrGECSEzBlBPtr6XHHeJbbiqQD/5tCKijmn192Obm94+9xY2uE=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr23699871ual.20.1546881354520;
 Mon, 07 Jan 2019 09:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com>
In-Reply-To: <20181211161139.31686-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Jan 2019 09:15:42 -0800
Message-ID: <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 8:11 AM Elijah Newren <newren@gmail.com> wrote:
>
> This series continues the work of making rebase more self-consistent
> by removing inconsistencies between different backends.  In
> particular, this series focuses on making the merge machinery behave
> like the interactive machinery (though a few differences between the am
> and interactive backends are also fixed along the way), and ultimately
> removes the merge backend in favor of reimplementing the relevant
> options on top of the interactive machinery.

Friendly ping...let me know if you want me to simply resend v4.

> Differences since v3 (full range-diff below):
>   - Fixed the redundant "fatal: error:" error message prefixes, as pointed
>     out by Duy
>   - Rebased on 2.20.0
>
> Elijah Newren (8):
>   rebase: make builtin and legacy script error messages the same
>   rebase: fix incompatible options error message
>   t5407: add a test demonstrating how interactive handles --skip
>     differently
>   am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
>   git-rebase, sequencer: extend --quiet option for the interactive
>     machinery
>   git-legacy-rebase: simplify unnecessary triply-nested if
>   rebase: define linearization ordering and enforce it
>   rebase: Implement --merge via the interactive machinery
>
...
