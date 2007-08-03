From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 17:12:56 -0700
Message-ID: <7vk5sdscfr.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<85ps25y1ac.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 02:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGknR-0000Sr-4Q
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 02:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759053AbXHCAM7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 20:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759146AbXHCAM6
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 20:12:58 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51767 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758952AbXHCAM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 20:12:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803001257.WXHN1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 20:12:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XCCw1X00Q1kojtg0000000; Thu, 02 Aug 2007 20:12:57 -0400
In-Reply-To: <85ps25y1ac.fsf@lola.goethe.zz> (David Kastrup's message of "Fri,
	03 Aug 2007 01:17:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54654>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> However, there is a line we need to draw when bending bacwards for
>> compatibility, and I think a system that does not have a working
>> command substitution $( ... )  is on the other side of that line.
>
> Not an issue.  But apparently, ${parameter#word} is for Solaris.  I'd
> still like to get confirmation that it is indeed /bin/sh, but if it
> is, the current code is not good for Solaris.

I happen to feel ${parameter#word} is more esoteric than $(cmd).
If a system does not even do the latter, then avoiding the
former to help such a system is a futile effort.

And /bin/sh my Solaris box does not understand $(cmd) and wants
you to say `cmd`.  Of course % and # parameter substition do not
work there.

People could probably say SHELL_PATH=/usr/xpg4/bin/sh there to
get a saner shell, even if they do not like bash, though.
