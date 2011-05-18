From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] add -i: ignore terminal escape sequences
Date: Wed, 18 May 2011 09:33:16 +0200
Message-ID: <201105180933.16650.trast@student.ethz.ch>
References: <05ce7ccdb3f4e07724d430f6ea2a8c9730971c9d.1305645331.git.trast@student.ethz.ch> <7vei3weh2w.fsf@alter.siamese.dyndns.org> <20110518055411.GA27482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 09:33:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMbFz-0004YF-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 09:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab1ERHdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 03:33:18 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41669 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996Ab1ERHdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 03:33:18 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 18 May
 2011 09:33:11 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 18 May
 2011 09:33:16 +0200
User-Agent: KMail/1.13.7 (Linux/2.6.38.6-28-desktop; KDE/4.6.3; x86_64; ; )
In-Reply-To: <20110518055411.GA27482@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173854>

Jeff King wrote:
> On Tue, May 17, 2011 at 10:03:03PM -0700, Junio C Hamano wrote:
> 
> > Of course Thomas could have simply done "reset" and started from scratch,
> > so in that sense nothing is destructive, but we are not talking about the
> > kind of destructive operations you cannot possibly recover without typing
> > everything again.
> 
> I'm not that concerned about these type of destructive operations, which
> might waste a few seconds or a minute of your time. But Thomas' original
> email indicated he was using "git checkout -p", which _is_ destructive
> in a much bigger way, because a "y" overwrites worktree files which do
> not otherwise have a backup (even "reset -p" leaves unreferenced blobs
> that used to be in the index).

Indeed.  I wouldn't be complaining if I typed "a" or "y", but
'checkout -p' trashed all my changes to a file because it treated the
up-arrow as an "a".  We should not accidentally "bind" things to extra
keys, much less dangerous ones.  The fact that up-arrow is ^[[A is an
implementation detail.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
