From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 19/20] gettextize: git-bisect [Y/n] messages
Date: Tue, 14 Sep 2010 13:52:19 +0000
Message-ID: <1284472340-7049-20-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:59:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvW2V-0000Do-CN
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797Ab0INN7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:59:09 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:35139 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab0INN7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:59:07 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Sep 2010 09:59:07 EDT
Received: by wyb40 with SMTP id 40so9224807wyb.11
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qXPtGGVyInxC/Wt5aTJhHzTmwsgYmVzQJh9XSnO0t3I=;
        b=Hz8r1hfXMLg6bjvmnpQvinP3E3WdBk3NcmlNQKWFuPUP9EZf+MoylqNOxeXx8KyqVG
         +alBdlN0eGd+EIy8aosPxXLG3CMAdk9WyJOgqilrlYxChGmL7xo5yTazWHZa9Mg8K5sc
         AHG49+BeglVYy+5/U455iGEPUHwSao8RbNu64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oXkZth7WeDZKVZgdPwwp4UV9SCY5MN4ax1I9lvX+qxxR6IgyHBbqbrwsyw0bK90rS3
         AA5nOEVNvNIYVEWP90peBWEDIF4s6umHUvTidzj51BPKAaW982UIM/eyAgAMp9OI+6Qn
         Uw160k4RbvhtZYpy/AcWxs93S2wKp9cHQmJNs=
Received: by 10.216.236.146 with SMTP id w18mr5800738weq.19.1284472443185;
        Tue, 14 Sep 2010 06:54:03 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.54.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:54:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156187>

Gettextize the [Y/n] questions git-bisect presents, and leave a note
in a TRANSLATORS comment explaining that translators have to preserve
a mention of the Y/n characters since the program will expect them,
and not their localized equivalents.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index f3162d6..b130129 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,7 +39,10 @@ bisect_autostart() {
 		echo >&2 "$(gettext "You need to start by \"git bisect start\"")"
 		if test -t 0
 		then
-			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
+			# TRANSLATORS: Make sure to include [Y] and [n] in your
+			# translation. The program will only accept English input
+			# at this point.
+			echo >&2 -n "$(gettext "Do you want me to do it for you [Y/n]? ")"
 			read yesno
 			case "$yesno" in
 			[Nn]*)
@@ -242,7 +245,10 @@ bisect_next_check() {
 		echo >&2 "$(gettext "Warning: bisecting only with a bad commit.")"
 		if test -t 0
 		then
-			printf >&2 'Are you sure [Y/n]? '
+			# TRANSLATORS: Make sure to include [Y] and [n] in your
+			# translation. The program will only accept English input
+			# at this point.
+			printf >&2 "$(gettext "Are you sure [Y/n]? ")"
 			read yesno
 			case "$yesno" in [Nn]*) exit 1 ;; esac
 		fi
--=20
1.7.3.rc1.234.g8dc15
