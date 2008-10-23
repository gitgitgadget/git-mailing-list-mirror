From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Tip: avoiding net overhead using git over sshfs
Date: Thu, 23 Oct 2008 10:32:34 +0200
Message-ID: <490036A2.20608@drmicha.warpmail.net>
References: <a2075f4c0810221826w511a3b87r6fea4fb0dee24e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Carvalho Oliveira <felipekde@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 10:34:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksvdj-0006xR-NP
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 10:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbYJWIcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 04:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYJWIcl
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 04:32:41 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59963 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751455AbYJWIci (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2008 04:32:38 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6ABD418060D;
	Thu, 23 Oct 2008 04:32:37 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 23 Oct 2008 04:32:37 -0400
X-Sasl-enc: 4aDWotRWzsv3XTTOFBNbzZbTmFy/5WcBiRseYiSlLfmY 1224750757
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BFC6D1C981;
	Thu, 23 Oct 2008 04:32:36 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <a2075f4c0810221826w511a3b87r6fea4fb0dee24e1f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98947>

Felipe Carvalho Oliveira venit, vidit, dixit 23.10.2008 03:26:
> Use git over sshfs is not so good, but is an option for people that
> don't have shell acess to the server/hosting like me.

I'm sorry but I'm afraid I'm missing the point: If you don't have shell
access then you can't use ssh(fs), can you?
Maybe you mean you can't set up git daemon or gitweb.cgi on the server?

> # mounting
> sshfs -o workaround=rename <user>@<host>:/home/<user>/  <mount_point>
> cd <the_directory_of_your_project>
> 
> # we will move the .git directory to the local filesystem
> mv .git ~/.my_project_git
> # and create a symlink to the local .git
> ln -s ~/.my_project_git .git
> 
> Done!
> 
> Now you can open gitk instantly ;-) and don't need to have the entire
> .git thing on a remote filesystem.

In fact your complete git repository is now on the local filesystem,
with only the worktree checked out on sshfs. Is that what you are trying
to achieve? Or do you want to "synchronize" repos on local and sshfs
filesystems?

Michael
