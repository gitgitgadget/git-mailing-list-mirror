From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: git-pull can't be used without URL - Has worked before
Date: Fri, 16 Mar 2007 12:52:15 +0100
Message-ID: <45FA84EF.3010103@lu.unisi.ch>
References: <6bb9c1030703160324u17d49b85s754ac8358f633bde@mail.gmail.com>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Pelle Svensson <pelle2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 12:53:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSAzb-0008M5-M0
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 12:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbXCPLwU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 07:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbXCPLwU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 07:52:20 -0400
Received: from server.usilu.net ([195.176.178.200]:28394 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965058AbXCPLwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 07:52:19 -0400
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Mar 2007 12:55:06 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <6bb9c1030703160324u17d49b85s754ac8358f633bde@mail.gmail.com>
X-OriginalArrivalTime: 16 Mar 2007 11:55:06.0343 (UTC) FILETIME=[F06DDF70:01C767C1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42351>


> I don't have .../.git/remotes directory in this setup??

For v1.5.0, git-clone sets up a remote repository so that
you can look at what's going on remotely like this:

  git log origin/next

To create your branch, you have to do something like

  git-checkout -b my-branch origin/next
  git-config add branch.my-branch.remote origin
  git-config add branch.my-branch.merge refs/heads/next

Note that the branch in the last command is the remote branch
name not the local name.

<shameless-advertisement-of-my-patches>
With the current git "master" branch, you are able to do
something like

  git-checkout --track -b my-branch origin/next

and git-pull (with no arguments) will automatically pull from
whatever branch you specified upon branch creation.  --track
also works with local branches, so you can have your topic
branches track the tip of your current development branch,
for example.
</shameless-advertisement-of-my-patches>

Paolo
