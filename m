X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_DISCARD,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: how to revert changes in working tree?
Date: Thu, 7 Dec 2006 08:15:56 +0100
Message-ID: <17783.49068.189000.958873@lapjr.intranet.kiel.bmiag.de>
References: <4576680B.7030500@gmail.com>
	<81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com>
	<45769417.70601@gmail.com>
	<81b0412b0612060220n11fb7e19hc6ed202759962bd3@mail.gmail.com>
	<4576A60A.3060003@gmail.com>
	<20061206181302.GA20320@spearce.org>
	<45777197.50805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 07:16:30 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45777197.50805@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33557>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsDUa-0003Yb-1Y for gcvg-git@gmane.org; Thu, 07 Dec
 2006 08:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031758AbWLGHQW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 02:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031761AbWLGHQW
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 02:16:22 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:2401 "HELO bilbo.bmiag.de"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1031758AbWLGHQV
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 02:16:21 -0500
Received: (qmail 22636 invoked by uid 106); 7 Dec 2006 07:16:18 -0000
Received: from eorl.intranet.kiel.bmiag.de(10.131.2.1) via SMTP by
 bilbo.bmiag.de, id smtpdHuP12S; Thu Dec  7 08:16:12 2006
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 3B59F3AE06; Thu,  7 Dec
 2006 08:16:12 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1]) by localhost (eorl
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 14606-02; Thu, 7 Dec
 2006 08:16:04 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5]) by
 eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 239753AE05; Thu,  7 Dec
 2006 08:15:59 +0100 (CET)
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao writes:
 > Yes, you are very right.
 > 
 > $ git ls-files |tr A-Z a-z | sort | uniq -c |grep -v "1 "
 >       2 include/linux/netfilter/xt_connmark.h
 >       2 include/linux/netfilter/xt_dscp.h
 >       2 include/linux/netfilter/xt_mark.h
 >       2 include/linux/netfilter_ipv4/ipt_connmark.h
 >       2 include/linux/netfilter_ipv4/ipt_dscp.h
 >       2 include/linux/netfilter_ipv4/ipt_ecn.h
 >       2 include/linux/netfilter_ipv4/ipt_mark.h
 >       2 include/linux/netfilter_ipv4/ipt_tcpmss.h
 >       2 include/linux/netfilter_ipv4/ipt_tos.h
 >       2 include/linux/netfilter_ipv4/ipt_ttl.h
 >       2 include/linux/netfilter_ipv6/ip6t_hl.h
 >       2 include/linux/netfilter_ipv6/ip6t_mark.h
 >       2 net/ipv4/netfilter/ipt_ecn.c
 >       2 net/ipv4/netfilter/ipt_tos.c
 >       2 net/ipv4/netfilter/ipt_ttl.c
 >       2 net/ipv6/netfilter/ip6t_hl.c
 >       2 net/netfilter/xt_connmark.c
 >       2 net/netfilter/xt_dscp.c
 >       2 net/netfilter/xt_mark.c
 > 
 > poor Windows... :-(

Incidentally I have this in my tree for a while, but it is not good
enough for general use, because you really need the original (not
lowercased) file names to resolve the problem. But my shell scripting
magic is not up to that task.

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 723a9ef..0ceb01b 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -7,6 +7,17 @@
 #
 # To enable this hook, make this file executable.

+# Detect case challenges
+
+case_challenge=`git ls-files | tr A-Z a-z | sort | uniq -d`
+if [ -n "$case_challenge" ]
+then
+       echo >&2 "index contains file names differing only in case."
+       echo >&2 "lowercase names follow:"
+       echo >&2 "$case_challenge"
+       exit 1
+fi
+
 # This is slightly modified from Andrew Morton's Perfect Patch.
 # Lines you introduce should not have trailing whitespace.
 # Also check for an indentation that has SP before a TAB.
