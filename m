From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/7 v3] push.default upcomming change
Date: Mon, 23 Apr 2012 10:37:57 +0200
Message-ID: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 23 10:38:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMEn3-0002uh-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 10:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab2DWIi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 04:38:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55558 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab2DWIi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 04:38:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3N8Vn2g029927
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 10:31:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-0004mn-M6; Mon, 23 Apr 2012 10:38:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-00081N-IC; Mon, 23 Apr 2012 10:38:07 +0200
X-Mailer: git-send-email 1.7.10.234.ge65dd.dirty
In-Reply-To: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Apr 2012 10:31:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3N8Vn2g029927
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335774714.30797@7wZWAqvAXnnWsfTuRZOcLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196100>

I think I've applied all feedback I've received.

Additionnally, I've split the "start warning" patch in a documentation
patch, that is meant to be applied now, and the warning patch itself,
which is meant to be applied after the first released version
introducing 'simple': we don't want to advertize 'simple' too loudly
until the option starts being deployed.

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

 Documentation/config.txt |   28 ++++++++++++---
 builtin/push.c           |   71 +++++++++++++++++++++++++++++++++---
 cache.h                  |    1 +
 config.c                 |    6 ++--
 t/t5528-push-default.sh  |   89 ++++++++++++++++++++++++++++++++++++++++++----
 t/t5570-git-daemon.sh    |   30 ++++++++--------
 6 files changed, 191 insertions(+), 34 deletions(-)

-- 
1.7.10.234.ge65dd.dirty
