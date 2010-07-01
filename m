From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 8/8] t/README: Document the dangers of printing "ok" / "not ok"
Date: Thu,  1 Jul 2010 15:10:04 +0000
Message-ID: <1277997004-29504-9-git-send-email-avarab@gmail.com>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:19:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULXy-0002zS-1Q
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab0GAPTS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:19:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41850 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281Ab0GAPTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:19:16 -0400
Received: by wyf23 with SMTP id 23so812668wyf.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=omoP8nYNI/R+UaVQ9DXzCx7hosGPae+Ezw2rWyAPfGY=;
        b=qXLr4I8f7p+9MnawrgYqLrDHf/kNLRuKXKT81KvKJhf5QLUBHwD3b7A+oCVwLGrsJ7
         IwmiMRuTVd6SPK14p5MTTnvByXWplJPathkFr09v9wYrlPRBWQPLKvX4NOUmEm8vc9iW
         PEj3IItLyg0V9Oep1c0+B99LPEr4kE2+XceMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wsoVU9rwOjpfvo/A8Bwkt0R7Uh/PYNEzmwQYWK5ZZRY+GxELDzwGqv+YxLFGQXRPiw
         Z3b6aM8Is5JZdKxYGDbEyDBY+k+8IipKvQz8fPLzg+EFOfs29YAnTExReq8h7T5QBv0E
         yzdXoCl6Q2YJFePAay7EcndPjZ7SMqr57Zdys=
Received: by 10.213.31.133 with SMTP id y5mr2578204ebc.6.1277997060316;
        Thu, 01 Jul 2010 08:11:00 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150048>

A TAP harness will get confused if you print "ok" or "not ok" at the
beginning of a line. This had to be fixed in
335f87871fe5aa6b3fd55b2b4e80f16fe9681483 when TAP support was
introduced.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 42a4c25..29f795e 100644
--- a/t/README
+++ b/t/README
@@ -50,6 +50,12 @@ prove and other harnesses come with a lot of useful =
options. The
     # Repeat until no more failures
     $ prove -j 15 --state=3Dfailed,save ./t[0-9]*.sh
=20
+The TAP support is completely incidental. A TAP harness is just a
+program that interprets the "ok"/"not ok" (and some other strings) in
+a special way. The only limitation this imposes is that you shouldn't
+echo "ok" or "not ok" by yourself at the beginning of a line, that'll
+confuse the TAP harness.
+
 You can also run each test individually from command line, like this:
=20
     $ ./t3010-ls-files-killed-modified.sh
--=20
1.7.1.251.g92a7
