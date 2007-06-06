From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Wed, 06 Jun 2007 03:35:25 -0700
Message-ID: <7vr6op4bgy.fsf@assigned-by-dhcp.cox.net>
References: <200706040251.05286.johan@herland.net>
	<7vejkp5ua1.fsf@assigned-by-dhcp.cox.net>
	<7vwsyh4ewh.fsf@assigned-by-dhcp.cox.net>
	<200706061226.00689.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 06 12:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvsrX-0001ml-AB
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 12:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbXFFKf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 06:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758026AbXFFKf1
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 06:35:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41129 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbXFFKf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 06:35:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606103526.XAEC7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 06:35:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8AbR1X00K1kojtg0000000; Wed, 06 Jun 2007 06:35:26 -0400
In-Reply-To: <200706061226.00689.johan@herland.net> (Johan Herland's message
	of "Wed, 6 Jun 2007 12:26:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49280>

Johan Herland <johan@herland.net> writes:

> I also noticed that a number of the early tags in the kernel repo use the 
> ancient format, and would thus fail fsck.
>
> <stroke-of-madness>
> Could we replace the v0.99 tag (and other ancient tags) with "correct" 
> versions, and then encourage users who have already cloned to delete their 
> v0.99 tag and re-pull? New clones would of course never see the old tag at 
> all. This sure as hell sounds similar to inserting foot into mouth before 
> shooting oneself in said foot, but it might still be worth considering...
> </stroke-of-madness>

I actually think that is not too bad.  In the course of git
development, the kernel folks had to do the wholesale repository
conversion twice (once when the order of hashing and compression
was swapped, another when the flat tree was made hierarchical),
I think.  Compared to that, tags are not referred to by other
entities, so it's much easier to "convert" (iow, re-sign).
