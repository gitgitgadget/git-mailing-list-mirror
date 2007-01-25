From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-1.5.0.rc2: "git pull -t" complains
Date: Wed, 24 Jan 2007 17:54:08 -0800
Message-ID: <7vwt3ban27.fsf@assigned-by-dhcp.cox.net>
References: <200701250137.l0P1bRYm020504@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Thu Jan 25 02:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9toc-0007AO-2f
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 02:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbXAYByL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 20:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbXAYByL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 20:54:11 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:38140 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965130AbXAYByK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 20:54:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125015409.TPEI19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 20:54:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FDuT1W00y1kojtg0000000; Wed, 24 Jan 2007 20:54:28 -0500
In-Reply-To: <200701250137.l0P1bRYm020504@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Wed, 24 Jan 2007 22:37:27 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37702>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> I've got a repo here which is missing oldish tags, so I:
>
>    $ git pull -t
>    Warning: No merge candidate found because value of config option
> 	    "branch.master.merge" does not match any remote branch fetched.
>    No changes.
>
> Both "git pull --help" and git-pull(1) say this should work.

Ah, that's because git-pull documentation shares large part of
the source with git-fetch (the part that talk about --tags is
coming from a single file, pull-fetch-param.txt).

It really shouldn't.  Fetching all tags and merging them all to
your current branch does not make any sense.
