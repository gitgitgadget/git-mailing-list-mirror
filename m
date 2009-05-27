Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 14310 invoked by uid 107); 27 May 2009 08:16:38 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Wed, 27 May 2009 04:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435AbZE0IQZ (ORCPT <rfc822;peff@peff.net>);
	Wed, 27 May 2009 04:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756400AbZE0IQZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 04:16:25 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:32870 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844AbZE0IQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 04:16:23 -0400
Received: by ewy24 with SMTP id 24so4320130ewy.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 01:16:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=brHKiiyyALalMXqRF1yXJi/luO186zSYfutRXW2ckKo=;
        b=EIUyT2zAzE+X1jhkwFcdYfrZW4xmj9wubPe14oJZJfJeNedGuyhJGXLlOE2i1fbzew
         B7jT7hgwbxe1pLPp5pxx2iZE9ZTcdjyLKGW5hMbYwjoJ95we113d3sCPMvUW26cxnHAY
         iMCZ0zg4YjmPLXpi4IPyS32laFl3FMXthPj9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XCPk4ty7RwEEhm6Hs25QNZjE24T202mS7j4XUhevLltHX94qmWGjMPHdOeqYMERpt/
         sY3YYugdCX/Rs6FnAoqNcwJ7jQFldIDO5zk5QIpADYjUrBIi3s1dPBMlmDeXLcyEb8TU
         94o08an5sHmiJqA4JDuVmP9SRjR5ZqEwawVDg=
Received: by 10.216.29.66 with SMTP id h44mr3558147wea.136.1243412183970;
        Wed, 27 May 2009 01:16:23 -0700 (PDT)
Received: from localhost ([141.76.90.80])
        by mx.google.com with ESMTPS id 24sm10025541eyx.53.2009.05.27.01.16.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 01:16:23 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Marc Weber <marco-oweber@gmx.de>
Subject: [PATCH TopGit 1/3] tg-push: remove useless warning of missing bases for non-tgish branches
Date:	Wed, 27 May 2009 10:16:22 +0200
Message-Id: <1243412182-24126-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.3.1.143.g17592
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-push.sh |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/tg-push.sh b/tg-push.sh
index 8d09a02..40849ae 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -51,12 +51,8 @@ push_branch()
 	$tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
 
 	echo "$_dep"
-	local base="top-bases/$_dep"
-	if ref_exists "$base"; then
+	[ -z "$_dep_is_tgish" ] ||
 		echo "top-bases/$_dep"
-	else
-		echo "warning, no base found $base" 1>&2
-	fi
 }
 
 for name in $branches; do
-- 
tg: (b725fc9..) bw/push-remove-useless-warning (depends on: master)
