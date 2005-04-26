From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git add / update-cache --add fails.
Date: Mon, 25 Apr 2005 17:47:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251741430.18901@ppc970.osdl.org>
References: <200504252226.00354.rhys@rhyshardwick.co.uk>
 <200504252252.05957.rhys@rhyshardwick.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 02:41:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQE8X-0002WX-HF
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 02:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVDZAqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 20:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDZAqN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 20:46:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:19843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261231AbVDZAqB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 20:46:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q0jOs4018549
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 17:45:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q0jN43017568;
	Mon, 25 Apr 2005 17:45:23 -0700
To: Rhys Hardwick <rhys@rhyshardwick.co.uk>
In-Reply-To: <200504252252.05957.rhys@rhyshardwick.co.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Rhys Hardwick wrote:
> 
> Just to clarify, the latest version of git to be merged with pasky is:
> 
> 4e03aae5feb2e3fd2f543796ca3d3e8aa86c02dc
> 
> I have tried rebooting

[ somebody has been using windows for too long ;]

Just do an "strace update-cache --add xxxxx", that often gives a clue. 
Also, "ltrace" is a wonderful tool at times.

update-cache will be unhappy if the file is unreadable, for example. But 
it will also be unhappy if it cannot create the sha1 hashed object file, 
which can happen if the permissions on the object directories are screwed 
up or similar.

I think these things should generally show up as a sore thumb in an 
strace.

		Linus
