Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094231F6AC
	for <e@80x24.org>; Fri,  6 Jul 2018 18:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbeGFSzD (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 14:55:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:38071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934352AbeGFSzC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 14:55:02 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhiPD-1fnwBk3XvP-00MuA8; Fri, 06
 Jul 2018 20:54:51 +0200
Date:   Fri, 6 Jul 2018 20:54:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 6/7] rebase -i: rewrite setup_reflog_action()
 in C
In-Reply-To: <xmqqy3eommq2.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807062052230.75@tvgsbejvaqbjf.bet>
References: <20180702105717.26386-1-alban.gruin@gmail.com> <20180702105717.26386-7-alban.gruin@gmail.com> <xmqq8t6soy2f.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807061457250.75@tvgsbejvaqbjf.bet> <xmqqy3eommq2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JCreRKw9Z8XgIEpaqLmGxjkz5WzMwvPiNXL+p5B7XmdL6J/DeYX
 2AJNq+xJJJVpEsimfOYBXR2csn26g49IK0GcUSpOgIPI2eP2WNxq91nxBbsCz9CPv2fKen/
 NLmfnlVHuj3md0rc3XC7AjYzKH1Y9Uy4ZWKRucROtthCDdtFdQBcUuEfepEVRjFNMd1mW7Z
 4QgmV6jqdKxtRfezxrAlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wuEvEbu4poo=:rxvxoJtwZcql8/HfFJZoyN
 c3fiZCJbXhY5D2/a4JmZb6mqvYWDICNTiyy5qElKSHucNf4Znpujk+Z9vUvFJDj/tbsD96eGg
 0CkgFk7qBlNu7rv37Ya7dLXRlpsHeC4gWvmFQDBtwJFfyrHvfLs2e6iMoiasrN+ZrDQJVJHRn
 H8jaikv0ciubAZrWCyMBGT08yOAHCAGo2Ner1Bi8QwGhDbqq7U27/HzJ83Ym/2LW+OcIBNsS4
 0XZ47tAQshiCqP+qbwGVekXTyD2Nu7xiop7edyLiR9+X25QHWtr4/Y42hGXPW/mD5sjE+FKRK
 6HvF21JJFQ2TKLRDV1Xt4//SLt/Gv4MuuWFFad3N7JZbFL6Lt9gk7E2urk//VcVU3zpoP0FKK
 RHJ+RIWdERc56mB3Z9E7NMMncx8Gq0nM4+ePdVpJUVStLhX1XDbK+xPdtyt23DnKsliMMgF/s
 /1HR1A4GM9kAYeqepW3JAInRdCZC2bSbRtOVMnpCnczzC/wvI24ovV3piWoTs0XzWucBIVOMc
 Ex9yNWt5wtZewIcpnJGEya4BpxjqtpVBMq3agpEY84kNZjlzckgEmmbHjsy9BuyWXpRNIbOvo
 D9s4/6FHxqVgGM9iITIhc2KTcy5cAh04fSX6G9Ik+1+XEffn3cD2SoiVUS0bkENH3AgQxPZVu
 9Fm6HeaOzHGaXWA49uzWU3gEej8cqwSCNt6aZFMBShS9BglGP+E0A9eJGwEFiJ+d3R76K6CKk
 j2wT6+r1QsyNde1h4GljlyRLa3wYH72Y9WtmYsNncXYy/PfuhKLSi7yEEjrbMpTNXOE0yr3zM
 Yp/DZC8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I thought we made this into
> >> 
> >> 	if verbose
> >> 		return run_command
> >> 	else
> >> 		return run_command_silently
> >> 
> >> to help readers in the previous round already.
> >
> > FWIW we had quite a couple of reviews in the recent years which pointed
> > out "unnecessary else" after returning or die()ing. Maybe we should make
> > up our minds, and set a consistent rule to follow.
> 
> FWIW the pattern you are referring to is
> 
> 	do something;
> 	if (error detected) {
> 		return error(...);
> 	} else {
> 		perform
> 		remaining
> 		actions
> 		the function needs
> 		to complete
> 	        its task;
> 	}
> 
> and those reviewers (including me) are absolutely right that such an
> "else" is not just unnecessary but actively harms readability of the
> flow of logic.
> 
> I am also absolutely right when I say what is quoted at the top
> makes 100% more sense than
> 
> 	if (verbose)
>         	return run_command();
> 	return run_command_silently();
> 
> as these two are about doing the same thing a bit differently.  
> 
> The way to think about the latter is that we won't have this "if
> (verbose)" if there were a variant of run_command() that took a set
> of option bits among which is a verbose bit, but instead would have
> a single call to that function that returns..  So it's not like "in
> an exceptional case, return after calling this function; otherwise
> keep going, which happens to only return after calling another".  It
> is more like "here we need to return after spawning a command, but
> depending on this bit, we spawn the command using a different
> function".
> 
> Good programers recognize the difference between these two patterns
> without being told, and mentors should teach and GSoC student should
> learn that an overly simplified rule like "when 'if' block ends with
> return, do not write 'else'" is harmful.

You recently also suggested this if...else... dance to Pratik, where it
was not at all about doing the same thing slightly differently, but rather
two different things: 1) return an error because execvp() returned an
error, 2) indicate a serious bug (and you did not even suggest using BUG()
IIRC which is also wrong).

Maybe I am the only one who finds this inconsistent and confusing. If that
is that case, I'll quiet down.

Ciao,
Johannes
