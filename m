From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [BUG] git-branch -m cannot rename remote branches
Date: Mon, 09 Jun 2008 14:53:29 +0200
Message-ID: <484D27C9.4000102@free.fr>
References: <200806082257.20833.jnareb@gmail.com> <alpine.DEB.1.00.0806082357470.1783@racer> <200806090906.51937.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 14:56:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5gtI-00054F-0d
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 14:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758556AbYFIMxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 08:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbYFIMxN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 08:53:13 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:37495 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756713AbYFIMxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 08:53:12 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 97BF912B6EB;
	Mon,  9 Jun 2008 14:53:11 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 64C9212B6B3;
	Mon,  9 Jun 2008 14:53:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <200806090906.51937.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84380>

Jakub Narebski a =E9crit :
>=20
> What I really wanted was "git remote rename <old-name> <new-name>",
> together with renaming branches and moving reflogs.  I can do first
> part by editing config file ("git remote rename"/"git remote mv"
> probably would want to assume that user wants to move branches if
> they follow remotes/<old-name>/* calling convention; ask user if it
> is not the case?).  I thought that I could use "git branch -m" for
> the other... I was left with editing packed-refs file (BTW. is leavin=
g
> empty directory 'xx' when packing 'xx/name' branch by design?) and
> moving reflog by hand.
>=20

You can use "git update-ref" for that. Maybe something like that:

$ git update-ref <newref> <oldref>
$ git update-ref -d <oldref> <newref>

Olivier.
