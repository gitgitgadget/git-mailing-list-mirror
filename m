From: Junio C Hamano <junkio@cox.net>
Subject: Re: specify charset for commits
Date: Thu, 21 Dec 2006 10:19:37 -0800
Message-ID: <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
	<20061221085907.GA2244@cepheus>
	<Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612211623.14236.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 19:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxSW6-0003Fu-OY
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 19:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422999AbWLUSTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 13:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWLUSTj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 13:19:39 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53387 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422999AbWLUSTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 13:19:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221181938.XUDV16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 13:19:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1WJv1W00N1kojtg0000000; Thu, 21 Dec 2006 13:18:56 -0500
To: Alexander Litvinov <litvinov2004@gmail.com>
In-Reply-To: <200612211623.14236.litvinov2004@gmail.com> (Alexander Litvinov's
	message of "Thu, 21 Dec 2006 16:23:13 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35077>

Alexander Litvinov <litvinov2004@gmail.com> writes:

> May we can add new header into commit with commit text encoding ?

I do not think we want to change the commit header, nor we would
want to re-encode, but I can see two possible improvements:

 (1) git-am should default to -u; this was suggested on the list
     long time ago, but is an incompatible change.  v1.5.0 we
     can afford to be incompatible to make it more usable and
     safer.

 (2) update commit-tree to reject non utf-8 log messages and
     author/committer names when i18n.commitEncoding is _NOT_
     set, or set to utf-8.

     Maybe later we can use encoding validation routines for
     other encodings by checking i18n.commitEncoding, but at the
     minimum the above would be safe enough for recommended UTF-8
     only cases.
