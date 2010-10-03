From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 09/16] t4026 (color): remove unneeded and unchained command
Date: Sat,  2 Oct 2010 23:10:37 -0600
Message-ID: <1286082644-31595-10-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gpr-0001zH-SY
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab0JCFJg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:36 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55800 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0JCFJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:35 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1068412pvg.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mS4vu5PmyCvgKsddmwlXW180GT7ZmuCET3HEoFJZ7EA=;
        b=fV2Fgmu5vd3SJ5bb5iyTJjxd8tCRW0EcZLNawkyq32l9haM98YWl858YcGMpVBFvQ8
         fD3IFTMYLzFmufE9To9aQerYrvv3JEw0epPOd+nrguVPmha5eKaJMBfOS+Vhukp7Nt9M
         HTUWJA41d/pIAJIoAQex+A1dm78qme2No9ml0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LygqUxZPwMgbwHyutK1RVRFZqjw+AwHYudKjYgNhxouyJxGirEOqNkEVK8mkLOtu8x
         Epo9kEvfjCAeNd2M20B2rnFAu6Lh3tywg99tZxJ1gEhcbSFkrdeSuHclWvP5Ss2FJL+v
         ccGbPfYgiKilfgR5vAlz7e6n9p8ZnwcU4P/rs=
Received: by 10.142.147.5 with SMTP id u5mr2252245wfd.229.1286082574774;
        Sat, 02 Oct 2010 22:09:34 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157841>

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
1.7.3.1.66.gab790
