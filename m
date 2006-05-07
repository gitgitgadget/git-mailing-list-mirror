From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: symlinks
Date: Sun, 7 May 2006 11:07:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605071104230.3718@g5.osdl.org>
References: <f36b08ee0605071047h32ccef4bk76ac360ada1331a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 20:08:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcnfZ-0002RS-4k
	for gcvg-git@gmane.org; Sun, 07 May 2006 20:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWEGSHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 14:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWEGSHp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 14:07:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932202AbWEGSHo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 14:07:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k47I7gtH012951
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 May 2006 11:07:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k47I7fkL024502;
	Sun, 7 May 2006 11:07:41 -0700
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0605071047h32ccef4bk76ac360ada1331a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19708>



On Sun, 7 May 2006, Yakov Lerner wrote:
> 
> I have a project that makes heavy use of symlinks in the source tree.
> I added it to git, then cloned the repository, and all symlinks were
> converted to plain files. What am I missing to preserve symlinks ?

You're not missing anything, it sounds like a bug. What did you use to 
clone, and what version? It definitely doesn't happen for me:

	mkdir symlink
	cd symlink/
	git-init-db 
	ln -s unknown new-link
	ls -l
	git add new-link 
	git commit

	cd 
	git clone symlink symlink2
	cd symlink2/
	ls -l

shows that the symlink was preserved.

But maybe there's a bug in some older version, or in some other clone 
protocol...

		Linus
