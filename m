Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048BC20248
	for <e@80x24.org>; Fri,  5 Apr 2019 05:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDEFqL (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 01:46:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34736 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfDEFqK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 01:46:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so6469504wrq.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 22:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b0oAk2bBBl9fyGzxgJOrKwYbXNrnrTOpNB3pDdOdDFU=;
        b=ZpjDVjnSDAJG78vQf2ceUh1pTUQN8DImZV8JGC0TNKblDRCIwQJE17QRoZ1a6aiAO6
         BQxWw7/pShqRilyTT8PZ+bnssNHABH3ODh+y0do1UiPyEttvgSlJtaFQQIyFzXGBs+lt
         /ccemJ1N70d6ptEduJjJz0I/IpWxnZh2cqPLlSwZ3YYnD6RdFvJILmqJCMQqiRIhKmj0
         DzNIo2YvUlHPGiS7CdtNxLS/o8mJvmPZy71H/4BG+16AQjOX8lr0Z+ow6jCqb0CGwAQU
         QASbA5rUJRXxJYVdfuXDYTGKksl0PIG59KCzEt2odCvbEOQj1FgE4bNB93bBNjoOAojt
         cy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b0oAk2bBBl9fyGzxgJOrKwYbXNrnrTOpNB3pDdOdDFU=;
        b=L8WIj2eeJ2u6gMziWMjd2THkBwXFsT9FNHAZjDeD5sk0FqUHcqvXyl9eYKU5LJMoqP
         U8Dip9fRMi4Q+zS1MeAXTbxjdtuC5u7g/0cZGj5fBIxO+R8+O5BURTyFMiSgaBf/rXnb
         fqphyhaEfyncugSa0j8mj7jPtwxrPACf+vsxUNb59vScU3mBvemQ8z+Z+jc6XexZ5sZo
         bjPQNxHFs9Ie45D+x2CCtC3j6TGgCaeKsNw1E+T6C50Fcx9znnlKa6mJylwkQ3PZUnLf
         jemcSw8TdHbE8yyJJFCmWeYlJ4XEiKx7XoYRvxB1/IXy+6AzuTDn0P9uKOwOlCX7Pafc
         eKCg==
X-Gm-Message-State: APjAAAVv3ep+uD5ci1ZVe+JyxErvyOJHtG0ebcF65f5bhzkki0tXffZ2
        //gwm9v3yu3PglFBDu9pRGo=
X-Google-Smtp-Source: APXvYqwLwkj2pQ7lcFRQ0LWgvvFBVxOPEcUVKWwrQniILfekyySld/DCAWLdNLAN8HpL1f1/EhmQHA==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr6623321wrs.5.1554443168669;
        Thu, 04 Apr 2019 22:46:08 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j22sm63322745wrd.91.2019.04.04.22.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 22:46:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/12] a rabbit hole of update-server-info fixes
References: <20190404232104.GA27770@sigill.intra.peff.net>
Date:   Fri, 05 Apr 2019 14:46:07 +0900
In-Reply-To: <20190404232104.GA27770@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 4 Apr 2019 19:21:04 -0400")
Message-ID: <xmqqpnq1c8dc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch series started with patch 12: I just wanted to drop the
> unused "force" parameter from update_info_refs().
>
> But that made me look at its sibling update_info_packs(), and whether it
> ...
> And here we are. I present them here in reverse rabbit-hole order (which
> is also roughly important fixes first, and minor cleanups last). The
> individual chunks are mostly independent, but the server-info cleanups
> rely on the shared pack_basename() helper added as part of the midx fix.

A kind of cover letter to make readers chuckle.  Well written.

And of course, thanks.  It's a delight to read a nicely constructed
series like this one.

>
>   [01/12]: t5319: fix bogus cat-file argument
>   [02/12]: t5319: drop useless --buffer from cat-file
>   [03/12]: packfile: factor out .pack to .idx name conversion
>   [04/12]: packfile: check midx coverage with .idx rather than .pack
>   [05/12]: http: simplify parsing of remote objects/info/packs
>   [06/12]: server-info: fix blind pointer arithmetic
>   [07/12]: server-info: simplify cleanup in parse_pack_def()
>   [08/12]: server-info: use strbuf to read old info/packs file
>   [09/12]: server-info: drop nr_alloc struct member
>   [10/12]: packfile.h: drop extern from function declarations
>   [11/12]: server-info: drop objdirlen pointer arithmetic
>   [12/12]: update_info_refs(): drop unused force parameter
>
>  http.c                      | 35 ++++++---------
>  packfile.c                  | 31 ++++++++++---
>  packfile.h                  | 86 ++++++++++++++++++++-----------------
>  server-info.c               | 57 +++++++++++-------------
>  t/t5319-multi-pack-index.sh | 29 ++++++++++---
>  5 files changed, 132 insertions(+), 106 deletions(-)
>
> -Peff
