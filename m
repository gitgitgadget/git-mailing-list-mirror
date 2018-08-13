Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239261F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbeHMWCe (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:02:34 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41631 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbeHMWCe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:02:34 -0400
Received: by mail-wr1-f45.google.com with SMTP id j5-v6so15179652wrr.8
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zfhULkPZ4nTrjDTm5Iyml2nWoXOKCNKHVArgDt6ye+A=;
        b=VXRljaXGBa1cDoQ5WJpi34auAN+EyvbSOjwngUpg2YgaqGEmx08wERSiHXq9o6YxMT
         I94IfeZs+6ntrcj77pXnGFM8dBMFwSZ7XBFiEQCWWGvQ769AkeJ6wWXTC1gvjc4qTX4r
         ZfTrtP84LAl6+iZlToiytFqJ7iycNke91UTqzcjNLk7vbddYPzjxLRaZW5e+qj4WMKjk
         MqTg8ibyAqWxdwtwuHyf7sIodH3EcdRBonzPQuVGGW8MVinIszbqzHvxVXv25Z5UbyU8
         9U4sruGtqtiqz50zLRJzkPKx3BBg+IOW8BuUQDw5bFwckTLibk/iwNvtFjgMFBwyi5mX
         F5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zfhULkPZ4nTrjDTm5Iyml2nWoXOKCNKHVArgDt6ye+A=;
        b=qKg+GVJgMV83jdizAqpfHWUE/NHBEoRDPglc3Pe82srP/UUx4nxdvJB/VcAvfgEPbO
         fE7cS8WCrvyREJIqtuAQGP6swJwMPXQsK5PLr2VTzaEVOgK5q4g9f4ma8B9n8VPRRwNY
         nhcTJgYjUk/wMtwUo1t0GpSTKz4kYrx2lTPJhQqjQI3/DhEdSkIDqf4BW9T52kUU81YQ
         4i8/OlGFR20C6Ge/94ldxf6vjnvMcKtExIk9UKdHc74jLUiFp6+E3qUOIN0WM3mgOApM
         we5bPGZPgnuoXqlrNvrDAhumT1LLXL3gfDAhULAS2MvASBnnwienjqLJ7GswJBEeRcwr
         KrdQ==
X-Gm-Message-State: AOUpUlF3cjYbWP4WbtS2qSN4ma6Obj2zbhHiDbfGePLYPKaXnPutoog1
        nBfmy6aYuAP93khi3B0A1UwnpO4r
X-Google-Smtp-Source: AA+uWPx6M0fm059Ttb2xyP2bl6sdp5d5wk411lQS/PpQMePjfhFD+oQVX/tcJ8350Re39Dh+esYMCw==
X-Received: by 2002:adf:e749:: with SMTP id c9-v6mr11202102wrn.143.1534187940168;
        Mon, 13 Aug 2018 12:19:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s10-v6sm25169238wmd.22.2018.08.13.12.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:18:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Maftoul <samuel.maftoul@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] implement branch.sort config option
References: <CAFj+z06S1V3Z7Z0zKPSrpZfWuzku9PTYjG+uu6ig-yCnG4FCLw@mail.gmail.com>
Date:   Mon, 13 Aug 2018 12:18:59 -0700
In-Reply-To: <CAFj+z06S1V3Z7Z0zKPSrpZfWuzku9PTYjG+uu6ig-yCnG4FCLw@mail.gmail.com>
        (Samuel Maftoul's message of "Mon, 13 Aug 2018 11:56:58 +0200")
Message-ID: <xmqq1sb25b30.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Maftoul <samuel.maftoul@gmail.com> writes:

> I'm still missing tests and docs, but if agreed the feature is useful,
> I will write them.

I personally think branch.sort would have about the same value as
the existing tag.sort, so if a patch is done well, it is likely that
users would find it valuable, but let's leave the final judgement
until we actually see the completed patch first.

Thanks.
