Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8ED8203C1
	for <e@80x24.org>; Thu, 21 Jul 2016 01:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbcGUBeQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 21:34:16 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:36873
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753833AbcGUBeP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 21:34:15 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1469062611;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=PEwdGiZscWk4E+5CMy8nqcpkD9WsDYbo8purtOIt6ho=;
	b=GUJps9G+dPGfsO1cB8aA45YfL1wH3TMI2hOous6DORvxtj6smgh9cdnOaSviNw/r
	svXboi9BVt96J7aJg6NYQ1ab1HueYn48d61DNF3OeFsXK0oufyQkHhhbemsdpQ1cSNx
	iRcdtnJ7vy1C8YHsphgPINnBJSh5wJylP9uqxRq4=
From:	Brett Cundal <brett.cundal@iugome.com>
To:	git@vger.kernel.org
Message-ID: <010201560af48050-012ea887-a1e1-4d1b-82d3-4799ac7788bc-000000@eu-west-1.amazonses.com>
Subject: [PATCH] git-subtree.sh: Use --allow-unrelated-histories when
 splitting with --rejoin
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Thu, 21 Jul 2016 00:56:51 +0000
X-SES-Outgoing:	2016.07.21-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7a39b30..556cd92 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -661,7 +661,7 @@ cmd_split()
 	if [ -n "$rejoin" ]; then
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old)
-		git merge -s ours \
+		git merge -s ours --allow-unrelated-histories \
 			-m "$(rejoin_msg "$dir" $latest_old $latest_new)" \
 			$latest_new >&2 || exit $?
 	fi

--
https://github.com/git/git/pull/274
