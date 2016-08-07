Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F36F2018E
	for <e@80x24.org>; Sun,  7 Aug 2016 08:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbcHGIea (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 04:34:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:52780 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbcHGIe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 04:34:29 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lusmr-1b5x1t1cgb-0101b0; Sun, 07 Aug 2016 10:34:16
 +0200
Date:	Sun, 7 Aug 2016 10:34:13 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 4/9] status: collect per-file data for
 --porcelain=v2
In-Reply-To: <xmqqbn16vnlf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608071026120.5786@virtualbox>
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com> <1470434434-64283-5-git-send-email-git@jeffhostetler.com> <xmqqbn16vnlf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hK94ZY+6+8cIpeyWYIWA3Hxd8OrsdBvoseRxBcrH1oX7vgEn6jU
 Mia0rOfqCZkwUMFXf1tY0GQQPZVfxnyNTiSqSUyVPZR8Dt+mom6X2j2O2nyLn6UzduHNKkE
 fGyLTygatXSUYzwq63EP+wegUBl8ufFHg/Rb20CH2l8o36UkBEJB7smULSGGhIvg1A8d0FB
 8wwnqfS78xhlVd6kvU3jA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:B3XFx+916eU=:4lmB5Fk/rEwzQROEr5NlKr
 0A6bGmYNWsFZDjQICGl1iGhNZ65/diCL1QhokNvPG7apZjKEKqDFAJucithQUNK9F/qDxw1E6
 +ubDrALCcOJXbEI6XZ4jJHxECSiXnGCJEdllfc+ZV4lCmSwJY9TWsErJBkwCYKsx1zzcLeQBV
 GG4C752jB5QWJLMwa8lUbeil3Nx44fjh203Ec/3ShnO6Y5nMDQ5TYvN2hF+TgdEuNYbZQ+1u/
 EfA7ZOfmS/NBOE9uy0qbsaJWBdn3nM4mMsP3wxF80X3Ym062uotH2KNApiqOHFYSoFluLAq+E
 l6FDbIhtRX3BqwZnGte787cEG5zyhCVVJEK0kZ0GiBUFvOrVbFsvD3l/NAlDi+HORLlxNzc3l
 9XtgWczSnFAGEJFG6Xyw05nlVimYX1fZ3PBtkj9PC4U9pAgZenO8eKEHXsm1u8GJBthSS/FH2
 TYVpsH4opX2Zn583Shf73iMQcIZiiw6u4ZMqdVTJjHOWjW211vxWtMwCmf48OeY+Yon9YZZq8
 G/VfVvPkIiDLS02L8i219MvcK8taSp7tx3Q3Ole8amSOPVv3dc/3dyU3wkJGFPSKrd/yk9IWM
 k5l/vqsCcgthdjcJZ/UOJZsNPUb0mZCbUPGuyG1Fl2kPTg/iPX381YQ8JnGjsKDXl+pyXrzNL
 U3kmRKZES0TxgRVwAaiY/NIz7PMBSgOS/uvuVW4ynzJ4eCBcsCbduAPa9QLnMBzu1qQHu5vu6
 SMmyxER1HN+rLw8jAepU8I+cF288GQG+6Gcj6taaRDCaYyU8SdrwIAaj2lDQoWEnMFnIUpy17
 17MYUlE
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 5 Aug 2016, Junio C Hamano wrote:

> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
> >  		if (ce_stage(ce)) {
> >  			d->index_status = DIFF_STATUS_UNMERGED;
> >  			d->stagemask |= (1 << (ce_stage(ce) - 1));
> > +			/*
> > +			 * Don't bother setting {mode,oid}_{head,index} since the print
> > +			 * code will output the stage values directly and not use the
> > +			 * values in these fields.
> > +			 */
> >  		}
> > -		else
> > +		else {
> >  			d->index_status = DIFF_STATUS_ADDED;
> > +			/* Leave {mode,oid}_head zero for adds. */
> > +			d->mode_index = ce->ce_mode;
> > +			hashcpy(d->oid_index.hash, ce->sha1);
> > +		}
> 
> Not a big deal (no need to resend for this one alone), but let's
> make the above properly formatted, i.e.
> 
> 		if (ce_stage(ce)) {
>                 	...
> 		} else {
>                 	...
> 		}                        

Do I understand correctly that your objections is against having the curly
brace before the "else" on its own line?

If so, when did our coding style change? I vividly remember that we
strongly favored putting the "else" on a new line after a closing brace,
to make diffs nicer in case the braces were removed or added.

BTW your suggestion has 24 extra spaces after the final closing brace ;-)

Ciao,
Dscho
