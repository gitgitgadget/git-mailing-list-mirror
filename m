From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/8] vcs-svn, svn-fe: add a couple of options
Date: Sun,  3 Jul 2011 23:57:49 +0600
Message-ID: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:56:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQuV-0001vs-Tv
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab1GCR4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:56:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62342 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab1GCR4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:41 -0400
Received: by bwd5 with SMTP id 5so3614734bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QD6BNNIID4OW2GFJ3FNaSxMPXuJlDU6fh3h6TmNMpPY=;
        b=MdkLG+kmN3wgUPatwZNPfxDQzH8HRXarE+TxHZes35yK7vDRyvroXj/xNFvfLEkM8G
         kTaPGUjUGEWZKjY9LV4dzhz7EVPI0RxZkgXsOZuI8OOL9RT2WkecYEvETIboieAOznCa
         jkgDgCX18I/eX58skAE79Ea0BgwefDu/+RT7k=
Received: by 10.204.41.206 with SMTP id p14mr4649881bke.53.1309715799858;
        Sun, 03 Jul 2011 10:56:39 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176578>

This patch set adds a few options for svn-fe that can be used in
a svn remote helper and useful in general for vcs-svn/. The last
three patches add the options, others prepare the ground for them.

The patch base is svn-fe branch at git://repo.or.cz/git/jrn.git

Dmitry Ivankov (8):
  vcs-svn: move url parameter from _read to _init
  svn-fe: add man target to Makefile
  svn-fe: add EXTLIBS needed for parse-options
  svn-fe: add usage and unpositional arguments versions
  test-svn-fe: use parse-options
  vcs-svn: allow to specify dump destination ref
  vcs-svn: convert REPORT_FILENO to an option
  vcs-svn: allow to disable 'progress' lines

 contrib/svn-fe/Makefile   |   18 ++++----
 contrib/svn-fe/svn-fe.c   |   42 +++++++++++++++++--
 contrib/svn-fe/svn-fe.txt |   29 +++++++++++--
 t/t9010-svn-fe.sh         |   99 +++++++++++++++++++++++++++++++++++++--------
 test-svn-fe.c             |   50 ++++++++++++++++-------
 vcs-svn/fast_export.c     |   13 +++++-
 vcs-svn/fast_export.h     |    2 +-
 vcs-svn/svndump.c         |   11 ++---
 vcs-svn/svndump.h         |    4 +-
 9 files changed, 205 insertions(+), 63 deletions(-)

-- 
1.7.3.4
