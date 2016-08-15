Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C490A1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 16:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbcHOQVa (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 12:21:30 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35302 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbcHOQUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 12:20:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id i5so17388513pat.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 09:20:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NDcE4K+58dLnolPJBxWjeSe0m7bBOHYErmfXocfWUdI=;
        b=chJpkTAinzKE1ONczIBwHF0vgw3rXtYWXm2z+IxoE7LjznDr+A/WjRWgrHmwtlKsvf
         6cU+yRqzx3xYF81uN+a8Ridc/I046Sx9jVrlxRygIC5IVQPH3eE/LKvF5VZyFagSAnXG
         4nZxKtG+nwEIv1ZWF4/Uzfq7wFPO6LlpT1BXbweinlolts/V212acRNLfs/Q68ieLt7s
         5SZyTpQf7kDyS0qt1zwo0erOLn51oNvGj5NaeVi1c3dd1CV2VptXFujVBD1bb2INEurN
         Wjtk8nZ/BwPuYt/Egsf+07tGetzNEHLUCj6OzH+y3/TInWYbX782t8Rs1HHOEWZvYW/O
         8wQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NDcE4K+58dLnolPJBxWjeSe0m7bBOHYErmfXocfWUdI=;
        b=QtkYdxMmzRxBkgis+ULeuIVPAKrKa9uHuvYgAhZlqx9bHE7R/qIL6NjhrjJRvQ+NF1
         H39TFpK8WEqXi2kcNojQqykdcL5DU/iNqsnlHnhOON84Jb6umcZWlRRW8IGvWmZ0AK93
         16DNllDVi7AuqvTsg0p/0qT3gvGu/Gbl5A1oO9wFrEqyvJHyPNpLPCnkq2gdXv8jOhFY
         xMGQoTecPIIZ6FlEjVdzq6NVVT4IyTiERkv1uBSaTiSlZkmSte5HjQHSD4E7H24q1yg2
         Mon37p9Hsnsp4OcQQiRuJb/50Nz9SqOQnXr4etbokL6Z8ivH+N/qy5Jc3oWxjt0x+gMu
         gtdg==
X-Gm-Message-State: AEkoouvUvBSbs/OKw7uOv2NPujbou6EP+PpZYZcaEtR7t3Dp/oVGw8umm9p/N1b3IcIkIA==
X-Received: by 10.66.0.231 with SMTP id 7mr55302626pah.118.1471278018609;
        Mon, 15 Aug 2016 09:20:18 -0700 (PDT)
Received: from tci.corp.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id c125sm32640147pfc.40.2016.08.15.09.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2016 09:20:17 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
X-Google-Original-From:	Brian Henderson <bhenderson@yp.com>
Date:	Mon, 15 Aug 2016 09:20:16 -0700
To:	Eric Wong <e@80x24.org>
Cc:	Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org,
	peff@peff.net
Subject: Re: [PATCH 1/3] diff-highlight: add some tests.
Message-ID: <20160815162016.GA20659@tci.corp.yp.com>
References: <20160730151149.15980-1-henderson.bj@gmail.com>
 <20160730151149.15980-2-henderson.bj@gmail.com>
 <20160810085635.GA1672@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160810085635.GA1672@starla>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 08:56:35AM +0000, Eric Wong wrote:

<snip>

> Typically, we expect a reroll in a few days, and I guess there's
> no rush (so you can squash your comment patch in addressing
> Junio's concern into 3/3).
> 
> Thanks.

thanks, (slowly) working on an update.
