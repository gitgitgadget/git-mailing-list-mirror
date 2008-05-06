From: Theodore Tso <tytso@mit.edu>
Subject: Re: merge renamed files/directories?
Date: Tue, 6 May 2008 11:47:09 -0400
Message-ID: <20080506154709.GF6918@mit.edu>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org> <ADDE27A8-6329-4C09-BC07-8EB023BA6D48@midwinter.com> <alpine.LFD.1.10.0805051724510.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 06 17:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtPPI-0002uu-85
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 17:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138AbYEFPry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 11:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756919AbYEFPry
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 11:47:54 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:33170 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756561AbYEFPrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 11:47:53 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1JtPQL-0008F9-33; Tue, 06 May 2008 11:49:49 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JtPNl-0003Jj-Tx; Tue, 06 May 2008 11:47:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805051724510.32269@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81362>

On Mon, May 05, 2008 at 05:29:12PM -0700, Linus Torvalds wrote:
> 
> Maybe somebody bothers to implement some directory rename heuristic some 
> day. Quite frankly, I personally cannot care less. It really is mental 
> masturbation, and has absolutely no relevance for any real-world problem.
> 

Actually, the directory rename hueristic *does* have relevance in at
least some real-world cases.  For example, MySQL has plugin
directories, and occasionally the plugins get renamed, for whatever
reason.  If a plugin gets renamed, so does its directory, and if the
rename operation happens in an experimental (or devel) branch, but
then for whatever reason, a new file is created in the devel (or
maint) branch, without the directory rename hueristic, when the
changeset is pulled into the experimental (or devel) branch, the file
will be created in the wrong directory.

So it may be rare, but this kind of thing does happen in the real
world.

							- Ted
