From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent info
Date: Sun, 08 Jul 2007 11:32:11 -0700
Message-ID: <7v4pke3fx0.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 20:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7bYO-0008EM-NS
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbXGHScN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbXGHScN
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:32:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42484 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbXGHScN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:32:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708183212.BQZD3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 14:32:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M6YB1X00E1kojtg0000000; Sun, 08 Jul 2007 14:32:12 -0400
In-Reply-To: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
	(Marco Costalba's message of "Sun, 8 Jul 2007 16:37:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51903>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Without this patch in case of a merge, duplicated parents are
> omitted in first line output, but still listed in following
> parents information.
>
> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>
> Following the hint of someone I submit this patch.
>
> Please take it as a wish of not reverting the patch ;-)

Sorry, I am puzzled... which patch are you talking about
possibly getting reverted?

In any case, the caller asked "log" to:

 1. simplify the history, by giving pathspec,
 2. show the list of parents,
 3. show the diff with each of the parents.

If we omit dupilicated parents in the simplified view from 2.,
we should be consistent in the output from 3.; I think what your
patch does makes sense.

I'll look at it again later.
