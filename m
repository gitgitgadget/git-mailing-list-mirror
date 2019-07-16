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
	by dcvr.yhbt.net (Postfix) with ESMTP id 408B51F461
	for <e@80x24.org>; Tue, 16 Jul 2019 18:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbfGPSAP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 14:00:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34461 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbfGPSAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 14:00:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so9483455pfo.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FGnUUo1N5Ft+EG4TNFevAvO/gQ43XBIF0G17oOu+Yk=;
        b=Py5HsBJRcJZNZHcyopkc+7vIj1bDEoTwjIKzPc0iVR6eLN56U68MYtt+JbsogNpmpX
         wlWgjl34HyfaOqgr4zwwwBtxGtq8kpNwchYwA7hjSX5jYoWrprgzk3GPgEHjlE/jG9zA
         f3ja6FACjBOgRFUnLtuBMIdnq+q4N/ub+UkyD6f3grfKFRNDdub628ctHR+0SYttLYkK
         ez44JHkIV/ejGnXC7dEJ66fhc6wg4vdq2Z+xg2a2wqwsDx6L7Tn/dOnUKRTTQnR4/Qz8
         U0oFCAVDMcaJnTBgaOwXzxhMal/QagaFiiyDMUdSA2Wvg+CWxl8MCi8sa8OI1hFghCS8
         MBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FGnUUo1N5Ft+EG4TNFevAvO/gQ43XBIF0G17oOu+Yk=;
        b=S7YthOeJfPcDWNQAHFVbpFq71nQ0k/dP7wFjFmkST85x0S92/77X7nTWesljvT7s+3
         9DkWqaW3iWQAcIius6TpG8lO/UGZDTvEQXHk92w9dQWarhLYa22iIP5OEehI1H8ofunj
         xGm04g1MJd/jLrlo39TEOsl4wqrd1fdQkWsnqjNr3pWVPerEJOOjQVq/+CZuOKzdj4zG
         dQzB1yMrJkqUvaQkrRgcsWpAQb5hNDWmeK4JXVGrJox14NaPIlIiQIMHrHl7aORrH7k4
         FmOki11Crn0acNsCCkqcfW8H/4wbKvoEgWJIc6J1DqMbSLAQOrS2YDd986e/gDPx4Qju
         B3kQ==
X-Gm-Message-State: APjAAAX+G77yb+rRSF5myeLr3ux0p04LPd28aQ5Ils9+HM+5D25sxkHD
        QKVDTluakJ1sx3Zcc5URNzo6a6KerHldfoe4VwY=
X-Google-Smtp-Source: APXvYqzZqGfIcESKM+/gFDmrKN5Q8GsmO2pjsxhUBJl6sBi5C1uSxRAoohG4VVYAKYwRhyPpsQfDCWpKMFZhJmOPMFc=
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr37299362pjo.111.1563300012814;
 Tue, 16 Jul 2019 11:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com> <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 16 Jul 2019 11:00:01 -0700
Message-ID: <CAPUEspjCXe4ga9HrF=RwGfP3Wc6Et4JW5ZG5thihgQTUQss77A@mail.gmail.com>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 16, 2019 at 9:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Does everything else compile OK with your rather old compiler on
> Centos 6?

yes, they were a few -Wmaybe-uninitialized warnings but they were most
likely false positives.

gcc 4.4.7 aborts the build (even without -Werror) with the following message:
transport.c: In function 'transport_push':
transport.c:1232: error: 'for' loop initial declarations are only
allowed in C99 mode
transport.c:1232: note: use option -std=c99 or -std=gnu99 to compile your code
make: *** [transport.o] Error 1

Carlo
