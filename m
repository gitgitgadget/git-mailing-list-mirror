From: Stephen Kelly <steveire@gmail.com>
Subject: Additional remote on a local clone. Where do the objects go?
Date: Wed, 01 Sep 2010 09:12:59 +0200
Message-ID: <i5kudr$dp7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 09:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqhVW-00074d-CK
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 09:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab0IAHNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 03:13:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:47471 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab0IAHNM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 03:13:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OqhVN-00070P-N5
	for git@vger.kernel.org; Wed, 01 Sep 2010 09:13:09 +0200
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 09:13:09 +0200
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 09:13:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155020>

Hi,

I have done something like this :

git clone git://gitorious.org/qt/qt.git qtrepo
cd qtrepo
git checkout -b 4.7 origin/4.7
git checkout -b 4.6 origin/4.6
git clone qtrepo qt46
cd qt46 && git checkout -b 4.6 origin/4.6
cd ..
git clone qtrepo qt47
cd qt46 && git checkout -b 4.7 origin/4.7
cd ..

The aim is to have multiple local checkouts of different branches of Qt 
while sharing the same object store. However, it is inconvenient to have to 
pull in the qtrepo directory, then cd to the other two to get the changes.

It would be more convenient to be able to add the qt.git remote to the local 
clones, pull from it, and have the pulled objects shared in the same object 
store. Is that possible or is it what already happens? I will also want to 
add additional remotes for pushing changes to from the local clones.

All the best,

Steve.
