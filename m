From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 23:18:10 -0700
Message-ID: <7vu08vjra5.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
	<7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141748070.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604141751270.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 08:18:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUe71-0007R7-5A
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 08:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWDOGSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 02:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWDOGSQ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 02:18:16 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8168 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030266AbWDOGSP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 02:18:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415061812.KPPD20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 02:18:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18727>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 14 Apr 2006, Linus Torvalds wrote:
>> 
>> I think you're right, and I've probably broken "--full-diff" (causing the 
>> revparse to also use the empty set of paths). Gaah.
>
> In fact, it's broken path-limited revisions entirely. Duh. We should have 
> a test for that, so I would have noticed.
>
> I think we need two diffopt structures there - one for the actual diff, 
> and one for the pruning.

Although I've already decided to merge it up, there are small
fallout from this.  I've fixed the ones I noticed, but there
probably remain some backward compatibility issues in commands
that I do not usually use.  We'll see.

Also I merged the commit prettyprinter change, but I was hoping
we could instead pass down the commit object and commit format
to places where log message needs to be output and write it out
to the standard output instead of formatting in core.
