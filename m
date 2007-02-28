From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: bug report, error : Unable to find 000000000.....
Date: Wed, 28 Feb 2007 22:09:33 +0100
Message-ID: <slrneubrsd.2pm.siprbaum@xp.machine.xx>
References: <BAY120-W200B9984A9E70409399666AE810@phx.gbl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 22:06:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMW0j-0000J8-3T
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 22:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXB1VGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 16:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXB1VGv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 16:06:51 -0500
Received: from main.gmane.org ([80.91.229.2]:52269 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbXB1VGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 16:06:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HMW0V-0007SY-LK
	for git@vger.kernel.org; Wed, 28 Feb 2007 22:06:39 +0100
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 22:06:39 +0100
Received: from siprbaum by magnum.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 22:06:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: magnum.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41006>

Jeremy Sw <kertejeremy@hotmail.com> schrieb:
>
> By running  # git clone http://intellinuxwireless.org/repos/ipwraw.git
> git return an error when trying to Get alternates list.
> the error is :
> "error: Unable to find 0000000000000000000000000000000000000000 under http://intellinuxwireless.org/repos/ipwraw.git/
> Cannot obtain needed object 0000000000000000000000000000000000000000"
> apparently caused by a weird architecture of the tree !
> there is 4 or 5 diffrents projects, but they have commun files because firmwares are related !

I suggested on IRC to try this (I reproduced the error)

mkdir test && cd test && \
git-init && \
git fetch http://intellinuxwireless.org/repos/ipwraw.git master:master

and it works. Ok, fist I thought the error is in another branch, but

git-ls-remote http://intellinuxwireless.org/repos/ipwraw.git
7e85b2032a864fcfe489085b768eea4b3a3a9d0b        refs/heads/master
7e85b2032a864fcfe489085b768eea4b3a3a9d0b        refs/heads/origin
7e85b2032a864fcfe489085b768eea4b3a3a9d0b        refs/tags/ipwraw-0.0.1
7e85b2032a864fcfe489085b768eea4b3a3a9d0b        refs/tags/ipwraw-0.0.2

there is no other branch, at least as I could see.

-Peter
