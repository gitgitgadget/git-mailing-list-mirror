From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH v3 0/4] Disable "git status" comment prefix
Date: Thu, 29 Aug 2013 15:05:32 +0200
Message-ID: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 15:07:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF1x0-0005xP-K6
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 15:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab3H2NHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 09:07:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47267 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab3H2NHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 09:07:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TD5j7R018646
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 15:05:45 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VF1v0-0008H2-D8; Thu, 29 Aug 2013 15:05:46 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VF1v0-0008KQ-1Q; Thu, 29 Aug 2013 15:05:46 +0200
X-Mailer: git-send-email 1.8.4.12.gf9d53a3.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 15:05:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TD5j7R018646
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378386346.80299@5Zb5ZgjlCCcdN+oUfrUqkg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233252>

So, here's a reroll that makes the code cleaner.

First patches are cleanups without behavioral changes, only the last
one does something new.

I'm waiting for more comments to decide what to do with the
configuration option. Right now, my preference would be to call it
status.oldStyle and default it to false (i.e. change the behavior, but
allow old-timers to get back the old one).

Matthieu Moy (4):
  builtin/stripspace.c: fix broken indentation
  wt-status: use argv_array API
  get rid of "git submodule summary --for-status"
  status: introduce status.displayCommentChar to disable display of #

 Documentation/config.txt     |  5 +++
 builtin/commit.c             |  9 +++++
 builtin/stripspace.c         |  8 ++---
 git-submodule.sh             | 17 +--------
 t/t7401-submodule-summary.sh | 13 -------
 t/t7508-status.sh            | 43 +++++++++++++++++++++++
 wt-status.c                  | 82 +++++++++++++++++++++++++++++++++-----------
 wt-status.h                  |  1 +
 8 files changed, 125 insertions(+), 53 deletions(-)

-- 
1.8.4.12.gf9d53a3.dirty
