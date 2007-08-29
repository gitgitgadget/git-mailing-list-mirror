From: Michel Marti <mma@objectxp.com>
Subject: Mixing cherry-pick and merge
Date: Wed, 29 Aug 2007 14:05:55 +0200
Message-ID: <46D56123.4030307@objectxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 14:37:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQMnM-00077K-0L
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 14:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbXH2MhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 08:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755259AbXH2MhI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 08:37:08 -0400
Received: from automatix.objectxp.com ([62.2.156.210]:47396 "EHLO
	automatix.objectxp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbXH2MhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 08:37:07 -0400
X-Greylist: delayed 1869 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2007 08:37:06 EDT
Received: from [192.168.0.56] (max.office.objectxp.com [192.168.0.56])
	by automatix.objectxp.com (Postfix) with ESMTP id 7757658011EB
	for <git@vger.kernel.org>; Wed, 29 Aug 2007 14:05:55 +0200 (CEST)
User-Agent: Icedove 1.5.0.12 (X11/20070730)
X-Enigmail-Version: 0.94.2.0
OpenPGP: id=F3EACEBF
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56939>

I just merged from a branch from which I previously cherry-picked some commits and now the
log contains the already cherry-picked commits twice (which is rather confusing). Is this
a bug or a feature?

Steps to reproduce:

mkdir foo && cd foo
git init
echo 123 >file
git add file
git commit -m "init"
git checkout -b branch
echo 321 >file
git commit -a -m "commit from branch"
=> Created commit 531fa08: commit from branch
git checkout master
git cherry-pick 531fa08
git merge branch
git-log --pretty=oneline
e5e8011c1ab7c9b8509604d27327b29fd1f7003a Merge branch 'branch'
ad91b39e433228809eb3cd6281cb686bf4871da0 commit from branch
531fa081d93249288efb70e9e8204e4ed9d70099 commit from branch
bc0a5bca29620eccd5b75e473d102317d8ce29f7 init
