From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 14:49:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
References: <17866.20355.744025.133326@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:50:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvcT-00068O-E6
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161476AbXBGWty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbXBGWtx
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:49:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43004 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030661AbXBGWtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:49:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17MnpdD023318
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 14:49:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17Mno0Y030098;
	Wed, 7 Feb 2007 14:49:50 -0800
In-Reply-To: <17866.20355.744025.133326@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.444 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38986>



On Wed, 7 Feb 2007, Bill Lear wrote:
> 
> I thought that it would be very useful to have a history of git
> commands that have been run against a repo, in order to hopefully
> debug this sort of thing --- perhaps only those that modify the repo.

The "reflog" is kind of that, and you can literally do

	less .git/logs/refs/heads/master

to get some kind of idea what's up.

Newer gits enable reflogs by default, older gits don't (and *really* old 
git versions don't support it at all).

Of course, we should probably just have a

	git reflog show

command for this to make it prettier.

NOTE! It's very much per-repository. When you push out your changes, your 
reflog stays private.

			Linus
