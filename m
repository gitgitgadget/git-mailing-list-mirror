From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-daemon: path validation, export all option
Date: Tue, 27 Sep 2005 08:03:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509270802140.3308@g5.osdl.org>
References: <4338AACC.1050305@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 17:09:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKGzv-0006pB-Sa
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 17:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVI0PD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 11:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVI0PD5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 11:03:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964966AbVI0PD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 11:03:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8RF3t4s021731
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Sep 2005 08:03:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8RF3sK9016017;
	Tue, 27 Sep 2005 08:03:54 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4338AACC.1050305@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9397>



On Mon, 26 Sep 2005, H. Peter Anvin wrote:
>
> A first attempt to make git-daemon a bit more suitable for kernel.org 
> use: it allows the user to specify a whitelist of directories, rejects 
> paths which have . or .. in them (to avoid bypassing the whitelist), and 
> allows for an --export-all option.

Removing the "chdir(".git")" thing is very wrong, though. Why do it?

It's very much on purpose: you can export even "regular" git trees (ie 
trees you have checked out) without the other side having to say

	git clone machine.com:/home/torvalds/v2.6/linux/.git

where the final "/.git" is just stupid.

		Linus
