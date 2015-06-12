From: Philippe De Muyter <phdm@macq.eu>
Subject: strange result of `git describe` while bisecting
Date: Fri, 12 Jun 2015 15:00:27 +0200
Message-ID: <20150612130027.GA19711@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 15:00:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3OZZ-0005kk-KF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 15:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbbFLNAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 09:00:32 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:60300 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbbFLNAb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 09:00:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 58056130DA2
	for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:00:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfqj2OsEM8yP for <git@vger.kernel.org>;
	Fri, 12 Jun 2015 15:00:27 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id A1E41130BDE
	for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:00:27 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 7EBBDDF0729; Fri, 12 Jun 2015 15:00:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271484>

Hi,

I am bisecting the kernel tree between v3.17 and v3.18, and 'git describe'
is used by the kernel compilation process.  Why do I get a version
v3.17-rc7-1626-ga4b4a2b, that seems outside of [v3.17..v3.18] ?

To reproduce :

git bisect start
git bisect bad v3.18
git bisect good v3.17
Bisecting: 6197 revisions left to test after this (roughly 13 steps)
[754c780953397dd5ee5191b7b3ca67e09088ce7a] Merge branch 'for-v3.18' of git://git.linaro.org/people/mszyprowski/linux-dma-mapping

git describe
v3.17-6163-g754c780

git bisect bad
Bisecting: 3086 revisions left to test after this (roughly 12 steps)
[4a4743e840d06a5772be7c21110807165c5b3c9f] Merge tag 'fixes-nc-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc

git describe
v3.17-3076-g4a4743e

git bisect good
Bisecting: 1506 revisions left to test after this (roughly 11 steps)
[a4b4a2b7f98a45c71a906b1126cabea6446a9905] Merge tag 'master-2014-10-02' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-next

git describe
v3.17-rc7-1626-ga4b4a2b

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
