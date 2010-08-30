From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 02/17] Makefile: provide a --msgid-bugs-address to xgettext(1)
Date: Mon, 30 Aug 2010 21:28:08 +0000
Message-ID: <1283203703-26923-3-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBve-0000N5-Ti
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab0H3V3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab0H3V3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:43 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LBNW2c2bPTufHZu+fWhfv5IKRVuQETNH0ihXikm5M4o=;
        b=H65p34PG+Aq4gPo0SXxQy5g96ljtc3PaQTutI1Frdm9bOJwvA4GOar1JDMeX2gjGFt
         3JiAAFWmiLsMAYNUtUwgXP/64QM6VvXvHWYWAxr26A5kXMq/0fACRvJBwKVMAOqMJMu5
         g3NtXGJY4rs8XiAjRk7MtXOLapTOqpozqYfLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=n9cHN0dNNY2ZhaDjqHp8L1NmXFvBhtf2QSbtkgp1ftv6GIuC/qokQ80kYA24AzFUf2
         3WGwzivUFDQUw+P+eX4sjwcsTijUrCrmGfOiqtMcF6pkp18Vuf+7mheOFNXErcx2ectX
         O/BfRWPDKapZ7FFCAGE1Yh84lc1gqytQTyCMg=
Received: by 10.227.137.199 with SMTP id x7mr5552754wbt.107.1283203725761;
        Mon, 30 Aug 2010 14:28:45 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.28.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:28:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154864>

Change the invocations of xgettext to use the --msgid-bugs-address
option. This has the effect of adding a Report-Msgid-Bugs-To header to
the git.pot and the derived *.po files. Doing so is recommended by the
gettext manual.

If this isn't added the Report-Msgid-Bugs-To header already in
po/is.po and other PO files will be removed by msgmerge(1).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 6a5bcf5..4b46579 100644
--- a/Makefile
+++ b/Makefile
@@ -2008,7 +2008,7 @@ cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
-XGETTEXT_OPTIONS =3D --add-comments
+XGETTEXT_OPTIONS =3D --add-comments --msgid-bugs-address=3D"Git Mailin=
g List <git@vger.kernel.org>"
 pot:
 	$(XGETTEXT) $(XGETTEXT_OPTIONS) --keyword=3D_ --keyword=3DN_ --output=
=3Dpo/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
 	$(XGETTEXT) $(XGETTEXT_OPTIONS) --join-existing --output=3Dpo/git.pot=
 --language=3DShell $(SCRIPT_SH) t/t0200/test.sh
--=20
1.7.2.2.536.g3f548
