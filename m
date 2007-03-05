From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] git-rev-list: --topo-order --boundary and --max-count
Date: Mon, 5 Mar 2007 09:05:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703050901370.3998@woody.linux-foundation.org>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOGdT-0000mA-QU
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 18:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbXCERGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 12:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbXCERGE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 12:06:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53893 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbXCERGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 12:06:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25H5qq8000379
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Mar 2007 09:05:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l25H5pM7027876;
	Mon, 5 Mar 2007 09:05:51 -0800
In-Reply-To: <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.952 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41461>



On Mon, 5 Mar 2007, Junio C Hamano wrote:
> 
> I think the code that does --boundary when the list is limited
> with --max-count is not quite right, even without topo-order.

Yeah. Sadly, this is a really irritating bug, becuase it means that you 
cannot do

	gitk -50

to see some random collection of 50 recent commits.

(And yes, I've wanted to do that - I know the commit is fairly recent, so 
rather than write "gitk @{1.hour.ag}..", I'd rather just be lazy and say 
"gitk -100" to get a smaller slider bar and easier to find the recent 
ones).

I never cared enough to fix it, but it's a mis-feature. I agree that it's 
probably not entirely trivial to fix.

		Linus
