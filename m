Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03671FF34
	for <e@80x24.org>; Thu, 11 May 2017 10:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbdEKK2Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 06:28:16 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:42125 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbdEKK2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 06:28:15 -0400
Received: from tigra (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id F20DDD400A6;
        Thu, 11 May 2017 13:28:12 +0300 (MSK)
Date:   Thu, 11 May 2017 13:28:12 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] usability: don't ask questions if no reply is
 required
Message-ID: <20170511102812.3ed3sqycjmapfj35@tigra>
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170503210726.24121-1-jn.avila@free.fr>
 <xmqqa86kccca.fsf@gitster.mtv.corp.google.com>
 <61C67DC73308BD49B2D4B65072480DBA2BDAB97D@DEERLM99EZ1MSX.ww931.my-it-solutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61C67DC73308BD49B2D4B65072480DBA2BDAB97D@DEERLM99EZ1MSX.ww931.my-it-solutions.net>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:10:05AM +0000, Kerry, Richard wrote:

[...]
> > > @@ -1940,7 +1940,7 @@ static void am_resolve(struct am_state *state)
> > >
> > >     if (unmerged_cache()) {
> > >             printf_ln(_("You still have unmerged paths in your index.\n"
> > > -                   "Did you forget to use 'git add'?"));
> > > +                   "You might want to use 'git add' on them."));
> >
> > This case is *not* an "rhetorical question is the most succinct way to convey
> > the information" situation; I think this rewrite is a definite improvement.
> > "You might want to 'git add' them" may be more succinct, though.
> 
> "You might want to use 'git add' on them." It isn't about what you
> *want* to use, it's what you *need* to use, isn't it?  And I'm not
> happy about "on them".  I'm not sure quite why, but the phrasing seems
> odd.  How about "You might need to use 'git add'.", or "You might need
> to use 'git add' first.", or "'git add' needs to be used to add
> files." ,  or "'git add' needs to be used before any other git command
> may be used.".

Why not just

  You should run `git add` on each file with resolved conflicts to mark
  them as such.

I'm not an English speaker but IMHO this phrasing concentrates on the
essense of the problem.  It's far from being succint, unfortunately.

I also wonder what to do with "deleted by them" state of certain files
which are also "unmerged" but `git add`-ing them would be a wrong thing
to do if we want to accept the upstream's decision to delete the file.
So maybe something like

  You might run `git rm` on a file to accept "deleted by them" for it.

appended to the original hint would be good.

