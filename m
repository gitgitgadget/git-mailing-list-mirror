From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Wed, 8 Feb 2006 17:21:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602081719250.2458@g5.osdl.org>
References: <87slqtcr2f.wl%cworth@cworth.org> <Pine.LNX.4.64.0602081643570.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 02:22:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F70Va-0007UE-Ff
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 02:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWBIBWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 20:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbWBIBWA
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 20:22:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422755AbWBIBV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 20:21:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k191LrDZ027513
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 17:21:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k191LnPq022773;
	Wed, 8 Feb 2006 17:21:51 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <Pine.LNX.4.64.0602081643570.2458@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15779>



On Wed, 8 Feb 2006, Linus Torvalds wrote:
> 
> The largest reason for why "git diff" defaults to diffing against the 
> index (and not head) is _literally_ that it's faster. Yes, I'm ashamed, 
> but "git diff HEAD" takes 0.35 seconds for me, and "git diff" takes 0.07
> seconds, and largely based entirely on that (and not "what would users 
> want"), I made the bad choice to default to git-diff-files for the "no 
> arguments" case.
> 
> I hang my head in shame. I just like the _instantness_ of "nothing 
> changed". That's a bad reason for choice of interfaces, though.

Btw, it was kind of luck (but it's definitely true) that the current "git 
diff" semantics happen to also be what you do want during merges when you 
try to resolve a conflict (while "git diff HEAD" is much less useful).

So making "git diff" default to diffing against HEAD is actually the wrong 
thing to do during merging, where the current behaviour is exactly what 
you'd want.

So I dunno. 

		Linus
