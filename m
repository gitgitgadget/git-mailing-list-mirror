From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Wed, 06 Jun 2007 02:03:50 -0700
Message-ID: <7vejkp5ua1.fsf@assigned-by-dhcp.cox.net>
References: <200706040251.05286.johan@herland.net>
	<200706040951.06620.johan@herland.net>
	<7vtztl7dqi.fsf@assigned-by-dhcp.cox.net>
	<200706061006.33139.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 11:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvrQu-0000VK-2W
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 11:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXFFJDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 05:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbXFFJDw
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 05:03:52 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49605 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXFFJDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 05:03:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606090351.QWWD1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 05:03:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 893q1X00J1kojtg0000000; Wed, 06 Jun 2007 05:03:51 -0400
In-Reply-To: <200706061006.33139.johan@herland.net> (Johan Herland's message
	of "Wed, 06 Jun 2007 10:06:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49272>

Johan Herland <johan@herland.net> writes:

>> This won't practically be problem in newer repositories, but it
>> is somewhat annoying.  Perhaps do this only under the new -v
>> option to git-fsck, say "warning" not "error", and not exit with
>> non-zero because of this?
>
> Like this?
>
> Or would you rather switch around the "verbose" and the
> "parse_and_verify_tag_buffer()" (i.e. not even attempt the thorough
> verification unless in verbose mode)?

Actually I was thinking about doing something like this.

-	if (parse_and_verify_tag_buffer(0, data, size, 1) && verbose)
+	if (parse_and_verify_tag_buffer(0, data, size, verbose))
