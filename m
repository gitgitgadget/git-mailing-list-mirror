From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 13:22:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091321100.5498@g5.osdl.org>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795787F@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 22:22:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FonV6-0001hS-53
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWFIUWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWFIUWd
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:22:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932257AbWFIUWc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 16:22:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59KMLgt028922
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 13:22:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59KMI9c028440;
	Fri, 9 Jun 2006 13:22:20 -0700
To: "Post, Mark K" <mark.post@eds.com>
In-Reply-To: <5A14AF34CFF8AD44A44891F7C9FF41050795787F@usahm236.amer.corp.eds.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21549>



On Fri, 9 Jun 2006, Post, Mark K wrote:
>
> Martin is using git over SSH.  I have git-shell in /etc/passwd for his
> account.

Ahh. git-shell doesn't read .bashrc or anything like that.

Does adding a "umask(0022)" to the beginning of main() in shell.c fix it 
for you?

		Linus
