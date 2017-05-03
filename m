Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B651F829
	for <e@80x24.org>; Wed,  3 May 2017 18:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbdECSfL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 3 May 2017 14:35:11 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:48768 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbdECSfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:35:09 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 3FBEC200416;
        Wed,  3 May 2017 20:35:07 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] usability: fix am and checkout for nevermind questions
Date:   Wed, 03 May 2017 20:35:06 +0200
Message-ID: <2001640.bFkheBfX4c@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20170503165158.GZ28740@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr> <20170503162931.30721-2-jn.avila@free.fr> <20170503165158.GZ28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mercredi 3 mai 2017 09:51:58 CEST, vous avez écrit :
> Jean-Noel Avila wrote:
> > Subject: usability: fix am and checkout for nevermind questions
> > 
> > Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> 
> Thanks for working on improving Git's UX.  I agree with the goal in
> general (we should not gratuitously surprise users) but I think I
> lack context for appreciating this particular example.
> 
> This is a good place to describe the motivation behind the patch and
> what effective change it would have.
> 
> [...]
> 
> > +++ b/builtin/am.c
> 
> [...]
> 
> >  	if (is_empty_file(am_path(state, "patch"))) {
> > 
> > -		printf_ln(_("Patch is empty. Was it split wrong?"));
> > +		printf_ln(_("Patch is empty. It may have been split wrong."));
> 
> [...]
> 
> >  	if (unmerged_cache()) {
> >  	
> >  		printf_ln(_("You still have unmerged paths in your index.\n"
> > 
> > -			"Did you forget to use 'git add'?"));
> > +			"You might want to use 'git add' on them."));
> 
> [...]
> 
> >  		if (opts.new_branch && argc == 1)
> >  		
> >  			die(_("Cannot update paths and switch to branch '%s' at the same
> >  			time.\n"
> > 
> > -			      "Did you intend to checkout '%s' which can not be resolved 
as
> > commit?"), +			      "'%s' can not be resolved as commit, but it
> > should."),
> 
> In the current state I think this patch makes things worse (questions
> are not automatically a bad thing), which would make it especially
> useful to see more about the motivation so we can find out whether
> there's another way.
> 

I am not a UX designer, but for me, in the context of interaction with a 
command line program, any question that does not accept a reply is bad design. 
That also means that any command that does not run interactively should not 
ask questions. The shell interface is too informal to allow being loose on the 
program side. Comparatively to a GUI, where a label is formally informative 
and a popping-up dialog box asks for user input.

This patch should indeed be squashed with the first one. They are small changes 
in strings printed when dying.  They would share the more extended commit 
message.



