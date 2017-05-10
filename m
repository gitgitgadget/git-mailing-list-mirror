Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF6C20188
	for <e@80x24.org>; Wed, 10 May 2017 16:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbdEJQQh (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 12:16:37 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36281 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754087AbdEJQQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 12:16:36 -0400
Received: by mail-pg0-f43.google.com with SMTP id 64so128771pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hUSLR0PQ/xiKehabT+KnBoJs3DKoAZ0ClyaptAyqso4=;
        b=Yzg2K5mqE1QQdBS/0LUhVkz/6AZLqen2hoGuFVTZVPjGsE9fxaN/oOJUqNADBxbt1q
         rlw8RWVRRQUX6HFabsrhxDyToUzPtKexzYFVMduWDpz55kXc0lyqjr5n3B97Uvz8upaH
         auDmDcz2hxy9OPuWGKJH033kun1FqYaGPOisbQ5DqMcmqz/J55xkUMhWxdwdqTAvKf+L
         XdqWXivkvqFv87ilojT81qmriYSAT9OOBWMpCqU6bQf1Z2aeRBt7kKD2b6QFDQgiomFx
         XlT6q3YPH82j/SsdrYnp/xfkRVqSe4f3tjbu2w5s/PFW9GBqCQ/CCENORuYA9nX9mANc
         nV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hUSLR0PQ/xiKehabT+KnBoJs3DKoAZ0ClyaptAyqso4=;
        b=Ee0H1eyRbUR0jB2fyOutRHxSRC5MzKh4nZlWm+ah70xATyMXSjp5De4E4ZS2iwpn7a
         yj4AqaILXn1UlvewfCe6GieUj9iRhQkDKc6C2gvRyNN0o4SPBdUNFi3a/ova6uO0eTV7
         aY2NPMFyAAs72Kqh6g6LuOas7yCOFoMigqhERtLkjUq+aCamUu/UgwDbpTmNMuIPBxmG
         DKtQPpvebM9h/dJFG2d36MYB/Xf1G5MEz9fs0m82htF/wNe6lyq1zNItr5u5hHjGc1EN
         jV9xDO8nX+zBf2sglqbT0RI5xhNmfhwduDArk1txTky1bPMLarF4d7ZwyDcuWXulPL2T
         PrUA==
X-Gm-Message-State: AODbwcDYTDJqn6Qko/cWNKPXJkF6qdUSkK2MpI1M/EuMxmMcfOM4d/jS
        wbgnQdsHL/ptNri3
X-Received: by 10.99.112.86 with SMTP id a22mr7328221pgn.52.1494432995957;
        Wed, 10 May 2017 09:16:35 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b127:d26b:19a3:378d])
        by smtp.gmail.com with ESMTPSA id p3sm6535495pgd.36.2017.05.10.09.16.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 09:16:34 -0700 (PDT)
Date:   Wed, 10 May 2017 09:16:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/8] pathspec: change
 PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
Message-ID: <20170510161633.GA41649@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170509191805.176266-4-bmwill@google.com>
 <xmqqefvxxnpq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefvxxnpq.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > It's confusing to have two different 'strip submodule slash' flags which
> > do subtly different things.  Both
> > PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE and
> > PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP will accomplish the same task of
> > striping a slash from a pathspec which matches a submodule entry in the
> > index.  The only difference is that
> > PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE will perform additional checks
> > and die if a pathspec has a leading path component which corresponds to
> > a submodule.  This additional functionality should be split out into its
> > own flag.
> >
> > To this end, rename the PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag to
> > PATHSPEC_SUBMODULE_LEADING_PATH and change its behavior to only die if a
> > path descends into a submodule.  In addition add the
> > PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag to callers which relied on the
> > old slash stripping functionality.
> 
> "PATHSPEC_SUBMODULE_LEADING_PATH" feels like an unfinished sentence
> to me.  Do I understand your description correctly if I say it is
> about "checking" the leading path to see if it overlaps with a
> submodule path?  IOW, I am wondering if the name should have the
> word CHECK somewhere in it.
> 

You're probably right, the name has something left to be desired.  I
chose it simply because it conforms to another flag
"PATHSPEC_SYMLINK_LEADING_PATH" which dies if there is a symlink in the
leading path.

And you are correct, it checks if the leading path overlaps with a
submodule path.  If it strictly matches a submodule path that's alright
though.  The point of this flag is to disallow paths which descend into
submodules.  One such use case is to prevent a user from trying to 'git
add' a file from a submodule.

-- 
Brandon Williams
