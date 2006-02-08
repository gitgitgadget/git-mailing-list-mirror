From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git + ssh + key authentication feature-request
Date: Wed, 8 Feb 2006 15:50:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602081545330.2458@g5.osdl.org>
References: <43EA73C3.2040309@iaglans.de> <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>
 <43EA7D57.7040409@iaglans.de> <7v4q39o3xs.fsf@assigned-by-dhcp.cox.net>
 <43EA8DDA.3070906@iaglans.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 00:51:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6z5d-0008NA-9E
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 00:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWBHXvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 18:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWBHXvK
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 18:51:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422654AbWBHXvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 18:51:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k18Np4DZ023369
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 15:51:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k18NouNL018999;
	Wed, 8 Feb 2006 15:51:01 -0800
To: "Nicolas Vilz 'niv'" <niv@iaglans.de>
In-Reply-To: <43EA8DDA.3070906@iaglans.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15765>



On Thu, 9 Feb 2006, Nicolas Vilz 'niv' wrote:
> 
> So, how do i tell git to send my identity-file to sshd? And could I set an
> alias like in .git/remotes for that location / identity?

Use a "fake host".

Ie, let's say that your project is "project@host.com", then make each user 
just have in their .ssh/config:

	host project.host.com
		User project
		HostName host.com
		IdentityFile /home/myhome/project-key

and there you are. Just use "project.host.com:repo-name" as the thing you 
pull and push from.

(Yeah, I forget the exact ssh config file format, so you should 
double-check that.)

		Linus
