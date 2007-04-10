From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 13:06:07 -0700
Message-ID: <7v1wisvvtc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<200704101828.37453.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
	<200704102004.08329.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:47:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbMcF-0006kc-6n
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbXDJUGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbXDJUGL
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:06:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51964 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030505AbXDJUGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:06:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410200608.IUAL1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 16:06:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lY671W0101kojtg0000000; Tue, 10 Apr 2007 16:06:08 -0400
In-Reply-To: <200704102004.08329.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 10 Apr 2007 20:04:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44175>

Andy Parkins <andyparkins@gmail.com> writes:

> On Tuesday 2007, April 10, Linus Torvalds wrote:
>
>> (But there's nothing that says that the ".gitmodules" file couldn't
>> just use the same parser as the git config file, so I don't really
>> strongly care either way. I just think it would be nice to be able to
>> say
>>
>> 	[module "kdelibs"]
>> 		dir = kdelibs
>> 		url = git://git.kde.org/kdelibs
>> 		description = "Basic KDE libraries module"
>>
>> 	[module "base"]
>> 		alias = "kdelibs", "kdebase", "kdenetwork"
>>
>> or whatever. You get the idea..)
>
> Would it be nicer if .gitmodules were line-based to aid in merging?

I personally feel that if there are cases that merge conflict is
hard to resolve, there is something wrong in the communication
between project members.  In other words, merging this *should*
be hard.

Really, if somebody wants to have project X at directory sub/X/
and somebody else wants the same at directory X/, merging the
modules file would be the least of your concern -- resulting
toplevel would not build correctly until you decide which tree
hierarchy should be picked, and later exchange of results among
project members would not be usable easily to half the people
who picked the hierarchy differently from you did.
