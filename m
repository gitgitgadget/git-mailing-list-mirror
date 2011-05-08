From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 36/48] i18n: git-stash "unknown option" message
Date: Sun,  8 May 2011 12:21:08 +0000
Message-ID: <1304857280-14773-37-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30s-0004Hv-CR
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab1EHMW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1EHMWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:07 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8mNqtDD8/YSwbeVW7jBNHKWWExfn/ZZ8D/FcS7HeSLY=;
        b=G9pWBe4rT9vz/XoWSrVEtHAGDvL7/r+4KGxG075x2KuEWHenaXnCIiiu+ahScnyyXj
         OXQUUEymzYALuMWbvsPkb40llt6QT7CtdnIZIq+kdLoWnAzct5iH8p4sSLyj8i2InpXF
         3AvNsVZlA0w3nxBWCm0yGSV5zBfhU7QBiN5K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QuW6x7dcxk+AiiZPxMcrvTapwGg4yuQpkENdhl2zMpTyhffEz67GiPHwMrXE91UWIS
         2kJmmb10fabBqdWTgKntSMDG1HpoJCnqf2hfGoZUHEeRze5XqnGx5DbYuLQc7n/NFfwC
         6LSATXTQ73pXGQALbi0hvBhLRPtAFAyVOGEOo=
Received: by 10.213.23.10 with SMTP id p10mr660919ebb.77.1304857326883;
        Sun, 08 May 2011 05:22:06 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.05
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173130>

Gettextize the "unknown option for 'stash save'" message that's shown
on:

    $ git stash save --blah-blah
    error: unknown option for 'stash save': --blah-blah
           To provide a message, use git stash save -- '--blah-blah'
    Usage: git stash list [<options>]

In a translation the second line should be aligned with the first
one. I've added a TRANSLATORS comment to indicate this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index bf4868a..73fa2ce 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -152,8 +152,14 @@ save_stash () {
 			break
 			;;
 		-*)
-			echo "error: unknown option for 'stash save': $1"
-			echo "       To provide a message, use git stash save -- '$1'"
+			option=3D"$1"
+			# TRANSLATORS: $option is an invalid option, like
+			# `--blah-blah'. The 7 spaces at the beginning of the
+			# second line correspond to "error: ". So you should line
+			# up the second line with however many characters the
+			# translation of "error: " takes in your language.
+			eval_gettext "$("error: unknown option for 'stash save': \$option
+       To provide a message, use git stash save -- '\$option'")"; echo
 			usage
 			;;
 		*)
--=20
1.7.4.4
