From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 09/16] t4026 (color): remove unneeded and unchained command
Date: Sun,  3 Oct 2010 14:00:07 -0600
Message-ID: <1286136014-7728-10-git-send-email-newren@gmail.com>
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
	id 1P2Uic-0002yx-Dz
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab0JCT7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:59:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45640 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab0JCT7E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:59:04 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1157782pvg.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IqN84CCzxlmp7cTYNydhdUna/QKyBCHVUkchjkolTxM=;
        b=d1OGUNwNd2FOo+beXB8j358PyFzm8vnYfvFE8ombZwBFsEZJGeRuyMI+Vl5tCvvqa3
         IVN6N7Keyv4LyEdKl4gfY/nI/CB0rpEav+ZCqWgu/7T4wF1KWy83mX9wlAmk7aaN2P61
         QkKF+oyhj8TVXLWNW1v/zeq1HBEDSd8FXZX3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=W545LpHK9n7Ib0gWp3uXVwzhDhN08BUDKyv1VkySibQfX+kzaTVTEC6+DWGePOk5hN
         CLahpj1BK8kBOCObBREQJo0otK2UIfg+Ueo0EiPzpvKAz9NQOsIARkWfY3/o88kS/GDZ
         qiM9FDvBf81kh4J5EMnl97V4jyjMkVzwkv1Js=
Received: by 10.115.77.17 with SMTP id e17mr10116260wal.108.1286135943896;
        Sun, 03 Oct 2010 12:59:03 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.59.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:59:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157907>

Ever since 8b12413 (color: allow multiple attributes 2010-02-27),
diff.color.new has been unused in t4026, so also remove the final unset=
ting
of that value to make the third to last test pass with appropriate
'&&' chaining.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Acked-by: Jeff King <peff@peff.net>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
1.7.3.1.66.gab790
