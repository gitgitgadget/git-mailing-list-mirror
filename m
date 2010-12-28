From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 20/31] rebase: show consistent conflict resolution hint
Date: Tue, 28 Dec 2010 10:30:37 +0100
Message-ID: <1293528648-21873-21-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYl-0005Wr-Uh
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab0L1PdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:01 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab0L1Pc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:58 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mjH+TRC4jafr67Xm2WlzB5hJwqfUhf+iS96/eM8I9Dg=;
        b=rnrcM/wj7++XLB2XA37FyvQY0FDfupu5GuXgYmINEQT/ktxMue76lrucI/tIByclC5
         iuKwdpa2G9273abhgrtCrJ7N+qzTD1XNNKh+uY31aiaSTbM4noeZZ7HcCxzJpsKEVQKF
         Oz9LfQLKBVVP66JIH7nQSeh4HLPz4jAACicxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RPbuUvvbwWPU1/3ILpGfKiwu8d1B2dUIecMu5jvbzQBIQLcQFa+XsJSIm32n4Ht9c2
         UqqjVSQrN5Fr9LDUoBwXMOVLvDOuDms87KaWbsognfgRAFbmxg4KaPl3u0ZOnfYsiCnk
         g+s65UNHAaEjjGuUFV2AhjGpJwS577A8bW5rU=
Received: by 10.229.189.66 with SMTP id dd2mr12103270qcb.168.1293550377888;
        Tue, 28 Dec 2010 07:32:57 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:57 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164257>

When rebase stops due to conflict, interactive rebase currently
displays a different hint to the user than non-interactive rebase
does. Use the same message for both types of rebase.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Should we include the "mark the corrected paths with 'git add
<paths>'" part?

 git-rebase--interactive.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0beeb8b..e848ea2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -81,9 +81,7 @@ AMEND="$DOTEST"/amend
 REWRITTEN_LIST="$DOTEST"/rewritten-list
 REWRITTEN_PENDING="$DOTEST"/rewritten-pending
 
-GIT_CHERRY_PICK_HELP="\
-hint: after resolving the conflicts, mark the corrected paths
-hint: with 'git add <paths>' and run 'git rebase --continue'"
+GIT_CHERRY_PICK_HELP="$RESOLVEMSG"
 export GIT_CHERRY_PICK_HELP
 
 warn () {
-- 
1.7.3.2.864.gbbb96
