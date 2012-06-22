From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/3] git credential plumbing command: implementation and use
Date: Fri, 22 Jun 2012 18:07:08 +0200
Message-ID: <1340381231-9522-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 22 18:09:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si6QR-0002br-G8
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 18:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab2FVQJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 12:09:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43449 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730Ab2FVQJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 12:09:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5MG6tJO007512
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 18:06:55 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Si6OJ-0004vI-8X; Fri, 22 Jun 2012 18:07:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Si6OJ-0002UF-7K; Fri, 22 Jun 2012 18:07:23 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 Jun 2012 18:06:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5MG6tJO007512
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340986021.52784@UF5OBBH4FJ2919Nv6oEQfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200442>

This is a rework of an earlier patch serie:

  http://thread.gmane.org/gmane.comp.version-control.git/199794/focus=199802
  http://thread.gmane.org/gmane.comp.version-control.git/199789

We first add a new "git credential" command, that replaces
test-credential.c and wraps the C API, and then use it in the
git-remote-mediawiki interface.

PATCH 3 is actually a rewrite of Javier's patch, so I took the
ownership of the patch, but mentionned Javier in the commit message.

Javier Roucher Iglesias (1):
  add 'git credential' plumbing command

Matthieu Moy (2):
  git credential fill: output the whole 'struct credential'
  git-remote-mediawiki: add credential support

 .gitignore                                  |   2 +-
 Documentation/git-credential.txt            | 133 ++++++++++++++++++++++++++++
 Documentation/technical/api-credentials.txt |  39 +-------
 Makefile                                    |   2 +-
 builtin.h                                   |   1 +
 builtin/credential.c                        |  31 +++++++
 contrib/mw-to-git/git-remote-mediawiki      | 106 +++++++++++++++++++---
 credential.c                                |   2 +-
 credential.h                                |   1 +
 git.c                                       |   1 +
 t/lib-credential.sh                         |  39 +++++++-
 t/t0300-credentials.sh                      |  14 +++
 test-credential.c                           |  38 --------
 13 files changed, 318 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/git-credential.txt
 create mode 100644 builtin/credential.c
 delete mode 100644 test-credential.c

-- 
1.7.11.5.g0c7e058.dirty
