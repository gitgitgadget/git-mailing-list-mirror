Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C20C1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeIZXjx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 19:39:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeIZXjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 19:39:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so24102048wrw.5
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HoPxf2Ryc1ZpZgjPCjlQdgQUbXI/X3Uwc0rPHlOt6RA=;
        b=XsvUy50YEWefivXZH6iY/9zMg5rZpzD6jb5GUy0RIclrtpLPlEQd8nnYc2isUEDYIp
         FIreA1bTKOnY5VWcnsByuQ/x6TAaZpcZnE8P3Wt931ejfiWWl+bTzHlgW8ibjY7YqFaJ
         aIEIXvS5ENBy1noIcDqBv5Nog/uQPmaiUJJxOSH4fwrVMAPsNstxuaF9dcto+d2WQWrF
         +stol99R8rxj28KzLdcXcy5umf9v0c5IINY6sUrd0ijybyTS8rfA2PjAVfthGwFlgn1U
         PfIiB2As7mb4CGc23Hmo5miENiUKQrx1Ob4wW5ImxrvByDbkk8PaZ/lcVEMSiW7J7+xD
         fupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HoPxf2Ryc1ZpZgjPCjlQdgQUbXI/X3Uwc0rPHlOt6RA=;
        b=Ywqgt0GAtTY+MCHd8wyoaFDlsxSGPkDa7ijCnJvS4WJyEUI814QVWt1vVAI1O4kEj+
         AnacMbTeQzw39ByjjtcHMKgl78R7m7b5lNPsnnQR4vpRmi8BVIlUW+fVKQA+oCnUB1Gx
         DNT069JAb26J3inePB42gSyCRSTu6p39C0ScoTgEtqUfPCl7oeoECxGnI+Xj7rXDjnYd
         DVy2lMmjbvzHqZ9mbjt0w9+Gu6BNqoAtDMG6ao4S+XqM8DKFjm91R1grLatDi2PkIKcA
         YPK+XkfI0H5nvHl0YSORzl124JTxfCZIYxDcCkpcmDjgru0Wmk0L4jEHrFU5EPh/XtcH
         0E1A==
X-Gm-Message-State: ABuFfohzmnJv4otu1xnt8ZPr5FFgvWc+zvno0imFVIZLDZeLAySxddxd
        oxk41dC14KJIdydO+cMyuoY=
X-Google-Smtp-Source: ACcGV62ief7H7rEkHX1X9LYnYqEZ7KnCUJCi+pomc7HcrM7zvGYdMKXomiVkevPkbFbKBRGvISKs3A==
X-Received: by 2002:adf:f991:: with SMTP id f17-v6mr5933360wrr.105.1537982753340;
        Wed, 26 Sep 2018 10:25:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a11-v6sm6674034wrr.81.2018.09.26.10.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:25:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git help: promote 'git help -av'
References: <20180922174707.16498-1-pclouds@gmail.com>
        <20180924181927.GB25341@sigill.intra.peff.net>
        <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
        <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
        <20180925174451.GA29454@duynguyen.home>
        <20180925205446.GB21956@sigill.intra.peff.net>
        <CACsJy8DCdwAre9dhwwC_5STNq_BuWahv-9Hoim+YUtVssJbzdQ@mail.gmail.com>
Date:   Wed, 26 Sep 2018 10:25:52 -0700
In-Reply-To: <CACsJy8DCdwAre9dhwwC_5STNq_BuWahv-9Hoim+YUtVssJbzdQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 26 Sep 2018 18:18:00 +0200")
Message-ID: <xmqqd0t0maqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> -v was recently added just for the new "help -a" in May 2018. I think
> it's ok to get rid of it. Memory muscles probably take a couple more
> months to kick in.

If it is not hurting, keeping it lets people say "--no-verbose" to
get a less verbose output to help those who do not like the new
default.

Unless you are removing code to show the current "help -a" output,
that is.
