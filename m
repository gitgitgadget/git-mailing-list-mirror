From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 16:27:28 +0100
Organization: At home
Message-ID: <ep00nl$mop$1@sea.gmane.org>
References: <17843.29798.866272.414435@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jan 21 16:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8ebD-0004tZ-J2
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 16:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbXAUP1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 10:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbXAUP1I
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 10:27:08 -0500
Received: from main.gmane.org ([80.91.229.2]:42693 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbXAUP1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 10:27:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H8eat-0002eh-1a
	for git@vger.kernel.org; Sun, 21 Jan 2007 16:26:55 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 16:26:55 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 16:26:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37330>

[Cc: git@vger.kernel.org]

Bill Lear wrote:

> We have a secure network in which we run all of our git-supported
> development activities.  We would like to be able to do git-push
> through the git protocol.  Reasons: 1) it seems more efficient; 2) we
> have run into problems with developers having different umasks ---
> when run through ssh, we ran into file permissions problems and
> instead of tracking down each umask issue the developer has (and,
> frankly, not wanting to change their default), we resorted to fixing
> up the permissions inside of the update hook (chmod -R ug+w, I think);
> 3) we would prefer a single protocol instead of sometimes pulling with
> git and pushing with ssh.
> 
> It seems there should be a way to configure a repo or the git daemon
> to say "Allow push operations".
> 
> I looked through the release notes Junio posted for 1.5.0-rc2, but
> found no reference to the git daemon.

git:// protocol is not authenticated. git by design allow push only through
authenticated protocols, i.e. local, ssh:// (git+ssh://), http(s):// with
WebDAV, probably in the future ftps://. 

rsync:// (deprecated) and git:// are fetch only (read-only) protocols.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
