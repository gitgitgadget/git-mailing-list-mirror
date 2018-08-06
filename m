Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C9D208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeHFUpH (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 16:45:07 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:43123 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeHFUpH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 16:45:07 -0400
Received: by mail-oi0-f43.google.com with SMTP id b15-v6so23943045oib.10
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=x53kbFTlWLzJGlMibqeR/JW1sp9Y0571OF33dXc9Q1A=;
        b=owwr5ewzKaZBx5l+WKseaEXvNaJ42oCj3XVI9eILFwnN+As0nkCGEt7fJovt4KSUUM
         7twkHo2y3D+CtKkSr4qPsCeLRNPu0RAjtF5G1SZBxsZo714RwRZjdlgEYlx9WZrnno2i
         NzyQ9/j3JkJUkXZgqOwg/H/pXpaz9ur1xiEBQNnZqajRxJeOZsSbjjm1sPlIxFaRB5QB
         XiWl0hs8O0UQDLYACEus1fAzTZVmfzs/f4f1FdPoYym53vEZIbOTm9hWJkGwbMQHliyI
         S8SwCFmZVDKIxEK71f3rjekFB3MMO+5OTpCA7Lp4Jzi5ez4/e3KP9CQ3g1knxW317DG7
         fYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=x53kbFTlWLzJGlMibqeR/JW1sp9Y0571OF33dXc9Q1A=;
        b=O7NjBwAqC8VnF8qflYWDAyoj4WTmasV39k0JsR7oT0ocVDD5OiRCWM1FHgl9yVKxjV
         kO56ZD+qczDYoWd0mXgOxmby0EzSuD2+PZm0qDdb5UMxlgJprZGoaQNkPdMn8NgT0cP1
         oaQVSjWH44U8eUwD9LYqARWCh2p4+0Yu9yh7nD3QZr9QSjBB+AL7hIw5GVs3Xnu0YUqp
         mWaxg8qUblSM73wRmaJD6fszLpjDJd8Agk6WnvWUoel0vscRH70vuNn5OGsT+VgpnvsU
         zAWCT1X6rPnx9QvWlcXqkobbOPyiLW3UTFHBEsctxAg1f1g96FozmUN6wD+tYN2BTbCw
         e/3g==
X-Gm-Message-State: AOUpUlFUHcci+/RZsq47vdWlSWTAY1sG7c0MLFijxq/36NhQZwW6W+Rm
        NhfmTzaumXGQtunYi7qXJW99QzyC35G3RLyqb6BKOwco
X-Google-Smtp-Source: AA+uWPy/lNQRi5R7rKA31Dc1msdFH7CP62uRHO4SLOAY9I1/ykRPxcL97lk3RtQhCIbMKU5o/hKJ2dc79ljlLxYcPLY=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr16635717oib.115.1533580486058;
 Mon, 06 Aug 2018 11:34:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 11:34:45 -0700 (PDT)
In-Reply-To: <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org> <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net> <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net> <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Mon, 6 Aug 2018 14:34:45 -0400
X-Google-Sender-Auth: OrkpRgqMxiXAj1dQaQjMFKWDec8
Message-ID: <CAM-tV-_=nbo8T4krCRoni9F5JyZ41oxHZLGnuPgshHw3ZZMRWA@mail.gmail.com>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 June 2018 at 08:47, Noam Postavsky <npostavs@users.sourceforge.net> wrote:

> I'm still having trouble getting a big picture understanding of how
> the graph struct relates the what gets drawn on screen, but through
> some poking around with the debugger + trial & error, I've arrived at
> a new patch which seems to work. It's also a lot simpler. I hope you
> can tell me if it makes sense.
>
> Also attached an updated test-multiway-merge.sh which allows adding
> more branches to test different sized merges more easily.

Ping? (I got some bounce message regarding test-multiway-merge.sh, but
it does show up in the mailing list archive, so I think my message has
gone through)

https://marc.info/?l=git&m=153036284214253&w=2
