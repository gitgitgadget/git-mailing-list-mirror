From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/24] Show usage string for 'git get-tar-commit-id -h'
Date: Mon,  9 Nov 2009 09:04:50 -0600
Message-ID: <1257779104-23884-10-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Vf9-0002nn-Mo
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbZKIOz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZKIOzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:25 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbZKIOzW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:22 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=//CPFm8+XBmCw/2+WGuLGpPgCNTHvDibvRu+LGCPnTE=;
        b=TMwftNFQYgZIrCoK4WvwbosJ8ppZyUoDmMHIF365AgT2ORxNBpPCJKRC19DcFU60Dg
         zXh4MtOBIgZbR/bdoj0xXgHLw7ZXP9whj8tHvWCPlaQIC2OwRPx650ul9DLCs4PH7Xgl
         X4Ug7U8ieJxqbWDnklljFtVWGbHTLdFEOhHXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qGBDecqxduwNVK683FAFi6nz3dMn6N/LhFP+zzzkfUBVGwz97Ec+XBCdMSHBMJbktv
         mnVrljK9vpczKvPLKKP7LK+xa9xQTcthJzreacfDPgiF7d/4Jw8y8+dI2RfWI3pNmZaB
         CC+pHCXeEgUvSFd/ASW7zDX+CKKgXoV0fmAFY=
Received: by 10.216.91.73 with SMTP id g51mr2523378wef.68.1257778528017;
        Mon, 09 Nov 2009 06:55:28 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:27 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132468>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-tar-tree.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 8b3a35e..3f1e701 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -11,6 +11,9 @@ static const char tar_tree_usage[] =
 "git tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
 "*** Note that this command is now deprecated; use \"git archive\" instead.";
 
+static const char builtin_get_tar_commit_id_usage[] =
+"git get-tar-commit-id < <tarfile>";
+
 int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 {
 	/*
@@ -81,6 +84,9 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	char *content = buffer + RECORDSIZE;
 	ssize_t n;
 
+	if (argc != 1)
+		usage(builtin_get_tar_commit_id_usage);
+
 	n = read_in_full(0, buffer, HEADERSIZE);
 	if (n < HEADERSIZE)
 		die("git get-tar-commit-id: read error");
-- 
1.6.5.2
