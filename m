From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 05/15] t4202 (log): Replace '<git-command> || :' with test_might_fail
Date: Sun, 26 Sep 2010 17:14:29 -0600
Message-ID: <1285542879-16381-6-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Q1-0005ch-IF
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758487Ab0IZXNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37370 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757639Ab0IZXNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:12 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1087690pvg.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gYv0KUz1PTkE4/K80DJG3zmXs0HYQYYcdVFeeLp+M/0=;
        b=H9z9OAb1ecoKuMYI4qUH/V60ft+04ODIg/ksvuEhpacdJtzGB62gc5S1lkClTZ0f9K
         +5wjNR+BwwEML+koGWe5+pV45VPnhUE2AZAGjAfd5v69UblT8IXHPoWltlItv0i0DJWU
         EZMW0bDfjUApedrVpS2Up7aK4kug4YHecMPcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KEsRkNhUjdHxK3cl89OW6IwrYt5ijL/IMeV7QXvE8XUBwh6jRkNcOvA8y13NfT9Fef
         ulyVaV0fKtr1ulTlcNzpv2thp/14toc4NRyGFgRXD7AYoh8OFm/HHXylabSBuviLjmyF
         5ugB60ARRkhNpxF9Fkwj1z36mS/Pi6Xa+kzmc=
Received: by 10.114.53.4 with SMTP id b4mr7338683waa.190.1285542792704;
        Sun, 26 Sep 2010 16:13:12 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157280>

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
1.7.3.95.g14291
