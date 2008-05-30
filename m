From: Jon Loeliger <jdl@freescale.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 30 May 2008 16:10:52 -0500
Message-ID: <48406D5C.4000703@freescale.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:14:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BvC-0001p6-IE
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbYE3VNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbYE3VNF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:13:05 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:41137 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbYE3VND (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:13:03 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m4ULBZ2L010643;
	Fri, 30 May 2008 14:11:35 -0700 (MST)
Received: from [10.214.73.8] (mvp-10-214-73-8.am.freescale.net [10.214.73.8])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4ULBYD6020269;
	Fri, 30 May 2008 16:11:34 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83336>

Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.
> 
>
> * js/rebase-i-sequencer (Sun Apr 27 02:55:50 2008 -0400) 17 commits
>  + Use perl instead of tac
>  + Fix t3404 assumption that `wc -l` does not use whitespace.
>  + rebase -i: Use : in expr command instead of match.
>  + rebase -i: update the implementation of 'mark' command
>  + Add option --preserve-tags
>  + Teach rebase interactive the tag command
>  + Add option --first-parent
>  + Do rebase with preserve merges with advanced TODO list
>  + Select all lines with fake-editor
>  + Unify the length of $SHORT* and the commits in the TODO list
>  + Teach rebase interactive the merge command
>  + Move redo merge code in a function
>  + Teach rebase interactive the reset command
>  + Teach rebase interactive the mark command
>  + Move cleanup code into it's own function
>  + Don't append default merge message to -m message
>  + fake-editor: output TODO list if unchanged
> 
> This may complement the proposed "sequencer" GSoC project.  Dscho seems to
> have quite a strong objection to the 'mark' syntax and mechanism being
> unnecessarily complex.  Let's wait and see if a less complex but equally
> expressive alternative materializes...


Well, there are the two not-quite facetious suggestions
I made off list to Junio.  Granted, he though they would
be overkill (too), but I guess I could make them here for
the general record in any case.

One suggestion was to make a procedural model out of
the commit graph and allow something like this:

    b :- pick(B)
    x :- merge(pick(A), b)
    y :- merge(pick(C), b)
    z :- merge(x, y)

My second and semi-equivallent suggestion was to
allow a lisp-like notation:

    (merge (merge (pick A)
                  (pick B)
           (merge (pick B)
                  (pick C)

As Junio observed, even that could be beyond what most
casual git rebase -i users are willing to do to a sequencer
edit stream before getting down to business.

Ah well. :-)

jdl
