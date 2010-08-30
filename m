From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 03/17] Makefile: tell xgettext(1) that our source is in UTF-8
Date: Mon, 30 Aug 2010 21:28:09 +0000
Message-ID: <1283203703-26923-4-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 30 23:29:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBuT-0008Ah-Py
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab0H3V2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:28:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab0H3V2t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:28:49 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so7081766wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=w3GUO84EjuKhGHCWW+xHL0QRupNPvqB/A38a3m1eHCw=;
        b=mC0aygxTRAzfQZjWb4jMaAY+w6A57av4QyNIiSQevHaw7nKWY7Xk1U5m+rzK4NhqTX
         10RQL91WJecds+GpAj+xN/lhNlSBidhIHb8IIll+O6+Vi+d7ltKw4UTDjbwGtarGDNur
         cr8pRT5xG61Jzidd3nJPwjZoVmZh5XfBkO9UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CMYIn3gBamUGOrTnq01KP4G0fF8f+K9QJWbSplz2tFJYGSATK8laJudmVP940rkVAi
         VS5kDcm+U4Ykj1bSg0iqvG34U3QYeyEusXpmIFMs6XgrYACznuz+ojsPatWMLrTuL2mQ
         XTNPsuPIblvEUjGyxDHkYdtI3TzCD/UF3AKec=
Received: by 10.227.156.213 with SMTP id y21mr5274075wbw.110.1283203728527;
        Mon, 30 Aug 2010 14:28:48 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.28.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:28:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154850>

By default xgettext(1) assumes that source code is in US-ASCII, change
that to UTF-8 for our case.

I'm not planning to include non-ASCII in any of the main Git interface
strings. But this'll be used for a gettext regression test to make
sure this works if we ever want to go this route, and to check that
the gettext implementation is sane in this regard.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4b46579..9818a59 100644
--- a/Makefile
+++ b/Makefile
@@ -2008,7 +2008,7 @@ cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
-XGETTEXT_OPTIONS =3D --add-comments --msgid-bugs-address=3D"Git Mailin=
g List <git@vger.kernel.org>"
+XGETTEXT_OPTIONS =3D --add-comments --msgid-bugs-address=3D"Git Mailin=
g List <git@vger.kernel.org>" --from-code=3DUTF-8
 pot:
 	$(XGETTEXT) $(XGETTEXT_OPTIONS) --keyword=3D_ --keyword=3DN_ --output=
=3Dpo/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
 	$(XGETTEXT) $(XGETTEXT_OPTIONS) --join-existing --output=3Dpo/git.pot=
 --language=3DShell $(SCRIPT_SH) t/t0200/test.sh
--=20
1.7.2.2.536.g3f548
