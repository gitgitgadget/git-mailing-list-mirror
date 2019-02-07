Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B131F453
	for <e@80x24.org>; Thu,  7 Feb 2019 21:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBGVd3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 16:33:29 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37362 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBGVd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 16:33:29 -0500
Received: by mail-wm1-f46.google.com with SMTP id g67so1408520wmd.2
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vi/nXLDMZKjLJlM0GMmMhE3Yq4G1Fh/SU6flGAgfTvY=;
        b=oH7vA3RsNHB/DSQV1ve0s3soklF0HTcCqtTFQ0bjvYUQfq6f42v49sLaZ7sH6FjEh3
         OAI5CgK8tAIdtIJrwSZ4w+bXBxoBjbb22vKO2JsCDNDsqwhL3yUGlrRkB1Udh7oo4ChG
         DPIq+W9XcdJ/z95jXMx2/zNDbKeqOK31k7ce+SVYEoQ75O5+OVJ5y3AAktGmbA2vbFBJ
         +WMIFpHhrjRjyeOqOSFkOtb5Hab+L0BZ5ClQ8IuWA3NIy5cfvp/bo/m8YkW3rfNfg3LU
         DaAv6n8tDdnhjJTSDwj5Yp/cRd5cJty+37qPtKU1lTH9heJOT8xNRe9HOgVk4n35xdZZ
         ZZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vi/nXLDMZKjLJlM0GMmMhE3Yq4G1Fh/SU6flGAgfTvY=;
        b=dzlS9qM4k8JJCyRBNLvM/wdeKBrX4a6UdlFKAWk6b/G1872vfA4d/6PZIH+Bj2JP//
         ac2hJAI03isbvS8OZU/zFl+golN95ufGfHgNoRdmCsdIpihMs8hjI1HQ4Rn3wb8QNr3e
         5sXrHnZ47RbjRISJC0xxvH1MwydDgH02hk+eJBkcFrleMVbFytTmD7OXQ4wCFbhE3bhu
         +IoeM5QLSCDm+b+3x+00J6sQNDVWk14VZfJWWyLBEKy0/p2KBB875X2Xtd4+CXR/DprV
         1JIc2Gs1wQrk6lOmBYrcyH8u8zZ4VLc3dl6fSmKSSWeb41jMDNXf2gcc1yqGkkeDpJLx
         rxZw==
X-Gm-Message-State: AHQUAuZrPtfku/PXkLAiI/8alY5ggsmKMB3HP27ZCucX2xbuJ7MpwJhE
        B0bQXB0HuGP41k0wTrqqCFU=
X-Google-Smtp-Source: AHgI3IZeaKjTZHv8y1j1533rgOew9T7jG1VjSD1+UzeXt2VjJy7k2ZBT9D69PsUlQkkjs+4cmb8H0g==
X-Received: by 2002:a1c:6c10:: with SMTP id h16mr504771wmc.84.1549575207920;
        Thu, 07 Feb 2019 13:33:27 -0800 (PST)
Received: from localhost ([109.180.252.133])
        by smtp.gmail.com with ESMTPSA id n6sm366069wmk.9.2019.02.07.13.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 13:33:26 -0800 (PST)
Date:   Thu, 7 Feb 2019 21:33:26 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190207213326.GF6085@hank.intra.tgummerer.com>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com>
 <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Wed, 6 Feb 2019, Thomas Gummerer wrote:
> >  - implement pushing the index state, without dealing with conflicts
> >  - implement poping the index state, without dealing with conflicts
> > 
> >    This can already be individually useful, and I think this is
> >    something people asked for on the mailing list, though I didn't try
> >    digging up old threads for now.  After these two steps stashing and
> >    restoring a merge conflict would still not work, but we have a good
> >    first step that could be merged.
> 
> We already have `git stash --keep-index`. Is this what you mean here?

`git stash --keep-index` does something different, what I meant here
was what `git stash pop --index` already does.   I had forgotten that
this functionality already exists.

> >  - implement pushing/poping conflicted state
> > 
> >    This would obviously be the end goal.
> 
> On second thought, this might actually be super trivial. Right now, we
> support two modes (not counting the `--untracked` stuff): --keep-index and
> --no-keep-index. In both cases, we seem to create a merge commit whose
> tree reflects the working directory and whose first parent is HEAD and
> whose second parent is a single commit on top of HEAD (which contains
> either no changes in the case of --no-keep-index, or whose tree reflects
> the index in case of --keep-index).
> 
> To extend that to the conflict case, we could introduce a new flag
> --with-conflicts, and have the commit structure
> 
> 	Worktree
> 	 |    \
> 	 |    index stage 0
> 	 |      /     |     \
> 	 | stage 1  stage 2  stage 3
> 	 |    /     /       /
> 	HEAD ---------------
> 
> The only tricky thing I can see is to maintain backwards compatibility if
> possible, so that old `git stash` will do something at least semi-sensible
> with those commit structures.
> 
> It might be too small a project, after all.

Yeah, looking at this I think you're right.  Thanks for helping work
through this.

> Ciao,
> Dscho
