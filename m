Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634CA1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbcIIKuF (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:50:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:62829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbcIIKuE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:50:04 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M2Ldk-1asY8g39FM-00s8TQ; Fri, 09 Sep 2016 12:49:58
 +0200
Date:   Fri, 9 Sep 2016 12:49:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] pull: make code more similar to the shell script
 again
In-Reply-To: <xmqqr3976vcy.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609091244500.129229@virtualbox>
References: <cover.1472137582.git.johannes.schindelin@gmx.de> <9a7cc36eee651fe8be280920587e1f83538caf77.1472137582.git.johannes.schindelin@gmx.de> <xmqqr3976vcy.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iQ8eMspDZp/jwZrIoNtsdvPX4FpvzFFCQqB91Ewcr/7t9cZ59ET
 NQvfOqAeRCTFkCQ+PjeaMYtp0K8u6K1o2pIA2Yn41fbk5kdRxmw4QKaP6AzlbFc1fs3vltG
 MCx3ch4Gmw94HtDkgRmc7YwbiXFZ7oFvrirS3DgRKlaVIuC5WqNxLwAq9IW1QG9GC61IlCH
 aCgSH9yVwcwSh99vWJ27A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tagTcepkRDA=:0DyDzHWWYoFcxd1kTUE+aQ
 p8r5QWwbDyaCLdmMe7Bega6qqkcSRDzissx8fqR/sfA4tNJ3cpTJaSZVNc/803cCbdCqI1S/T
 lGciXBdIYjVGA8g4+hUdn8b6LDE+lxPECBztYl24SGByS0CHhjQGbVUwoW4azLlMrzxNppkBt
 QKzUQoHpSiGM8UF1h28ZeC3ymA1aBtEKKIXqttnOGgAbo4fRqM0cZLV4xZw5tR87RfRhhQV6l
 yQ/Oa7USFv5DGOArfzbFyrqrrSfcrzvSSwizU9cz+7X2aPPiqKkDM+h2Ju6HGPqwIcF1Dts4r
 qTQcRvwmJd1YvWc7s8CYpSTPzH+BTWrsAauA8mwQvVYuoUEwkZp4v70YgmYpCNObYxU5ZNS1L
 RCc5xfMpGimSq0Nq1MRuKaL9vBF35DjJBeECAwdi6ZIeAociVVNA+VysM/hp3RuLK2Wzb3Jnn
 /QZCY7yxkxUqiaTInY6gmuY5WD98jGXzknB5G+m2g97l4QFt6KoA23REbS4uCkUhzCzt25R2b
 CIDu6gL3Gr0rLO7qirkqboKFFHwWi8iGD/KUiEJ4ePqXptUzRcVQ0avavfiIEOBVxU27ytDzQ
 DN1WP2zipioxeedl4wWQeRJMBhgOr4ZO/86zb7n+KfIETtG3W81b0HNZdYO26kN1zF9RUGZ8S
 7HTl9tZnodj763KbPxAM0aCE8AU8VlFeX/Ssps/JIAQKp1jT97LunqHIUOtE3+ERUSRbOxBHx
 szYWRQDVyxJV4Kx1t5L3eJbxdT9/yjRPGLpCHxLTKVaYJgxtg9huXHzzPMBLwjQXi+/MMdLW0
 8+JoYcb
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
> 
> Can we do this differently?
> 
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

Hrm. After thinking about this for over a week, I think that this is the
wrong approach.

To introduce new wrapper functions just for the sake of being able to
provide possibly dozens of different error messages seems quite a bit
wrong.

I agree, however, that it may be a better idea to add a "gently" flag to
require_clean_work_tree() that lets it print out a (localizable) error
message and return -1 instead of die()ing.

The result would be that a failed `git pull --rebase` would then print out
*two* lines: one explaining that there are unstaged changes, and one that
explains that the pull did not even start due to an unclean work tree.

That solution would scale better, and I may get a chance to make those
changes and send out another iteration of this patch series before
October.

Ciao,
Johannes
