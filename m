Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919B11F404
	for <e@80x24.org>; Sun,  8 Apr 2018 13:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeDHN7K (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 09:59:10 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:37258 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeDHN7J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 09:59:09 -0400
Received: by mail-wr0-f176.google.com with SMTP id l49so5835051wrl.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pYBRw+Huux4NSus1lIU37J2W/NXI36YDyr+v22mwSis=;
        b=gp2ZJMGWIWwFenou4Ic4xP/wCFgZeg4HM+lsxy8PWt3hd88hTF9eFNcEEBFZcbA/q6
         EwUEvdceuR1UCJGFwZtbzhqGhviwbzwPI1ACwa9/MMWNohTU9jyRjXwL8LxfmwvW8kPn
         9wsrpCDcK/rjHmHJj4lfpFt7TEtm3RJtrKaFhJjFKIayzSZ84WhrZxASTN5JS35OVtTN
         irFrPiX7/vx+d5ZdIWtrT4aP9sU33QIoHQOxyzHKFb96IQfMr1TLfNaDzWz7DeybqM4Z
         GJ0BZkmoRrDzVtR7roeAUEufrm5eKM8gT3NZROX+EyV/Sa7s7D+oWx8yxFBLbb1LsD+K
         0Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=pYBRw+Huux4NSus1lIU37J2W/NXI36YDyr+v22mwSis=;
        b=Kd6bNjJY0iHQeqAXLcsSJhPK7OBXIUyS1G7KJmFu4rYyTM62XzjmVYjCUnTQ/UcGnK
         pMO8zQvEUXFVdThh6GvLronaxRvcJRaEwql8tKszKSNWc9kerCOnXZBhokTSbr+VyrA3
         0gTQeDIaXFxig496QoAe/53S/GGx+y1lcpTgmpSvyLi+IwdXqZZiBENrPhOw6fK1v/uB
         /tQ3aeEjd8HaUrE9e0bhKHn2B0C4OXy+KG9lQEf2vcOpxO9o1o9atc8J0dCDARNqwoZ+
         Za83ViScYfCoXClEw6X0tjFC9f5WbHsY7f1DZHX0yNqdx9WjmUKyUc5WPssaHhtYuyxx
         8C9g==
X-Gm-Message-State: ALQs6tAZinAniR6VMlcEvUzXR06zU6T6a1qc8bNPPFJNZ7o/d/+jOwNM
        fr76aM2IJQks/k6a6u7XdEJBzG75
X-Google-Smtp-Source: AIpwx4+24mzGzM7DeUQHhqFfsYqXqEuIbuVctiHgdLXmHzvLTvQQeQUJ4xgrbVv3BnJHNpMNCiHKMQ==
X-Received: by 2002:a19:f1d:: with SMTP id e29-v6mr19105703lfi.138.1523195948073;
        Sun, 08 Apr 2018 06:59:08 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id i19sm2492983ljj.84.2018.04.08.06.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 06:59:07 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Is offloading to GPU a worthwhile feature?
References: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
Date:   Sun, 08 Apr 2018 15:59:04 +0200
In-Reply-To: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
        (Konstantin Ryabitsev's message of "Tue, 27 Feb 2018 15:52:12 -0500")
Message-ID: <86k1thdck7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> This is an entirely idle pondering kind of question, but I wanted to
> ask. I recently discovered that some edge providers are starting to
> offer systems with GPU cards in them -- primarily for clients that need
> to provide streaming video content, I guess. As someone who needs to run
> a distributed network of edge nodes for a fairly popular git server, I
> wondered if git could at all benefit from utilizing a GPU card for
> something like delta calculations or compression offload, or if benefits
> would be negligible.
>
> I realize this would be silly amounts of work. But, if it's worth it,
> perhaps we can benefit from all the GPU computation libs written for
> cryptocoin mining and use them for something good. :)

The problem is that you need to transfer the data from the main memory
(host memory) geared towards low-latency thanks to cache hierarchy, to
the GPU memory (device memory) geared towards bandwidth and parallel
access, and back again.  So to make sense the time for copying data plus
the time to perform calculations on GPU (and not all kinds of
computations can be speed up on GPU -- you need fine-grained massively
data-parallel task) must be less than time to perform calculations on
CPU (with multi-threading).

Also you would need to keep non-GPU and GPGPU code in sync.  Some parts
of code do not change much; and there also solutions to generate dual
code from one source.

Still, it might be good idea,
--=20
Jakub Nar=C4=99bski

