Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DB420970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdDKRhR (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:37:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33210 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdDKRhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:37:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so667512pgf.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5lkNvfdqzLNCCHCaYrY6KK8auJzefWzgOZIlhiWbVmE=;
        b=hq1U16vu/iKkz3LhmIq/mLDk3hJNHd5shiAuZU+Ey3h8WISNDIc7Isrwx2Hg0uzZwA
         Ivj7DA0fkpNIPHf7BH4/jK3N6YGVc30VWZJ0G0V4Yb1pjp/Zkm4FmQJS+uVNOrAHqxMK
         aiMxvY04f5dQQ9ZDhIrv7ZYWQk4I+5lSCmVG3Y+vOfFtJ20NsX1rMKKm5S8XdTqYfm8C
         CcDp/H7s+vfrAJgYoMrp8ht8DVleoqveeNVP159udv3nLzVs+6Q8qopP8vyG3zH7LxmV
         uPhSmW08WFqqAjmeC6dM9qv1v8ZEWB2JCgTcI+EahhKJJD3qMY7NkTLdBkzXoA57tU/M
         SiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5lkNvfdqzLNCCHCaYrY6KK8auJzefWzgOZIlhiWbVmE=;
        b=KDSB5gqfFxahZvkSMrIffgr3WYRrM/T/8LtPVwcpsocQGcK/CroVpmLLqn0VW7KJFf
         1GztJgmTiXOinwr710j0C4KRRP1gBJeBS2fKu8E7de6qtsiVgZx91BcUP9vil5Y+FJOS
         iA4jVZJZYg6aU9htnJEbRHoYNY2pQ0RBTErz69WxJSwNfk9onhofM/s9oLyZdZcBXNJ6
         RuAfCAKJ9n7lKiJl+ZfbWIBGTQ5v/YbFq1jsBVTw3wEam5iYVZS10orUvbkWSPJMVTHY
         7Unl8kSF3BU3n1xl0p41g6eDZDHDK01gakNIe3Mfz80Uh5rSnf7zCcEfG/RjTsiC0wCn
         k5/Q==
X-Gm-Message-State: AFeK/H16xLBmUx7IF/9uWOgBA75QULFrvO46xcmJA7DU8fGXeEUrZWmhWCqJetBRy1leJw==
X-Received: by 10.84.231.193 with SMTP id g1mr62784353pln.84.1491932235124;
        Tue, 11 Apr 2017 10:37:15 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:c434:5e79:6b7e:ed6b])
        by smtp.gmail.com with ESMTPSA id 20sm15052550pfq.42.2017.04.11.10.37.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:37:14 -0700 (PDT)
Date:   Tue, 11 Apr 2017 10:37:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/5] forking and threading
Message-ID: <20170411173712.GN8741@aiede.mtv.corp.google.com>
References: <20170410234919.34586-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410234919.34586-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> As far as I understand the only instance of threading and forking which exists
> in the current code base is 'git grep --recurse-submodules', and the standard
> builds against glibc shouldn't exhibit any of this deadlocking.

I don't think we consider builds against glibc to be the only standard
way to build git.  So I do think we need to fix this (and not, e.g.,
to modify our build instructions to require use of a malloc
implementation that registers an atfork handler that unlocks all of
its locks).  Thanks for your work on that.

Jonathan Tan had an idea about how to side-step the issue: what if
"grep" forks an appropriate set of child processes before creating any
threads and then communicates with those children using pipes?
Because no threads have been spawned yet in the children, the child
processes can use ordinary run_command.  When run_command finishes,
the child is still available to launch another command using
run_command.

Thoughts?
Jonathan
