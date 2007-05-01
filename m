From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Tue, 01 May 2007 15:27:35 -0700
Message-ID: <7v4pmw5gdk.fsf@assigned-by-dhcp.cox.net>
References: <200705012346.14997.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, releases@openoffice.org,
	Jan Holesovsky <kendy@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 00:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj0ou-0004m4-64
	for gcvg-git@gmane.org; Wed, 02 May 2007 00:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbXEAW1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 18:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbXEAW1h
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 18:27:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46271 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbXEAW1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 18:27:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501222736.PFZC6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 18:27:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tyTa1W00r1kojtg0000000; Tue, 01 May 2007 18:27:35 -0400
In-Reply-To: <200705012346.14997.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 1 May 2007 23:46:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45987>

Jakub Narebski <jnareb@gmail.com> writes:

> What might help here is splitting repository into current (e.g. from
> OOo 2.0) and historical part, and / or using shallow clone.

Yes, depending on where you cut off and how reasonable the
project history is.

> Implementing 
> partial checkouts, i.e. checking out only part of working area (and 
> using 'theirs' strategy for merging not-checked-out part for merges) 
> would help.

Partial checkouts, perhaps, "theirs", NO.

Consider that you are working on the tip with partial checkout.
Somebody has a bugfix that is applicable to all of ancient, old,
maintenance and current codebase.  Naturally you would want the
bugfix to be applied to ancient, merge it to old, and then
maintenance and then current (the last one is what you are
working on).

What happens if you actually pull ancient when you are partially
checked out and use "theirs"?

> Splitting repository into submodules, and submodule
> support -- it depends on organization of OOo sources, would certainly 
> help for third party stuff repository.

This is probably the most sane way.
