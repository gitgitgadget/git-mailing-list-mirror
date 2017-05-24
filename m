Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36BD82023D
	for <e@80x24.org>; Wed, 24 May 2017 10:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761767AbdEXKzo (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 06:55:44 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36853 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761587AbdEXKyu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 06:54:50 -0400
Received: by mail-qk0-f170.google.com with SMTP id u75so150075050qka.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QVCn46iaWB4R6B/p3mMr6GhMbx8GTX85o1Q/qUsq6GU=;
        b=Bj84KRFfW4aLgRDRp0bRP2fb/emnOPRx3AFl9Jvj1VQwPc1v9JRLNq57pO60mmy09o
         tu8s737AeEEwJ0KIxQNFFia6fYMz2XRxxT+HloIuDh4XOh2hKG13i48tPRyoRZgEJF3E
         mXmGNvUn38JBMAKBSoCh7CZ9xhgfX5R9fFhLtEXGDWCJuDbuBltp0LwNdhPry7sDRl1x
         kN7/s7rdKp0PBJjoTHgwnrUPhV8lLnq7ygtj0EH9OwkDf4K7QvfVNDaoJEaSOngSXugm
         DBLFy1Vv4sp9q+nzOX/pMMuPDrpKXentES9PTYefGegdMt79Epy46HlqtBY5JED7l04Y
         kfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QVCn46iaWB4R6B/p3mMr6GhMbx8GTX85o1Q/qUsq6GU=;
        b=iLVBjKwdLaO9Ydm31TTxVEYhk4sjDgNIv/2Y+AfVPkSW+ngkgqAlYHs0wyFdUZXLvB
         SwL1N68+IztckrVaZAaF8HBPNHwl+9iMiLcYvlB48VsCFo3QRin+F8lTnGVNHGIe2F1S
         nzqQx6eybgnL3qkpEmmHfS+wZoMB56iqmhGW7NWfOamEAsOyGYR/p47hvjOA9cuGPh8b
         4oe0ctOOupqzQf7iQ3y7PL5SVslz8ZI5vRTQyG21D4EPvzjtt7s8/WdyFDy17m1b5Xxo
         2w60zitMrdJHMJjM8I6z+3vvggrz/nISFQdhsjNimYk8Iw9aA3qWf9EEyNfHMCpMexNj
         5CSg==
X-Gm-Message-State: AODbwcAOyagPrems7GFKLrVayeSJJPu6ze8wAWBJqFj9GJgCf6wv3qoa
        aKkSrF37jdx6Yq0pYtt5+XTbfGzeTQ==
X-Received: by 10.55.217.155 with SMTP id q27mr32796035qkl.217.1495623289140;
 Wed, 24 May 2017 03:54:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Wed, 24 May 2017 03:54:48 -0700 (PDT)
In-Reply-To: <20170518201333.13088-1-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 24 May 2017 12:54:48 +0200
Message-ID: <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Design
> ~~~~~~
>
> A new git hook (query-fsmonitor) must exist and be enabled
> (core.fsmonitor=true) that takes a time_t formatted as a string and
> outputs to stdout all files that have been modified since the requested
> time.

Is there a reason why there is a new hook, instead of a
"core.fsmonitorquery" config option to which you could pass whatever
command line with options?

> A new 'fsmonitor' index extension has been added to store the time the
> fsmonitor hook was last queried and a ewah bitmap of the current
> 'fsmonitor-dirty' files. Unmarked entries are 'fsmonitor-clean', marked
> entries are 'fsmonitor-dirty.'
>
> As needed, git will call the query-fsmonitor hook proc for the set of
> changes since the index was last updated. Git then uses this set of
> files along with the list saved in the fsmonitor index extension to flag
> the potentially dirty index and untracked cache entries.

So this can work only if "core.untrackedCache" is set to true?

Thanks for working on this,
Christian.
