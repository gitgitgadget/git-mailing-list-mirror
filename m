From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Pushing into a repository with working directory?
Date: Fri, 05 Jan 2007 09:32:19 +0000
Message-ID: <459E1B23.4060400@shadowen.org>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org> <7vwt41j1le.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 10:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2lR4-0002R7-D4
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 10:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbXAEJcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 04:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbXAEJcW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 04:32:22 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2507 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965140AbXAEJcW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 04:32:22 -0500
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1H2lQ7-0007nZ-7g; Fri, 05 Jan 2007 09:31:27 +0000
User-Agent: Icedove 1.5.0.9 (X11/20061220)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt41j1le.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35984>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> Special casing the 'current' branch makes any sort of automated push
>> setup unreliable.  Indeed the special case preventing a fetch into the
>> current branch is pretty annoying for the same reason.  I would almost
>> prefer to relax that than add the same for push.
> 
> How would you relax the fetch case?  Fetching into the current
> branch, unless the repository is bare, is always a fishy
> operation.

Is it fishy if the working directory and index match HEAD?  If not, then
we could detect that and allow update in that case?

Also, if we had dangling head support we could "leave" HEAD pointing to
the starting commit, and emit a nice fat warning.

-apw
