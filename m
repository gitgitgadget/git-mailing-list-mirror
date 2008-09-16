From: Marc Weber <marco-oweber@gmx.de>
Subject: You don't exist, Go away! although user.name has been set
Date: Tue, 16 Sep 2008 03:05:29 +0200
Message-ID: <20080916010529.GB22597@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 03:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfP1d-0007kL-SY
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 03:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbYIPBFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 21:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbYIPBFd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 21:05:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:34527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753214AbYIPBFc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 21:05:32 -0400
Received: (qmail invoked by alias); 16 Sep 2008 01:05:29 -0000
Received: from pD9E0A481.dip.t-dialin.net (EHLO nixos) [217.224.164.129]
  by mail.gmx.net (mp026) with SMTP; 16 Sep 2008 03:05:29 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+Cp7NezACCw1BFEpLRaZwEv0qKLg9EIirUQl1bE/
	bevv+Ldaxx7Tzo
Received: by nixos (sSMTP sendmail emulation); Tue, 16 Sep 2008 03:05:29 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95966>

Today I was glad. I 've been able to compile git on a maanged server.
git clone did work as well however running
git fetch <remote location> caused the line
      die("You don't exist. Go away!");

to be executed. (the first one)

Before examining that I asked at #git and got the tip to set
user.name and user.email which I did. Then I verified that git
git var GIT_AUTHOR_IDENT and 
git var GIT_COMMITTER_IDENT
both printed some values.

I still got the failure above.
I've fixed it for my case by setting
git_default_name and git_default_email just before the check within the
ident.c file (line 76)..

However I want to ask wether I've hit a known problem and wether you
would appreciate me debggung this issue any further?

Maybe I should add that I've been running that git from the build
directory if that matters. The version is 1.6.0 from the official
mirror site.

Marc Weber
