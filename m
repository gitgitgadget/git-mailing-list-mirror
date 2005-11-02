From: Junio C Hamano <junkio@cox.net>
Subject: Re: HTTP pushes
Date: Tue, 01 Nov 2005 16:36:42 -0800
Message-ID: <7v1x1z51id.fsf@assigned-by-dhcp.cox.net>
References: <20051101020248.GA3928@reactrix.com>
	<Pine.LNX.4.63.0511012008310.11979@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6cX-0004OC-JK
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbVKBAgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVKBAgp
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:36:45 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9202 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751484AbVKBAgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:36:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102003624.YJDQ1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 19:36:24 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10982>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 31 Oct 2005, Nick Hengeveld wrote:
>
>> HTTP is currently listed as a read-only/unsupported method for doing
>> pushes, is that due to inherent problems with HTTP or just because
>> it hasn't been written yet?
>> 
>> I've built a working prototype of an HTTP push implementation using DAV.

I had an impression that DAV has its own notion of version
control, so using git as a backend on the server side might be
an interesting exercise.

> I think this is useful. There are restrictive firewalls out there, which 
> only allow ports 80 and 443 to be connected to. Your work would fit in 
> right there.

Another solution for this would be to allow connect.c to use a
HTTP connect passthru proxy. CVS does this with an ugly but easy
to understand notation:

    ':pserver;proxy=firewall;proxyport=3128:user@host:/path/to/repo
