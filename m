From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: started a cvsps testsuite Was: Re: [PATCH v3 0/2] cvsimport:
	add test illustrating a bug in cvsps
Date: Mon, 6 Apr 2009 21:01:49 +0200
Message-ID: <20090406190148.GB466@macbook.lan>
References: <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net> <7vfxhag07g.fsf@gitster.siamese.dyndns.org> <49C22166.3000807@drmicha.warpmail.net> <49C47DF7.9000601@alum.mit.edu> <20090323181110.GB26678@macbook.lan> <49C8667B.5050506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <git-list@hvoigt.net>, ydirson@altern.org,
	git@vger.kernel.org, CVSps@dm.cobite.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:04:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqu7C-0003SF-D6
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 21:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928AbZDFTB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 15:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757501AbZDFTB5
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:01:57 -0400
Received: from darksea.de ([83.133.111.250]:53115 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755249AbZDFTBy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 15:01:54 -0400
Received: (qmail 6371 invoked from network); 6 Apr 2009 21:01:37 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Apr 2009 21:01:37 +0200
Content-Disposition: inline
In-Reply-To: <49C8667B.5050506@alum.mit.edu>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115868>

On Tue, Mar 24, 2009 at 05:50:03AM +0100, Michael Haggerty wrote:
> Heiko Voigt wrote:
> > I just started a very simple but hopefully effective testsuite to 
> > collect all the issues we found with cvsps. [...]
> > 
> > Maybe Michael can add his tests as well. You should just need to 
> > construct the expected cvsps output.
> 
> Please note that the cvsps output format itself is not rich enough to
> represent all of the information needed, so it is not trivial to
> construct the "expected" output.  

But its possible ;) I have extracted some tests from the scripts you
send and pushed them into the repo. The output format definitely needs
extension. I already included that in the expected output. Maybe you
want to have a look. Tell me what you think.

> The following is from an email that I
> sent to the Mercurial mailing list [1]:
> 
> > I spent some time looking into cvsps, and I don't think that its
> > output format, let alone the output itself, is suitable for
> > industrial-strength conversion from CVS.  For example, as far as I
> > can tell from my brief investigation:
> > 
> > * log messages are not unambiguously separable from the metadata
> > 

Thats one issue which could be addressed by escaping the sequences which
lead to the ambiguity.

All issues described below could be addressed by the examples I included in
the tests.

> > * it seems to only allow a single tag per changeset
> > 
> > * it seems to only apply tags to single changesets, whereas in CVS
> >   files can be added to a tag at different times.
> > ...
> > 
> > * it seems to completely ignore a branch tag if no commits were
> >   ever made on that branch.
> > 
> > * it seems to ignore the effect that a second import to a vendor
> >   branch has on the main branch.
> 
> You might also be interested to know that there has been some work in
> the Mercurial project on a Python-based "cvsps".  I believe they use
> their own version for their cvsimport extension.  I don't know how
> different their cvsps is from the original.

Thats indeed interesting I have to try it once the testsuite is ready.
Maybe we can then just replace the original.

cheers Heiko
