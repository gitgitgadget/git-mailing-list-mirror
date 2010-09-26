From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 08/15] t4026 (color): remove unneeded and unchained command
Date: Sun, 26 Sep 2010 17:14:32 -0600
Message-ID: <1285542879-16381-9-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Px-0005ch-4n
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758347Ab0IZXNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:25 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36429 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758272Ab0IZXNT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:19 -0400
Received: by pzk34 with SMTP id 34so1046760pzk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7pwsupycdZotTEhMpe/d1UWzI7jiPJ1P1i6QUajjPKM=;
        b=PbFB1wA+/eBJdw54rKnqxXBJZB8VzIc7YmAWQair39Ghp/j9hVM9X8UHVkWTk1ByKY
         1JKSkKGiy2aMo1CAB16ZjRI6JNvcX1+q1feBXaPTkSJJoaT29FY9dn31h1CKRpyta5em
         E3uQhweRwXwgKciYA8l7uOS7U34zXwAATqQrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dB246lv2+xUowCm1vzqpcoFai3ntGONQ1CCPR2nynEUO8flaYswBTw0igmdoNnLGYd
         BKvZMNPdgw/s0VsuEQ1j8OvhZOjK1Ueimn+pYk7Q12pluXey+jAMfQCbZJPvMEEGYRL7
         3p3ZC31OVErY640hUDarzLmaEz7VFjjt5ipmo=
Received: by 10.114.123.4 with SMTP id v4mr7396937wac.0.1285542799374;
        Sun, 26 Sep 2010 16:13:19 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.17
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157274>

Ever since 8b12413 (color: allow multiple attributes 2010-02-27),
diff.color.new has been unused in t4026, so also remove the final unset=
ting
of that value to make the third to last test pass with appropriate
'&&' chaining.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4026-color.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index d5ccdd0..3726a0e 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -74,7 +74,6 @@ test_expect_success 'extra character after attribute'=
 '
 '
=20
 test_expect_success 'unknown color slots are ignored (diff)' '
-	git config --unset diff.color.new
 	git config color.diff.nosuchslotwilleverbedefined white &&
 	git diff --color
 '
--=20
1.7.3.95.g14291
