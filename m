Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5431F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 18:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDVSeA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 14:34:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37117 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfDVSeA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 14:34:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so6200548ply.4
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EE9xICX4EVvKx9+RiCbulfYDUdRY2YLBhcAACE2jEek=;
        b=UAiXbdiXzdaeZCb62wqae9EOfgMUfCNaUN9Gvnb4yq3aMwdpoOdOb90r0gdviFG5zJ
         WmY/pjyC4n9nVmcJxnm9kfU6BCnV5pz610oRqsFfj6EjU4h8kuFy2kQ+53PCV1Y9CcxT
         QPYZIylFalJwjZ9hIsucc0viGtBi8LjmZ9pufBVeyqcYbAJ0/ozld5o2A+ryQezP68Zd
         +pG4GXML0bu90DtGUE1njqPzAPK/UMKVCnCAkf99i2mkicNIfElsAxF48ipPHPt63aIv
         lN/qnlqE3erWuIVsd3JN7FtXCbDPF+DShMl1NA4w1GGhU987m4pOiS2MBexuPVHGffOj
         qWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EE9xICX4EVvKx9+RiCbulfYDUdRY2YLBhcAACE2jEek=;
        b=YZ4gAke4SXjsHd3qk3WTZFqGHCO8QJMWejZL8cGfQ7I7nojTsxxctqixH4e5wKIvNI
         tQcZlsxdCYZt3HG+yoEqDYmohbBAwyX1UtzLObv7HvxtIycnCwNHqeEvhkWK031m9UiI
         uV0wMu0h+cWGcyg8DUFtlbsZV7Pmwo0dCiLHN9i+TIWwLgyA+mY9u5aKC2DH9BnXONFe
         oGjbbOvsERlOGLvSj+73ZJ7jNZkm+KyZG0pAWLOzLCyViTtAqemE+B/aZqh7CQ9lJEwB
         pP/9i6UmF/SjWfg6deOG2L++3wiGgrb0V0Vp503203Ea95gQ0F7rU5FNFOjOE4I6NRtI
         5P+A==
X-Gm-Message-State: APjAAAWtNAMybUxHJBbBPFp2n8tYrCadqDSVmB4dD1cGIOlMIglgFESi
        1M7IvbfQ2eYvCRUlVG9ukjo=
X-Google-Smtp-Source: APXvYqyARpZkPs8m1xDkz+vwb/hVO3ysGr/BRlkTpgCHtt4okNIt88FMhUiXjGEhnHA5e6JP7IR0uw==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr20805401plo.32.1555958039127;
        Mon, 22 Apr 2019 11:33:59 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id y10sm19845329pfm.27.2019.04.22.11.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 11:33:58 -0700 (PDT)
Date:   Mon, 22 Apr 2019 11:33:56 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 5/5] difftool: fallback on merge.guitool
Message-ID: <20190422183356.GA6730@dev-l>
References: <cover.1555880168.git.liu.denton@gmail.com>
 <fb7ac11439cbfd52d9181b78fdc8f8034a6b1064.1555880168.git.liu.denton@gmail.com>
 <2a521a5c-4b5d-57aa-1e91-d4ec9b190fb7@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a521a5c-4b5d-57aa-1e91-d4ec9b190fb7@jeffhostetler.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Mon, Apr 22, 2019 at 02:18:36PM -0400, Jeff Hostetler wrote:
> 
> 
> On 4/22/2019 1:07 AM, Denton Liu wrote:
> >In git-difftool.txt, it says
> >
> >	'git difftool' falls back to 'git mergetool' config variables when the
> >	difftool equivalents have not been defined.
> >
> >However, when `diff.guitool` is missing, it doesn't fallback to
> >anything. Make git-difftool fallback to `merge.guitool` when `diff.guitool` is
> >missing.
> >
> 
> Is this a well-defined operation?

I believe this is a yes.

> 
> I mean, we're assuming here that a 3-way gui merge tool (that probably
> expects 3 input pathnames and maybe a 4th merge-result pathname (and
> associated titles and etc)) can function sanely when only given the
> pair that a diff would have.
> 
> That is, we're assuming that the selected merge tool has a 2-way diff
> mode and that the command line args for the 2- and 3-way views are
> compatible.

If I read the code correctly, it seems like the only tool that is
strictly "merge-only" is tortoisemerge. In mergetools/tortoisemerge, we
have

	can_diff () {
		return 1
	}

which means it will refuse to run as a difftool.

In the case where it fails like this, it'll loudly complain to the user,
which'll give them a chance to fix their config. I believe that this is
desired behaviour and the patch adds on top of that.

Thanks,

Denton

> 
> Just a thought
> Jeff
> 
> 
