From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Wed, 8 Feb 2006 17:30:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602081726390.2458@g5.osdl.org>
References: <87slqtcr2f.wl%cworth@cworth.org> <7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 02:31:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F70eQ-0000ir-8h
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 02:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbWBIBbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 20:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWBIBbL
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 20:31:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422762AbWBIBbK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 20:31:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k191V2DZ027888
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 17:31:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k191UvCH023148;
	Wed, 8 Feb 2006 17:30:59 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15780>



On Wed, 8 Feb 2006, Junio C Hamano wrote:
> 
> So we could even implement that with
> 
> 	$ git commit --preview [other flags] [paths...]

My argument for "git status" was that it very much _is_ about "what would 
I commit". So I'd much rather extend on "git status" than add a 
"--preview" flag to "git commit".

At least to me, "git status" is very much a "what is pending" kind of 
command. The fact that you can't con it into giving a diff is actually a 
downside: I would at times have preferred to have the "git commit" message 
contain an extended status that contained the diffs too.

Another way of saying that: I think it would make sense to have a verbose 
status report, and maybe also have that verbose flag passed into "git 
commit" so that you can see the verbose status when you edit the commit 
message.

Under that logic, "git status -v" would show all the diffs (not just 
filenames) and "git commit -v .." would be the same as "git commit .." but 
the "-v" flag would have been passed down to the "git status" call, so the 
commit message file would be pre-populated with the diff.

For small commits, it's actually nice to see the diff itself as you write 
the commit message.

		Linus
