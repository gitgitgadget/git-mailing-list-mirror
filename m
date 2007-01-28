From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sat, 27 Jan 2007 16:32:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
References: <20070127062826.GE14205@fieldses.org> <20070128002246.GA10179@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 01:32:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAxy9-0002Ft-Jd
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 01:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbXA1AcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 19:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbXA1AcX
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 19:32:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40203 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbXA1AcW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 19:32:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0S0WG1m024278
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 16:32:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0S0WEap019495;
	Sat, 27 Jan 2007 16:32:16 -0800
In-Reply-To: <20070128002246.GA10179@moooo.ath.cx>
X-Spam-Status: No, hits=-2.469 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38008>



On Sun, 28 Jan 2007, Matthias Lederhofer wrote:
>
> There are some other places where direct editing of .git/config is
> suggested.  I'd rather tell the user to use repo-config and add a note
> that repo-config saves the configuration to .git/config (or
> ~/.gitconfig with --global) which can be edited by hand too.
> cat .git/config to show the remote configuration can be replaced by
> git-repo-config -l | grep '^remote\.'

I dunno. I really think that editing the config file is actually simpler.

The "git repo-config" thing is really usefull from scripting, and for 
general automation, but maybe it's just me - I find human-readable ASCII 
files that you can put comments in etc just *nice*.

I think the whole notion that you have to use a tool to edit 
configurations is asinine. It's good to have a tool for automation, but 
it's bad if that's the only way to interact with the system.

The first time I had to use AIX, and realized that they do everything with 
some crazy system management tool, and that you can't do anything by 
editing files in /etc, I realized that IBM was totally incompetent when it 
came to UNIX.

I mean, do people _really_ think that it's easier to do black magic 
scripts like

	git repo-config --global user.name "Your Name Comes Here"

(which not only looks scary, but means that the user will never learn 
about the git config file at all), or just somebody saying:

	"Fill your .git/config file with

		[user]
			name = Your Name Here
			email = your@email.example

	 and be happy"

I'm just saying that the second example seems to not only be more 
human-friendly, it actually teaches people something that "git 
repo-config" never did. 

Maybe most users will just do what they are told without thinking about 
it, but then some users will look at that and say "Ahh, there's a 
.git/config file, I wonder what else I could do there.."

			Linus
