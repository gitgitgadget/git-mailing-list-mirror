From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 14:13:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
References: <17866.27739.701406.722074@lisa.zopyra.com>
 <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
 <17867.40122.51865.575762@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHWe-00051X-0o
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423417AbXBHWNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423433AbXBHWNx
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:13:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42219 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423417AbXBHWNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:13:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l18MDn3O003371
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Feb 2007 14:13:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l18MDlHo028308;
	Thu, 8 Feb 2007 14:13:48 -0800
In-Reply-To: <17867.40122.51865.575762@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.438 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.115__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39105>



On Thu, 8 Feb 2007, Bill Lear wrote:
> 
> However, I still have a few open issues with the other branch of this
> discussion, i.e., why can we not have an update operation that
> respects branches in the first place, as 'git pull' seems to do, when
> run from the master branch?

Actually, git does that all correctly for other branches too, but only in 
git-1.5.

It's one of the bigger UI warts that got fixed since the last release 
(although it got fixed by better config management, and as such you'll 
only *see* the fixes if you end up doing the initial clone with the new 
git version - if you use a new git version with an old repo, many - but 
not all - bad semantics will remain).

Considering how stable the -rc kernels are (and actually, git "master" in 
general), there's really very little reason to wait for the real release. 
Junio has been very careful, and I think a lot of the delay in 1.5 has 
been about trying to get all the new stuff that changes semantics subtly 
in before the release, so that Junio will not have to do any real user- 
visible changes later.

So it might be worth while trying out git-1.5.0-rc4, and seeing if that 
solves some of the UI issues for you guys. It changes things like where 
the default remote branches are, and makes the distinction between "my 
local copy of branch X" and "the remote branch X" much clearer, which has 
clearly been a UI problem.

			Linus
