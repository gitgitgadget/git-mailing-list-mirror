From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: fix calculation of the number of suspicious revisions
Date: Wed, 21 Mar 2007 14:23:57 -0700
Message-ID: <7vodmmz3wy.fsf@assigned-by-dhcp.cox.net>
References: <20070317141209.GA7838@cepheus>
	<Pine.LNX.4.63.0703171845541.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070317195840.GA20735@informatik.uni-freiburg.de>
	<20070321210454.GA2844@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Mar 21 22:24:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU8Ht-0008Kt-0V
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 22:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbXCUVYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Mar 2007 17:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbXCUVYA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 17:24:00 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35527 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965069AbXCUVX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2007 17:23:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321212359.GLQP18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 17:23:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dZPy1W00m1kojtg0000000; Wed, 21 Mar 2007 17:23:59 -0400
In-Reply-To: <20070321210454.GA2844@lala> (Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 =?utf-8?Q?'s?= message of
	"Wed, 21 Mar 2007 22:04:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42818>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> Up to now the number printed was calculated assuming that the
> current revision to test is bad.  Given that it's not possible
> that this always matches the number of suspicious revs if the
> current one is good, the maximum of both is taken now.
>
> Moreover I think the number printed was always one to high,
> this is fixed, too.

I know you mean well, but is it really worth an extra rev-list
for this off-by-one, I wonder?
