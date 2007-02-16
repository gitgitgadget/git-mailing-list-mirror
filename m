From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Thu, 15 Feb 2007 18:40:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702151838250.20368@woody.linux-foundation.org>
References: <11715851974102-git-send-email-mdl123@verizon.net>
 <11715851972838-git-send-email-mdl123@verizon.net>
 <11715851973802-git-send-email-mdl123@verizon.net> <7vire2c00i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 03:41:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHt1y-0007Ls-UZ
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 03:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbXBPCkw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 21:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbXBPCkw
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 21:40:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46853 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932500AbXBPCkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 21:40:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1G2eehB005459
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Feb 2007 18:40:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1G2eXVY017211;
	Thu, 15 Feb 2007 18:40:36 -0800
In-Reply-To: <7vire2c00i.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.433 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39880>



On Thu, 15 Feb 2007, Junio C Hamano wrote:
> 
> One way to check that would be to ask "describe --all" if it can
> find a ref that can reach that commit.  It would error out if
> the commit object exists but is not reachable from any of the
> refs.

Actually, more efficient and to the point:

	list-all-boundary-sha1s |
		git-rev-list --stdin --not --all

should return empty. Or something like that.

		Linus
