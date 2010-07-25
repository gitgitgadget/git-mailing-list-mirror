From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 7/7] t/README: Add a note about the dangers of coverage chasing
Date: Sun, 25 Jul 2010 14:41:01 +0000
Message-ID: <1280068861-17701-8-git-send-email-avarab@gmail.com>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 16:41:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2OY-0001DE-Fk
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab0GYOld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 10:41:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52047 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab0GYOl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:41:28 -0400
Received: by ewy23 with SMTP id 23so602454ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hofQEzfJzynDjAatPl2c8O+xK/k8b1uvnRxQ8wJRQnQ=;
        b=PMhTkh4WZHZXs940+Lh8CYQkd0R/2txyvs8+DIaag0uC77gDXxn3QOTax/0TqJsK6d
         3tCL9gBHOULa/X6JYLNZ3jk1658zit5CCcdEUnjHTY77CQ/KTXmvxkRYEbq6dvIIa762
         vRWokmh73NSBxehrjfbYbE7ZAqlVTRygO58eY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Gft0AhQzFlvmTBNyMhhk2bOFX/Q9qYQRteFip4PzgHl/XxO7RL+OkyTf2MeN6GeJ8x
         OM0fOcRW+brMRo5kVtdFk12vO1zk/DYYFJPznbLBb65OihpZZACOa8NvXQ63l0dbHQNe
         eQA2H5H9xDsFFgnRkT7s3wN3RYTurym9I/vDY=
Received: by 10.213.31.148 with SMTP id y20mr5264876ebc.39.1280068886109;
        Sun, 25 Jul 2010 07:41:26 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id x54sm3977142eeh.23.2010.07.25.07.41.24
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 07:41:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151752>

Having no coverage at all is almost always a bad sign, but trying to
attain 100% coverage everywhere is usually a waste of time. Add a
paragraph to explain this to future test writers.

Inspired-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 2fa6744..400e2da 100644
--- a/t/README
+++ b/t/README
@@ -271,6 +271,15 @@ Do:
  - Check the test coverage for your tests. See the "Test coverage"
    below.
=20
+   Don't blindly follow test coverage metrics, they're a good way to
+   spot if you've missed something. If a new function you added
+   doesn't have any coverage you're probably doing something wrong,
+   but having 100% coverage doesn't necessarily mean that you tested
+   everything.
+
+   Tests that are likely to smoke out future regressions are better
+   than tests that just inflate the coverage metrics.
+
 Don't:
=20
  - exit() within a <script> part.
--=20
1.7.0.4
