From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-push: creating branch on remote, refspec format
Date: Thu, 26 Feb 2009 13:08:29 +0100
Message-ID: <49A6863D.9000900@drmicha.warpmail.net>
References: <go609m$3dj$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lasse Kliemann <lasse-gmane-git-2009@mail.plastictree.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 13:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcf43-0004cD-9A
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 13:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbZBZMIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 07:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbZBZMIk
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 07:08:40 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50708 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754325AbZBZMIj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 07:08:39 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6A1CF2A4EBB;
	Thu, 26 Feb 2009 07:08:37 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 26 Feb 2009 07:08:37 -0500
X-Sasl-enc: sDIEHDD+0bW33yRjL424JpZHq9/xVT2h7LY7bNclXivJ 1235650117
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C43311FA69;
	Thu, 26 Feb 2009 07:08:36 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090226 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <go609m$3dj$2@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111557>

Lasse Kliemann venit, vidit, dixit 26.02.2009 13:00:
> http://www.kernel.org/pub/software/scm/git/docs/git-push.html reads:
> 
> | git push origin master:refs/heads/experimental
> | 
> |   Create the branch experimental in the origin repository by copying the 
> |   current master branch. This form is only needed to create a new branch or 
> |   tag in the remote repository when the local name and the remote name are 
> |   different; otherwise, the ref name on its own will work.
> 
> It appears to me that the ref name on its own will also work to create a new 
> branch, at least with local repositories:
> 
> $ (mkdir a && cd a && git init)
> Initialized empty Git repository in /tmp/a/.git/
> $ mkdir b && cd b && git init
> Initialized empty Git repository in /tmp/b/.git/
> $ pwd
> /tmp/b
> $ touch x && git add x && git commit 
> [master (root-commit)]: created 87a90f5: "NA"
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 x
> 
> Now the push from '/tmp/b' to '/tmp/a':
> 
> $ git push /tmp/a master:foo
> Counting objects: 3, done.
> Writing objects: 100% (3/3), 209 bytes, done.
> Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> To /tmp/a
>  * [new branch]      master -> foo
> 
> Am I missing something?
> 

You're using the very same form as the doc. "This form" in the doc
refers to "repo refspec", i.e. something like "a b:c", which is what you
use. The "refs/heads/" part is just there to disambiguate between
possible different matches on the remote side (refs/heads/foo,
refs/tags/foo, refs/remotes/bar/foo, ...).

Michael
