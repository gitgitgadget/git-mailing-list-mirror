From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 09/48] i18n: git-am "Apply?" message
Date: Sat, 21 May 2011 18:43:50 +0000
Message-ID: <1306003469-22939-10-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCu-0001Bj-KR
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240Ab1EUSrW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44943 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456Ab1EUSpL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:11 -0400
Received: by ewy4 with SMTP id 4so1451116ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ptcCUc0LU1Sg4sDXx41jJIrZQeAbPt7aH1k8+iQgjOs=;
        b=LGIn+C8xDEguI45sFFN4kqfPntMsWdhPPxaje562plCs2o680hnyMQ5eWS4VjJC06R
         uQJxrSMYvYTdsDeBcJFMuw4o5bhVg2tZjFAPUqXuc1ISY5FBs4eL/2DBZOOaRCNf0kQ8
         LtVM40hrEjhF3uAtfV65Mp/hVNKZlqBK+uhcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=q/NMkki+xqf+SLyixY8sdxiInp4mP8dHfdIuyixGnytljLyDNCaDAAent3UkD5lcdP
         5NtWyHvOMn2A3YSGnOdorCIi9vYbq/65OIwycoO58FDqnglrv9UCtioJvVP7Hp2I+A7Z
         JXIRIJmGm179cPoDn2vxgsSUAz2CqJkKR3ABU=
Received: by 10.213.33.193 with SMTP id i1mr274470ebd.142.1306003510342;
        Sat, 21 May 2011 11:45:10 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.09
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174161>

Make the "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all" message
translatable, and leave a note in a TRANSLATORS comment explaining
that translators have to preserve a mention of the y/n/e/v/a
characters since the program will expect them, and not their
localized equivalents.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index bb58c1c..e5edb55 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -703,7 +703,10 @@ To restore the original branch and stop patching r=
un \"\$cmdline --abort\"."; ec
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
-		printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+		# TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+		# in your translation. The program will only accept English
+		# input at this point.
+		gettext "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
 		read reply
 		case "$reply" in
 		[yY]*) action=3Dyes ;;
--=20
1.7.5.1
