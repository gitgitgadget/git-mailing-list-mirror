From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] Fix documentation syntax of optional arguments in short
 options.
Date: Wed, 09 Apr 2008 13:07:14 +0200
Message-ID: <47FCA362.3090607@gmail.com>
References: <47FC4510.6080904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 13:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjYAD-0004NO-2W
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 13:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYDILHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 07:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYDILHa
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 07:07:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:38482 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbYDILHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 07:07:30 -0400
Received: by ug-out-1314.google.com with SMTP id z38so982784ugc.16
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=NVmYlroyPxvXwacG1TWt89HZl3wI4v6+yvGnBs3YJVc=;
        b=FNsT5ktEIjlH9jJcMlSX1bKc+pVXL5VuyDr5InzZImBuSngaaS/SEUi7GVvvNx/DGYaZ1GdGaFncFkcc9XzuHieionONz8JLTCR5NB7xxFUg0mhswgbm4ENqhtwFafvSh/0kGRXhBQ94wCSEXWOu8CY6+0Dol1tHk4lLK/pk4T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MJfOlRa/lw2cMAh3V5Wqivb1gf53UZmUC7rLI6vMi5eOx9ToaYAIlNHUUJ7+cDwPCmNJYyHl5/oBrQQsjySxYD9NXN0rqDnjOxczDbnXFNOttSkOzJ3r2aXjyeBDGz/JZqMOD+KLWJw2xcp63qUlXq8IYF3qfNT3WOx3FIe/6eE=
Received: by 10.67.24.18 with SMTP id b18mr4421600ugj.65.1207739247429;
        Wed, 09 Apr 2008 04:07:27 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id 40sm3647014uge.2.2008.04.09.04.07.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Apr 2008 04:07:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
In-Reply-To: <47FC4510.6080904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79103>

When an argument for an option is optional, like in -n from git-tag,
puting a space between the option and the argument is interpreted
as a missing argument for the option plus an isolated argument.
Documentation now reflects the need to write the parameter following
the option -n, as in "git tag -nARG", for instance.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   I forgot to make the same change to the command's syntax in builtin-tag.c.

   I didn't check if this also happens for OPTION_STRING, this is only for
   OPTION_INTEGER, which seems to be only used in git-tag. I must note that
   all this is related to the PARSE_OPT_OPTARG option, which is used only
   (apart from builtin-tag.c) in builtin-rev-parse.c but in a different way.

 Documentation/git-tag.txt |    4 ++--
 builtin-tag.c             |    2 +-
 parse-options.c           |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c22fb71..4b6fd90 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
 'git-tag' -d <name>...
-'git-tag' [-n [<num>]] -l [<pattern>]
+'git-tag' [-n[<num>]] -l [<pattern>]
 'git-tag' -v <name>...

 DESCRIPTION
@@ -57,7 +57,7 @@ OPTIONS
 -v::
 	Verify the gpg signature of the given tag names.

--n <num>::
+-n<num>::
 	<num> specifies how many lines from the annotation, if any,
 	are printed when using -l.
 	The default is not to print any annotation lines.
diff --git a/builtin-tag.c b/builtin-tag.c
index 8dd959f..129ff57 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -16,7 +16,7 @@
 static const char * const git_tag_usage[] = {
 	"git-tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git-tag -d <tagname>...",
-	"git-tag -l [-n [<num>]] [<pattern>]",
+	"git-tag -l [-n[<num>]] [<pattern>]",
 	"git-tag -v <tagname>...",
 	NULL
 };
diff --git a/parse-options.c b/parse-options.c
index e87cafb..acf3fe3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -344,7 +344,7 @@ void usage_with_options_internal(const char * const *usagestr,
 			break;
 		case OPTION_INTEGER:
 			if (opts->flags & PARSE_OPT_OPTARG)
-				pos += fprintf(stderr, " [<n>]");
+				pos += fprintf(stderr, "[<n>]");
 			else
 				pos += fprintf(stderr, " <n>");
 			break;
-- 
1.5.3.4
