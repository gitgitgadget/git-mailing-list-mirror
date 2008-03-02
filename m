From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC] git rebase -s ours
Date: Sun, 2 Mar 2008 13:48:48 +0100
Organization: glandium.org
Message-ID: <20080302124848.GB8696@glandium.org>
References: <20080301111716.GA3263@glandium.org> <20080302010527.GB22843@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 13:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVnZd-00047y-Iw
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 13:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbYCBMpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 07:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbYCBMpN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 07:45:13 -0500
Received: from vuizook.err.no ([194.24.252.247]:58346 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573AbYCBMpL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 07:45:11 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVnYs-0001QF-Ce; Sun, 02 Mar 2008 13:45:08 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVncW-0002I2-1L; Sun, 02 Mar 2008 13:48:48 +0100
Content-Disposition: inline
In-Reply-To: <20080302010527.GB22843@coredump.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75776>

On Sat, Mar 01, 2008 at 08:05:27PM -0500, Jeff King wrote:
> On Sat, Mar 01, 2008 at 12:17:16PM +0100, Mike Hommey wrote:
> 
> > What do you think git rebase -s ours should be considering as "ours"?
> > If I'm not mistaken, at the moment, "ours" stands for "upstream", which
> > is kind of confusing...
> 
> Sort of. It actually works as "what is in the working tree is fine" so
> it ends up not applying _any_ commits. In other words,
> 
>   git rebase --strategy=ours upstream
> 
> is equivalent to
> 
>   git reset --hard upstream
> 
> So I think the current behavior is nonsensical, and I assume nobody uses
> it.
> 
> OTOH, what exactly are you trying to accomplish? If you have "ours" mean
> "always take the rebased content", then aren't you stomping on original
> commits? You might mean something like "do a regular 3-way merge, and
> for every textual conflict, choose the rebased content". That at least
> makes some sense, but I suspect it will produce uncompilable results in
> most cases.

That's actually almost what I would have liked when I looked at the
git-rebase manpage to see what I could do. Except that the 'ours' merge
strategy doesn't do that. But considering what the 'ours' strategy does,
I wanted to see what it would do anyways, and it just does nothing,
which is somehow sad.

> What I am getting at is: what 'ours' should mean in a rebase depends on
> how it can usefully be used in a workflow. Do you have a workflow in
> mind?

I don't have a workflow in mind, but I have expectations: considering
the documentation, I would expect git rebase -s ours to do what git
filter-branch can do with grafts.

Mike
