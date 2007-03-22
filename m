From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] bisect: show the maximal number of commits to be tested
Date: Wed, 21 Mar 2007 19:05:00 -0700
Message-ID: <7vhcsexcc3.fsf@assigned-by-dhcp.cox.net>
References: <20070317141209.GA7838@cepheus>
	<Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070317195840.GA20735@informatik.uni-freiburg.de>
	<20070321210454.GA2844@lala>
	<Pine.LNX.4.64.0703211521290.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Uwe =?utf-8?Q?Kleine-?= =?utf-8?Q?K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 22 03:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUCfu-0005Bm-KP
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 03:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbXCVCFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Mar 2007 22:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbXCVCFF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 22:05:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55972 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbXCVCFC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2007 22:05:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322020501.CHQD748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 22:05:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id de501W01V1kojtg0000000; Wed, 21 Mar 2007 22:05:01 -0400
In-Reply-To: <Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Mar 2007 02:43:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42832>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Since git-bisect already asks rev-list to find the midpoint (and rev-=
list
> consequently counts the number of commits), rev-list can pass it the
> maximal number of commits.
>
> As a bonus, this avoids an extra call to rev-list.
>
> Miscalculation noticed by Uwe, implementation suggested by Linus.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Wed, 21 Mar 2007, Linus Torvalds wrote:
>
> 	> On Wed, 21 Mar 2007, Uwe Kleine-K=C3=B6nig wrote:
> 	> >
> 	> > Up to now the number printed was calculated assuming that the=20
> 	> > current revision to test is bad.  Given that it's not possible=20
> 	> > that this always matches the number of suspicious revs if the=20
> 	> > current one is good, the maximum of both is taken now.
> 	>=20
> 	> How about adding a new flag to "git-rev-list", to make it count=20
> 	> both ways?
>
> 	Did I understand you correctly?

Why not show both, or at least total?

This and the earlier optimization patch steps on each others
toes, ouch ;-).
