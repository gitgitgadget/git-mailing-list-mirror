From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git-submodule questions
Date: Fri, 19 Oct 2007 14:30:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710191423130.26902@woody.linux-foundation.org>
References: <428b865e0710191354v59f558bbv4536d60902977ac@mail.gmail.com>
 <alpine.LFD.0.999.0710191420410.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Evan Carroll <me@evancarroll.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:31:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IizRN-0006hj-OS
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 23:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966623AbXJSVbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 17:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935576AbXJSVbW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 17:31:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55711 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934052AbXJSVbV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 17:31:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JLUopx000647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Oct 2007 14:30:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JLUoWx021109;
	Fri, 19 Oct 2007 14:30:50 -0700
In-Reply-To: <alpine.LFD.0.999.0710191420410.26902@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61767>



On Fri, 19 Oct 2007, Linus Torvalds wrote:
> 
> In fact, it should be enough to do
> 
> 	cd /srv/DM
> 	git init
> 	git add .
> 	git commit
> 
> and you're now literally all done!

.. btw, when I say that, I guess I'm lying a bit.

Yes, the above will actually generate a valid git superproject repository, 
but it won't generate/populate the necessary .gitmodules stuff. You'd need 
to add it by hand.

But yes, if you want to avoid doing that hand-editing, you should use the 
whole "git submodule add .." thing to clone the git repos you already have 
into a supermodule. But the .gitmodules thing really is pretty simple, you 
just do something like

	[submodule "x"]
		path = x
		url = official-url-of-x
	[submodule "y"]
		path = y
		url = official-url-of-y

and now you just do "git submodule init" and you should be all done 
(again, the "git submodule init" thing you could do by hand by editing 
the .git/config file, but since you can do it automatically in-place, 
there's no real point).

		Linus
