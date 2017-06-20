Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DAC20282
	for <e@80x24.org>; Tue, 20 Jun 2017 20:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbdFTUNp (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 16:13:45 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36850 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTUNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 16:13:44 -0400
Received: by mail-pf0-f182.google.com with SMTP id x63so74205223pff.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27HLm36eEqvkjradCki3lCMoOCoexk9AYJUw7f/85IM=;
        b=fdU7GYv19hYNjlShgjHbUnSqD7X+lzJz37B+Tte0nlQ0bNzWX7R/WP87QKhR3d5+KR
         X+xvhcdbr6p0LDd+L2kIwEd8rfuViu3xGuCOgIGpc5WeDS8MnLPdm+Clcml9UPI1NAyD
         ZN5SBwXNf5oVmwZzZIeyRa8DeMB6rv/MD/XEO7A9Xaqj4XqD8X3P+PZdC6Spy0HzfNBv
         AyG3eaWfHPfgAieQxuuOEBmR/qqm/mZSnMRqoo59W8WkZqIqNZocHrNaqzhJ3ZE4IkHo
         lUJSbSthSQmz4KnVZ7s3gMVvTiLxkVmleUdf+th1ErOHCqg65NDtWHPuLmskYFw7j1uI
         8NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=27HLm36eEqvkjradCki3lCMoOCoexk9AYJUw7f/85IM=;
        b=tNxTDdb9UrsmYE3U5e5kdxIyXIaWd02lY2I8C+masjBLjidbDZAiCAqWYCbV7ucxzm
         9yeH7X+CJ3CWpAyux1JoxVeZsHK5o17FnPNcSYGI/WzdOXYDxvoo4OirWIWmTC9/CYO8
         COeJnN61cfd58TM9MKltZfmWWEEb6halx7TQFWDtwWzLtigUl0x5Uck8J7th8nQUT53n
         lIxRg+HIPxmONIdmuLc3hE+AtQMUSvuTPfUONmomdYfApoQsI9KpHeUzhb75jG+/docL
         fxVtyBRqPXiF364dShtJdhslgAItLZ/dSB1/cbcfa2kDYgwLEJl2QZLtZlCcYVYzA2gj
         U9GQ==
X-Gm-Message-State: AKS2vOy1dsXXpkcGR1ymDysAMPKJ7Agihj4U/vFEZf+dlYs0miaoVtD7
        zHvRkIbg50ZSM6YQ
X-Received: by 10.84.224.199 with SMTP id k7mr6930382pln.207.1497989623351;
        Tue, 20 Jun 2017 13:13:43 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6c40:b92c:899d:9917])
        by smtp.gmail.com with ESMTPSA id e63sm29445217pfb.18.2017.06.20.13.13.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 13:13:43 -0700 (PDT)
Date:   Tue, 20 Jun 2017 13:13:39 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 22/26] diff.c: color moved lines differently
Message-ID: <20170620131339.3f56bcf0@twelve2.svl.corp.google.com>
In-Reply-To: <20170620024816.20021-23-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-23-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just glanced through this file, because it seems similar to the
versions I have previously reviewed.

I'll skip patches 23 onwards in this round of review because (i) I would
be happy if just patches 1-22 were included in the tree and (ii) those
patches might end up changing anyway because of review comments in the
prior patches.

On Mon, 19 Jun 2017 19:48:12 -0700
Stefan Beller <sbeller@google.com> wrote:

> +/* Find blocks of moved code, delegate actual coloring decision to helper */
> +static void mark_color_as_moved(struct diff_options *o,
> +				struct hashmap *add_lines,
> +				struct hashmap *del_lines)
> +{

[snip]

> +		if (flipped_block)
> +			l->flags |= DIFF_SYMBOL_MOVED_LINE_ZEBRA;

This should probably be DIFF_SYMBOL_MOVED_LINE_ALT. "Zebra" refers to
both the stripes, not just the alternate stripe.
