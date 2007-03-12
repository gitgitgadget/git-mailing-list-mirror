From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git-diff -p :/anything" always segfaults
Date: Mon, 12 Mar 2007 09:22:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703120921080.9690@woody.linux-foundation.org>
References: <87d53fsjiz.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0703111322180.9690@woody.linux-foundation.org>
 <7vslcbv6ol.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703120900300.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:23:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQnIh-0005vf-77
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 17:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbXCLQWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbXCLQWT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 12:22:19 -0400
Received: from smtp.osdl.org ([65.172.181.24]:59707 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030580AbXCLQWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 12:22:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2CGMAo4014017
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Mar 2007 09:22:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2CGM9Sq007550;
	Mon, 12 Mar 2007 08:22:09 -0800
In-Reply-To: <Pine.LNX.4.64.0703120900300.9690@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.487 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42037>



On Mon, 12 Mar 2007, Linus Torvalds wrote:
> 
> Otherwise, please apply something like this, which also fixes the return 
> value. We should return -1 on error!

Btw, I didn't remove the 

	if (!commit)
		break;

but I should have. It doesn't actually matter (since it will never 
trigger), but it adds to the confusion around pop_most_recent_commit.

		Linus
