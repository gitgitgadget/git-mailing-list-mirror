From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] git-apply: apply submodule changes
Date: Sat, 11 Aug 2007 00:00:04 -0700
Message-ID: <7vvebmo8sr.fsf@assigned-by-dhcp.cox.net>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
	<20070810135744.GA29243MdfPADPa@greensroom.kotnet.org>
	<7vd4xupqwh.fsf@assigned-by-dhcp.cox.net>
	<20070811064555.GC29996@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Sat Aug 11 09:00:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJkxd-00060v-DK
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 09:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbXHKHAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 03:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbXHKHAH
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 03:00:07 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47078 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbXHKHAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 03:00:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811070003.DDDQ3478.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 03:00:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aX041X0051kojtg0000000; Sat, 11 Aug 2007 03:00:04 -0400
In-Reply-To: <20070811064555.GC29996@liacs.nl> (Sven Verdoolaege's message of
	"Sat, 11 Aug 2007 08:45:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55591>

Sven Verdoolaege <skimo@liacs.nl> writes:

> Or should we just refuse to apply submodule patches if --index
> has not been specified?

If somebody sends you a patch that adds a new gitlink, I think
it is very natural to create a directory (or make sure a
directory exists) there when applying without --index.

My gut feeling is that it would probably be the most user
friendly to just warn but ignore if you do not have submodule
there and a patch wants to modify that path.  After all, the
fundamental idea behind our submodule support is that you as a
superproject person should not even have to have the submodule
checked out.
