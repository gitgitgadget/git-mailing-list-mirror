From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/48] i18n: git-am clean_abort messages
Date: Sun,  8 May 2011 12:20:40 +0000
Message-ID: <1304857280-14773-9-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ304-0003rg-0x
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab1EHMVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab1EHMVi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:38 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Qi7hCwlQa/pzc9vzWph5SRfWnSQgZtJagdDKeZa4HRA=;
        b=qClVOkCsdeYXYJYAwCu2sNqUk6h+Zf4ZQWPZu/xyuekxta0ZWmlyYAHAfNp5QNMoDn
         j9NOy3+/3TfNuq6MsBGqhx9imU2exNwtvKi96mJTLqSdNACup4LcFFky+XEg/cPwQnKe
         8qhTJmbQ7wIXKze3cYf+tBGLb87p12szEJlOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NgEydzaPW8J/4pJ20DV7k7ZKURJmou3vSbUotIjmpbXurX6pjDb0FHU30jCzSa/F7t
         PwWY1+f7PrLx8s2u4WWKx34vR7ch0Mni0omLB9/Pmu5uMajwQAMhCkatbBd2y8gbMpJ3
         Z91sAyq1QczwXX3lyK+FjxJBeMPzor3S2q1Xg=
Received: by 10.14.148.67 with SMTP id u43mr2776172eej.7.1304857297845;
        Sun, 08 May 2011 05:21:37 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.36
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173111>

Messages that used the clean_abort function needed both gettext(1) and
eval_gettext(). These need to be interpolated in a string like the die
and cannot_fallback messages.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 5c06eda..ed48673 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -255,7 +255,7 @@ split_patches () {
 	stgit-series)
 		if test $# -ne 1
 		then
-			clean_abort "Only one StGIT patch series can be applied at once"
+			clean_abort "$(gettext "Only one StGIT patch series can be applied =
at once")"
 		fi
 		series_dir=3D`dirname "$1"`
 		series_file=3D"$1"
@@ -307,9 +307,9 @@ split_patches () {
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
1.7.4.4
