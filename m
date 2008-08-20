From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: git-cvsimport - losing changes in subsequent pulls of a CVS branch
 that I thought I wasn't modifying in the GIT repo.
Date: Wed, 20 Aug 2008 00:35:31 -0700
Organization: Bluelane
Message-ID: <48ABC943.20508@bluelane.com>
References: <48AA6F8E.70807@bluelane.com> <48ABB899.4090608@alum.mit.edu>
Reply-To: piet@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: piet@bluelane.com, Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Piet Delaney <piet.delaney@gmail.com>,
	Piet Delaney <pdelaney@bluelane.com>,
	Avinash Kaul <avinash@bluelane.com>,
	Aravind Srinivasan <aravinds@bluelane.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 09:36:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KViFM-0006ky-W7
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 09:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbYHTHfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 03:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYHTHfp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 03:35:45 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:30483 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1749667AbYHTHfo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 03:35:44 -0400
Received: from piet2.bluelane.com ([64.94.92.242]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Aug 2008 03:35:42 -0400
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48ABB899.4090608@alum.mit.edu>
X-Enigmail-Version: 0.95.7
X-OriginalArrivalTime: 20 Aug 2008 07:35:43.0103 (UTC) FILETIME=[5A0F28F0:01C90297]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92967>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Haggerty wrote:
> Pete/Piet Delaney wrote:
>> I'm running into a problem with git-cvsimport.  [...]
>>
>> I'll take another stab at it tomarrow. Any thoughts or
>> recommendations appreciated.
> 
> If this is a one-time conversion (i.e., you don't need to actively track
> a live CVS repository), then I suggest that you try cvs2svn/cvs2git [1].
>  It can migrate to git via a git-fast-import output stream [2].  All
> cvsps-based tools necessarily have problems because cvsps (a) doesn't
> output enough information for a reliable conversion and (b) gets
> confused by certain patterns that commonly occur in CVS repository
> histories.  cvs2svn can handle every CVS repository that we have seen
> and is also highly configurable [3].

Hi Michael:

  I migrated our BLUX build environment from CVS to GIT about six
months ago. In the mean time some additional development occurred
in the CVS repo in a new 'virtualshield_saflow' branch.

  In parallel, I updated the git repository and bit keeper repos in
an upgrade from 2.6.12 to 2.6.16 kernel and quite a few of
the associated Linux-From-Scratch (LFS) library migrations.

  My 1st resync using git-cvsimport to update the git repo by pulling in
the new 'virtualshield_saflow' branch went without any problems; thought
I recall that it seems more in sync after doing a second cvsimport.

  A few weeks later, the second resync came out totally wrong.
This evening I updated the git repo with the corrected files. It
would be interesting to know how it could have been done right in
the first place and to understand why do things like modifying the
imported 'engg' branch that I imported and NEVER should have been
done confused git. I suspect that doing:

    git-cvsimport -o virtualshield_saflow -r origin blux

wasn't right I don't think I has to use "-r origin' option on the
1st import of the 'virtualshield_saflow' branch.

  Hopefully we are done with the CVS repo updates. If it turns out
that it all should be done again, avoiding the modification of
imported branches, we'll look at using the cvs2git approach that
your recommending.

  How does your proposed cvs2git facility deal with importing on top
of branches that have been modified?

> 
> Michael
> 
> [1] http://cvs2svn.tigris.org/
> [2] http://cvs2svn.tigris.org/cvs2git.html
> [3] http://cvs2svn.tigris.org/features.html

Thanks for to pointers.

- -piet

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIq8lDJICwm/rv3hoRAut5AJ4qLkfBBym9aC7Aajae8VkkrxE58gCffb5S
I5g8ri5ZLPUQ7uL7h/Kx2/M=
=RF1O
-----END PGP SIGNATURE-----
