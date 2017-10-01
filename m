Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF96820A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 16:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdJAQRa (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:17:30 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:46098 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAQR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:17:29 -0400
Received: by mail-pg0-f52.google.com with SMTP id v3so1895081pgv.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BcxKiJgjtx3kS8wUAkNO4F/s8u+BX1EVPk/o754vnv0=;
        b=yxGVYs7xRLKV82cZOf44WXcsvNrhPuyrPwZ4PxSxvGBukfoU2B+SKe9Q93WuKPX5ex
         XNpTpAJEIgMW4jZG7/iZyMBPf0W+TwjqvHDdEmn+pPG0bTHrrCtOYabdxlX/YUtaSRx9
         hppga9ZDbaOUKTNOGHzJEVEBYGeNfG4DLJTHypjOp7o1SeymjdlY6Ly267RPqxnjRVh7
         5Map8qXuGbuv3FXzwigKQFCsiXm900dSWNH7FOfI4G0ZcvdT5GTWD+inSreikf0oJjv9
         SWNzxhgZYMeo9ScLKX0cWB4nniXHxT4w8qVQSDzHzHIDDw1C5NOu6SO5G1KfgL/V+ZVk
         Q1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BcxKiJgjtx3kS8wUAkNO4F/s8u+BX1EVPk/o754vnv0=;
        b=IFadCuZD8U7bGQYnKMYg6XH/ShQCuq74OSEGs0hbxa2FbP/I7u2lWIlV8sMIqxYGDR
         7RpMTJoypgsEPkIYZIk7ymwWCZcY21o3BBoM4Yokyoq9KgFDstJGQmUpxp/EvuwipcUd
         Du8ACdbBzAiTchU49+xtq6wXLU13D2bgbeWzm3YiP2mepHONBbaynDn3aAzYFTLH2xBc
         I0ZqJ0DvzDQnJWOgXnio9EfiESy21nYGbDZ0AmcWTE+CsVUHY6v/AZA4Rb9zK6XQuqVR
         XudugvcYS5BFZo/2HyP1KdONH/VbZWn1DaL59rOuBJ0Cckyj/854OEi0Hj3xu5uc5+8W
         bw8g==
X-Gm-Message-State: AMCzsaUVNmV4gz5B8S9I6ShzOop0b8jy9PtGc10IIEDQrDanKUWLCExw
        wXAii5J7mguFbsaLZVl0kdH2F8pax8U=
X-Google-Smtp-Source: AOwi7QB3t0nDB7Pl6nuHROUMRcZRNXIINdwUiA37RIFAYNEvB/e6ue7zvxxgm3ybxdPmTX+wq//WsA==
X-Received: by 10.84.178.4 with SMTP id y4mr1683562plb.142.1506874648759;
        Sun, 01 Oct 2017 09:17:28 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id 75sm13507515pfx.145.2017.10.01.09.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 09:17:27 -0700 (PDT)
Date:   Sun, 1 Oct 2017 09:17:25 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v4 0/6] Support %(trailers) arguments in for-each-ref(1)
Message-ID: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the fourth revision of my patch-set "Support %(trailers)
arguments in for-each-ref(1)".

It includes the following changes since v3:

  * Teach unfold() to unfold multiple lines.

  * Rebase patches to apply on top of master.

Thanks in advance, and thanks for all of your help thus far :-).


- Taylor
