Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50961F405
	for <e@80x24.org>; Tue, 18 Dec 2018 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeLRROU (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 12:14:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42602 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeLRROT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 12:14:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so16359765otk.9
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 09:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=or9u7+hvtx/+dZ77QtyFEjz74oi2Ey46kx0Ke0n4iCI=;
        b=WKq2zSd8J6vUlRPcX4/+rG6+qLwRYauvm0DqFctPhyLUOdcVHb7vn5kgnRUID7itnd
         IdP3miu3P4hlQJ64G6IL4iMsjbZfmJJAlCciFH2mHsiyyVr+u4GcfrlRBWaHZAfOdbOx
         vPgER0zY/kPswFb968TLYQZmR4KCa2+hM7BdVLtuo/JAZvr3S4QoUucPDrhrt9jealGU
         ZX5/aB6BpbaszhanN/3u13EULDDalJoKRmGsFRfsAak25ES4EIRxDIVjH1v22Jnimizp
         bayAenuQuV6jq4IaEiknEDlC6YLZ20C4mvxsVOB19g08Ok5BKnh4G8g0GRYo+Ejwkvng
         lKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=or9u7+hvtx/+dZ77QtyFEjz74oi2Ey46kx0Ke0n4iCI=;
        b=B1YFrmdtQJzBA2lmFGyAvagJnEVsdnRhhZZxOM3r8oJrPJtrtLM184+ZmSTgMkynby
         fzorUQtDibgwIhm4ol+TivIIpO+cFW9guAASiEbn1YM1QnLY8vVqDxP6SYW3XFyAkIr3
         LtzBsdp0k78wNgBfC5LdivW2EK6chZpd6O5l2V9GudM/ae89CtpqLZkOULa4LYtlD/Tg
         uofW6yd/pPtYxME1c50Z5OZEp98oUQAf6hSSLyyrTjKVaIzmbtDonwTPM1Z9ut3BPtzd
         WIr2l9EH/+hGGgrLjFenn4powjZaBdTYk516vkow/gItKLl1xCqtFLHJekLh5PTBSY92
         xDTQ==
X-Gm-Message-State: AA+aEWbLE+8EB+RBuQyRz8q6vH5/GJfOR39zrUdXXumhI1QlZKVTQ9pu
        veZlI3Ikgw27OVVosEt6MSna8B39i5TW+FVB+UY=
X-Google-Smtp-Source: AFSGD/V5hMhfHSocdgoFM5GoDFVTmp0QyhuDYpw5NmOTtX8KbsbfhyUoBDyA7RtefZAmudFejfLbNjyzVgimor5yBME=
X-Received: by 2002:a9d:3a0a:: with SMTP id j10mr3233802otc.229.1545153258764;
 Tue, 18 Dec 2018 09:14:18 -0800 (PST)
MIME-Version: 1.0
References: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
 <20181217155915.GA914@sigill.intra.peff.net>
In-Reply-To: <20181217155915.GA914@sigill.intra.peff.net>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Tue, 18 Dec 2018 09:14:06 -0800
Message-ID: <CANdyxMzsf00k44TVkw+9uL4E3G_0rjYNgiMFK2o7MX83fCMPMQ@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Noemi Mercado <noemi@sourcegraph.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff, thanks for the feedback. I tried a variant of the command you
showed and it yielded a seg fault:
```
[ issactrotts ~/git ] ./git diff-tree -s --pretty=tformat:'%S %H %s' HEAD
Segmentation fault: 11
```
I'll see if I can track it down this evening.

Issac

On Mon, Dec 17, 2018 at 7:59 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Dec 16, 2018 at 10:25:14PM -0800, Issac Trotts wrote:
>
> > Make it possible to write for example
> >
> >         git log --format="%H,%S"
> >
> > where the %S at the end is a new placeholder that prints out the ref
> > (tag/branch) for each commit.
>
> Seems like a reasonable thing to want.
>
> One curious thing about "--source" is that it requires cooperation from
> the actual traversal. So if you did:
>
>   git rev-list | git diff-tree --format="%H %S"
>
> we don't have the %S information in the latter command. I think that's
> probably acceptable as long as it does something sane when we don't have
> that information (e.g., replace it with an empty string). It might also
> be worth calling out in the documentation.
>
> -Peff
