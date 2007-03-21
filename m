From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: fix calculation of the number of suspicious revisions
Date: Wed, 21 Mar 2007 14:49:20 -0700
Message-ID: <7vk5xaz2qn.fsf@assigned-by-dhcp.cox.net>
References: <20070317141209.GA7838@cepheus>
	<Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070317195840.GA20735@informatik.uni-freiburg.de>
	<20070321210454.GA2844@lala>
	<20070321213450.GB17632@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Mar 21 22:49:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU8gU-0003oM-Ep
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 22:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbXCUVtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Mar 2007 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbXCUVtW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 17:49:22 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36618 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbXCUVtW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2007 17:49:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321214922.XFML748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 17:49:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dZpM1W00G1kojtg0000000; Wed, 21 Mar 2007 17:49:21 -0400
In-Reply-To: <20070321213450.GB17632@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Wed, 21 Mar 2007 22:34:50
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42821>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> Uwe Kleine-K=C3=B6nig wrote:
>>  	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &=
&
> independant of my suggested patch, I wonder if that line should bette=
r
> use update-ref.  (This line is older than update-ref.)

Yup.  If we can clean things up to use update-ref and
symbolic-ref properly that would be nice.  Re-counting is an
independent issue as you say.

Also we may perhaps want to stop using bisect branch but use
detached HEAD (but still refs/bisect hierarchy)?  This one I am
not so sure, but one less reserved name.
