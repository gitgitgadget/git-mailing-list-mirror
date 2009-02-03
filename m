From: Tommi Virtanen <tv@eagain.net>
Subject: Re: is gitosis secure?
Date: Tue, 3 Feb 2009 13:41:43 -0800
Message-ID: <20090203214143.GB1970@eagain.net>
References: <200812090956.48613.thomas@koch.ro> <1228813620.18611.41.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Koch <thomas@koch.ro>,
	Git Mailing List <git@vger.kernel.org>, dabe@ymc.ch
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUT32-0005G4-Cy
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 22:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZBCVlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZBCVlq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 16:41:46 -0500
Received: from eagain.net ([208.78.102.120]:54267 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbZBCVlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 16:41:45 -0500
Received: from musti.eagain.net (unknown [69.84.6.92])
	by eagain.net (Postfix) with ESMTPS id 55EE256602;
	Tue,  3 Feb 2009 21:41:45 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id C9B61870013; Tue,  3 Feb 2009 13:41:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1228813620.18611.41.camel@starfruit.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108254>

On Tue, Dec 09, 2008 at 01:07:00AM -0800, R. Tyler Ballance wrote:
> Accounts set up with keys for Gitosis are given restricted accounts
> (from my understanding similar to how CVS or SVN operate over SSH
> tunnels).

I don't think I've ever seen a CVS used with "virtual"
restricted-shell accounts.

The svnserve --tunnel-user= support for that mode of operation was
written by me, and is basically exactly the same trick as the one used
by gitosis.

Before gitosis, I had my old SVN setup pretty much reproduced with
git, but then I got bored administering it and wrote gitosis to
automate account and access management.


I am not aware of anyone ever finding a way to get around an svnserve
--tunnel-user= setup. I'm not losing my sleep over the security of
this concept.

Use an SSH gateway if you want tighter control on who gets where,
network-wise. Then you won't get non-git login attempts from the
external net.

Or run an extra SSH service, e.g. using Conch. As long as it respects
~ssh and is interoperable with OpenSSH, gitosis should work just fine.
It can even run as the git user 100% of the time.

-- 
:(){ :|:&};:
