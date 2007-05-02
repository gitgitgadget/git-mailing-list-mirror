From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] http-fetch: Disable use of curl multi support for libcurl < 7.16.
Date: Wed, 02 May 2007 11:42:59 -0700
Message-ID: <7vfy6f3w3w.fsf@assigned-by-dhcp.cox.net>
References: <87slafs7y4.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Wed May 02 20:43:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjJnC-0001Ht-Vs
	for gcvg-git@gmane.org; Wed, 02 May 2007 20:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767191AbXEBSnD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 14:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767190AbXEBSnC
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 14:43:02 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43096 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767191AbXEBSnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 14:43:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070502184300.BZZZ13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 2 May 2007 14:43:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uJiz1W00d1kojtg0000000; Wed, 02 May 2007 14:43:00 -0400
In-Reply-To: <87slafs7y4.fsf@wine.dyndns.org> (Alexandre Julliard's message of
	"Wed, 02 May 2007 14:53:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46043>

Alexandre Julliard <julliard@winehq.org> writes:

> curl_multi_remove_handle() is broken in libcurl < 7.16, in that it
> doesn't correctly update the active handles count when a request is
> aborted. This causes the transfer to hang forever waiting for the
> handle count to become less than the number of active requests.

Is there a changelog entry for release 7.16 that you can point
at in your commit log message?

It's not that I do not believe you, but I'd feel happier to see
independent success stories/confirmation, as I do not know if we
have broken non-multi codepath lately.  How many people still use
the non-multi codepath I wonder?

List?
