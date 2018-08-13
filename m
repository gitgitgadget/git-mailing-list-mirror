Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B4A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 23:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeHNC1C (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 22:27:02 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37555 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNC1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 22:27:02 -0400
Received: by mail-yw1-f68.google.com with SMTP id w76-v6so14926831ywg.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 16:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzzIhwSxO4nY6+8UTdElM/3M8aRQTXI/jPLhbcDmNvo=;
        b=vAWnKf/flYiiVp6Csrrgn44DI/kVryIc5OxjiiomO29Bk+EGPI1/BjGC035VcmXL0+
         4fhrMPPdgjLVVLTfZxnGygL9/cx2ynqzy7ST8DTRACvpxZlQIBwaC1DPZ7KxUyqBhDb6
         z6YdzlRAwgTqLh5OtsXr2tXpV8xee/WQb5Tq044wFEcACvm4vRzINF0GR7y+lM+YPEuB
         wTVh7xFHqog6AqLKyyWQuFZBjTVQO5/Zl42j1TlyIhoprPGgU8tTnenRMZpdufMtVTMc
         lwu3z1dEu7p6BJVUdQ6TVEs4KRmYofZoOE6c3Ef3xFDg/vvSDenH5cWm38ZBHGgPj4n4
         Ibeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzzIhwSxO4nY6+8UTdElM/3M8aRQTXI/jPLhbcDmNvo=;
        b=sOG0mL+co+DMhHmwE7+/kwWN+6ezRFdArzwQcq6YEhcamX/sQQ8NgDYBfCYRh8w5p3
         n/uRH6VxHL0ktJhhlKa3inctY9FFr9UReLuwIgXODagbMUv3toIHpwBLR7pOtme5ng8D
         CrCREfyPq7uS6SFyMbykXwjVA8O84MOlsIBn/Mao7mqDOGldMi6+TFImHlwk+Nha4YY+
         tzwXEcebIew0M4c05GeM6Uvfej0WQspdxK1wtwQmbpmBq1uP4aTCfv+6cpM9uNagGG/o
         mNoqj9YHoxyYIQw6iRcNEPyjuw2gNXemeT3FV5Q23qQiFHmwQNMEyKYZNfze5crBQcrv
         9PpA==
X-Gm-Message-State: AOUpUlHghRhsvWyrnX9FWTCPGhGljibbQ8N/1o4WvnK5Krfgohc46o8V
        J2SPqonW+332W1/w/As2f8/P/4QW0aJFDgbY+fhtu+Fo
X-Google-Smtp-Source: AA+uWPzupL9K79B4y/68ghAT8kprDQqFIDJFxg5ZMq4+VBKqx0RGTMtG+i2VaIm4nfYL13TyIaJ2+O7ucnhPi2EWmWM=
X-Received: by 2002:a25:3624:: with SMTP id d36-v6mr10969411yba.292.1534203751944;
 Mon, 13 Aug 2018 16:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-6-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131412100.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808131412100.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 16:42:20 -0700
Message-ID: <CAGZ79kbypjBQ6gnULg6ZgMVDD8h8BMzkLK=SYKZo9PHzH7z5BA@mail.gmail.com>
Subject: Re: [PATCH 5/8] diff.c: add set_sign to emit_line_0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 5:15 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stefan,
>
> On Fri, 10 Aug 2018, Stefan Beller wrote:
>
> > For now just change the signature, we'll reason about the actual
> > change in a follow up patch.
> >
> > Pass 'set_sign' (which is output before the sign) and 'set' which
> > controls the color after the first character. Hence, promote any
> > 'set's to 'set_sign' as we want to have color before the sign
> > for now.
>
> I'll freely admit that I had to study the diff in order to understand this
> paragraph.
>
> My I suggest something along those lines instead?
>
>         Split the meaning of the `set` parameter that is passed to
>         `emit_line_0()` to separate between the color of the "sign" (i.e.
>         the diff marker '+', '-' or ' ' that is passed in as the `first`
>         parameter) and the color of the rest of the line.
>
>         This changes the meaning of the `set` parameter to no longer refer
>         to the color of the diff marker, but instead to refer to the color
>         of the rest of the line. A value of `NULL` indicates that the rest
>         of the line wants to be colored the same as the diff marker.
>

That is a wonderful commit message,
I'll just use it as-is.

Thanks,
Stefan
