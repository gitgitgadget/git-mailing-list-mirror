From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2 1/2] git-archive: add '-o' as a alias for '--output'
Date: Mon, 14 Sep 2009 00:13:36 +0400
Message-ID: <20090913201336.GG30385@dpotapov.dyndns.org>
References: <7v3a6r5znq.fsf@alter.siamese.dyndns.org> <1252863407-2598-1-git-send-email-dpotapov@gmail.com> <7v4or6sngc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 22:18:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmvX1-0001MK-Ew
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 22:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbZIMUSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbZIMUSf
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 16:18:35 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:52277 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbZIMUSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 16:18:34 -0400
Received: by fxm17 with SMTP id 17so462994fxm.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q1yiTHJbG5npPctnM/c9J6NU8uFlhQKdSPdF3WjKaQw=;
        b=MC7mZjbBvRoBrERwLRO6jXb7opuqPhcOiS32Bh226GPS2lEjU+j1umJIkTezH5Ssmq
         WfwMpOXCnteRJSOnQ01vNe97KFcLJ241yu6Qh4mDmBLixAV8IAoVNzkKNNngAd97cSeR
         K9fc+lbZH/r6hPIJXDtJU8NTT0jdMSCMN7/J0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z3AqUOlDHKAFb0+raDlLi8RsMWoE/vm+N3ZJN9iOMGyoFyEJ/XVaMMD7MzUCnHSGrm
         /8ei8T87Rf3R1gli/DPM8p/OsQq0u5iva88OVdlXkrJP9X/4AgbMHWVN6geBVmIRd999
         VI1Lf4k3F9m3foyh3mKQwqw9JM1ljYzQmcNoo=
Received: by 10.86.238.30 with SMTP id l30mr4206121fgh.75.1252873117156;
        Sun, 13 Sep 2009 13:18:37 -0700 (PDT)
Received: from localhost (ppp91-77-225-181.pppoe.mtu-net.ru [91.77.225.181])
        by mx.google.com with ESMTPS id l12sm204517fgb.18.2009.09.13.13.18.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 13:18:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4or6sngc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128406>

The '-o' option is commonly used in many tools to specify the output file.
Typing '--output' every time is a bit too long to be a practical alternative
to redirecting output. But specifying the output name has the advantage of
making possible to guess the desired output format by filename extension.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

On Sun, Sep 13, 2009 at 11:34:43AM -0700, Junio C Hamano wrote:
> I think this patch is very reasonable, except for this hunk, which would
> want to say "-o <file>::" instead.

Corrected.

 Documentation/git-archive.txt |    3 ++-
 archive.c                     |    2 +-
 builtin-archive.c             |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 92444dd..1917f2e 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
-	      [--output=<file>] [--worktree-attributes]
+	      [-o | --output=<file>] [--worktree-attributes]
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [path...]
 
@@ -48,6 +48,7 @@ OPTIONS
 --prefix=<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
 
+-o <file>::
 --output=<file>::
 	Write the archive to <file> instead of stdout.
 
diff --git a/archive.c b/archive.c
index 0bca9ca..73b8e8a 100644
--- a/archive.c
+++ b/archive.c
@@ -283,7 +283,7 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_STRING(0, "prefix", &base, "prefix",
 			"prepend prefix to each pathname in the archive"),
-		OPT_STRING(0, "output", &output, "file",
+		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
 		OPT_BOOLEAN(0, "worktree-attributes", &worktree_attributes,
 			"read .gitattributes in working directory"),
diff --git a/builtin-archive.c b/builtin-archive.c
index f9a4bea..565314b 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -71,7 +71,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *output = NULL;
 	const char *remote = NULL;
 	struct option local_opts[] = {
-		OPT_STRING(0, "output", &output, "file",
+		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
 		OPT_STRING(0, "remote", &remote, "repo",
 			"retrieve the archive from remote repository <repo>"),
-- 
1.6.5.rc1.2.g6bb993
