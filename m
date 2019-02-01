Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738331F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfBAWkG (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:40:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44947 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfBAWkG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:40:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so6725375edd.11
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qajGL0Qvp/cv4P/ns/8XMED7YmpiJ+/qEQ1zOv5qVbg=;
        b=GrprXMW9wsl+pr59nzD200jMqh/1IGIYvfMGlLOXhscFQHe6caCrFDpE+u2QjqbZ1M
         ZFQP2NxXcd/fbHJ7KDHEdWGHpDeEXX52Ppyjy6lfPrdZGDKiJaVHdq68/5fMBJhQHanu
         a1aG7b8Ovvb6CkTqoAkbJw85shkZ2W/f9u3bFyxWa4kSlUOBZV5jee7DY2dxm3A7VUMk
         REVLxzyWHjUM5UdDZfEsKtXnXmnwwFmqXSe0P45zWOLkIz2NBtnTs07chblrWhR7QYRZ
         ya4K2rE3f/uu3i6QTqR4bdhVta7bTJjJDz5i2erRNl2z4vXrOzwOf1hjp8PVY0+LBEsf
         7oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qajGL0Qvp/cv4P/ns/8XMED7YmpiJ+/qEQ1zOv5qVbg=;
        b=kyvR7EhXOSjf5ulWorhJwLABARZNsFe3jvoeWbLb8yjik/TqrX8mwLNRuyK30Luavd
         dY886ToVE7vhwUlqi0JesxCsQLM8GIkMy9lo2FtALAR+uT5xqFNncjy+NI2Z4pBTj4gr
         rOzctlhVjH7xqgnH3nysW56B3EA4/cIGYILSLmRInAl9FOuCMF/7zbuC3fLEwhxm9rBz
         wQg0OF1mxQ/0o3xxYQPkw9yNYH6DqASZn8cJ95dciifufB/pYziz2+UmdAzw7r/2Wdfy
         ZU+r4t4mwZ+aNTY/7yNDhIGyFjEbFj1IAuUAG/vyUJ7xhJyxW36J4HZwlYBEpbhVting
         4D1A==
X-Gm-Message-State: AJcUukfZUvadPcIZiZRyuf5GZYMCR+5SVOQqW36++AcwasPxPn81Rd+T
        J9Jt2PqLI3xiaqRSqewUP74=
X-Google-Smtp-Source: ALg8bN7lIQVtlf8boax0FbtvaTPHE+tWptny33dEl/FyxwrJ6eHNV27TwAztiksdaYQkUQhkB3MeGA==
X-Received: by 2002:a50:ae64:: with SMTP id c91mr40150865edd.222.1549060804323;
        Fri, 01 Feb 2019 14:40:04 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40eb:400:6cd3:4d33:1db0:edba])
        by smtp.gmail.com with ESMTPSA id r1sm2266870eds.1.2019.02.01.14.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:40:03 -0800 (PST)
Date:   Fri, 1 Feb 2019 23:40:00 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Using sparse in a CI job
Message-ID: <20190201223959.zmlyg4buwolw2b3p@ltop.local>
References: <78f85f0b-176f-0b54-2ec8-4c13fd386733@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f85f0b-176f-0b54-2ec8-4c13fd386733@ramsayjones.plus.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 01, 2019 at 09:01:20PM +0000, Ramsay Jones wrote:
> 
> I suspect that the Makefile sparse target is not easy to use in a CI
> job, since the 'sparse' program (via cgcc -no-compile) does not exit
> with a non-zero value, even when issuing errors and warnings.

...
 
> We can change that by passing '-Wsparse-error' to 'sparse':
> 
>   $ make SPARSE_FLAGS=-Wsparse-error change-table.sp
>       SP change-table.c
>   change-table.h:53:24: error: dubious one-bit signed bitfield
>   change-table.h:54:25: error: dubious one-bit signed bitfield
>   change-table.h:55:25: error: dubious one-bit signed bitfield
>   change-table.h:56:26: error: dubious one-bit signed bitfield
>   Makefile:2729: recipe for target 'change-table.sp' failed
>   make: *** [change-table.sp] Error 1
>   $ echo $?
>   2
>   $ 
> 
> Note that '-Wsparse-error' not only returns a non-zero exit code (1), but
> it also changes a 'warning' into an 'error' (see above):

Yes, I know :(
The fact that, by default, sparse doesn't fail on errors is wanted
(otherwise it would break the kernel compile). But that the only way
to return an error is to use -Wsparse-error (which is supposed to
replace GCC's -Werror) is a real problem.

-- Luc
