From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 23/24] merge-{recursive,subtree}: use usage() to print usage
Date: Mon,  9 Nov 2009 09:05:03 -0600
Message-ID: <1257779104-23884-23-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfF-0002nn-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038AbZKIOz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756037AbZKIOzz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:55 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbZKIOzv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:51 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OQfd/2EeYC1NoScxCsqRDCYmxaAtFiyhcGvtm5zZYrY=;
        b=VjevP1mwRI8YB8d+22k9WFPwQMdwrSis8r8KO9wqbo1XGy00S8pq7CTDX1MMKq/op/
         ZvBHBoJktGzzb+behHQWWd3dlroMKtptJ4ZE7Q45j79JNqU22moHNu8bLjG8esdNfNoM
         x3E10xNNMi4jKF14aG3heLUbb8Insi1+Lyy/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=utdhgTkn7GbWQunxYcpEgdpmO8RBaBaE8A/VpiTzgSQbxkitt69n0eN2cnXC3QJgMp
         VqdT4H9wN/tsTmkzKn7OABH7mKl4Q3qL0AkO2GFrBn20RwC+gcL6WVPR2d/kijp4BRCI
         t4dGy7K4D5b5kK37ra5Jr1HXcdlilE+K984nQ=
Received: by 10.216.93.2 with SMTP id k2mr2566832wef.210.1257778556657;
        Mon, 09 Nov 2009 06:55:56 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:55 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132479>

Usage messages (for example, from "git merge-recursive -h") are
friendlier when not preceded by "fatal".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index d26a96e..add5900 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -33,7 +33,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	}
 
 	if (argc < 4)
-		die("Usage: %s <base>... -- <head> <remote> ...", argv[0]);
+		usage("%s <base>... -- <head> <remote> ...", argv[0]);
 
 	for (i = 1; i < argc; ++i) {
 		if (!strcmp(argv[i], "--"))
-- 
1.6.5.2
