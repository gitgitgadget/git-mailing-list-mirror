From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 11:04:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141101110.3691@g5.osdl.org>
References: <43F20532.5000609@iaglans.de>  <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
  <87k6bxvmj6.wl%cworth@cworth.org> <1139943349.4341.66.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>,
	"Nicolas Vilz 'niv'" <niv@iaglans.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:04:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F95TS-0004DN-Cz
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 20:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbWBNTE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 14:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030602AbWBNTE1
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 14:04:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030609AbWBNTE0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 14:04:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1EJ4EDZ025554
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 11:04:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1EJ4Dh0021966;
	Tue, 14 Feb 2006 11:04:13 -0800
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1139943349.4341.66.camel@evo.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16158>



On Tue, 14 Feb 2006, Keith Packard wrote:
>
> I was using:
> 
> 	 rm -r *
> 	 rm -f .cvsignore .gitignore
> 	 git-reset --hard <tag>

Ooh.

Try doing that on a big project, and it will just kill you. You've also 
lost the "top-of-branch" info, but if you're just tracking some other 
tree, that's likely not an issue.

(actually, under Linux, with enough memory, and the git stuff all cached, 
it will perform pretty well, but that's just because the OS does a _lot_ 
to try to hide how expensive it is to re-write everything. And even under 
Linux it will suck in the cold-cache case).

> Creating a fake branch seemed like a lot more bother.  

You'll find that if cairo ever grows bigger, it has huge advantages to 
switch between branches (or any random state, for that matter) without 
having to rewrite it all is a _major_ performance impact.

		Linus
