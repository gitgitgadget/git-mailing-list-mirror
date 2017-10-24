Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989F21FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 13:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbdJXNTo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 09:19:44 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:35688 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933487AbdJXNSa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2017 09:18:30 -0400
Received: from app06-neu.ox.hosteurope.de ([92.51.170.140] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1e6z6B-0001C9-FE; Tue, 24 Oct 2017 15:18:27 +0200
Date:   Tue, 24 Oct 2017 15:18:27 +0200 (CEST)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Message-ID: <1989036170.30614.1508851107354@ox.hosteurope.de>
In-Reply-To: <5bc82075-0fb2-0929-2da7-d9069222a3fe@kdbg.org>
References: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
 <5bc82075-0fb2-0929-2da7-d9069222a3fe@kdbg.org>
Subject: Re: [PATCH v1 1/1] completion: add remaining flags to checkout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev14
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1508851110;bb4189d2;
X-HE-SMSGID: 1e6z6B-0001C9-FE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Johannes Sixt <j6t@kdbg.org> hat am 12. Oktober 2017 um 18:50 geschrieben:
> 
> 
> Am 12.10.2017 um 14:20 schrieb Thomas Braun:
> > In the commits 1d0fa898 (checkout: add --ignore-other-wortrees,
> > 2015-01-03), 1fc458d9 (builtin/checkout: add --recurse-submodules switch,
> > 2017-03-14), 870ebdb9 (checkout: add --progress option, 2015-11-01),
> > 08d595dc (checkout: add --ignore-skip-worktree-bits in sparse checkout
> > mode, 2013-04-13), 1d0fa898 (checkout: add --ignore-other-wortrees,
> > 2015-01-03), 32669671 (checkout: introduce --detach synonym for "git
> > checkout foo^{commit}", 2011-02-08) and db941099 (checkout -f: allow
> > ignoring unmerged paths when checking out of the index, 2008-08-30)
> > checkout gained new flags but the completion was not updated, although
> > these flags are useful completions. Add them.
> > 
> > Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> > ---
> >   contrib/completion/git-completion.bash | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index d934417475..393d4ae230 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1250,7 +1250,9 @@ _git_checkout ()
> >   	--*)
> >   		__gitcomp "
> >   			--quiet --ours --theirs --track --no-track --merge
> > -			--conflict= --orphan --patch
> > +			--conflict= --orphan --patch --detach --progress --no-progress
> > +			--force --ignore-skip-worktree-bits --ignore-other-worktrees
> 
> Destructive and dangerous options are typically not offered by command 
> completion. You should omit all three in the line above, IMO.
> 
> Furthermore, --progress and --no-progress are not useful in daily work 
> on the command line, I think. By offering them, --p<TAB> would not 
> complete to --patch anymore, you would need --pa<TAB>. You should omit 
> them, too.

Thanks for the review.

I've fixed that for the next reroll.
