From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Wed, 06 Jun 2007 00:18:13 -0700
Message-ID: <7vtztl7dqi.fsf@assigned-by-dhcp.cox.net>
References: <200706040251.05286.johan@herland.net>
	<200706040253.51920.johan@herland.net>
	<20070604055655.GB15148@moooo.ath.cx>
	<200706040951.06620.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 09:18:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvpmg-0004y2-LX
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbXFFHSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbXFFHSQ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:18:16 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42114 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbXFFHSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:18:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606071815.JDWU14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 03:18:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 87JE1X0011kojtg0000000; Wed, 06 Jun 2007 03:18:14 -0400
In-Reply-To: <200706040951.06620.johan@herland.net> (Johan Herland's message
	of "Mon, 04 Jun 2007 09:51:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49254>

Johan Herland <johan@herland.net> writes:

> Teach git-fsck to do the same kind of verification on tag objects that is
> already done by git-mktag.

The tagger field was introduced mid July 2005; any repository
with a tag object older than that would now get non-zero exit
from fsck.

This won't practically be problem in newer repositories, but it
is somewhat annoying.  Perhaps do this only under the new -v
option to git-fsck, say "warning" not "error", and not exit with
non-zero because of this?
