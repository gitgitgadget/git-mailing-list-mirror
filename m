From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 06/16] t4202 (log): Replace '<git-command> || :' with test_might_fail
Date: Sun,  3 Oct 2010 14:00:04 -0600
Message-ID: <1286136014-7728-7-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uib-0002yx-Br
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab0JCT66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:58:58 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45640 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab0JCT65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:58:57 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1157782pvg.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sk2CaN9pqn+WgVIhTmNa/xBws91YQnY7H7rodOc62hk=;
        b=Xmouu3WT6oCpwoBHlEOz5DSbPyWTIT93ibTUUY1bkP6gZlz7M0wU2enAg76VIStEE0
         84YrrwfJzsMoFT6rxITJ3gQrrJPsYZuyMFpwgbMoYGDn1gE489XIliS30jX+QBD0vQkk
         W7/6b96qz09aIa5933vvFz/CturzvEPNSF5F0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kOD5iBS5xfIcnTXLd1hmeEwibuPDUIPdfKy/5Tbkn/+hGR9eId8ybHX62hp+2Cckgr
         o+m9xDKJn1TKUap4eWeaXij6rhYmCAj1wnYLFRIp7DD62ncPS+IWa6OmDsGAYVuLIksw
         lfI6Gx0cBxcITA3YOepWAkt9QjxFH328etJuQ=
Received: by 10.114.66.5 with SMTP id o5mr10033591waa.219.1286135936807;
        Sun, 03 Oct 2010 12:58:56 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.58.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:58:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157908>

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
