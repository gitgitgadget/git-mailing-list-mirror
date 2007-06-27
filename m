From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn error "Unable to extract revision information from commit
 ...~1"
Date: Wed, 27 Jun 2007 13:25:43 -0700
Message-ID: <4682C7C7.7050603@midwinter.com>
References: <1182884957.16012.31.camel@omicron.ep.petrobras.com.br>	 <4681C27B.8040009@midwinter.com>	 <1182947236.21320.3.camel@omicron.ep.petrobras.com.br>	 <468296DE.7000704@midwinter.com> <e2a1d0aa0706271031n3191a27fi41ca5ba3f14c3a51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'git' <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 22:26:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3e5Q-00021p-PW
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 22:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbXF0UZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 16:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754644AbXF0UZq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 16:25:46 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:45266
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1755417AbXF0UZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 16:25:44 -0400
Received: (qmail 7614 invoked from network); 27 Jun 2007 20:25:43 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Ssh9FLu+wuEmsqXVBwu4Y/zohyTUl2K+X3oHNpnE6tbAVEhOMjqH/y87EGReg+vp  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 27 Jun 2007 20:25:43 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <e2a1d0aa0706271031n3191a27fi41ca5ba3f14c3a51@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51064>

Patrick Doyle wrote:
> Wouldn't the svn head be called "git-svn"?
> Should the first checkout be written as:
>
> git checkout -b tempbranch git-svn
>
> (In other words, were the "trunk" and "tempbranch" arguments swapped
> in your example?)

Yes, sorry, I swapped the arguments. Should indeed be "git checkout -b 
(your new branch name) (svn head branch name)" rather than the other way 
around. My apologies for not proofreading my message.

However, the name of the svn head branch depends on the version of 
git-svn you're using, and how you cloned the svn repository. If you used 
the -T/--trunk option, then the svn head branch will indeed be called 
"trunk" (and you might also have other branches corresponding to 
whatever branches you're tracking in the svn repository.) If you're not 
using that option, then your svn tracking branch will be called 
"git-svn" or "origin" depending on your git-svn version.

> Finally, what is the purpose of creating a new branch as part of that 
> command?

You never ever want to work directly on the git-svn tracking branch. It 
is considered a remote branch and while it is technically possible to 
check it out and commit to it, you will almost certainly confuse git-svn 
if you do.

Also, creating a new branch means you still have your original nonlinear 
history easily accessible if you need it (just check out your old 
branch.) You can certainly still get at the old history without creating 
a new branch, but it's more awkward.

-Steve
