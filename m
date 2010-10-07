From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Thu,  7 Oct 2010 20:59:51 +0200
Message-ID: <081ad1459d5b1584cbe474581bd3a01d0d58d11d.1286477945.git.bert.wesarg@googlemail.com>
References: <AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 21:00:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vhC-0002Bk-SQ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab0JGS75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 14:59:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51434 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0JGS74 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 14:59:56 -0400
Received: by fxm14 with SMTP id 14so14743fxm.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=62HlDJdFYdwI+0z2Esz5CxbLVPpBH9pgjczpzpgdPGk=;
        b=uJKxAYB/FTcZjYvEMJFocBZGKYRNRlc9B0JPsYbhCaaKOHSC2SICXevocwYIlUwOnu
         MktQQD8ESqxWvf7IGwiq+YGuRkjbq3MjF5nGPbLFx1N5RUjL79QuPfPLqZH628kshCcM
         MVJFvUZFGjea8mpvp6zqmYxDjolaSkIyldVkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ihnByRz6cvMwc6YtoscKreDgdaVc3QGrOQhdX6AFOzaHPbNzQ9ojzyEgN/3qw6Xxve
         XTR0FB+bgfKM3lZCtrB9a90q0L7vcLb1n37W/Y+l8TaDhbYQ05LycnkfRV7EoXKMT5iv
         3uzZycitVzKZ/MKnWKbQZVwJFMm/VxOehkqCI=
Received: by 10.223.105.1 with SMTP id r1mr1773082fao.1.1286477994909;
        Thu, 07 Oct 2010 11:59:54 -0700 (PDT)
Received: from localhost (p5B0F784F.dip.t-dialin.net [91.15.120.79])
        by mx.google.com with ESMTPS id 2sm1233126faz.38.2010.10.07.11.59.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 11:59:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158431>

Also mention, that --stdin and --index-info needs to be the last
option supplied and indicate this in the usage string.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/git-update-index.txt |   13 +++++++------
 builtin/update-index.c             |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 74d1d49..022c0fc 100644 Documentation/git-update-index.txt
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -18,10 +18,10 @@ SYNOPSIS
 	     [--skip-worktree | --no-skip-worktree]
 	     [--ignore-submodules]
 	     [--really-refresh] [--unresolve] [--again | -g]
-	     [--info-only] [--index-info]
-	     [-z] [--stdin]
+	     [--info-only]
 	     [--verbose]
-	     [--] [<file>]*
+	     [[-z] --stdin | --index-info]
+	     [--] [<file>]
 
 DESCRIPTION
 -----------
@@ -72,7 +72,7 @@ OPTIONS
 	Directly insert the specified info into the index.
 
 --index-info::
-        Read index information from stdin.
+        Read index information from stdin. (Must be the last option.)
 
 --chmod=(+|-)x::
         Set the execute permissions on the updated files.
@@ -139,13 +139,14 @@ you will need to handle the situation manually.
 	Instead of taking list of paths from the command line,
 	read list of paths from the standard input.  Paths are
 	separated by LF (i.e. one path per line) by default.
+	(Must be the last option.)
 
 --verbose::
         Report what is being added and removed from index.
 
 -z::
-	Only meaningful with `--stdin`; paths are separated with
-	NUL character instead of LF.
+	Only meaningful with `--stdin` or `--index-info`; paths are
+	separated with NUL character instead of LF.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..2c1a81e 100644 builtin/update-index.c
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -398,7 +398,7 @@ static void read_index_info(int line_termination)
 }
 
 static const char update_index_usage[] =
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--unresolve] [--again | -g] [--ignore-missing] [--verbose] [[-z] --stdin | --index-info] [--] <file>...";
 
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
-- 
1.7.1.1067.g5aeb7
