From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Strangely broken git repo
Date: Mon, 10 Oct 2005 08:21:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510100800580.14597@g5.osdl.org>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
 <46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
 <4349ED5D.6020703@catalyst.net.nz> <7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510100742070.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	Nick Hengeveld <nickh@reactrix.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 17:26:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOzTb-00052N-Ux
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 17:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVJJPWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 11:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVJJPWD
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 11:22:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750863AbVJJPWD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 11:22:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9AFLb4s019390
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Oct 2005 08:21:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9AFLUWl018746;
	Mon, 10 Oct 2005 08:21:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0510100742070.14597@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9892>



On Mon, 10 Oct 2005, Linus Torvalds wrote:
> 
> It seems to be the space.

Doing an strace on curl vs wget shows that curl seems to do no quoting at 
all. I'd personally argue that that is a serious bug in curl: it sure as 
hell knows that it's a http transport, and it seems to be just doing

	GET %s HTTP/1.0\r\nUser-agent:...

without any sanity checking at all.

		Linus
