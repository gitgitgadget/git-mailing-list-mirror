From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/7 v4] push.default upcomming change
Date: Tue, 24 Apr 2012 09:49:59 +0200
Message-ID: <1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 24 09:51:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMaWV-0001k2-5j
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 09:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab2DXHuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 03:50:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49092 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab2DXHut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 03:50:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3O7iBgo018725
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Apr 2012 09:44:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMaW9-0007JN-4q; Tue, 24 Apr 2012 09:50:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMaW9-0002NV-14; Tue, 24 Apr 2012 09:50:33 +0200
X-Mailer: git-send-email 1.7.10.234.g365b0
In-Reply-To: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 24 Apr 2012 09:44:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3O7iBgo018725
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335858256.2429@KO1A+5Lh++BimW4x3Dw88g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196194>

This version should address all the comments from Junio, except that I
went for my simple one-argument test_push_failure (we don't need the
complex one for now, and I'm not sure the complex one will be good
enough when we want to test 'matching'---for example, we may want to
parse the output of 'git push').

Clemens Buchacher (1):
  t5570: use explicit push refspec

Matthieu Moy (6):
  Documentation: explain push.default option a bit more
  Undocument deprecated alias 'push.default=tracking'
  t5528-push-default.sh: add helper functions
  push: introduce new push.default mode "simple"
  push: document the future default change for push.default (matching
    -> simple)
  push: start warning upcoming default change for push.default

 Documentation/config.txt |   26 +++++++++++++---
 builtin/push.c           |   73 ++++++++++++++++++++++++++++++++++++++++---
 cache.h                  |    1 +
 config.c                 |    6 ++--
 t/t5528-push-default.sh  |   78 +++++++++++++++++++++++++++++++++++++++++-----
 t/t5570-git-daemon.sh    |   30 +++++++++---------
 6 files changed, 181 insertions(+), 33 deletions(-)

-- 
1.7.10.234.g365b0
