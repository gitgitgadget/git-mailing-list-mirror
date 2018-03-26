Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1926D1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeCZSJ3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:09:29 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39462 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCZSJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:09:28 -0400
Received: by mail-wm0-f51.google.com with SMTP id f125so17086872wme.4
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KWc90gnotiyS4/kwvu8d6hfJp5ZGhq0GcYANbmgZS74=;
        b=JwXb4OXFAdaQaVlokezleszYdGM1KrpHpLVZFt9zPrE9jOzroUHPXZUuXnoPkRqyOc
         DGQf5FwUXTfc7A0RTe2bKb16w4pBx/oEECvpRrQOvuMyZWcjdhJm/tLUHmF97QEOPOGG
         F6QIgRQ831VT+AxlVH3yDqtRFb0UyET/H3GIL7nvpWS0m/D4d4j5/kK0b0sBD6/v+w1t
         8UkKoX39t/RXFymizSK736+Ckeb5nFMyrWPhLZjgZtt7XDqNTY7F/kYhYf54iknva7CQ
         aYmiTVuHTwCzxKzM3/kr+GG7Y+IiZ1Y0dDq3x4gqnhBCJVIQDu7Jw1GcZWh/lHzJF5d9
         e8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KWc90gnotiyS4/kwvu8d6hfJp5ZGhq0GcYANbmgZS74=;
        b=cy4KmLX8Io8nP9J17BgHuplGFTQMrsYjR4897WqTsV4tmztGXXDPNVddsrK/qih5Gv
         jo5zs7JzVSbrN+Dpecmurtl0zx6s62QlvxyGy1mEZE/3tjFW3UX5LdHc8JSNQ2Agrhaz
         rKv0ibee7aejRwX5scjmLNQ2ArzS+kvhYWOyIzLDDdsxepzBBMlbkpbyYfslmtAm7OQm
         6YAN4nvljMyPzEjuLeTmejI320tMU16V8DRvav6Y9w9o4TuHDlvWnvocKB/ceD4Egmou
         w62qweKejnxMec4kfxUa9FGAC7ExG9AGwfDy/DI9uqqeJbn70rMyj5X+93ZwPgSuecN6
         b7IQ==
X-Gm-Message-State: AElRT7H3isPPhQ2B6mDzHB68SOA8X1KHA96IbBxr+Oew/7nYI2tbkAbU
        wmsnlZOLXxRL2BSOmcNFtMs=
X-Google-Smtp-Source: AIpwx4+jvILQj8sDQTRRtcbnTHB4gTstVKSaQbhQr58PHDMn88n6bSVd8GWHOIjQS7sYHr6GehkRew==
X-Received: by 10.28.63.136 with SMTP id m130mr5876056wma.69.1522087766621;
        Mon, 26 Mar 2018 11:09:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h132sm12026099wme.1.2018.03.26.11.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 11:09:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
References: <20180303113637.26518-1-pclouds@gmail.com>
        <20180323172121.17725-1-pclouds@gmail.com>
        <CAPig+cQ=u2xVaptpVzVd3g_RO+9kTWVitD4V7zpZFuL+a3wmtg@mail.gmail.com>
        <20180324053144.GA11420@duynguyen.home>
        <CAGZ79kbkc2d-EHDTWP1GvCU62=ogZbP0ffxOHZamdQK+3h1yJw@mail.gmail.com>
Date:   Mon, 26 Mar 2018 11:09:25 -0700
In-Reply-To: <CAGZ79kbkc2d-EHDTWP1GvCU62=ogZbP0ffxOHZamdQK+3h1yJw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 26 Mar 2018 17:45:47 +0000")
Message-ID: <xmqq8taed7ze.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Thanks for driving this when I was away!
>
> With the fixup patch, both series are
> Reviewed-by: Stefan Beller <sbeller@google.com>

I think everybody involved agrees that these two you cited above are
already in good shape.  Let's have them in 'next' for the remainder
of this cycle and go incremental, and merge them to 'master' soon
after 2.17 final is tagged.

Thanks all for working well together.  

