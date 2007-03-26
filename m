From: Junio C Hamano <junkio@cox.net>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 16:24:09 -0700
Message-ID: <7v3b3rvbae.fsf@assigned-by-dhcp.cox.net>
References: <1174825838.12540.5.camel@localhost>
	<20070326220302.GH22773@admingilde.org>
	<7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
	<200703270117.59205.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVyXv-0003yV-PX
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbXCZXYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933700AbXCZXYM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:24:12 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:65380 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406AbXCZXYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 19:24:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326232412.RZWW1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 19:24:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fbQ91W00Z1kojtg0000000; Mon, 26 Mar 2007 19:24:10 -0400
In-Reply-To: <200703270117.59205.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 27 Mar 2007 01:17:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43203>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Tuesday 27 March 2007, Junio C Hamano wrote:
>> Martin Waitz <tali@admingilde.org> writes:
>> 
>> > For submodules I currently use <parent>/.git/objects/module/<submodule>/
>> > to store the objects belonging to the submodule.
>> 
>> I was not following the gitlink discussion closely, but what is
>> the motivation behind this separation of the object store?
>
> The separation issue is about scalability of submodules, and not
> directly about gitlink.

Unless you are thinking about rsync of object store, it is not
clear what "scalability of submodules" has to do with having
separate object database.

The issue I recall from earlier discussion on scalability of
submodules was about the direct placement of commit objects in
supermodule trees (which would force fetching in supermodule to
drag in all submodules even when the "integration" or "build
infrastructure" person does not want to have submodules pulled).
But I think that is an issue of the definition of connectivity.
It should be orthogonal to the issue of how object store is laid
out, shouldn't it?
