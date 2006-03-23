From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning from sites with 404 overridden
Date: Thu, 23 Mar 2006 12:45:19 -0800
Message-ID: <7vwtek51r4.fsf@assigned-by-dhcp.cox.net>
References: <20060322025921.1722.qmail@science.horizon.com>
	<20060322172227.GO3997@reactrix.com>
	<20060322183621.GP3997@reactrix.com>
	<7vslpa8fld.fsf@assigned-by-dhcp.cox.net>
	<7vacbi8eu1.fsf@assigned-by-dhcp.cox.net>
	<20060323184351.GA3892@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 21:46:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMWhA-0003Cl-0W
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 21:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWCWUp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWCWUp0
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 15:45:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37092 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422691AbWCWUpW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 15:45:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060323204520.QTGO6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 15:45:20 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060323184351.GA3892@reactrix.com> (Nick Hengeveld's message of
	"Thu, 23 Mar 2006 10:43:51 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17869>

Nick Hengeveld <nickh@reactrix.com> writes:

> Seems like there are three cases to worry about:
>
> 1) the server returns a 200 status and a text/html response instead of a
>    404, and the server's default content type is not text/html
> 2) the server returns a 200 status and a text/html response instead of a
>    404, and the server's default content type is text/html
> 3) the server returns a corrupt object from the repository

> I don't think there's a way to distinguish between #2 and #3, so all we
> can really do is display as helpful an error message as possible.

The code behaves correctly the same way whether the server says
404 or 200 with human readable "No such object", and this is
just for formatting error messages, and to be honest I do not
really care at this point.  I think the existing error message
at the end of transfer we added recently should be sufficient.

> On a related note, I noticed that http-fetch will continue to try
> inflating/sha1_updating the response after an inflate error has been
> detected.  It's probably not a huge deal, but we could just error out
> immediately at that point or at least stop the unnecessary processing.

That would probably be more helpful.
