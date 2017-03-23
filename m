Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4567A20958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935224AbdCWPtb (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:49:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:49321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754389AbdCWPtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:49:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuOYx-1c96x93dp9-011klb; Thu, 23
 Mar 2017 16:49:24 +0100
Date:   Thu, 23 Mar 2017 16:49:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/3] sequencer: allow the commit-msg hooks to run during
 a `reword`
In-Reply-To: <xmqq60j1kv8n.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703231646430.3767@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <9b83b6f7012368e970ec2b310f63b4daf66602e5.1490194846.git.johannes.schindelin@gmx.de> <xmqq60j1kv8n.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LZCkyN8GWDKR7zJCszYjz/SEC/TVS1wkiuDpvezIPfSb+rI+x1M
 3VjZt3lR4TGQLQc8Yi2KPOboeZ5LDv33aEBP23wZyaSnYW6S1i6Lau8+rvRR71vE9yeDCvx
 9Gtp/FxHU4a1sN7EedxEkEyW3z+iUUhQM08jLHyv4QW7lzla2kqeLB40fWLhtpVI8svYMFG
 G8pyC/M+qm3ucRVAS3gBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BG9/Np/kt4A=:husvJT9Ikb7xbNgma9hIg+
 RBCC3Khtzurbqca98KR5usfOEmFdS5fhuwN7ILjKt/RN3dg+o34RHp7kf+/nuQhkP4y5Q065a
 7k4qu9URyyyTJqjDr34kG60xEYCwgMmr/XK7Ei+umEfWJZ3BCwR6VCAro6XTgFQNV9dSt/zz+
 cPAH1Qho9eOzGbGWOKBQvADQhfSRWMh7vaarOro4fzr7TisMSiBnewrLVMuEr9xbV6SloLPeu
 sxsJS5E8bYgzUJA9qBdO2T8aehnQW12HWKw0CDhCsA1fy4LxPiAm2vIMnCRveyvwAWXryz+sk
 MIaRO0wjuvpY2P9ImX8kA8KOWg7M1JO3YnzTl+Ku0c5uWgBuvvTILWuRaEeNDEqk6bqLoDrbd
 ukZxlbOhJvPPnTfNMT4+iDBdu2JUB8v7+3amhZ8hzXkiwU+du/LzMrwd1jcQIlCMjXT1L51xz
 IuQcfPbB084lXthqrZTkfhNp6wCx0wOdSvSFFCjtGoLwfpiQNCAC98a1uPyZEZDlR3I0GNK8T
 DWHSRsQxFrTV+sFFGGyBl5m2tWaRLGDpWNAson7pH72Syo9dx3FBEYYoUMW0KAkw7YzIbpyhs
 ERJYOS4ur2gLHpmlmyCvct5+3GxN8g9kJmkBM+y/AAks0UlbC2n8HFEWm9nI0kUH6DpnpLb/Y
 NiOUDkq5TT1GLCDcJaH9IrW2SXIU2HwcAtsJAsgvB8ELoDoA8XdtSbfG2dP2d3ECC9QUs+YxO
 BmJLqWCMJkTSgeCpoz4fYOc0A/2NVP5Mmosh8Zl6Fy5dicnxQ3DOKW0zSxiP9TxUAwwnYOvfl
 NMzAi4hTITGuaxmy+XS8t1CweUWKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index 1abe559fe86..377af91c475 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -606,6 +606,7 @@ N_("you have staged changes in your working tree\n"
> >  #define EDIT_MSG    (1<<1)
> >  #define AMEND_MSG   (1<<2)
> >  #define CLEANUP_MSG (1<<3)
> > +#define VERIFY_MSG  (1<<4)
> >  
> >  /*
> >   * If we are cherry-pick, and if the merge did not result in
> > @@ -642,8 +643,9 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
> >  	}
> >  
> >  	argv_array_push(&cmd.args, "commit");
> > -	argv_array_push(&cmd.args, "-n");
> >  
> > +	if (!(flags & VERIFY_MSG))
> > +		argv_array_push(&cmd.args, "-n");
> 
> OK, so by default we pass "--no-verify" but selected callers can
> set the bit in the flags word to disable it.  That sounds sensible,
> especially given that the original callers, cherry-pick and revert, 
> did want "--no-verify".  "reword" in "rebase -i" is currently the
> only one we want to supress "--no-verify" and the place that does so
> are all shown in this patch.

Indeed, my reasoning was to keep the default to be the previous behavior.

> Just to see if there are other callers that may want to do the same
> suppressing of "--no-verify" as a follow-up, I looked at the whole
> file after applying the patch, and I think everything looked good
> as-is.

Thank you for being thorough; That is exactly the type of review I hoped
for. I did the same research myself, of course, but it is most reassuring
if an independent reviewer comes to the same conclusion.

> > @@ -993,7 +995,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
> >  			write_author_script(msg.message);
> >  		res = fast_forward_to(commit->object.oid.hash, head, unborn,
> >  			opts);
> > -		if (res || command != TODO_REWORD)
> > +		if (res)
> > +			goto leave;
> > +		else if (command == TODO_REWORD)
> > +			flags |= VERIFY_MSG;
> > +		else
> >  			goto leave;
> 
> Both before and after are your code, but wouldn't this:
> 
> 	if (res || command != TODO_REWORD)
> 		goto leave;
> +	if (command == TODO_REWORD)
> +		flags |= VERIFY_MSG
> 
> result in smaller changes relative to the original and still be much
> easier to understand than the above?

Yes. I just did not like the repetition.

But thinking about it again, the previous logic was only concerned about
an early exit, and the clause I added is all about the flags. Therefore, I
agree with you that it should be untangled again.

v2 coming,
Dscho
