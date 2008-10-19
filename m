From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Usability of git stash
Date: Mon, 20 Oct 2008 01:12:39 +0200
Message-ID: <20081019231239.GA23692@leksak.fem-net>
References: <87wsg9acfv.fsf@cup.kalibalik.dk> <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil> <86vdvsg4up.fsf@lola.quinscape.zz> <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil> <87prly5k5r.fsf@cup.kalibalik.dk> <20081019184029.GF14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 10:42:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrhTP-00069C-Ke
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 01:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYJSXMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 19:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYJSXMv
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 19:12:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:49657 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751895AbYJSXMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 19:12:50 -0400
Received: (qmail invoked by alias); 19 Oct 2008 23:12:47 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp022) with SMTP; 20 Oct 2008 01:12:48 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19qZN9Pj2dqXDuQTrB+ycN6590A4Bx2APxC52NZAS
	P6PkheMPaTNlKL
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KrhRv-0000MJ-EA; Mon, 20 Oct 2008 01:12:39 +0200
Content-Disposition: inline
In-Reply-To: <20081019184029.GF14786@spearce.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98627>

Hi,

Shawn O. Pearce wrote:
> Personally I wish git-stash wasn't invented the way it is.  I would
> have rather seen it as macros to do a quick:
> 
> 	git commit -m wip-index-state
> 	git commit -A -m wip-worktree-state
> 
> and unwind it with essentially:
> 
> 	git reset --mixed HEAD^
> 	git reset --soft HEAD^
> 
> then its a lot less black magic to users, as they can see it in the
> DAG, and its more explicitly tied to the branch they were on at the
> time they ran the stash.  I think its rare you'd stash something
> then switch to another branch to apply it.  But that could easily
> be done with cherry-pick.

Just a side note:
I, for example, have a stash in which some "valgrind ..." string is
prepended to some lines in some test scripts.  I apply the stash on
different branches and after testing I reset the file (or checkout -f
another branch).  I never really want to commit these changes.

So, the alternative for this use case (if there was no git-stash) is
to have a "valgrind" branch somewhere and do some "cherry-pick -n" of
those commits, right?

Hmm, it seems that this is the better way in the long run. But
"git-stash" seemed to be the natural way at first.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
