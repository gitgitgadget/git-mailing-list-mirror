Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399B61F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758384AbcH3R4I (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:56:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:49285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756356AbcH3R4H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:56:07 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mgc0l-1bQj3O1rZH-00Nzp3; Tue, 30 Aug 2016 19:56:01
 +0200
Date:   Tue, 30 Aug 2016 19:56:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] pull: make code more similar to the shell script
 again
In-Reply-To: <xmqqr3976vcy.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608301953340.129229@virtualbox>
References: <cover.1472137582.git.johannes.schindelin@gmx.de> <9a7cc36eee651fe8be280920587e1f83538caf77.1472137582.git.johannes.schindelin@gmx.de> <xmqqr3976vcy.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sedf1QxfCknhdKdixuEFydHphnBa1zOfqg5ZlHcD5ZNFSJMqwjM
 t4IQ6eLADwDKPrOgToyDVMvPE4tFXi376w8VxFvExe9Vxb3voEJNxq/O+UFD4x5V/bBtQAC
 GLEZAs27l++y71G/nK3aQwWXvTb1H2esg6Q7hhfgnipU8mLm28QEAbt534eMKpQPhkxT76a
 fupW9UU16dqKMwJuGrktQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:15pQWWAgqU0=:nek82SzZ7BEZx8lyACckhq
 uPd/OwtghOKBr9e/s3lKi8ZEDbKOun9D3cJtPc8gmsDhzCMjHtppGhfIoBJw5udZgDtp29ich
 IjetgxU8r56/VQjtx5AnMH0LXl9LMWCJ1eIbVEBYDbv5eefGttZoOikh9yJEoqKSsrdxIFUox
 LBWjO4S75VqI9y3kmJkUCqY6/C2y7JOuY4ZG6smOz24z9Oh1HZcuxYTxb0J7lOcLDlSL2a1Mr
 O6ZSGPxWDZF4/JbBLJCe++yByYLPx6xIC2GC8OJqW4bKQjFoDbT0J2IDhTHqsLhK7esRdihQu
 OoZXIpyNDU1UUph13TCT4qLk5cimCpwYsvjMPfu+x/UA0N/td+KS1tE5zTiHP+2/wjQD/luVW
 NPpA9HcmZ9S5ugpRV3PXcDUHKKMhfpf24F3J0KL9uI0eChn1tYMPzJBWvDg1UN1mMN/R9v5uE
 wSocu4tq8peqvG+VK5u85pYMRMR4b7m3yh69TlbS6MwMMXO77ibL/r/sczwaOsepJBvvH0UKA
 u3VXYz3EGHcZKlMOVIHG7NvWW+CjkHObByGz9q0Mj/LyCwg6ZM0C0YJYznOCD8eJHA4DjJiSP
 2e6ArnKPBsTcxj+eJ4WQwBHaB+e6QcxJioRPEOfa0ovr8OBi+lSRzb9o/3juuV0zd7xmK5dM8
 lCNU+g8CNshxR3sg8O61a8ln/LK3oVAlEYf3zAISf1HF6jSzpBMe7weJ3tghLiareinHK87Md
 3sig9x53+r7nYyfrh/traYtcx5PgABgMSyV3g1FOtBJIrZH+XSraE+ChE5sEsMAvuCLRn3XDD
 ETykzTq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +static int require_clean_work_tree(const char *action, const char *hint,
> > +		int gently)
> >  {
> >  	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
> > -	int do_die = 0;
> > +	int err = 0;
> >  
> >  	hold_locked_index(lock_file, 0);
> >  	refresh_cache(REFRESH_QUIET);
> > @@ -376,20 +377,26 @@ static void die_on_unclean_work_tree(void)
> >  	rollback_lock_file(lock_file);
> >  
> >  	if (has_unstaged_changes()) {
> > -		error(_("Cannot pull with rebase: You have unstaged changes."));
> > -		do_die = 1;
> > +		error(_("Cannot %s: You have unstaged changes."), action);
> > ...
> >  		if (!autostash)
> > -			die_on_unclean_work_tree();
> > +			require_clean_work_tree("pull with rebase",
> > +				"Please commit or stash them.", 0);
> >  
> >  		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
> >  			hashclr(rebase_fork_point);
> 
> Splicing an English/C phrase 'pull with rebase' into a
> _("localizable %s string") makes the life of i18n team hard.

Hrm.

> Can we do this differently?

Sure, but not at this stage. Because...

> If you are eventually going to expose this function as public API, I
> think the right approach would be to enumerate the possible error
> conditions this function can diagnose and return them to the caller,
> i.e.
> 
>     #define WT_STATUS_DIRTY_WORKTREE 01
>     #define WT_STATUS_DIRTY_INDEX    02
> 
>     static int require_clean_work_tree(void)
>     {
> 	int status = 0;
> 	...
>         if (has_unstaged_changes())
>         	status |= WT_STATUS_DIRTY_WORKTREE;
> 	if (has_uncommitted_changes())
>         	status |= WT_STATUS_DIRTY_INDEX;
> 	return status;
>     }
> 
> Then die_on_unclean_work_tree() can be made as a thin-wrapper that
> calls it and shows the pull-specific error message.

This sounds like a good plan, if involved. At this stage, I am really
unwilling to introduce such extensive changes, for fear of introducing
regressions.

I will keep it in mind and make those changes, once Git for Windows
v2.10.0 is out.

Ciao,
Dscho
