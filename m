Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584BD208E8
	for <e@80x24.org>; Tue, 24 Jul 2018 19:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbeGXUgL (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:36:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34040 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbeGXUgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:36:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so3580614pgv.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ERAyh0E9ftG1bvboGYVYCIf8RFrZ8fUMm8MDeIfSmQM=;
        b=jfhhFPI1uQNx+EFSY9lqD17cBjKqL+g7rNqzPuAHWn8Mr1TFv/lrQvVT/cv7qqm4Si
         DNu1I1qb4wt414QzaZ6Qol8WN7JGI7Qmq9oI0QmNJ+PN9WUwbTkBsowZPGgBk/hGL574
         Y0GursKhCSh//S71PljGYlbd1hU155VHeIxRGwt/vBDHqJB5u5K7AHKwLa2ICFX6eYEG
         hZEleGOqbwKW2fOXiLIecIQMju/TEC0WvQhsESDotr2E56yoGHJlmH5dhWRvsr8yDrG7
         o6PEBK+BQso35E63n8I1RjfJv5WTQ88AMyJpXY1goY5Ql9IF9vprnfchJ/8eh1PDuMAM
         9EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ERAyh0E9ftG1bvboGYVYCIf8RFrZ8fUMm8MDeIfSmQM=;
        b=TDcnoMRfwqjfh+1ejIS0CQoanlJTZZ4uInYeOivmwuXTSg1Vi3bSwsdI2YLqCQZHsU
         L1Iaxk38RFw4XtmguFfoZUGxSpp554eCOxORpXulMWxrTeuQAK0no+Jr1lIZHMtbXe+R
         kHM35uEkiOsgB8mqT12Q/eWFh7Rv2AFSJhhK+7vxqlKcqR0mJAMbCXJMJBlQHDb9zigh
         NKvUV22rVCStU7lGxI74O6huplQPuPGskzU3jqboC3kVerLS4H5GSOf0qFk5m9aXLku1
         +RmdChFDz477QYpTIefFwmaHkAudEHlWnpvyaGccOtkXuSsumgdCndkRPhz5Y6g3KNsZ
         ZA7w==
X-Gm-Message-State: AOUpUlFSg+Eo/SmbY2xJxEwjuCe63Xczm4S6jq6yD2aWzqvQVZOLs6fF
        zzjvGzQRp1mnnTRomLOfjyOK2PpG/00=
X-Google-Smtp-Source: AAOMgpelSQcZkuJoBPNAgN9kQrl1f5YulYB7ycfuT6IDz/S9mM8UP8RcqTPKC/mS7fulZL+4K0baSw==
X-Received: by 2002:a63:144b:: with SMTP id 11-v6mr17894686pgu.219.1532460493193;
        Tue, 24 Jul 2018 12:28:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p66-v6sm31407599pfd.65.2018.07.24.12.28.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 12:28:12 -0700 (PDT)
Date:   Tue, 24 Jul 2018 12:28:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Subject: Re: [RFC] push: add documentation on push v2
Message-ID: <20180724192811.GC225275@google.com>
References: <20180717210915.139521-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717210915.139521-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/17, Brandon Williams wrote:
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
> 
> Since introducing protocol v2 and enabling fetch I've been thinking
> about what its inverse 'push' would look like.  After talking with a
> number of people I have a longish list of things that could be done to
> improve push and I think I've been able to distill the core features we
> want in push v2.  Thankfully (due to the capability system) most of the
> other features/improvements can be added later with ease.
> 
> What I've got now is a rough design for a more flexible push, more
> flexible because it allows for the server to do what it wants with the
> refs that are pushed and has the ability to communicate back what was
> done to the client.  The main motivation for this is to work around
> issues when working with Gerrit and other code-review systems where you
> need to have Change-Ids in the commit messages (now the server can just
> insert them for you and send back new commits) and you need to push to
> magic refs to get around various limitations (now a Gerrit server should
> be able to communicate that pushing to 'master' doesn't update master
> but instead creates a refs/changes/<id> ref).
> 
> Before actually moving to write any code I'm hoping to get some feedback
> on if we think this is an acceptable base design for push (other
> features like atomic-push, signed-push, etc can be added as
> capabilities), so any comments are appreciated.
> 
>  Documentation/technical/protocol-v2.txt | 76 +++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)

Pinging this thread again to hopefully reach some more people for
commentary.  Looking back through the comments so far there are concerns
that a server shouldn't be trusted rewriting my local changes, so to
address that we could have the be a config option which is defaulted to
not take changes from a server.

Apart from that I didn't see any other major concerns.  I'm hoping to
get a bit more discussion going before actually beginning work on this.

-- 
Brandon Williams
