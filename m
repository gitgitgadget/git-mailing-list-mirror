From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 06/16] t4202 (log): Replace '<git-command> || :' with test_might_fail
Date: Sat,  2 Oct 2010 23:10:34 -0600
Message-ID: <1286082644-31595-7-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gpq-0001zH-98
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab0JCFJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:29 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51054 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0JCFJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:27 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1068077pxi.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Q9nMdvbGr1xfn/Mnx0k54MCx/0eZruMdD7Rzy9n544o=;
        b=T/UMhkA9cijXDYnFU4ZgZlrMa9guDJCfokGRbCOrArZvNzOo5aTjck3RFPlCrjhsxG
         W/pX5IqbXwvnbf52SqrXwUS5FQ55Q9dPD6RnKu/oCn5VV/TdVM+ROi3sXunLtOAS2H4h
         Z/DK6Qz8CWjn+uooebx2Sf9TFPJrCC33Yf8l8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=w3BBBxEBEKyf9djHq+kcs2tTuioTqjBe4/ewWaiPO+BucQCGOdRjFyBSHfnkWhtxKR
         +Zbwxjk91w3OX8KtxM6PA9mrUANg6ni8T8q+r/yVpNO3uuYXS8IBJjcwcqOYnL6bje6Z
         6yi2s66Z4qXwByjpWW44UN9QE9Wmz4e0l1zIU=
Received: by 10.142.61.39 with SMTP id j39mr6795980wfa.347.1286082567315;
        Sat, 02 Oct 2010 22:09:27 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157832>

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4202-log.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2e51356..1172e45 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -393,7 +393,7 @@ test_expect_success 'log --graph with merge' '
 '
=20
 test_expect_success 'log.decorate configuration' '
-	git config --unset-all log.decorate || :
+	test_might_fail git config --unset-all log.decorate &&
=20
 	git log --oneline >expect.none &&
 	git log --oneline --decorate >expect.short &&
--=20
1.7.3.1.66.gab790
