From: Junio C Hamano <junkio@cox.net>
Subject: Re: Submodule object store
Date: Mon, 26 Mar 2007 16:28:28 -0700
Message-ID: <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
References: <1174825838.12540.5.camel@localhost>
	<1174930688.5662.20.camel@localhost>
	<20070326183523.GG22773@admingilde.org>
	<200703262133.44520.Josef.Weidendorfer@gmx.de>
	<20070326220302.GH22773@admingilde.org>
	<7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
	<20070326231637.GJ22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVyc4-0006Mz-KS
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933699AbXCZX2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933700AbXCZX2a
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:28:30 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34624 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699AbXCZX23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 19:28:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326232830.SCFA1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 19:28:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fbUU1W0011kojtg0000000; Mon, 26 Mar 2007 19:28:28 -0400
In-Reply-To: <20070326231637.GJ22773@admingilde.org> (Martin Waitz's message
	of "Tue, 27 Mar 2007 01:16:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43205>

Martin Waitz <tali@admingilde.org> writes:

> To make purge and fsck work we have the hard requirement that it
> must be possible to list all objects which belong to one submodule.

I understand you would want to separate the ref namespace, but I
still do not see why you would want to have a separate object
store, laid out in a funny way.  Unless you are thinking about
using rsync to transfer object store, that is.

> And moving the submodule object store into the .git directory of the
> supermodule has several reasons:...

Oh, I am not disputing that.  If you want to use a single object
store for both levels, I think that is a sensible thing to do.
I just do not see the point of segregating submodule objects and
supermodule objects in the single object store you attach to the
supermodule.  After all, any traversal starts from refs, so by
segregating the ref namespace you would limit the extent of the
traversal, no?
