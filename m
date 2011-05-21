From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 08/48] i18n: git-am clean_abort messages
Date: Sat, 21 May 2011 18:43:49 +0000
Message-ID: <1306003469-22939-9-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrDQ-0001WK-Io
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251Ab1EUSrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:24 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45234 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172Ab1EUSpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:10 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451059ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=DJAQtnIS8Qsm6V0xP1MqnVVjkgTG52SQFHoBp+OdV/M=;
        b=LF2JLL/crEu0yMr/Lm+PDVYLtZdQ0adzAtQrqxDG+ye646tQdp6j5q/ha1WP/Q9e7u
         qAEz9MqJHuzKES1eehabtVAZf/e9oYxkK9zvGkMvjXbgTjwjuizN+5gQY/sc+r/ffzTl
         IUT67+GLSqKIVlwk8BWqrfTimmH0dtN9qJooY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JDLETbiCPfGeajSl1upcYY921yA3E7UW0Bw64MJBj4HSyoy72GvU3gq41jPA7xLUIw
         q9rai6RBtICZgXwGkfcWm9RrpziAcuYpudaAB/npJuPdgqCdQ+ijCdn20j3oaotLv6v3
         4O7fRpM6qRhNDCGCR2MQwVBV/m32SLrrbjrzw=
Received: by 10.213.19.136 with SMTP id a8mr610345ebb.87.1306003509413;
        Sat, 21 May 2011 11:45:09 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.08
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174165>

Messages that used the clean_abort function needed both gettext(1) and
eval_gettext(). These need to be interpolated in a string like the die
and cannot_fallback messages.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ac2d202..bb58c1c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -258,7 +258,7 @@ split_patches () {
 	stgit-series)
 		if test $# -ne 1
 		then
-			clean_abort "Only one StGIT patch series can be applied at once"
+			clean_abort "$(gettext "Only one StGIT patch series can be applied =
at once")"
 		fi
 		series_dir=3D`dirname "$1"`
 		series_file=3D"$1"
@@ -310,9 +310,9 @@ split_patches () {
 		;;
 	*)
 		if test -n "$parse_patch" ; then
-			clean_abort "Patch format $patch_format is not supported."
+			clean_abort "$(eval_gettext "Patch format \$patch_format is not sup=
ported.")"
 		else
-			clean_abort "Patch format detection failed."
+			clean_abort "$(gettext "Patch format detection failed.")"
 		fi
 		;;
 	esac
--=20
1.7.5.1
