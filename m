From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/24] Show usage string for 'git fast-import -h'
Date: Mon,  9 Nov 2009 09:04:49 -0600
Message-ID: <1257779104-23884-9-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:55:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VeZ-0002Sr-Mk
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbZKIOzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbZKIOzX
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:23 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61909 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbZKIOzV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:21 -0500
Received: by bwz27 with SMTP id 27so3533124bwz.21
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/lN17I0NhyXjGgH3+0J6BvR/x5BYxIkCg5pbJKvomJ8=;
        b=PdxD+gru5UNF4Xdc2TOk8hAyhHKlj1zFJCErXtfbzwG6v7c5arp6WVS3zN5i4BSIm1
         Ywywv3we6/IHzjAmyukG/FVlx3fhdbxYMXCBtVdSxv/841P43m/uTJjy3XU4X3jnjvct
         EU9wfTI9owBLHdf/PJttYCJlKcLOcTFivS6Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oY4yl25Aw7iM6DvpKVBXW/p866K7MMs6fdDtChJmny4QWIsJ+kZhS/vEZIdoWauSdP
         neuLHbL6HpnuqPjlAr2NleGnaaLOMWim34avBwhuqK1PEvcveLoRaRYnIutShe5bsgdv
         GxkSI/V99UoTwahkjfKuDtckW51Iea6lJ/0iY=
Received: by 10.216.88.7 with SMTP id z7mr2590720wee.19.1257778526015;
        Mon, 09 Nov 2009 06:55:26 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:24 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132465>

Let "git fast-import -h" (with no other arguments) print usage
before exiting, even when run outside any repository.

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6faaaac..f4f1de6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2405,6 +2405,9 @@ int main(int argc, const char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(fast_import_usage);
+
 	setup_git_directory();
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
-- 
1.6.5.2
