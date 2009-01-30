From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Fri, 30 Jan 2009 17:31:09 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
References: <871vulda2r.fsf@gigli.quasi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 18:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSxEY-0004lE-GE
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZA3RbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 12:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZA3RbY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 12:31:24 -0500
Received: from main.gmane.org ([80.91.229.2]:57973 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbZA3RbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 12:31:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LSxD4-0006GS-Sw
	for git@vger.kernel.org; Fri, 30 Jan 2009 17:31:18 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 17:31:18 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 17:31:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107857>

[replying only because no one else did; caveat reader!]

On 2009-01-29, Raimund Berger <raimund.berger@gmail.com> wrote:

> The question is whether a (3way) merge is commutative, purely in terms
> of content (i.e. disregarding commit history for now). Iow if no matter
> in which order I merge A and B, i.e. A into B or B into A, I'd be
> guaranteed to arrive at the same content.

I'd say yes.  Finding the common ancestor and then applying
the differences from both sides are operations that do not
appear to be order dependent.

> If yes, a followup question would be if the merge machinery sitting
> beneath rebase is exactly the same as that of a standard merge.

The merge "machinery" can be explicitly chosen using the
"-s" (strategy) option, but for the same chosen strategy, I
think yes it would be the same for a merge as for a rebase.

> The reason I ask is obvious I guess. What basically interests me is if I
> gave a bunch of topic branches exposure on a test branch and, after
> resolving issues, applied them to stable, that I could be 100% sure to
> not introduce new issues content wise just by applying merges in a
> different order or form (rebase, patch set).

That appears to be a different question than the one you
started with.

Reversing A and B is one thing, applying a sequence of
merges in a different order is quite something else.
