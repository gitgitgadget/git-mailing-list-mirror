Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5142018E
	for <e@80x24.org>; Mon,  8 Aug 2016 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbcHHUcz (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 16:32:55 -0400
Received: from mout.web.de ([217.72.192.78]:52128 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176AbcHHUcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 16:32:51 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0McWrM-1boO4Y3z1c-00HfYP; Mon, 08 Aug 2016 22:32:27
 +0200
Date:	Mon, 8 Aug 2016 20:32:24 +0000
From:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160808203224.GA28431@tb-raspi>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:rUpESjL7v6thba2eOzFxkZpyTCZcIyUQImjjvrRLf9WLaYdsync
 1AMxS/f7unLfDsx5VvJGqL3/k1IX/xYrilGKoCZc3Vd6e5emOzU20Y6rraW5oyla4q9A2ei
 p504voZOGTybi149DCEQ29nA4mXBM+g0YLD/Ym6Vp80wUttJ6XHRg2Cb21wMY5o6+LxuT3z
 7l2+DxKTYBwWsyCBTuyOA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:sxF8dDfcpkI=:vylfO8GXK9l2HHKrxxulvm
 jgG3Ito22jDz/HKT6QVJGJJJF/9PZ+uj0uOoCwqnNvKTvm0ypjseu9EtbLUXgHbQuS1yEBQud
 7qzPHj+zubfn0mFY0dHdiFIEyBNNCd65+WC1+7SVtjzRFVRYOUrWglnWGaFANLke+mHEiojCO
 gqI+ZEdhELZsIe221UcZCxp5DNqPPtKIdw6raZeHqeZaPClkRMbtXaw1RrL5qW358SWxf3imm
 YmcXtCxCfCmG/3CBYScRP6M96oyMM7KmoAC2Dxh5y2o3EBG22jud4UEAt/idWlSLE1LRh5pWw
 hyj+IRDvJfL/okL5dbtE7qaGfs+zspvIzR/qzLHNqQW2QUbUEH8SLKbL6qeF+SBzXIRo/PWUx
 GaKuYm6XzO81ylb5Ce67Tn8aAwsfEVfyHAGist8ozUFTxZTb4kdmVCfHm9OqOONEIYVkw+0Gz
 ls7nelaUm6vcM8MtvMHEAYxAOj2+SY+2JndGwD0QkOVotx1ltyxb5InHcZmUPjtkAJyN8Oo75
 U3RI/3j6Ho3CddqmlwhwyoLsYuNM4TTpeyjxPnQ39iqrkTyVLON4Ag/1PyQF1jRjFXz+UUU7B
 mo9pVLuIwRHUbLNDkiKTcpGUL0W7x5S4cZjuIqL2eQB1LWLgED6XSX9RUnqiOkzMN2Jjal9dl
 ghnrcZ67u91XIk4Q5f/14l3FlDeQHg10LI5oA2FJi86/9uRgM1R+F8GU9bxkGVZkuP1fAy1YD
 LtjUFiEoEvRjPEG0UPFQhWNeKpHGKix7jWecxLUDYCwF8wlay7k7V4BZS7c=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 11:29:26AM -0400, Jeff King wrote:
> On Mon, Aug 08, 2016 at 05:05:07PM +0200, Johannes Schindelin wrote:
> 
> > I remember that you did a ton of work on t0027. Now I see problems, and
> > not only that the entire script now takes a whopping 4 minutes 20 seconds
> > to run on my high-end Windows machine.
> > 
> > It appears that t0027 fails randomly for me, in seemingly random places.
> > Sometimes all 1388 cases pass. Sometimes "29 - commit NNO files crlf=true
> > attr=auto LF" fails. Sometimes it is "24 - commit NNO files crlf=false
> > attr=auto LF". Sometimes it is "114 - commit NNO files crlf=false
> > attr=auto LF", and sometimes "111 - commit NNO files attr=auto aeol=lf
> > crlf=false CRLF_mix_LF".
> > 
> > When I run it with -i -v -x --tee, it passes every single time (taking
> > over 5 minutes, just to make things worse)...
> > 
> > Any idea about any possible races?
> 
> Try:
> 
>   https://github.com/peff/git/blob/meta/stress
> 
> which you can run as "sh /path/to/stress t0027" in the top-level of your
> git repository. I got failure within about 30 seconds on t0027 (though 5
> minutes? Yeesh. It runs in 9s on my laptop. I weep for you).
> 
> The verbose output is not very exciting, though:
> 
> 	expecting success: 
> 	                check_warning "$lfwarn" ${pfx}_LF.err
> 
> 	--- NNO_attr_auto_aeol_crlf_false_LF.err.expect 2016-08-08 15:26:37.061701392 +0000
> 	+++ NNO_attr_auto_aeol_crlf_false_LF.err.actual 2016-08-08 15:26:37.061701392 +0000
> 	@@ -1 +0,0 @@
> 	-warning: LF will be replaced by CRLF
> 	not ok 114 - commit NNO files crlf=false attr=auto LF

(I realized that t0027 is not yet self-explaining, I have it on my list)

NNO_attr_auto_aeol_crlf_false_LF means:

NNO:           "Not NOrmalized" A file had been commited with CRLF in the repo
attr_auto:     .gitattributes has "* text=auto"
aeol_eol       .gitattributes has "eol=crlf"
crlf_false     git config core.autocrlf = false
LF             We commit a file with LF line endings.

This should happend:
- The file is commited "as is", with LF line endings.
- While commiting, git should print the warning
- "warning: LF will be replaced by CRLF" to stderr
- stderr is piped (redirected) into NNO_attr_auto_aeol_crlf_false_LF.err
- we grep for "will be replaced by" in xx.err and pipe it into xx.err.actual

The rest is test_cmp, this is what you see.
The warning is missing, but should be there:

The file has LF, and after commit and a new checkout these LF will
be convertet into CRLF.

So why isn't the warning there (but here on my oldish machines)
