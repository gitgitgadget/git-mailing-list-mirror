From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: After git svn clone master is tied to a branch in svn, howto
 set    master to trunk
Date: Wed, 11 Mar 2009 17:32:59 +0100
Message-ID: <49B7E7BB.2090803@drmicha.warpmail.net>
References: <09fb20f5-3722-49d4-9565-95a5b41d15ac@c36g2000yqn.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Svenn Are Bjerkem <svenn.bjerkem@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 17:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhROZ-0001dh-IT
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 17:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZCKQdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 12:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbZCKQdN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 12:33:13 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47414 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990AbZCKQdM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 12:33:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 587DB2EADF1;
	Wed, 11 Mar 2009 12:33:10 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 11 Mar 2009 12:33:10 -0400
X-Sasl-enc: jKTvEO6O+Km8zGnCiay3qS2eqAOOckTNDMOWC0xtPyas 1236789190
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B8929E2A8;
	Wed, 11 Mar 2009 12:33:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090311 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <09fb20f5-3722-49d4-9565-95a5b41d15ac@c36g2000yqn.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112954>

Svenn Are Bjerkem venit, vidit, dixit 11.03.2009 16:17:
> Hi,
> after performing a
> $> git svn clone https://svnserver/svn/a/b/c -T trunk/current -t tags -
> b branches
> I find that the git master has been tied to one of the branches. It
> turns out that the highest svn revision number in the repository was
> tied to that branch.
> 
> For historical reasons we have subdirectories in trunk/ on svn, but I
> inspected .git/config
> [svn-remote "svn"]
>         url = https://svnserver/svn
>         fetch = a/b/c/trunk/current:refs/remotes/trunk
>         branches = a/b/c/branches/*:refs/remotes/*
>         tags = a/b/c/tags/*:refs/remotes/tags/*
> And I assume it picked up the strange trunk correctly.
> 
> I have been googling around for a while looking for instructions how
> to tell git that when I check out "master" it should be "trunk" from
> svn and not "branches/next_gen", or more precisely how to move master
> to trunk from branches/next_gen.
> 
> I guess I could solve the problem by modifying a file in trunk on svn
> and commit so that the trunk will get the highest svn revision number
> again and redo the clone.

I'm not quite sure what you mean by master being "tied" to an svn
branch. You mean you want master to track the svn trunk? Then

git branch -D master
git checkout --track -b master trunk

should do (assuming you haven't worked on master yet).

Michael
