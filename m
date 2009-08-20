From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: question concerning branches
Date: Thu, 20 Aug 2009 15:47:31 +0200
Message-ID: <4A8D53F3.3050500@viscovery.net>
References: <alpine.LFD.2.01.0908191441070.3158@localhost.localdomain> <4a8d4583@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Ingo Brueckl <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81C-0007ZS-Rp
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbZHTNrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 09:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbZHTNrk
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55154 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbZHTNrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Me7zH-0002GB-J8; Thu, 20 Aug 2009 15:47:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 45F74735; Thu, 20 Aug 2009 15:47:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4a8d4583@wupperonline.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126625>

[Please don't cull the Cc list.]

Ingo Brueckl schrieb:
> On the one hand, I want to add single new features (such as other developers
> do) which will be written, tested and committed. I want to push/pull
> frequently to be up to date all the time. (master branch)

If you want to stay up-to-date while you are creating a new feature, then
your workflow is sub-optimal. This message by Linus is good to read:

http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg39091.html

The important rule is "Don't merge upstream code at random points".

Once you learnt this rule, then you also see that it is not important to
always stay up-to-date. It is important to complete (test, debug) your
feature on a stable base. During that time, you don't care about upstream;
you care about your feature.

> In a branch, I learned, I have to commit or stash before I return to master
> for push/pull to follow the project. If I forget, I'm screwed, because files
> have changed due to the rewrite (in that branch), I won't get a warning until
> my first commit (in that branch) and commits (in master) will conflict.

You are obviously of a CVS or SVN mindset, where making a commit is such
an important operation that you don't dare to make it until your work is
*completed*.

With a git mindset, it won't happen that you "forget" whether you have
anything uncommitted; you simply never have because committing half-baked
stuff is the rule, not the exception. That is, before you get a cup of
coffee, you commit; before you answer a phone call, you commit; before you
turn your attention away, you commit. (That may be exaggerated, perhaps it
even isn't, but you get the point.)

When you have completed your work, you go back to make your commit history
look nice, comprehensible, and bisectable.

And only then comes the heavy operation: You publish your work for
consumption by interested parties. This may be even only you yourself:
"Consumption" would be to merge the work into your release branch. This is
the right time to care about upstream again.

-- Hannes
