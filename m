From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/5] difftool improvements
Date: Fri, 29 Mar 2013 11:28:31 +0000
Message-ID: <cover.1364555970.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 12:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULXUq-0007Rm-Fp
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 12:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab3C2L24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 07:28:56 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49730 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab3C2L2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 07:28:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9D0136064CA;
	Fri, 29 Mar 2013 11:28:54 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6rlx9A5-TwEl; Fri, 29 Mar 2013 11:28:53 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id E167B6064FF;
	Fri, 29 Mar 2013 11:28:41 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.411.g65a544e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219489>

This is a consolidated series replacing jk/t7800-modernize.  The patches
here have been rebased on master.

Patch 1 is new and moves the test added by commit 02c5631 (difftool
--dir-diff: symlink all files matching the working tree) to the end of
the test file.  This means that once this is applied the second patch
and the final three patches can become independent branches.

Patch 2 is a fix for a long standing deficiency, but the potential for
this to happen has been increased by the commit mentioned above.  It has
already been through a couple of iterations [1].

The final three patches are the same as the current jk/t7800-modernize,
with one tweaked commit message.

[1] http://article.gmane.org/gmane.comp.version-control.git/219100

John Keeping (5):
  t7800: move '--symlinks' specific test to the end
  difftool: don't overwrite modified files
  t7800: don't hide grep output
  t7800: fix tests when difftool uses --no-symlinks
  t7800: run --dir-diff tests with and without symlinks

 git-difftool.perl   |  73 +++++++++++++++++++++++++++++-------
 t/t7800-difftool.sh | 105 ++++++++++++++++++++++++++++++++++------------------
 2 files changed, 127 insertions(+), 51 deletions(-)

-- 
1.8.2.411.g65a544e
