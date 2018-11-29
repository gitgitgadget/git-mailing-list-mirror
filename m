Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1979C211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 12:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeK2X5A (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 18:57:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:47583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeK2X46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 18:56:58 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ7bs-1g7Oar1K8K-00KxQu; Thu, 29
 Nov 2018 13:51:37 +0100
Date:   Thu, 29 Nov 2018 13:51:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] rebase --stat: fix when rebasing to an unrelated
 history
In-Reply-To: <xmqqlg5cph1n.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811291318090.41@tvgsbejvaqbjf.bet>
References: <pull.88.git.gitgitgadget@gmail.com> <680385e4bd5c34a5fcf9651a776c52db61557652.1543317195.git.gitgitgadget@gmail.com> <xmqqlg5cph1n.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZUSR1rF2Qo+wEC//vLUzqgg89dAyBMjuv3uC/nL7ekO45DiA8w8
 +agv00VbkFLn7tjBJmJtOwn8+T1IFrDz6UmP8wh1SYscTVwS1Q0whsHkZZWn/Jog5jMIPZ0
 h6fxCy0KrRloSWfOZyN8i4LaLH1hTaqkROsOOb7x2y8boY/k76PUZgpYR1LU8hgaQE4s8EX
 ANfWdo+/0H+EZ027LXyRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k2to223mg/g=:Ir0Lxkrdxb+r64I7n+wZ1x
 nEAaQM1u/V7x4VM+QGQNoAoIcijqPoFVct/Fgqgm4cwmHsMkkx9Kx0d8XTrPfL1PNENfQKh3a
 VE03xTvyxbo+POvc8K55lfEKu3hMrAoFEGLc5VWkomu3IyjBcR73py1Hs6O3uzRcGbu8TDKOv
 qD/TB+vI+Y0JqCNMzV8G1yXVttwYZX8wh+eu9t7AX5ibMwsVzs8H/AlJBU27ElmeoeQKRK1GZ
 QKLIIMtx2UIPCoTO3fonT20HZNSQOomEKIX41XTyhnUPFtghqRn/zEJYyBQz0fjZtnitFqC4G
 uWK5QS6LREKaRt0JxrF5QhoNv4dqwN6wIlbAfD3rq4GM3d1ZgGwTyf39nA21DqIFWjTFDYpHt
 6wsnrO8YnO25HudErsygikCWg/gT3nqXZTYVmJZihs+S1307JYp+6CgoX2B6H5GBJahO/Yq4N
 Kl601Fb9icsydaFnRdP4QHJKvFkYtK1/DQSNXnRmR4snVwsW1kPpXWOE5EfvaqomJYYI1nCG+
 gWcR343IcyHEUllLZPBZ09f309hEmhiuDlul8jgd5qAfvoim5/h7Eg+ThHhJ8JUQoce4A3qSa
 kh31pu/EuiurnFF1v/sKDCG7dzxgtTKVWQxXktNvjVFVdH7fOjtOEP7t/76Yo12orfvuXZiJn
 ee2PTI+i3/u+Ivnp3FWlvyNWSRE1halRNOpdgFZrEVVzcodO2nc07LMaUTLkqqFETfRAK94RT
 CE3atdXLeVjB//Mc30Nvtp2thSC9UyI82yygqA884sxHNUztO5Gbi+Ai1ND8cHyeVhVTSoBai
 1u0ioYxkRaYI3UNFp2sM/y2P/nPPL2djt6dl+2eC97zfnk8zcIGNOzPCqfIcbuLWqBbhE5Hyy
 WNDOtowRcxiCU3rvLiPkI0PpSZBI8/UNiHxG1EOkAOa7vKFDF+ggRxzFUCP6lRBjlDvPi+jIB
 K2zOjhIePlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 29 Nov 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > The built-in version of the `git rebase` command blindly translated that
> > shell script code, assuming that there is no need to test whether there
> > *was* a merge base, and due to its better error checking, exited with a
> > fatal error (because it tried to read the object with hash 00000000...
> > as a tree).
> 
> And the scripted version produced a wrong result because it did not
> check the lack of merge base and fed an empty string (presumably, as
> that is what you would get from mb=$(merge-base A B) when A and B
> are unrelated) to later steps?  If that is the case, then it *is* a
> very significant thing to record here.  As it was not merely "failed
> to stop due to lack of error checking", but a lot worse.  It was
> producing a wrong result.

Indeed. But it was only in the `--stat` reporting, so it did not produce
an incorrect rebased history.

> A more faithful reimplementation would not have exited with fatal
> error, but would have produced the same wrong result, so "a better
> error checking caused the reimplementation die where the original
> did not die" may be correct but is much less important than the fact
> that "the logic used in the original to produce diffstat forgot that
> there may not be a merge base and would not have worked correctly in
> such a case, and that is what we are correcting" is more important.

True.

> Please descibe the issue as such, if that is the case (I cannot read
> from the description in the proposed log message if that is the
> case---but I came to the conclusion that it is what you wanted to
> fix reading the code).

Indeed, my commit message is a bit too close to what I fixed, and not
enough about what needed to be fixed.

> >  		if (options.flags & REBASE_VERBOSE)
> >  			printf(_("Changes from %s to %s:\n"),
> > -				oid_to_hex(&merge_base),
> > +				is_null_oid(&merge_base) ?
> > +				"(empty)" : oid_to_hex(&merge_base),
> 
> I am not sure (empty) is a good idea for two reasons.  It is going
> to be inserted into an translated string without translation.

Oooops.

> Also it is too similar to the fallback string used by some printf
> implementations when NULL was given to %s by mistake.

You mean `(null)`? That was actually intentional, I just thought that
`(empty)` would be different enough...

> If there weren't i18n issues, I would suggest to use "empty merge
> base" or "empty tree" instead, but the old one would have shown
> 0{40}, so perhaps empty_tree_oid_hex() is a good substitute?

As this is a user-facing message, I'd rather avoid something like
`empty_tree_oid_hex()`, which to every Git user who does not happen to be
a Git developer, too, must sound very cryptic.

But I guess that I should not be so lazy and really use two different
messages here:

	Changes from <merge-base> to <onto>

and if there is no merge base,

	Changes in <onto>

Will fix.

> > @@ -1494,8 +1495,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> >  		opts.detect_rename = DIFF_DETECT_RENAME;
> >  		diff_setup_done(&opts);
> > -		diff_tree_oid(&merge_base, &options.onto->object.oid,
> > -			      "", &opts);
> > +		diff_tree_oid(is_null_oid(&merge_base) ?
> > +			      the_hash_algo->empty_tree : &merge_base,
> > +			      &options.onto->object.oid, "", &opts);
> 
> The original would have run "git diff '' $onto", and died with an
> error message, so both the original and the reimplementation were
> failing.  Just in different ways ;-)

Right.

> > diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> > index b97ffdc9dd..be3b241676 100755
> > --- a/git-legacy-rebase.sh
> > +++ b/git-legacy-rebase.sh
> > @@ -718,10 +718,12 @@ if test -n "$diffstat"
> >  then
> >  	if test -n "$verbose"
> >  	then
> > -		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
> > +		mb_display="${mb:-(empty)}"
> > +		echo "$(eval_gettext "Changes from \$mb_display to \$onto:")"
> >  	fi
> > +	mb_tree="${mb:-$(git hash-object -t tree /dev/null)}"
> >  	# We want color (if set), but no pager
> > -	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
> > +	GIT_PAGER='' git diff --stat --summary "$mb_tree" "$onto"
> 
> Code fix for diff-tree invocation, both in the builtin/ version and
> this one, looks correct.

Okay. I fixed the two things you pointed out, just waiting for the Linux
phase to finish (I don't think there is anything OS-specific in this
patch, so I trust macOS and Windows to pass if Linux passes):
https://git-for-windows.visualstudio.com/git/_build/results?buildId=26116

Ciao,
Dscho
