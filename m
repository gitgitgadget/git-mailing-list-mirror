From: Dave Jones <davej@redhat.com>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 14:32:40 -0400
Message-ID: <20050427183239.GE19011@redhat.com>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org> <426FD3EE.5000404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:33:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQrJp-0003Fi-HI
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 20:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVD0SgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVD0Sef
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 14:34:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261937AbVD0Scq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 14:32:46 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j3RIWeKM025367;
	Wed, 27 Apr 2005 14:32:40 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j3RIWeO05803;
	Wed, 27 Apr 2005 14:32:40 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j3RIWeqp018384;
	Wed, 27 Apr 2005 14:32:40 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j3RIWeND018382;
	Wed, 27 Apr 2005 14:32:40 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <426FD3EE.5000404@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2005 at 11:03:26AM -0700, H. Peter Anvin wrote:
 > Linus Torvalds wrote:
 > >
 > >On Tue, 26 Apr 2005, H. Peter Anvin wrote:
 > >
 > >>One solution to all of this would be to define a quoting standard for 
 > >>strings, and simply require that all free-format strings (like the 
 > >>author fields) or at least strings that match [0-9a-f]{20}, are always 
 > >>quoted.
 > >
 > >
 > >git uses more of the ".newsrc" format, in that it just knows which 
 > >characters are legal or not.
 > >
 > >To find the email address, look for the first '<'. To find the date, look 
 > >for the first '>'. Those characters are not allowed in the name or the 
 > >email, so they act as well-defined delimeters.
 > >
 > 
 > That's true for email addresses, but the point was to distinguish links 
 > to other git objects from any other kind of text.  Currently there is no 
 > such delimiter for that.

That actually broke one of my first git scripts when one of the
changelog texts started a line with 'tree '.  I hacked around it
by making my script only grep in the 'head -n4' lines, but this
seems somewhat fragile having to make assumptions that the field
I want to see is in the first 4 lines.

		Dave

