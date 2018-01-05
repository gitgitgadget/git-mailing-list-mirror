Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE521F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeAEVWB (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:22:01 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:35855 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753045AbeAEVV7 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jan 2018 16:21:59 -0500
X-Greylist: delayed 2397 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2018 16:21:59 EST
Received: from cmgw2 (unknown [10.0.90.83])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id B93321ACCAE
        for <git@vger.kernel.org>; Fri,  5 Jan 2018 13:26:21 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw2 with 
        id ukSJ1w00T0QvKlu01kSMQR; Fri, 05 Jan 2018 13:26:21 -0700
X-Authority-Analysis: v=2.2 cv=doKrMxo4 c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=RgaUWeydRksA:10 a=pGLkceISAAAA:8 a=ivXI333Y1-cMi7feZ64A:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K0jH0/vVVQX7tN3sYP4GrWPtUSleu4MTYDlIzJGTMg0=; b=RfnK/zVqQUaHrH1iAX5gOTSuKC
        mh2dJX9jRcxNfEHaV+jUUfXPAPgcoXm07J7bohHFyWlxksvY6ruaL9f42N0eELR0LlYcOhZW4ZTAf
        6dPw7NU1/6Xu4ZEVd7mhKxWUs;
Received: from [65.112.16.22] (port=57670 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <paul@mad-scientist.net>)
        id 1eXYZG-0023Wv-52; Fri, 05 Jan 2018 13:26:18 -0700
Message-ID: <1515183976.21764.114.camel@mad-scientist.net>
Subject: Re: Can't squash merge with merge.ff set to false
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Bryan Turner <bturner@atlassian.com>,
        Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Date:   Fri, 05 Jan 2018 15:26:16 -0500
In-Reply-To: <CAGyf7-FHyO9pkEFFguea+B+VMTodF=mg8wJNedvjYdL7e7ORqQ@mail.gmail.com>
References: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
         <CAGyf7-FHyO9pkEFFguea+B+VMTodF=mg8wJNedvjYdL7e7ORqQ@mail.gmail.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 65.112.16.22
X-Exim-ID: 1eXYZG-0023Wv-52
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [65.112.16.22]:57670
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2018-01-05 at 12:12 -0800, Bryan Turner wrote:
> On Fri, Jan 5, 2018 at 11:59 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> > Not sure if this is intended or a bug, but with the following
> > configuration:
> > 
> > $ git config --global merge.ff false
> > 
> > I am not able to merge my topic branch into master with squash
> > option:
> > 
> > $ git checkout master
> > $ git merge --squash topic
> > fatal: You cannot combine --squash with --no-ff.
> > 
> > I'm not sure why a non-fast-forward merge would prevent a squash
> > merge, since by its very nature a squashed merge is not a fast
> > forward merge (or maybe it is if you only have one commit).

Hah!  I was just thinking of checking the latest Git RC I built
yesterday to see if this pet peeve of mine has been fixed yet.  I guess
not!

> The easiest way to move forward is probably to pass "--ff" on the
> command line to override the config, when you're using "--squash".

That's what we always have to do.  Very annoying; we use squash-merge
extensively but also want to require ff merge by default.

> As for why the two aren't allowed together, my assumption would be
> because if you're only squashing a single commit "--squash" and that
> commit is fast-forward from the target, a new commit is not created
> and instead the target branch is fast-forwarded. With "--no-ff", it's
> questionable what "--squash" should do in that case. Fast-forward
> anyway? Rewrite the commit simply to get new committer details and
> SHA-1?

If it only failed when you were squash-merging a single commit that was
also fast-forwardable, I guess that would be one thing.  But even if I
have multiple commits and I want to squash-merge them, which clearly is
a separate operation giving different results, I get this error.

I don't think Git should try to be clever here (if that's what it's
doing--I always assumed it was just a missing configuration case in the
error check).  If I asked for a squash-merge then Git should give me a
squash merge.

So in answer to your question, --squash should give me a squash merge
and the setting of --ff / --no-ff should be completely ignored, as it's
irrelevant.

My $0.02.
