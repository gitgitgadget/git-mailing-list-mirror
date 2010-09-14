From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 09/20] gettextize: git-stash drop_stash say/die messages
Date: Tue, 14 Sep 2010 13:52:09 +0000
Message-ID: <1284472340-7049-10-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVwp-0004Ln-3r
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab0INNxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:53:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34548 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab0INNxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:53:08 -0400
Received: by ewy23 with SMTP id 23so3076710ewy.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vsS+pP9mlxYkaiSCsSEuxTieMwHnimJ3pEoi30cewGk=;
        b=L75peUHaekfOxlPBeSTcZo8mCjqv7DnCJzUkPrrmZL1Y53wY64WwYOdly82RZ5TwVE
         XaqVA51zVb6ZAUAw4JmIYHJlXYNHOb1GFEgAdAKgZ9RICDTSO5s77qXeL6qxm0BrzWVx
         LCjba0FJUHJX9YwLzBBz2fW/y4fpnEzn46XaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XgJ1eq3wMXQXwI56jTgU45NO6rEGHZ2L0u49JcJj5DOOZZEjSknPzuw5J/QFN0tE0T
         QQyPiRGxtvMTyKMSIt1YrMY9lGvsAFg5Vj81GYLmwQg08bzhy7iWbHKr+CiNiKwms7+t
         iY1uIy4BupzdtJmU7ODc9vnmlWHYMUwXjie10=
Received: by 10.216.162.72 with SMTP id x50mr4002340wek.3.1284472386478;
        Tue, 14 Sep 2010 06:53:06 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.53.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:53:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156176>

Gettextize the say/die eval_gettext messages in the drop_stash
function. Since making these translatable would result in a long line
I've wrapped this into two lines.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 63885a3..36d821b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -440,7 +440,8 @@ drop_stash () {
 	assert_stash_ref "$@"
=20
 	git reflog delete --updateref --rewrite "${REV}" &&
-		say "Dropped ${REV} ($s)" || die "${REV}: Could not drop stash entry=
"
+		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
+		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
=20
 	# clear_stash if we just dropped the last stash entry
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_sta=
sh
--=20
1.7.3.rc1.234.g8dc15
