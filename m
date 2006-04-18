From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 08:25:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-2100992859-1145373947=:3701"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 17:26:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVs5W-0001Bs-02
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 17:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWDRPZw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 11:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWDRPZw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 11:25:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932276AbWDRPZv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 11:25:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3IFPltH005644
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 08:25:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3IFPll6014672;
	Tue, 18 Apr 2006 08:25:47 -0700
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20060418133847.GC4720@wohnheim.fh-wedel.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18857>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-2100992859-1145373947=:3701
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 18 Apr 2006, Jörn Engel wrote:
> 
> $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git foo
> [ stored >200M of data under foo/.git/objects ]
> 
> The above looks as if new objects are not stored under
> /home/joern/.git, as specified by GIT_OBJECT_DIRECTORY.

The "rsync" protocol really doesn't honor git rules. It's basically just a 
big recursive copy, and it will copy things from the place they were 
before.

I suspect that if you had used a real git-aware protocol instead, you'd 
have been fine, ie

	git clone git://git.kernel.org/... foo/

would probably work. (I say "probably", because very few people likely use 
GIT_OBJECT_DIRECTORY, and it makes a lot less sense with pack-files than 
it did originally, so it's not getting any testing).

		Linus
--21872808-2100992859-1145373947=:3701--
