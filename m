From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: drop confusing prefix parameter of
 die_on_unclean_work_tree()
Date: Mon, 14 Mar 2016 14:42:32 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603141410590.4690@virtualbox>
References: <974d0bfed38e8aa410e97e05022bc5dbbd78d915.1457615785.git.johannes.schindelin@gmx.de> <xmqqr3fidxs3.fsf@gitster.mtv.corp.google.com> <xmqqk2ladx36.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 14:42:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afSln-00078h-3I
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 14:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbcCNNmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 09:42:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:63412 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432AbcCNNml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 09:42:41 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LZz01-1ZyedY4Ahx-00lkKb; Mon, 14 Mar 2016 14:42:34
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqk2ladx36.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:IbMoJ/GP6w3cJYb9wNELbtMayozVykJKFdRnQrnyIL5HEh47ql1
 hcePuQI4J33GM5bVH2xcjLMa+p8yzcPvRvB6BZVyv4UfQWuGBZmApJ7I7wPwR7L2NCnSQ0O
 4EUcwOIAwJJzedD+gi2PwFGKMJ8laRQX/QF1FO7yFuqyz/DcHjZZGn3sGLtVSE5dpq7z6NO
 5a3ti6nxI9kEI5cTDqfDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rcjZSGxqTck=:6qn1HqH1aUbxriI/Lhw7mJ
 eDsQh07a6ocOzQlxB6eoFh5bRHQDXJp6H8qoVGy9v0U3Gm0iTHMT6nafpJgix26bU7kl4UEPl
 nfixLcvVusb57zAMvS7vKpIkFJyAxm++593JhV+gBmyi+fmaEREHvBDzp1AUN/J50OpGlbTkB
 zA5xLHrWS6N2486gCyllSCG/XQ2+WwtAlKYJ1Wzkjtfnrf0u5SyOXJmHZRUK0Ogu1lITusDhC
 mjQDZkbGmcMHwQ9j2MCRNi4gW7UBTqDL9/wBjaWiAX7+XT/a1Q9MMvFzFthGo6VXh/SEoazmV
 Z5UMfIwLhEuAYuxMUauImE1ARVjDwwAkOx9ztg4FwYxauGdzeTLZoc+v+R303UPHmt2BvbaNV
 nuIHcS9Z54c534x+u5BQJ7MKVyxYBl/dV++/8k6YcLWbGAip7pzXk+hTt+KQcH4r2SeEDFauO
 gEJsAIN49zku+La8Zn4KGJrgTWYtl1ToHL2pKZf7XgSThft56Ojx24prTUjeczI1TshdvDS+M
 rhvyrvgiq194WxsrnQhb0q+15HKJaoqHUrwuvperDDnP7f1OSlg+7MA6+dt7z2b06OSFOOz0Q
 YFXMIWu9nDrAdKQ7Un1VMdRxjz6ikZUSO8mIEqFgHIBqEcbJOcK6HPH8uN3lQKi7OU82WR1he
 qOpYv5YHucj1dfRO/MTSKxMKA51GPX01wNgc6a+8oNqanFWLUk2+Caj03DCJVbqA6SJeliy7H
 bnRFl9YaGD9bKl1o0CK4eOIckwVQQe01/LjnzEq1WYw1YL0jq+zB+AEVlamOTk4civqjRzW4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288777>

Hi Junio,

On Thu, 10 Mar 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think this is quite subjective, as I tend to take the presence of
> > "prefix" to mean "the callee assumes that the caller has gone up to
> > the root level already", and take the absense of use of "prefix" in
> > the callee to mean "the callee is working on the whole tree", and
> > discarding the parameter is robbing that clue from that point of
> > view.
> >
> > So I am mildly opposed to most parts of this change, including not
> > spelling out (void) as the list of parameters for a function that
> > does not take any.
> >
> > I do think not passing "prefix" to init_revisions() would be the
> > right thing.  In fact, that prefix is copied to rev, but the current
> > end result is correct _only_ because the pathspec limit given by
> > that "prefix" parameter to init_revisions() is not automatically
> > copied to rev_info.diffopt, and the code is very misleading.
> 
> Another reason why it is more sensible to keep the prefix available,
> but not use it to limit the extent of diff, to has_*_changes()
> functions is that it would be easier for us to change our mind later
> to allow the users to ask for more detailed output.  Instead of
> "Cannot pull with rebase: You have unstaged changes, period.", you
> may be asked to list which paths are dirty in such a case, and in
> order to present the list relative to the directory where the user
> started the command, you would need "prefix" available to the code
> that calls into diff machinery somehow.

Let me summarize.

First, you argue that the prefix is a documented way to say: "This
function needs to be called from the top-level directory".

Nevermind that the parameter reads "prefix" instead of
"this_parameter_means_you_have_to_call_this_from_the_top_level_directory".

And then you say that it is not a bug to pretend to use said "prefix"
value by passing it to init_revisions() only to ignore it presently due to
some chain of side effects.

In short: there is no bug, even if the code is really confusing, so much
so that this developer got highly confused.

And after that, you continue by stating that we need to keep the "prefix"
parameter because we *might*, *eventually* fix the bug (that is not a
bug at all?!?!?!)?

Now I am even more confused than before.

Ciao,
Dscho

P.S.: The idea that a rebasing pull might, at some stage in the future,
want to require only part of the working directory to be clean, this idea
also makes little sense to me.
