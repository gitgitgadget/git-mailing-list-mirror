From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCHv5 1/5] Scripts to install, delete and clear a MediaWiki
Date: Thu, 14 Jun 2012 10:57:20 +0200
Message-ID: <1339664243-31952-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Cc: Simon.Cathebras@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr, Charles.Roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 10:58:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf5sL-0000VL-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 10:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab2FNI5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 04:57:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59564 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294Ab2FNI5i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 04:57:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5E8vXd7030743
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 10:57:35 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sf5rx-0007My-DL; Thu, 14 Jun 2012 10:57:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sf5rx-0008K3-BG; Thu, 14 Jun 2012 10:57:33 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1339607025-22725-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 14 Jun 2012 10:57:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E8vXd7030743
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340269056.91937@l4GHKY+PH0nJR36nJcryNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199983>

The script didn't work for me. I first applied the patches below
(essentially style, but also a clearer error message). I get:

$ ./install-wiki.sh install
Instance already running. Restarting...                                                 
kill: 45: No such process

2012-06-14 10:53:21: (log.c.166) server started 
mediawiki-1.19.0.tar.gz downloaded in /tmp. You can delete it later if you want.
Generating the SQLite database file. It can take some time ...
Could not get page: http://localhost:1234/wiki/mw-config/index.php
Can't create database file in TODO. Try to run ./install-wiki.sh delete first.

Indeed:

$ ps -u moy | grep light
$ telnet localhost 1234 
Trying 127.0.0.1...
telnet: Unable to connect to remote host: Connection refused

Matthieu Moy (3):
  chmod -x test-gitmw-lib.sh
  Coding style
  Explicit error when curl_exec() fails

 contrib/mw-to-git/t/install-wiki/db_install.php | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
 mode change 100755 => 100644 contrib/mw-to-git/t/test-gitmw-lib.sh

-- 
1.7.11.rc0.57.g84a04c7
