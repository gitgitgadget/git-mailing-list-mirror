From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 10:26:43 -0800
Message-ID: <1AD9B065-647B-4672-B6B0-8D4447960913@midwinter.com>
References: <20071120155922.GA6271@pvv.org> <Pine.LNX.4.64.0711201226320.32410@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXoy-0001ne-CX
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761583AbXKTS0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761577AbXKTS0q
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:26:46 -0500
Received: from tater.midwinter.com ([216.32.86.90]:33391 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761569AbXKTS0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:26:45 -0500
Received: (qmail 15820 invoked from network); 20 Nov 2007 18:26:44 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Kq21Kg73z1A82cTiC72dyaGO6tUD8WBEmaY4E2uQ57CVAs8cDdOk8W412ilstiAX  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 20 Nov 2007 18:26:44 -0000
In-Reply-To: <Pine.LNX.4.64.0711201226320.32410@iabervon.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65560>

On Nov 20, 2007, at 10:03 AM, Daniel Barkalow wrote:
> This has theoretical problems: it's going to be practically  
> impossible, in
> most cases, to write a commit message that describes changes in three
> submodules (which are sometimes used in the context of a different
> supermodule) as well as the supermodule.

I got the impression from his email that there *are* no other  
supermodules. The submodules are submodules purely to reduce the  
amount of data people have to transfer around, not because they're  
logically distinct from the parent.

Something like "Fix bug #10391 by closing the data file before  
launching the GUI" or something like that would be just as valid a  
commit comment in the submodules here as it would be in the  
supermodules.

Sounds like what he wants is actually partial checkout, but since git  
doesn't (yet) support that, he's emulating it as best he can using  
submodules.

> I think it should be possible and sufficient to have "git commit"  
> able to
> recursively start a "git commit" in submodules (where you'd write a
> separate message suitable for exposure to other supermodules), so  
> you'd
> have to write 4 messages but only type one command line.

If the message in the submodule defaulted to the one from the  
supermodule, and there was a way to just accept it without popping up  
an editor N times, this might solve his problem.

-Steve
