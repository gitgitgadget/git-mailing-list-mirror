From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make GIT-VERSION-GEN tolerate missing git describe
 command
Date: Fri, 30 Dec 2005 11:55:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512301153100.3249@g5.osdl.org>
References: <dp3mtp$rfm$1@sea.gmane.org> <Pine.LNX.4.64.0512301046230.3249@g5.osdl.org>
 <43B586B4.5030001@research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 20:56:04 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsQM4-0006UK-Jo
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 20:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVL3Tzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 14:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVL3Tzg
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 14:55:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932217AbVL3Tzf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2005 14:55:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBUJtXDZ003744
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Dec 2005 11:55:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBUJtW2Z025375;
	Fri, 30 Dec 2005 11:55:32 -0800
To: John Ellson <ellson@research.att.com>
In-Reply-To: <43B586B4.5030001@research.att.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14118>



On Fri, 30 Dec 2005, John Ellson wrote:
> 
> I checked and that bug has been fixed since the older version of git that
> was causing me problems. "git non_existent_command" now returns 1.

Ahh, good.

> However, the error message was also changed to goto stderr, which it 
> sounds like you disagree with?

Not that I can see:

	[torvalds@g5 ~]$ git --version
	git version 1.0.6-g58e3
	[torvalds@g5 ~]$ git hjsdhjas > /dev/null 
	[torvalds@g5 ~]$ echo $?
	1

so yes, it returns a proper error, and it outputs the help message to 
stdout, not stderr. Which is fine, because it means that you can indeed do

	git help | less

and it will do the right thing (apart from printing the line

	git: 'help' is not a git-command

which is a bit sad).

		Linus
