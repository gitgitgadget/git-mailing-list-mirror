Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD341F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 21:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfKMVJi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 16:09:38 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:38307 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMVJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 16:09:37 -0500
Received: by mail-pl1-f178.google.com with SMTP id w8so1585123plq.5
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ykvC9RTnSj+2GQVUCT+h53Yy+AyUOVxYSHEWTWevOBE=;
        b=NQ9E3ePNtj1H87RAz7U0b6+NSQczQaMXGLz5brXAY0NNti+S5KfDFzconluT77d5Ti
         5nR//zuItkbnEMuAF0HL1mbEHAvGpumdLrUP8XhqwR+qRDUM5Hm0mVj7L5hVD7e7oGLK
         wfSCEAh/JO8U913izkTz3dl6pIdnzSRRhrJQJ0DG3aC0iw+aAzQksU2UQ/kseVlHPAed
         STnHoRBCAFq8moKp/azy+8GysB7QxWRQcXCocUQorh5sMo8Qgo0LqkXt5cLkzUkk4b0k
         4xXxEFPt0Je74XBs8cJUtH5zNJX/qEB9l5I+V/tO3uahusF7TJq6hkh6yR7ZrR6aBoxp
         QwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ykvC9RTnSj+2GQVUCT+h53Yy+AyUOVxYSHEWTWevOBE=;
        b=A0ZZwxu7vhCo1tUPfdBkbRq+PfeRt+kuUdajQVj2Gm5nl89w/IF8gFj1nSKcvrkVW5
         wL2x+nl5X4xdtUWK5I0yqUa160p98JCfxCDkcrcoYBsv49gUM3cs6sk7sQITsoVJV5rc
         wlXPyLa3/UrUfblNaAHTUYz8SmGAGQTlgaNIztBKpwdtOb4e8zaQK+0AYFhCFMDMNqGf
         q23XZpvreuZw35A745lbaTDirR+ORzSx2gjiUbOU0TZkPBKnFJAMez99dSprM1LBAHzm
         a2WX/iCWLmaTxSIPE8PHOMLUwnAlTLJud+Inmc3fMYErzLrsOb25nBrwYHJxPTSOaNxp
         n8rw==
X-Gm-Message-State: APjAAAU9grau7f2BhXFQRMAa5jIOSVmtCK4LnIqOtF8eYhEMdCbzCaJC
        6xT6FB0EbcIywakJZnMSl1iHf9jSUHg=
X-Google-Smtp-Source: APXvYqxMaLUq+BBtrFG2WzTFJG/kYtKPq2OdZhEbWHnzknzhOv1GVHfoSW5llzxx1k7rbIr+4+hY1g==
X-Received: by 2002:a17:902:6807:: with SMTP id h7mr5651502plk.230.1573679375045;
        Wed, 13 Nov 2019 13:09:35 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id a3sm3659124pfo.71.2019.11.13.13.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:09:34 -0800 (PST)
Date:   Wed, 13 Nov 2019 13:09:29 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: Should we auto-close PRs on git/git?
Message-ID: <20191113210929.GC60198@google.com>
References: <20191109020037.GB60198@google.com>
 <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 08:11:06PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Fri, 8 Nov 2019, Emily Shaffer wrote:
> 
> > It seems to me that the friendly template text we prefill when someone
> > opens a pull request in github.com/git/git isn't being fully appreciated
> > by many interested contributors.
> 
> That is probably due to our confusing use of the template as a stop sign
> ;-)
> 
> > For some time now, Johannes has been slogging through the list to try
> > to narrow it down to folks who are still interested in contributing,
> > and yesterday on #git-devel said he was pretty happy with the progress
> > so far.
> 
> I don't mind it, and quite honestly, it does not take a lot of time,
> most of the time.
> 
> > But to me, this seems like a sort of Sisyphean task - more folks will
> > want to make contributions and not read the template text, and we will
> > have more PRs being ignored forever, especially if Johannes decides he
> > doesn't want to shepherd those changes anymore (I would have decided
> > that long ago, in his shoes).
> 
> The PRs are not bad. What is bad is all those comments on commits coming
> in as of recent, some developers thinking that they do not need to
> research the best way to reach the Git contributor community and instead
> just assuming that adding comments via GitHub's UI is a valid way.
> 
> I should probably refrain from trying to help those developers because
> it makes me very cranky, but I just don't want Git to be an unfriendly
> project.

I guess my concern is this: when I reply to some code review, email,
whatever, when I am cranky, it makes me seem unfriendly; when I do so
while wearing a maintainership hat (I maintain another project
elsewhere) it makes my project seem unfriendly :) Besides, I don't think
that anybody wants a contributor to be regularly doing work that makes
them cranky.

> > PS: Today we have 17 PRs open against git/git, and I think all of them
> > have been nudged by dscho in comments to open against GGG instead. Many
> > are in a state where dscho is sending a ping every few weeks to see if
> > the committer is interested in following through.
> >
> > https://github.com/git/git/pulls

> They all have been nudged, sometimes to clean up the patch first, or to
> suggest that maybe the goal of the PR might not be all that desirable.
> 
> Some of the PRs probably can be closed, but as I said, I would like to
> think of Git as a friendly project, a helpful one, so I want to err in
> favor of talking to the contributors rather than shutting the door in
> their face, so to say.

I do agree that meeting a patient human instead of silence is a good
contributor experience, and I appreciate all the work you're putting in
that direction.

 - Emily
