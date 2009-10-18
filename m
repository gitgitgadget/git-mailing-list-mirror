From: Norbert Preining <preining@logic.at>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 17:20:54 +0200
Message-ID: <20091018152054.GA3956@gamma.logic.tuwien.ac.at>
References: <20091018144158.GA9789@gandalf.dynalias.org> <200910181703.20607.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Oct 18 17:21:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzXZM-0001qC-Kn
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 17:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbZJRPUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 11:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754642AbZJRPUu
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 11:20:50 -0400
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:42570 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbZJRPUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 11:20:50 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzXZ0-000703-AS; Sun, 18 Oct 2009 17:20:54 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzXZ0-0001BW-7M; Sun, 18 Oct 2009 17:20:54 +0200
Content-Disposition: inline
In-Reply-To: <200910181703.20607.johan@herland.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130597>

On So, 18 Okt 2009, Johan Herland wrote:
> A global, increasing version number ala SVN is fundamentally impossible in 
> any distributed version control system (like Git).

Yes, agreed. 

The point is that I do not actually need the "distributed" part of git.
I want one central repository and all collaborators commit to that.
Yes, that is subversion, I know.

We have no branches, no tags, nothing of that. Only trunk.

>     $ git describe
>     v1.0.4-14-g2414721
> 
> where the "v1.0.4" part is the last tag that the current state is based on, 
> the "14" part is the number of commit between that tag and the current 

So if we have only one tag (initial) then it would count the number
of commits?

And if yes, is it easy to find out at which commit a file has been changed
last time (svn status -v).

I have read a lot on the net about the impossibility, and I agree that
in a distributed setting it does not work.

And in fact we would not even have revision numbers on our local
git repositories. Only one (the master checkout from which our 
distribution server is updated) needs to have some commit numbers.

THe reason is that we use that as serial number for packages. One packages
is roughly on package from CTAN (Comprehensive TeX Archive Network, 
like CPAN), and we want to make sure that if that is updated on CTAN
and we import it into our system, the next time we create a TeX Live
package for it (that will be served to quite a lot of users) we have
a new version number.

We first thought about using the version number as provided by authors,
but that is completely useless, because there are tooo many authors
of packages on CTAN where the version numbers are in no way increasing ;-)
So we settled for the max of all the last changed revision number of
the contained files, whcih is guaranteed to increase.

As a lat resort I will try to use git-svn ...

Again, thanks a lot and all the best

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining                                        Associate Professor
JAIST Japan Advanced Institute of Science and Technology   preining@jaist.ac.jp
Vienna University of Technology                               preining@logic.at
Debian Developer (Debian TeX Task Force)                    preining@debian.org
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
QUOYNESS (n.)
The hatefulness of words like 'relionus' and 'easiephit'.
			--- Douglas Adams, The Meaning of Liff
