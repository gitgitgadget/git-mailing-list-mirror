Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9272520986
	for <e@80x24.org>; Fri, 21 Oct 2016 11:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbcJULLF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 07:11:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:63924 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbcJULLE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 07:11:04 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lx5hl-1cyoTM06iv-016gUy; Fri, 21 Oct 2016 13:10:53
 +0200
Date:   Fri, 21 Oct 2016 13:10:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 18/25] sequencer: do not try to commit when there were
 merge conflicts
In-Reply-To: <xmqqmvhyg4ru.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610211304240.3264@virtualbox>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de> <38d5f853444f80c90713f7a6e4ef1f2382549b29.1476450940.git.johannes.schindelin@gmx.de> <xmqqmvhyg4ru.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7xJYgIwRaWAuhN43Eq8hxSS7gT1XHz3BTaU+ArHNjZDBrbli6mE
 AQznNQLms8fwwBFnZQ0NcJ6Vjf7l6HpFhougNsLZ2DgDpkMXyNurXMSCaJeHKbcKjQQNGJr
 sk2TmenEVlNOOwiuP8CvWhKv6oK9NnlCcp6fr0MEHR8eLnj3cwQeGtgS3UMAVIt0a4n9OGA
 I8qnm+kJkgjmn1EOyjFrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dvoDV0pfDSI=:VaWiobaa5kOJvRMMXlgPqh
 KNVnNqGI8hMoyL7ZhwgaIWHJkNGDOsDB+WQc/7+hlbs29wdg7K3e8TkwGd27ei0FE1CAG4fzk
 5rwrM86YYU8570iQ5cedpOSDkNRBqrsAoa2xEirZW2/lt+VY8W73+ufAT/mmTLg3vUnI0iAx7
 LvHR4guVtogIlOQLKtK6YQnzTk5+ljyvA7nuLgQ1fu9c1xY0KvxypG408gBSeK7XtMJuahhOj
 2bxDubzI4WG958ZPGIIeSvdhulxDrWAU+dAaEtzT3PR7SNfGOAegg82qR7oiUFPwLRUkImWFb
 6GVWOyXNUJty2ob07//O/FGZomRzVgs3QAKlE5gD7fHo9T9q6tLvyI17KeBO0en3fUUjwI4dG
 61dA5brARnvFAcEKrMioMSC4dn3O13OnOvLZRhK1ZYFII4j2v7RTwpNUXorl3rNRZujeZrwNh
 0fJ0iIzTXsMRwHGK6pw4TecSmqEyDeJ4UUO7A8inc/Es9sEI3O8t5nKWolaTKibMMpsCVBvOZ
 5tokX6qqWkfb4f3x+oX0z7mZ4VKyiSDVbOk3yZWUji9zTsZttOqoX4dvXFoznCCa9OTJBh9Cr
 lNHO5sP5ZHE2odqr8kXi0Y+/m8kNsjkp+g3hszx4rUOzXu+45DVUGOc4UFXdmb9ojJyc5DED5
 R45ilsjv9IaFdp/JH42pwacLg8ywrzrNnAB4h3HTimueEFzK81jXWjno77DQ5hN3mwThiPnz4
 P2C11u/WWyCJDS3xDht6JFlIv8knT2cifegcp2Jx2kBdYYUUkZ2JHiRdXZ13bWvmD5OA2mjBW
 6CmqWWp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 20 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The return value of do_recursive_merge() may be positive (indicating merge
> > conflicts), or 0 (indicating success). It also may be negative, indicating
> > a fatal error that requires us to abort.
> >
> > Now, if the return value indicates that there are merge conflicts, we
> > should not try to commit those changes, of course.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index cbc3742..9ffc090 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -787,7 +787,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
> >  		res = allow;
> >  		goto leave;
> >  	}
> > -	if (!opts->no_commit)
> > +	if (!res && !opts->no_commit)
> >  		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
> >  				     opts, allow, opts->edit, 0, 0);
> 
> This by itself looks more like a bugfix than preparation for later
> steps.  The only reason why it is not a bugfix is because there is
> nothing in this function that makes res a non-zero value and reach
> this if statement at this step.  We would have been caught by an 
> "if (res) { ... rerere(); goto leave; }" or 
> "if (allow < 0) { res = allow; goto leave; }" 
> that appear before this part of the code.
> 
> So while it is not wrong per-se, I think this should be part of an
> actual change that makes it possible for the control flow to reach
> here with non-zero res.

It looks like it is no longer needed (I *think* that it was made obsolete
by the change where I now "goto fast_forward_edit" only in case there were
no errors).

In any case, the patch's gone now,
Dscho
