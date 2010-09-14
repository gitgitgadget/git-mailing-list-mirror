From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 08/20] gettextize: git-stash "unknown option" message
Date: Tue, 14 Sep 2010 13:52:08 +0000
Message-ID: <1284472340-7049-9-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:59:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvW3B-0000mq-Uy
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab0INN7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:59:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59709 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0INN7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:59:48 -0400
Received: by wwd20 with SMTP id 20so146788wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AQ9NKN+TbgWdBtOQ9k88hBmVjWARwUoldz9oUI1XwdY=;
        b=md09EzM9Fz1qgdrddHbiOpwaiEgBCSrMc+S6418Kss1kCcw03GfEmYXKZXYnXLtz4I
         6BienxxJyFUlioaIf3nuav2lqNvoKqNFKJ5eiATtk8oXLX56+/h2Q5Zbj0W3i40mIgYo
         e3b0LqRkOnx6oMN++QtZfJcyS8O7FhPMgpTDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=J/izxbkSG9OiY8Os7TC280ZSrupO0IsbCHMJfU4H4YEcxusIi5wntUecAxQ0/9UcP1
         WyvkATRBwLv2MDnNo3PEq9hH660WZclsQXpwhdP2hXT29JnS88QK6umyh9B8F3FPwbM5
         ECWlvtD3YIinqcSLzWozK+dhQ9MuCgbTaM97s=
Received: by 10.216.22.74 with SMTP id s52mr3966311wes.11.1284472384158;
        Tue, 14 Sep 2010 06:53:04 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156188>

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
index 7c005d3..63885a3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -151,8 +151,14 @@ save_stash () {
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
1.7.3.rc1.234.g8dc15
