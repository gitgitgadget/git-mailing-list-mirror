From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git + ssh + key authentication feature-request
Date: Wed, 8 Feb 2006 14:45:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602081438390.2458@g5.osdl.org>
References: <43EA73C3.2040309@iaglans.de> <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>
 <43EA7D57.7040409@iaglans.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 23:46:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6y4F-0002kD-VA
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 23:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWBHWpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 17:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWBHWpl
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 17:45:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965225AbWBHWpk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 17:45:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k18MjZDZ020274
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 14:45:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k18MjYkG016050;
	Wed, 8 Feb 2006 14:45:35 -0800
To: "Nicolas Vilz 'niv'" <niv@iaglans.de>
In-Reply-To: <43EA7D57.7040409@iaglans.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15758>



On Thu, 9 Feb 2006, Nicolas Vilz 'niv' wrote:
> 
> in my case it would be only one system-user which has full access to several
> repositories. At this time, the users which use that account, have to give a
> password, which isn't that bad... it would be easier and more secure for me,
> not to give a password, but ask the users for the ssh pubkey..

That is very much part of how the whole git-shell usage was envisioned.

Create a "project" account on some shared machine, create the project(s) 
in that accounts home directory, and set the login shell for that 
project to "git-shell".

Then you ask people who are part of the project to send in some ssh key 
for that project. Then add those keys to the authorized_keys2 file for the 
project, and voila, you all your participants can pull and push into it 
but do not get any other access to the machine.

It _should_ all work perfectly fine. There are features you may want to 
add, like logging (but sshd does some of that for you) and various "admin" 
commands in addition to just plain push/pull. git-shell was really just a 
quick hack, and I don't know if anybody actually uses it.

In other words, it hasn't exactly been tested,

		Linus
