From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git filter-branch --filter-notes/--post-rewrite?
Date: Fri, 18 Mar 2011 10:53:58 +0100
Message-ID: <201103181053.58969.trast@student.ethz.ch>
References: <hbf.20110317iwua@bombur.uio.no> <201103180116.14754.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	<git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 10:54:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0WNv-0007dr-SD
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 10:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393Ab1CRJyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 05:54:04 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:28040 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365Ab1CRJyB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 05:54:01 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 18 Mar
 2011 10:53:57 +0100
Received: from thomas.inf.ethz.ch (129.132.153.219) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 18 Mar
 2011 10:53:59 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.37.4-17-desktop; KDE/4.6.0; x86_64; ; )
In-Reply-To: <201103180116.14754.johan@herland.net>
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169307>

Johan Herland wrote:
> On Thursday 17 March 2011, Hallvard B Furuseth wrote:
> > Is there a git version where filter-branch can copy notes, or with a
> > post-rewrite hook?  I found an old discussion of that on WWW, but
> > nothing seems to have come of that yet.  Currently I remove the 'rm
> > -rf "$tempdir"' in git-filter-branch.sh so the info is available
> > for a separate script.
> 
> No, AFAIK notes copying (or post-rewrite hook) has not yet been implemented 
> in filter-branch. However, it shouldn't be very difficult to add support for 
> this:
> 
> Looking at git-rebase.sh (where it _is_ implemented), it seems to be a 
> matter of feeding "old_sha1 new_sha1" pairs into a "rewritten" file, and 
> then passing that file to the stdin of "git notes copy --for-rewrite=filter-
> branch" (followed by passing the same file to the "post-rewrite" hook).

I had a patch for this back when post-rewrite was invented,

  http://thread.gmane.org/gmane.comp.version-control.git/139919/focus=139917

but Hannes replied that it should grow a real notes filter, and while
I dropped it there, I tend to agree with him.  Feel free to pick it up
again.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
