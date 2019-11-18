Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA9B1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 13:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRNfk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 08:35:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41396 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfKRNfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 08:35:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id o3so20189013qtj.8
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=40PMK9ilXvdL7q79r5ltJuDMad2IpifpmsKztZcXomQ=;
        b=UfWvU/LktfkgvzzfTK1n6D7wMoMgVWyR2w1/wahEHC+JB/7U1pvutZHE/AgaaNqznV
         AZxSscdoihPnY0Wwz/EVKmg+CqqkBaOscCZeENZ+pxnnqYY6s7CPDyNRifhOJvZDa9KU
         PY8zqfwIWW+rC5KBhBOLTF489vnVIE8/FXh4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=40PMK9ilXvdL7q79r5ltJuDMad2IpifpmsKztZcXomQ=;
        b=dnCjQA8nUJDdjOAgXnx1hZLYYEJTeMy6AW0yk+p7YSGAwnmTQbhbMBEbi8Xp1JGc28
         1q0wH9tWj6iLyI1AeOy8SF1GysLv2SwtojQ7ikRNUk8Jn+kQzX1JrA4gN7sWUb+EDPZg
         X1byb6w74U+gyOnIHAI/NU8BvSAiur/ZcQIutOSmtxBeRMzCkwBS1wN1RTTBpHI6IjoI
         2ZGBWyLUq6XMKfCsx2ygo94X1VXo0sbeoVOW+/CxAgIH0yZDQce25yf4sa0jVZOLmeDv
         w7hF1QNCD/+ZfVHGXjbU6UGpxdX6Vfi5iGyAGXwzXFUTcDHJnGT2NZc5dO+nl6VF+aW7
         1g0Q==
X-Gm-Message-State: APjAAAUH5ZdiunvtCSCfjYrVpdhyqo4msPic3ZrvzBy46AD4gu0/Pn+n
        mt5qthxLSQFgHY0txjwXm+9D5g==
X-Google-Smtp-Source: APXvYqzLGZYjjvdiZv4ECA2p7ZgSCRZznPyLvNBq8aN3O3dn2fIhcd2nN8csMMjXrbIF+dm+YWoMDg==
X-Received: by 2002:ac8:51c5:: with SMTP id d5mr27278168qtn.41.1574084139190;
        Mon, 18 Nov 2019 05:35:39 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id g45sm10747597qtb.48.2019.11.18.05.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 05:35:38 -0800 (PST)
Date:   Mon, 18 Nov 2019 08:35:36 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, dev@ius.io
Subject: Re: Multiple empty "remote:" lines during remote update
Message-ID: <20191118133536.u3k7kkucw6mz7jlv@chatter.i7.local>
Mail-Followup-To: Jiri Slaby <jslaby@suse.cz>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dev@ius.io
References: <c6b51eaf-79b1-6fb9-6085-2d1a45b739a6@suse.cz>
 <20191118114449.GA12766@sigill.intra.peff.net>
 <90c545c3-4d7c-6d98-a516-e76fe180026e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90c545c3-4d7c-6d98-a516-e76fe180026e@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 12:59:52PM +0100, Jiri Slaby wrote:
> On 18. 11. 19, 12:44, Jeff King wrote:
> > On Mon, Nov 18, 2019 at 09:34:46AM +0100, Jiri Slaby wrote:
> > 
> >> since some time (weeks or months), I am seeing this:
> >> $ git --version
> >> git version 2.24.0
> >> $ git remote update
> >> Fetching origin
> >> remote:
> >>         remote:
> > 
> > This was a bug in v2.22.1, which has been fixed in v2.24.0. However, the
> > bug is on the remote side, so whether you see it depends on which
> > version of Git the server has installed.
> 
> OK, thanks.
> 
> $ git remote -v
> origin
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
> (fetch)
> origin
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git (push)
> 
> CCing Konstantin, in case he does not know yet...

I'm aware of it, but I'm hoping IUS starts providing either a patched 
git222 package, or a new git-224 package where this bug is fixed. Since 
it's a purely cosmetic problem, I don't want to patch it locally.

CCing devs at IUS for their info.

-K
