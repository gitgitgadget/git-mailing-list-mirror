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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA3C1F453
	for <e@80x24.org>; Fri,  3 May 2019 14:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfECOQU (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 10:16:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39426 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfECOQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 10:16:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so6923124wmk.4
        for <git@vger.kernel.org>; Fri, 03 May 2019 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JdqmEGwly3sY9s6+2oI3Ad+EjmKL9qgo17KMXYcitU=;
        b=isq19gm4Tay2qHALn8+O7iek5eHFhqZYkFzA/siUeV4hyovvHrQRGo+6bUlYiX3NdZ
         pSpN+CHrz2H+p9is4xoAEwNAcKXVlv4PkGi69mNH/GkwOFMzpnwzlAFhczx+mAP3CG1p
         bZ4JZF8QwEztd0KZnKf13TnI/tBxaE0V01ezXHiOXRr96q2NQRdCcC1YAW4anY4Y3LEB
         Ubw99OpLA13amjauSxrkOxT41xGwhdhnrr5Spzoa7wk75OejcGKdsYfuRhQZERW9fKaV
         9dThlzkl6/qd1vRER3hVR+Y6dhhPU9DW26veSG3WU8N8crvzG+Vj30K0I9ed05aBASpT
         FVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JdqmEGwly3sY9s6+2oI3Ad+EjmKL9qgo17KMXYcitU=;
        b=cRJkGSckjwdalTZ038Ovp24R3YqSqm6OVr5+WO582BGOC3+VhaBUnEkmH8C+2rpxjU
         tGMI4t13dVLTVtx6vEoXWl0dqlhpNgZ2SFovhRrJzkARhYD2ZUQpDjrWIbbHIMq1Pfhu
         SSfVKzrut233owe/ZY1TK2/PhCqz8y3pSgQIhN6Jj6mEHJZ2KxwR8UgtSSSkSstr+qyK
         8mPK2SaFbGStBiiZmf2UrTSyaXuT7wwzMY2hT1PpmOIXqZ3US0Dw2SIrFM53JuyhOViQ
         22iJ6+8CBfSPTfNb4UZ34TNXwwD0STMUlkfZb6OqYyHUQXWgN9tqJz1CNhewoqK4Oz9F
         w4qw==
X-Gm-Message-State: APjAAAXRAWC1FenY1I2V96IXpXrUmdU6lvuMYlDobO+yGiA5Gx7Pln5/
        ISwiuEKR4lusWaf2r88GEqwihXC8
X-Google-Smtp-Source: APXvYqyL2IR1R+detlCGnFPuIPvaOSbIJ1KatMmfG0hRtOq5gXXvEWkiHc8683mxRbDcsq/8UHZAVw==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr6194047wma.129.1556892978518;
        Fri, 03 May 2019 07:16:18 -0700 (PDT)
Received: from szeder.dev (x4db507c5.dyn.telefonica.de. [77.181.7.197])
        by smtp.gmail.com with ESMTPSA id u2sm4461272wru.36.2019.05.03.07.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 07:16:17 -0700 (PDT)
Date:   Fri, 3 May 2019 16:16:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
Message-ID: <20190503141613.GG14763@szeder.dev>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
 <pull.112.v3.git.gitgitgadget@gmail.com>
 <87lfzprkfc.fsf@evledraar.gmail.com>
 <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com>
 <87h8acivkh.fsf@evledraar.gmail.com>
 <04ac97c5-ab2b-2b23-4c84-8ed8aab0e2f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04ac97c5-ab2b-2b23-4c84-8ed8aab0e2f5@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 08:47:25AM -0400, Derrick Stolee wrote:
> It would be much simpler to restrict the model. Your idea of changing
> the file name is the inspiration here.
> 
> * The "commit-graph" file is the base commit graph. It is always
>   closed under reachability (if a commit exists in this file, then
>   its parents are also in this file). We will also consider this to
>   be "commit-graph-0".
> 
> * A commit-graph-<N> exists, then we check for the existence of
>   commit-graph-<N+1>. This file can contain commits whose parents
>   are in any smaller file.
> 
> I think this resolves the issue of back-compat without updating
> the file format:
> 
> 1. Old clients will never look at commit-graph-N, so they will
>    never complain about an "incomplete" file.
> 
> 2. If we always open a read handle as we move up the list, then
>    a "merge and collapse" write to commit-graph-N will not
>    interrupt an existing process reading that file.

What if a process reading the commit-graph files runs short on file
descriptors and has to close some of them, while a second process is
merging commit-graph files?


> I'll start hacking on this model.

Have fun! :)


Semi-related, but I'm curious:  what are your plans for 'struct
commit's 'graph_pos' field, and how will it work with multiple
commit-graph files?

In particular: currently we use this 'graph_pos' field as an index
into the Commit Data chunk to find the metadata associated with a
given commit object.  But we could add any commit-specific metadata in
a new chunk, being an array ordered by commit OID, and then use
'graph_pos' as an index into this chunk as well.  I find this quite
convenient.  However, with mulitple commit-graph files there will be
multiple arrays...

