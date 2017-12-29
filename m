Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7191F404
	for <e@80x24.org>; Fri, 29 Dec 2017 13:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdL2Nwp (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 08:52:45 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:41602 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdL2Nwo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 08:52:44 -0500
Received: by mail-qk0-f179.google.com with SMTP id a8so15483457qkb.8
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rtkywx1s+wGG5GycW+nMRCKjKYFoysemyy6xsjUhXsg=;
        b=Y01EL4rZfnEdph240UbaSIXz2mvQ4mJ+MNEbk/J4+9Z2ZXzNi8T1XWL5jJUXMZ4pBm
         HCqR0R7hlhnBKQNgVsASF7JPo06lPIw4FwGAlGIs4ANpBvicZ4RXjsSJTNLzOi18x4n7
         F3JHSC4bnodC442y6AP3EHY6cfFiIsXlmAUEeU7h1JlpK+F9y26SAJ2CbgyWzntMrejW
         ncW8XNhGXlOs5aM48EQhrmsd/oYykGO/oRvYUS+2jMhf3ddv2gOJWsoKt61934TwcpcU
         cIyMEDfKbVvP2wCSDSVQJ4FJ644Hz10uf2+qpZ4cqVDMPhPMrp3WxuHUwyfINYIHXy5V
         pvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rtkywx1s+wGG5GycW+nMRCKjKYFoysemyy6xsjUhXsg=;
        b=Rhs3kVrIQPCGHMk7USJb1dx6dfL6tpE6qJvIWod9GKqiRaG5pHg7HajhecTBZnPser
         98uUt4vG3ttWn5wjOPiEkKj8I5yvjTl2yCKfOb6qy2/uEvGyYYffTtQPC0iB20hXt0MG
         ZBYO0kySMF0lZOWJtGllltx0prGucXF+SqHmUk59VoMmGhEqkDy0J7mRvgGGpt9ynfmi
         w0J6LjG5sW0zzkCaPYEt6LZc2zwikCnlFXn2F5C5vEfbz/NfGQpHdnZqjnYEf7iIdj66
         krRGHopc6ClaGaIEtJ+wQKCFfih7MW+Ii16nS+BkxZHWXd3bRWyllfIwnxATWED+mHxV
         LZBQ==
X-Gm-Message-State: AKGB3mL1+41aa9mW/bYXbdRvM3S+lmQHD+ZWbAQY0O/DZQFxanbpWoyW
        MoGMeon81/iKmJYNPI4OslQ=
X-Google-Smtp-Source: ACJfBouAxWp9SgpHxYDVCxN7u15AWikMDXXgRm0fzTZmoMbZIqLtBWvx4HGXQjj4bXmJ7Ojfh/b4Ww==
X-Received: by 10.233.223.133 with SMTP id t127mr3460390qkf.38.1514555563929;
        Fri, 29 Dec 2017 05:52:43 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id s58sm23817224qtb.41.2017.12.29.05.52.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Dec 2017 05:52:42 -0800 (PST)
Date:   Fri, 29 Dec 2017 08:52:40 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Keith Smiley <k@keith.so>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20171229135240.GQ3693@zaya.teonanacatl.net>
References: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
 <20171229032927.GN3693@zaya.teonanacatl.net>
 <20171229041927.GA83931@bryant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171229041927.GA83931@bryant.local>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keith Smiley wrote:
> It looks like that was just about preferring remove in documentation
> and the like, I think it would still make sense to have both for
> completion since rm is still supported.

I read it as a first step in a long process to eventually
remove 'remote rm', but if that's never intended, then sure,
restoring completion for it seems reasonable.

It would be good to hear from those who know or recall the
intention.

I think we should only complete the preferred subcommand.
That encourages use of 'remote remove' even if 'remote rm'
will stay forever to avoid breaking existing scripts.

If it does make sense to restore completion, adding a link
back to e17dba8fe1 and explaining why the completion is
being restored would be good.  Reading the commit message
now makes it sound like 'remote rm' was never present and is
being added to correct an oversight.

Maybe something like:

    completion: restore 'remote rm'

    e17dba8fe1 ("remote: prefer subcommand name 'remove' to
    'rm'", 2012-09-06) removed the 'rm' subcommand from
    completion.  The 'remote rm' subcommand is still supported
    and not planned to be removed.  Offer completions for it.

I also noticed that in your original commit that you say
"list of removes as remove does." That should be "remotes"
instead of "removes" there. -- I've made that typo myself
quite often. :)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
There are no stupid questions, but there are a LOT of inquisitive
idiots.
    -- Demotivators (www.despair.com)

