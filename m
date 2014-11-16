From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/2] Don't make $GIT_DIR executable
Date: Sun, 16 Nov 2014 08:21:46 +0100
Message-ID: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 08:22:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpuAB-0005sK-BU
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 08:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbaKPHWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Nov 2014 02:22:11 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51100 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752393AbaKPHWK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2014 02:22:10 -0500
X-AuditID: 1207440e-f79806d000000bb4-26-54685094288c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C6.66.02996.49058645; Sun, 16 Nov 2014 02:21:56 -0500 (EST)
Received: from michael.fritz.box (p4FC97A4A.dip0.t-ipconnect.de [79.201.122.74])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAG7Lrk6002608
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 16 Nov 2014 02:21:54 -0500
X-Mailer: git-send-email 2.1.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqDslICPE4PFyS4uuK91MFg29V5gt
	Fv47ym7xf8cCFovbK+YzW+xvSrJY072DyaKz4yujA4fH3/cfmDx2zrrL7nHsWCuzx8VLyh6f
	N8l53H62jcWjecp51gD2KG6bpMSSsuDM9Dx9uwTujG9ThAueclXcOBbZwHiNo4uRk0NCwESi
	69YPRghbTOLCvfVsILaQwGVGiQnTpLoYuYDsE0wSz3ZeYQJJsAnoSizqaQazRQTUJCa2HWIB
	KWIW2MYk8W3eP3aQhLCAmcSvqfdYQGwWAVWJVauXgm3gFXCRmNLexAaxTU5i7+TVLBBxQYmT
	M58A2RxAg9Ql1s8TAgkzC8hLNG+dzTyBkW8WkqpZCFWzkFQtYGRexSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRrrJebWaKXmlK6iRES3Hw7GNvXyxxiFOBgVOLh3WCRESLEmlhWXJl7iFGSg0lJ
	lDfUCSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHeNKVCONyWxsiq1KB8mJc3BoiTOq7ZE3U9I
	ID2xJDU7NbUgtQgmK8PBoSTBG+sP1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEP
	irn4YmDUgaR4gPZOBGnnLS5IzAWKQrSeYlSUEufNB0kIgCQySvPgxsJS1itGcaAvhXl3gVTx
	ANMdXPcroMFMQIMZj6WCDC5JREhJNTCWWdnP27w7U0dS7VzNZe/wG6/89ZsrH1ZPl2CNjnxe
	061n7bYwnnXpjxu2bRc22NUKrVwQeLtX9dhFdekMqSXb9wWaPpoY8S77n4jvu01r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1 [1]:

* Check the chmod() return result in create_default_files(), as
  suggested by Torsten B=C3=B6gershausen.

* Fix a comment typo found by Stefan Beller.

* Extend patch 2/2 to also clearing the executable bits when "git
  config --edit" is run.

* Add test cases to patch 2/2 that the executable bits really are
  cleaned up when they should be.

Thanks to Stefan Beller, Torsten B=C3=B6gershausen, and Eric Wong for t=
heir
feedback about v1.

I have also pushed this series to my GitHub fork [2].

Please remember that this patch series applies to maint. This version
has a couple of conflicts with master; I have pushed my proposed
conflict resolution to GitHub [3], including a preparatory commit that
I recommend for master.

[1] http://thread.gmane.org/gmane.comp.version-control.git/259620/focus=
=3D259620
[2] https://github.com/mhagger/git branch "config-non-executable"
[3] https://github.com/mhagger/git branch "config-non-executable-merge"

Michael Haggerty (2):
  create_default_files(): don't set u+x bit on $GIT_DIR/config
  config: clear the executable bits (if any) on $GIT_DIR/config

 builtin/config.c       | 21 ++++++++++++++++++---
 builtin/init-db.c      |  1 +
 config.c               | 12 ++++++++++--
 t/t1300-repo-config.sh | 13 +++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

--=20
2.1.1
