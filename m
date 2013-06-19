From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] push.default in the triangular world
Date: Wed, 19 Jun 2013 16:41:38 +0530
Message-ID: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 13:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGLq-0002tC-32
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934312Ab3FSLOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:14:53 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:50142 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666Ab3FSLOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:14:52 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so4970865pdi.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EBFkmf6Ezd51rjqnUEYItMR0GwwQWZAdEHX+g+BaCy4=;
        b=BvyAzHQIkSjnLpiPAaSbya/vDDCLG7ixrPDyagPJHEikZcxC3lSnpgu+vt7rXcQrPD
         e69Olv0A+PXSRcH/8Zr3Db2bxGBWuwmS/T2zK1/Ktewk0dv5/1dMvHOLt20Tqt1i9ClR
         tZLZ54LCPgYYttn4mO9h6ykOyLQUwkeDVJsmMelGdqja3W7NW37+PVWXAvTSaHdgZxYT
         q1YR+lKLxr5n5T9mxs1pFUA3nehOhhbkPSLsuk1lfRy8/21QxmBwTUlY8he18cCWgP15
         Dxtw8NlztmJaABe534YosWfy/cE2TQp+pDbz6EeOOIb1B0fWfZdiEjLxWk4Cs36T2HGn
         /bmg==
X-Received: by 10.66.7.164 with SMTP id k4mr6291800paa.142.1371640492513;
        Wed, 19 Jun 2013 04:14:52 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id iq2sm22746579pbb.19.2013.06.19.04.14.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 04:14:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.454.gff6ba36
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228383>

[2/6] documents existing push.default modes properly, but doesn't
touch `simple`.  It incorporates feedback from Junio, Philip Oakley,
Matthieu Moy.

[3/6] gives `simple` an exciting new meaning.  I think it's an
absolutely fabulous default!  It's aimed at triangular people who
occassionally need to do central stuff.

[6/6] adds some new tests to illustrate how all these push.default
modes work in central and triangular workflows.

Thanks.

Ramkumar Ramachandra (6):
  t/t5528-push-default: remove redundant test_config lines
  config doc: rewrite push.default section
  push: change `simple` to accommodate triangular workflows
  push: remove dead code in setup_push_upstream()
  t/t5528-push-default: generalize test_push_*
  t/t5528-push-default: test pushdefault workflows

 Documentation/config.txt | 62 ++++++++++++++++++++++++++----------------------
 builtin/push.c           | 27 +++++++++++++++++----
 t/t5528-push-default.sh  | 46 +++++++++++++++++++++++++++++++----
 3 files changed, 97 insertions(+), 38 deletions(-)

-- 
1.8.3.1.454.g30263f3.dirty
