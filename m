Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C134A1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 15:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeJAVzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 17:55:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42317 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbeJAVzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 17:55:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id b11-v6so14391862wru.9
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o5eT8btDnYzmm+hNAVbefD0718wYJ/SCA+YTtjyfsb0=;
        b=m5fqUGzaGMdBeqfA1npu7CtZdA5kzXcKvd1gg7PktzhdxsJptujOME8mtiUi+ABend
         fAPLl1QKtqP9PPFCjuHdz60MxqGQcKZL6GwQlBYwNgOd1RI3MS5yjGXpyLg05e+89wjF
         pu1Oh3PTtORysHFmuLUNymB5oPtYdRueD1JgDRB0Vl3ZSox0BXp0jze/Ur12oGSUfusR
         0n/AmHlRNH9MeQi/uChULikL8MAEAQCj/BrMkkK1fmH/OMYZI+MmKSnwZGq0ALxAoodh
         ibV/96xhHTfzXIidZAA44hI9Gf+IQL1XU5fC9o3rRoeUwFrVDHOPT5qzeT9JSU0Q7ubi
         4Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o5eT8btDnYzmm+hNAVbefD0718wYJ/SCA+YTtjyfsb0=;
        b=aqw2sAsi1+8mXas5BqCkzlbGTvQE6DG4w4umhDz9T/kIsDqYcJBev95hGZJthMQDXm
         xtUBKUGbhoqL6/9Ag+27FkN4iFGhclvBd1wlmP5YOwW2qHSzbcCLZhDJktfMOPHJFRdG
         jBvEUF2wzx9Lf9RyPtAW2zO2hY0oOW+sYWpgJvuJa2fdmFjmgVNMZAe3k0tTVo9fb5G+
         AcknMz9m+FE6OIX6kUCZhBj0sMR5iYoRX8NmvQ+0n9i2Lnbo9wotup9v5vnGOb7nn0cK
         yMBYYyxhP8QdUdrn9FdrKhNMrIppSHwAStx5e42B1v3YYyLffj8YX1Sg18dmDiIj9Xdq
         R9Jg==
X-Gm-Message-State: ABuFfohM2REBdA8z8f4gLf012wDGwFwLbrJdtSiSdLeM9l8zCAYxPk50
        OavpWZ2vCJ2yQ/lCVh1MYvU=
X-Google-Smtp-Source: ACcGV60HxK/eMdkO473wponGR/ZYZpMEjeGnpsnsz0oGs7SIXkBmmiy+xB9gS1cI/b0Wg70e9W3gdg==
X-Received: by 2002:a5d:4706:: with SMTP id y6-v6mr7132125wrq.256.1538407039623;
        Mon, 01 Oct 2018 08:17:19 -0700 (PDT)
Received: from localhost (x4db10555.dyn.telefonica.de. [77.177.5.85])
        by smtp.gmail.com with ESMTPSA id b74-v6sm17058068wma.8.2018.10.01.08.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:17:18 -0700 (PDT)
Date:   Mon, 1 Oct 2018 17:17:16 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v7 3/7] eoie: add End of Index Entry (EOIE) extension
Message-ID: <20181001151716.GL23446@localhost>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
 <20181001134556.33232-4-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181001134556.33232-4-peartben@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 09:45:52AM -0400, Ben Peart wrote:
> From: Ben Peart <benpeart@microsoft.com>
> 
> The End of Index Entry (EOIE) is used to locate the end of the variable
> length index entries and the beginning of the extensions. Code can take
> advantage of this to quickly locate the index extensions without having
> to parse through all of the index entries.
> 
> Because it must be able to be loaded before the variable length cache
> entries and other index extensions, this extension must be written last.
> The signature for this extension is { 'E', 'O', 'I', 'E' }.
> 
> The extension consists of:
> 
> - 32-bit offset to the end of the index entries
> 
> - 160-bit SHA-1 over the extension types and their sizes (but not
> their contents).  E.g. if we have "TREE" extension that is N-bytes
> long, "REUC" extension that is M-bytes long, followed by "EOIE",
> then the hash would be:
> 
> SHA-1("TREE" + <binary representation of N> +
> 	"REUC" + <binary representation of M>)
> 
> Signed-off-by: Ben Peart <peartben@gmail.com>

I think the commit message should explicitly mention that this this
extension

  - will always be written and why,
  - but is optional, so other Git implementations not supporting it will
    have no troubles reading the index,
  - and that it is written even to the shared index and why, and that
    because of this the index checksums in t1700 had to be updated.

