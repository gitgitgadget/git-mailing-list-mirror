From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: update-index --unresolve
Date: Thu, 2 Oct 2008 16:18:53 +0200
Message-ID: <20081002141853.GD6839@neumann>
References: <20081002135224.GC6839@neumann>
	<m3tzbvqesz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:20:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlP2D-0006d0-1K
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbYJBOSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2008 10:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbYJBOSy
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:18:54 -0400
Received: from francis.fzi.de ([141.21.7.5]:36880 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752504AbYJBOSy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:18:54 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Oct 2008 16:18:52 +0200
Content-Disposition: inline
In-Reply-To: <m3tzbvqesz.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 02 Oct 2008 14:18:52.0941 (UTC) FILETIME=[CC16C3D0:01C92499]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97338>

Hi Jakub,

On Thu, Oct 02, 2008 at 06:58:41AM -0700, Jakub Narebski wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
> >   --unresolve::
> >          Restores the 'unmerged' or 'needs updating' state of a
> >          file during a merge if it was cleared by accident.
> >=20
> > How could I clear those states by accident (or intentionally)?
>=20
> "git add <file>", or "git update-index <file>", or error in handling
> merge tool via git-mergetool.
Thanks for your fast reply.

However:

# ...  do a conflicting merge
(master|MERGING)$ echo 4 >one
(master|MERGING)$ git status
one: needs merge
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
#   directory)
#
#       unmerged:   one
#
no changes added to commit (use "git add" and/or "git commit -a")
(master|MERGING)$ git add one
(master|MERGING)$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   one
#
(master|MERGING)$ git update-index --unresolve
(master|MERGING)$ echo $?
0
(master|MERGING)$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   one
#

So, as you can see, after 'add ; update-index --unresolve' the file is
not marked as unmerged, but it's still ready to be committed.

Is something wrong going on here, or it is indeed the intended
behaviour and I misunderstood this functionality?

Thanks,
G=E1bor
