From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 11/11] [RFC] tg-patch: simulate mnemonic prefixes
Date: Sat,  9 Oct 2010 22:57:02 +0200
Message-ID: <d9801fe5759b2d40d7bc7497d37545e15293041f.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
 <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
 <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
 <b765e0da80781182bf6c3af8f28d9496ed49cc1b.1286657607.git.bert.wesarg@googlemail.com>
 <62e3424559a93dc0f7c3ed55aafce738f2b0f6d3.1286657607.git.bert.wesarg@googlemail.com>
 <65565f00635372ad3677c0187c33da4d3ceb4b73.1286657607.git.bert.wesarg@googlemail.com>
 <3f39e999ea8aeca5c7125e8981aeffb8cd92d472.1286657607.git.bert.wesarg@googlemail.com>
 <320cfcab44939419b5700daa6c356648becc2004.1286657607.git.bert.wesarg@googlemail.com>
 <58dbd71af776b1fb088080129a65c623b1dea926.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 23:00:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gWe-0000hx-8w
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 23:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760635Ab0JIVAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 17:00:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202Ab0JIVAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 17:00:08 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=moAbZP30SuYgovV0y6hQkmGhBMOeHpZtXHgz6gkY6Fk=;
        b=Os844N25tTZ4XjhlGc6aEwwplDBmfRgrOLbzW0KJYuevO2HIAtIQzLcGFqzG5b3w0e
         HK0TTWEdzIzAUymQS5zEjjabU3H2nbSg/edgzKfxStVYP+w+BMiwxUDNJM5ilOaeAudH
         iQqBgp+JmVxSDczE81TmnP/n+c0g3Ty9Na2tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KboOz0LpC7Br2Zsu0az5qv5XKNPcb2P+yIkpIUAprO+Arz9PUwXjWFM5G8YawBC3tA
         lfyy/J9En3LnXz40atOlIFtUpAKLZir4VEiRiEYEL8OSuzxGGgdnVSuzorktnPmWG/gL
         29BCWiZuBJbvn5M9e/C62iehZUJo7SwZJsZNY=
Received: by 10.213.101.10 with SMTP id a10mr828316ebo.85.1286658007136;
        Sat, 09 Oct 2010 14:00:07 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id p53sm408348eeh.1.2010.10.09.13.59.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 14:00:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <58dbd71af776b1fb088080129a65c623b1dea926.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158621>

b/ is for base, i/ and w/ correspond to -i/-w and t/ is the committed
topic.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-patch.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index dcce672..c8ad723 100644 tg-patch.sh
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -6,7 +6,7 @@
 name=
 
 head_from=
-
+dst_prefix="t/"
 
 ## Parse options
 
@@ -15,7 +15,8 @@ while [ -n "$1" ]; do
 	case "$arg" in
 	-i|-w)
 		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
-		head_from="$arg";;
+		head_from="$arg"
+		dst_prefix="${arg#-}/";;
 	-*)
 		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
 		exit 1;;
@@ -72,6 +73,9 @@ if [ $b_tree = $t_tree ]; then
 else
 	# use the ui diff command when the pager is active
 	diff_command=diff
+	if $(git config --bool diff.mnemonicprefix); then
+		diff_command="$diff_command --src-prefix=b/ --dst-prefix=$dst_prefix"
+	fi
 	[ "x$GIT_PAGER_IN_USE" = "x1" ] ||
 		diff_command=diff-tree
 
-- 
1.7.1.1067.g5aeb7
