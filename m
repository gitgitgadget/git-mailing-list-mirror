From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Mon, 17 Dec 2007 23:32:28 +0100
Message-ID: <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
References: <20071217110322.GH14889@albany.tokkee.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Harl <sh@tokkee.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:33:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OWu-0001X1-2d
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbXLQWdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbXLQWdD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:33:03 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:37069 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbXLQWdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:33:01 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1J4OWB-0007Ig-7V; Mon, 17 Dec 2007 23:32:59 +0100
In-Reply-To: <20071217110322.GH14889@albany.tokkee.org>
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68641>

On Dec 17, 2007, at 12:03 PM, Sebastian Harl wrote:

> Hi,
>
> By default, git-stash (when called without any other arguments)  
> creates a new
> stash. This is quite different to the behavior of most other Git  
> commands
> (e.g. git-tag, git-branch, etc. do "list" by default). In order to  
> improve
> consistency git-stash should imho adopt this as well.
>
> The creation of a new stash should not do any harm. However, I  
> think that
> consistency is more important (iirc this has been mentioned in the  
> current
> survey a couple of times) and doing "list" is (in general) the best  
> default.


Hi Sebastian,
this topic has been brought up the ML several times already, and  
there seems to be some sort of consensus on the misbehavior of git  
stash and what the default should be (listing the stashes seems like  
a decent default action).  The current behavior of git stash is very  
dangerous as the following frequently happens to new comers:
   $ git stash
   $ <hack on something else>
   $ git commit
   $ git stash apply
   $ git stash clean # Oops, typo, I just stashed my changes again
   $ git stash clear # Oops, I just lost my changed

Hopefully, Git gives you means to recover from this sort of error,  
but most of the time new comers don't know them and just assume they  
lost their work.

Whenever I use git stash, it gives me chills, because I know I can  
easily screw things up (even though now I know how to recover from  
this sort of "user error").

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
