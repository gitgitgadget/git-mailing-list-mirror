Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E850D1F462
	for <e@80x24.org>; Tue, 19 Feb 2019 00:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfBSAXl (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:23:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfBSAXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 19:23:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so12016640wrs.13
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 16:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJj11zG8LY9IPkHuz1aAn/qUBa0psu+KKco0WSuLBzc=;
        b=fLkDQhODhMlaIDhc78vb7aCrdodYT0jGDnHnFaD2T7HLvqQaoSzQGaKbupo0lC1ENY
         i1DmfBsCH6HIO6hrFTwPoyv4LE84A3hQuyLL9hTW8faUMPixTH1DgvDxrlvsqQiZGn+4
         LGagy2JC1xduXAM9MdgDjfVP+Ob7kvpwe8v7OcImiWRP3W23IJxlDDqVt9J9dpQLg6PI
         mVQvGp2OQpECQrlcZvFLV26si7LWIno+SpQB2kvdZPb/qUxbtwizpw6UH/EQ2oQ5Q8hG
         AdoY8dv8W6E+VkbTuXjSVX86JIYr9+hXcMGoi1ve4rRy5K19sxeN0ptaZrH4M9wTto4/
         efGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJj11zG8LY9IPkHuz1aAn/qUBa0psu+KKco0WSuLBzc=;
        b=p8kHJSyztK5UXNnLbQ/SrPSu07pGA8ZIOk9I9eDLEVMb30mpGzTGcO4y7tuOaW/4M0
         xB/ulq6Q7eyysTW+pTapyjV2fwIX8fXL7J4gx4uQl1056cUhAkSH7F5zHqe9gFjqeCwg
         ew5r94OUBcwFq76zlX+AnLVZNrPojtEIyfV//0rCnswgYDvRJHNeD8Bep/eHlOTt+Ee8
         6HWi3oEcDxuMBCYHmWqxBHY1vITxqExp0WF5YSOUbUW8s/9UjQl/iyjdlEnHi+XDlKft
         1kxwMPh/rziuXd038zjjZfbtIIVp0lZPsPCs6qwVR7TBfeWjTPViGrikD15lBNmTXTWq
         llbQ==
X-Gm-Message-State: AHQUAuYxrrT3L14hv5805lQspOcLc6B6PXoPGVqTqCa/IXE7XCF3a3uc
        6hDdrmu2yUYXIa4Mcwp4MKs=
X-Google-Smtp-Source: AHgI3IZ5jilEL/8oE2jn4GO0TdbjVmVVFseh1qlmRnOOxVyCtsEI5qBXDjdqOVPROzonOe0m68Q7zA==
X-Received: by 2002:adf:e706:: with SMTP id c6mr18723309wrm.278.1550535819480;
        Mon, 18 Feb 2019 16:23:39 -0800 (PST)
Received: from szeder.dev (x4db52463.dyn.telefonica.de. [77.181.36.99])
        by smtp.gmail.com with ESMTPSA id k23sm579044wmj.32.2019.02.18.16.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 16:23:38 -0800 (PST)
Date:   Tue, 19 Feb 2019 01:23:36 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
Message-ID: <20190219002336.GN1622@szeder.dev>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
 <20190208113059.GV10587@szeder.dev>
 <20190210221712.GA9241@hank.intra.tgummerer.com>
 <20190211011306.GA31807@szeder.dev>
 <20190212231837.GI6085@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212231837.GI6085@hank.intra.tgummerer.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 11:18:37PM +0000, Thomas Gummerer wrote:
> Thanks.  I still didn't manage to reproduce it locally, but I was now
> able to test it on Travis CI.
> 
> The diff below fixes the issue, but I still need to spend some time to
> better understand why it does.

There is nothing like a fix that works, but you have no idea why :)

FWIW, I'm at a couple of thousands of '--stress' repetitions with your
patch below, and not a single failure yet.


> I'll hopefully be in a position to
> send a patch with a proper log message why this is the right fix in
> the next couple of days.
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index c77f62c895..3dab488bd6 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -231,6 +231,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>  	struct tree *tree;
>  	struct lock_file lock_file = LOCK_INIT;
>  
> +	discard_cache();
>  	read_cache_preload(NULL);
>  	if (refresh_cache(REFRESH_QUIET))
>  		return -1;
> 
> 
