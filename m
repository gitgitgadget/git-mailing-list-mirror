From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/2] push: better error messages
Date: Mon, 28 Feb 2011 22:14:03 +0100
Message-ID: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 28 22:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuAmD-0001ED-8r
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab1B1VhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 16:37:04 -0500
Received: from mx1.imag.fr ([129.88.30.5]:56355 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab1B1VhC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 16:37:02 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p1SLE9Lv015983
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Feb 2011 22:14:09 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PuAPy-0000Nh-UJ; Mon, 28 Feb 2011 22:14:10 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1PuAPy-0000lL-RX; Mon, 28 Feb 2011 22:14:10 +0100
X-Mailer: git-send-email 1.7.4.1.142.g43604.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Feb 2011 22:14:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1SLE9Lv015983
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1299532454.00431@N+ID0evSjzcraulEiR7f9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168149>

Since it's likely to become the default in 1.8.0, I've played a bit
with "push.default = tracking". I was very happy to see that the flow

git init bla
git clone bla
git commit
git push

was working like a charm (it required a --all or so the first time),
but the "create a new branch and push it" is still a bit hard to get
for newbies.

[PATCH 1/2] should solve it, by providing a cut-and-paste ready
command to do the push.

While I was there, I also improved a bit other messages which gives
[PATCH 2/2]. I've kept the changes in separate patches, but they may
be squashed once reviewed.

Matthieu Moy (2):
  push: better error message when push.default = tracking
  push: better error messages for detached HEAD and "no destination"

 builtin/push.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

-- 
1.7.4.1.142.g43604.dirty
