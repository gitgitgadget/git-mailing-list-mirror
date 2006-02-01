From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Question around git-shell usage in Everyday Git
Date: Wed, 1 Feb 2006 15:30:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602011523000.21884@g5.osdl.org>
References: <200602012301.56141.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 00:30:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4RR0-0006B3-Kr
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 00:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423027AbWBAXao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 18:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWBAXao
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 18:30:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62602 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423027AbWBAXan (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 18:30:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11NUaDZ032733
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 15:30:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11NUZcF017534;
	Wed, 1 Feb 2006 15:30:35 -0800
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200602012301.56141.alan@chandlerfamily.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15465>



On Wed, 1 Feb 2006, Alan Chandler wrote:
> 
> My question, in this case is there any reason (such as git creating home 
> directoriy temp files or something) why each developer could not have their 
> home directory as the root of all the repositories (ie where my git user in 
> the above example had its home directory).

No reason why not.

I use my home directory for all _my_ projects, and just clone them within 
my own network with

	git pull g5:v2.6/linux ..

rather than using the absolute path-name.

And no, git should never use your home directory for anything else (ie 
all file operations are normally done just in $GIT_OBJECT_DIR or 
similar: some things like "git-diff-files" will use the current working 
directory, but nothing uses $HOME (*)).

So I would indeed suggest that the home directory would be the natural 
place to put developer projects.

		Linus

(*) Not entirely true. "git-cvsimport" uses "$HOME/.cvspass" for CVS 
passwords. But the _basic_ git commands shouldn't do that.
