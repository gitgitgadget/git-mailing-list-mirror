Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82AF11F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 09:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJFQCb (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 12:02:31 -0400
Received: from mail.ao2.it ([92.243.12.208]:45982 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeJFQCa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 12:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=pIjx3HiOmWzGnQirUtItbYUu1tK62hr11nnJOyUp/X4=;
        b=lftcw6ODY3KzBbQ2DfGXjb80qBKrsdotd9OYJbLddwbPt/48g2ySxu07IwqerrcFk4OlstZ+VitWTTfmATCqhcP9Lg6/kqHWVpKVr0W+VMwCGMlZmxwXkzS/v1FHn4XcQxyz1fb/KO3oJxsKREEP8e8pvOr8lFQPgqFxmcsEmF1UDaJU+cN7KFS8GiQyxCPdspNxKm/NKu5vb4jUerz4lh74O6BPrDRYa+DNhQg0PDBUVuQcNS6M5zWSSr9IHdh3qQfTSiA4PrRz10sGCpDM5uDJH/ubeordJPUryySsvdWRUfHh0aK8hZuVSusE+fEYy1/CZiVO6KDhJtyfBDSyhw==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8iOq-0006jS-Rf; Sat, 06 Oct 2018 10:57:24 +0200
Date:   Sat, 6 Oct 2018 10:59:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/grep.c: remote superflous submodule code
Message-Id: <20181006105959.47f8ccf38281d8bdd07448e7@ao2.it>
In-Reply-To: <20181005224557.31420-1-sbeller@google.com>
References: <20181005224557.31420-1-sbeller@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri,  5 Oct 2018 15:45:57 -0700
Stefan Beller <sbeller@google.com> wrote:

> In f9ee2fcdfa (grep: recurse in-process using 'struct repository',
> 2017-08-02), we introduced a call to repo_read_gitmodules in builtin/grep
> to simplify the submodule handling.
> 
> After ff6f1f564c4 (submodule-config: lazy-load a repository's .gitmodules
> file, 2017-08-03) this is no longer necessary, but that commit did not
> cleanup the whole tree, but just show cased the new way how to deal with
> submodules in ls-files.
> 
> Cleanup the only remaining caller to repo_read_gitmodules outside of
> submodule.c
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

Not sure if I am entitled to formally ack it, but:

Acked-by: Antonio Ospite <ao2@ao2.it>

> ---
> 
> Antonio Ospite writes:
> > BTW, with Stefan Beller we also identified some unneeded code which
> > could have been removed to alleviate the issue, but that would not have
> > solved it completely; so, I am not removing the unnecessary call to
> > repo_read_gitmodules() builtin/grep.c in this series, possibly this can
> > become a stand-alone change.
> 
> Here is the stand-alone change.
>

Thank you for sending it.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
