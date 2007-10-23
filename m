From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 00:33:21 -0400
Message-ID: <20071023043321.GC27132@thunk.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org> <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:33:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBSe-00017j-AV
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbXJWEdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbXJWEdh
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:33:37 -0400
Received: from thunk.org ([69.25.196.29]:48632 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbXJWEdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:33:36 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IkBcL-0001G0-S0; Tue, 23 Oct 2007 00:43:49 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IkBSE-0007Wt-06; Tue, 23 Oct 2007 00:33:22 -0400
Content-Disposition: inline
In-Reply-To: <20071023040522.GX14735@spearce.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62086>

On Tue, Oct 23, 2007 at 12:05:22AM -0400, Shawn O. Pearce wrote:
>
> Yes.  Because 'next' always has commits in it that never appear in
> 'master'.  So any topic forked from master must merge into next.
> It can't be a fast-forward.  No forced merging required.

Why is it the case that 'next' always commits that never appear in
'master'.  So far in how I've been doing things that hasn't been the
case.  When I do a "git checkout master; git merge next", it's always
been a fast-forward merge. 

Oh, I see.  That's because if you put some trivial changes in
'master', and then pull those changes into next, there will be merge
commits in 'next' that will never be in 'master.  Is that it?  

I had been trying to avoid that case by always putting new commits,
even trivial ones, into 'next', and then having them drop into
'master' at the next cycle; so 'master' was always trailing 'next',
but they were always the same commit string (i.e., 'master' was always
a subset of 'next').  

Aside from the WC script not working right, are there other
disadvantages to my doing things that way as opposed to the way the
Junio has been running the git repository?

						- Ted
