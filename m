From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: how to do "git merge --abort"
Date: Fri, 21 Aug 2009 17:26:19 +0200
Message-ID: <200908211726.21593.trast@student.ethz.ch>
References: <20090821145157.GA6471@debian.b2j> <20090821151926.GE6850@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 17:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeW1K-0001rd-2C
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 17:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbZHUP1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 11:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbZHUP1D
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 11:27:03 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:31064 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612AbZHUP1C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 11:27:02 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Fri, 21 Aug
 2009 17:27:00 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Fri, 21 Aug
 2009 17:26:40 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090821151926.GE6850@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126732>

Jeff King wrote:
> On Fri, Aug 21, 2009 at 10:51:57PM +0800, bill lam wrote:
> 
> > How to abort a merge if it said there are conflicts but I do not want
> > to (or can not) resolve it for the moment.  I can not find the --abort
> > option as that for git-rebase.
> 
> It is spelled "git reset --merge" (though --merge was introduced in
> v1.6.1; prior to that, you had to use "git reset --hard").

Umm, no, you still have to use "git reset --hard".

"git reset --merge cmt" is a rough equivalent for

  git stash
  git reset --hard cmt
  git stash pop

and fills the case where you merged with (unrelated) unstaged changes,
and want to discard the merge while keeping the changes.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
