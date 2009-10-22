From: =?UTF-8?B?R3LDqWdvcnkgUm9tw6k=?= <gregory.rome@maxim-ic.com>
Subject: git bisect Vs branch
Date: Thu, 22 Oct 2009 17:48:59 +0200
Organization: Maxim Integrated Products
Message-ID: <4AE07EEB.2010101@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 18:30:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N10Y4-0000r3-F2
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 18:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbZJVQ3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 12:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbZJVQ3u
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 12:29:50 -0400
Received: from smtp-out04.msg.oleane.net ([62.161.7.2]:43844 "EHLO
	smtp-out04.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbZJVQ3t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 12:29:49 -0400
X-Greylist: delayed 1221 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Oct 2009 12:29:49 EDT
Received: from smtp01.msg.oleane.net (smtp01.mail.priv [172.17.20.110]) 
	by smtp-out04.msg.oleane.net with ESMTP id n9MG9V5n021490
	for <git@vger.kernel.org>; Thu, 22 Oct 2009 18:09:31 +0200
Received: from zebulon.innova-card.com (6-61.252-81.static-ip.oleane.fr [81.252.61.6]) (authenticated)
	by smtp01.msg.oleane.net (MTA) with ESMTP id n9MFn0ZR028058
	for <git@vger.kernel.org>; Thu, 22 Oct 2009 17:49:00 +0200
X-Oleane-Rep: REPA
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits))
	for git@vger.kernel.org;
	Thu, 22 Oct 2009 17:48:59 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Spam-Flag: NO
X-PMX-Spam: Probability=10%
X-PFSI-Info: PMX 5.5.5.374460, Antispam-Engine: 2.7.1.369594, Antispam-Data: 2009.10.22.152419 (no antivirus check)
X-Orange-Auth: dG9zbXRwQGZyLm9sZWFuZS5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131030>

Considering the following story what is the method to find the=20
regression with bisect?

I cloned a git repository (origin) which derives from another one=20
(first-origin). A merge is done from first-origin to origin at each=20
stable release (identified by a tag).

first-origin/master  *---A---------B-----------------------C-
                          \         \                       \    =20
origin/master              ----------B'----------U-----------C'-
                                      \           \           \  =20
master                                 ------------U'----------C''-

Now, after that I merged C' I fixed the conflicts and compiled without=20
error but I have a regression. It could come from any commit between B=20
and C or U and C', and I need to modify my code to correct the issue.

I would like to find the commit which introduce this regression by usin=
g=20
git bisect but as the history is not linear it is not so easy (1). It=20
though to create a linear history but I have no idea how to proceed...

Thanks,
Gr=C3=A9gory

(1)=20
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#bisect=
-merges
