From: Tvangeste <i.4m.l33t@yandex.ru>
Subject: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 15:14:08 +0200
Message-ID: <17231378818848@web5m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 15:20:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJNry-0003mp-PC
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 15:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab3IJNUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 09:20:35 -0400
Received: from forward9.mail.yandex.net ([77.88.61.48]:48641 "EHLO
	forward9.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab3IJNUe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 09:20:34 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2013 09:20:34 EDT
Received: from web5m.yandex.ru (web5m.yandex.ru [37.140.138.96])
	by forward9.mail.yandex.net (Yandex) with ESMTP id 70555CE0DB8
	for <git@vger.kernel.org>; Tue, 10 Sep 2013 17:14:09 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web5m.yandex.ru (Yandex) with ESMTP id 28BCE2C60092;
	Tue, 10 Sep 2013 17:14:08 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1378818849; bh=WK9R/NQWnvT2kkkbBVOoEsxDCW01GQpyNlV8NOo1nfs=;
	h=From:To:Subject:Date;
	b=ic8BKFqs/5uca+dc4QcZtKX6j//00Z2iGG4HSUzbx4tbJySqVbrWQXZg2m2Yn40H3
	 HXVzEwvCgVOsJe3ZxB/NFFkkayLOa/BQfiDIe+OZQNwfT1ECclhZ6pC0T8vGNkOvb2
	 lfxrUr2KM3+Rsjrxdp4Qx231yGUiytIsDREYil54=
Received: from agsb-5d87fcb4.pool.mediaWays.net (agsb-5d87fcb4.pool.mediaWays.net [93.135.252.180]) by web5m.yandex.ru with HTTP;
	Tue, 10 Sep 2013 17:14:08 +0400
Envelope-From: i-4m-l33t@yandex.ru
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234434>

Hi,

After bisecting this problem I ended up with the mentioned commit that completely breaks git-svn for me on Windows (mingw/msys version).

==========
#> git svn rebase
warning: unable to access '': Invalid argument
warning: unable to access '': Invalid argument
fatal: unable to access '../../../../w:/work/my/repo.git/.git/config': Invalid argument
fatal: index file open failed: Invalid argument
Cannot rebase: You have unstaged changes.
Please commit or stash them.
rebase refs/remotes/trunk: command returned error: 1
==========

Please note that I use the official git repository as-is, this one (no additional patches):
git://git.kernel.org/pub/scm/git/git.git

e02ca72f70ed8f0268a81f72cb3230c72e538e77 is the first bad commit
commit e02ca72f70ed8f0268a81f72cb3230c72e538e77
Author: Jiang Xin
Date:   Tue Jun 25 23:53:43 2013 +0800

    path.c: refactor relative_path(), not only strip prefix

Thanks,
  --Tvangeste
