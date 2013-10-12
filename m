From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/5] remote-helpers: test reorganization
Date: Sat, 12 Oct 2013 02:04:20 -0500
Message-ID: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:10:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLL-0003ah-3T
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab3JLHK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:10:27 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:47901 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3JLHK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:26 -0400
Received: by mail-oa0-f45.google.com with SMTP id i4so255445oah.4
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NzHQL3cTShX8VmMmrhg96QxSGxJZ8ui3Dj2upFpi8zA=;
        b=OvcruRrEyibKdlUtH3WIMGnOXSvcnCanGC06N9ZXykDURr8ZHcl+KvPNhlawdU4Guj
         5BK1Stvs5ech07hfioNiFwojjY6px5qYEbz/Q9cjig0J0Be4oXF/g3fmPKYMtrAEyoAC
         a2UM96iJjfQczJmfn1xsyofTxVIY16XHeyW9MAoU3d39UrSaeKbITwh36fBG2K93vCZ0
         PPVK+ulQAiXpb40KgBhHixZHXHRnKsHBTx2s7+Mf/9qnFPOOGX9bR59WrARcH7bOfazT
         dwGNnY3xUt1MEkD79tzIkQp3E4guYABlDKo32702DUvJfr8wwIkqpBC7ST2083brAUDP
         HvmA==
X-Received: by 10.60.43.131 with SMTP id w3mr17904974oel.10.1381561826352;
        Sat, 12 Oct 2013 00:10:26 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm101360195oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235956>

Now we use PYTHON_PATH properly, and also we are able to do:

  make -C contrib/remote-helpers install

Felipe Contreras (5):
  remote-helpers: generate scripts
  build: fix installation of scripts
  remote-helpers: rename tests
  remote-helpers: allow direct test execution
  remote-helpers: add exec-path links

 Makefile                                 |   10 +-
 contrib/remote-helpers/.gitignore        |    2 +
 contrib/remote-helpers/Makefile          |   27 +-
 contrib/remote-helpers/git-remote-bzr    |  960 -----------------------
 contrib/remote-helpers/git-remote-bzr.py |  960 +++++++++++++++++++++++
 contrib/remote-helpers/git-remote-hg     | 1220 ------------------------------
 contrib/remote-helpers/git-remote-hg.py  | 1220 ++++++++++++++++++++++++++++++
 contrib/remote-helpers/test-bzr.sh       |  361 ---------
 contrib/remote-helpers/test-bzr.t        |  362 +++++++++
 contrib/remote-helpers/test-hg-bidi.sh   |  240 ------
 contrib/remote-helpers/test-hg-bidi.t    |  241 ++++++
 contrib/remote-helpers/test-hg-hg-git.sh |  527 -------------
 contrib/remote-helpers/test-hg-hg-git.t  |  528 +++++++++++++
 contrib/remote-helpers/test-hg.sh        |  692 -----------------
 contrib/remote-helpers/test-hg.t         |  693 +++++++++++++++++
 15 files changed, 4034 insertions(+), 4009 deletions(-)
 create mode 100644 contrib/remote-helpers/.gitignore
 delete mode 100755 contrib/remote-helpers/git-remote-bzr
 create mode 100755 contrib/remote-helpers/git-remote-bzr.py
 delete mode 100755 contrib/remote-helpers/git-remote-hg
 create mode 100755 contrib/remote-helpers/git-remote-hg.py
 delete mode 100755 contrib/remote-helpers/test-bzr.sh
 create mode 100755 contrib/remote-helpers/test-bzr.t
 delete mode 100755 contrib/remote-helpers/test-hg-bidi.sh
 create mode 100755 contrib/remote-helpers/test-hg-bidi.t
 delete mode 100755 contrib/remote-helpers/test-hg-hg-git.sh
 create mode 100755 contrib/remote-helpers/test-hg-hg-git.t
 delete mode 100755 contrib/remote-helpers/test-hg.sh
 create mode 100755 contrib/remote-helpers/test-hg.t

-- 
1.8.4-fc
