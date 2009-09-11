From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] add documentation for mailinfo.scissors and '--no-scissors'
Date: Fri, 11 Sep 2009 02:29:58 +0200
Message-ID: <f63e8402656c02fc2ecdcce8a37cc1d60a61aa1d.1252628643.git.nicolas.s.dev@gmx.fr>
References: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 02:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlu3O-0001Xh-K5
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 02:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbZIKAaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbZIKAaF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 20:30:05 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:18064 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbZIKAaC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 20:30:02 -0400
Received: by ey-out-2122.google.com with SMTP id 25so137723eya.19
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Pbw7Z5JYTDHZ8baOUfJ7N4Ethj3frfpXhNpboiB0nHA=;
        b=OHW+mnvLGimhV7XwnhDBf5y4Jn5l1blWsmwM8ODLHxzUXSDCUPl8DV/jWN49CxTbY3
         Nne/4J7KTihzDAijUijupH0fmGpeng3llzhFvvyPR43vOM2z5GJEe6aViBXXx0JeFdkT
         539ZImByyimObLu7a1egb7DWBRgl9eEylW8rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=t/HuQKZWQGUVFdSrYXo0bRR3uSVY7fE5MRW2KpP/v+rWeEg4UMxoUR5dgEJC88SciC
         Dm1eehYwhcjTycHP5eGHYMEBe4uMxOuEg90igtn7Ubv/emw69uaefXQvPx6gphnEoDla
         KfZ9fHyKmbG8DSxFUm7WJfkteciZfsfpJyY1E=
Received: by 10.216.87.68 with SMTP id x46mr635846wee.2.1252629004330;
        Thu, 10 Sep 2009 17:30:04 -0700 (PDT)
Received: from localhost (91-164-133-105.rev.libertysurf.net [91.164.133.105])
        by mx.google.com with ESMTPS id 5sm1351377eyf.0.2009.09.10.17.30.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 17:30:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.168.gdcd6e
In-Reply-To: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128165>

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

I've missed the documentation of --no-scissors in git-am.txt in the previous
round (second hunks here).

Sorry for inconvenience.

 Documentation/git-am.txt       |    5 ++++-
 Documentation/git-mailinfo.txt |    6 ++++++
 builtin-mailinfo.c             |    2 +-
 git-am.sh                      |    1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 87781f4..14ae3a5 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--reject] [-q | --quiet] [--scissors]
+	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
 
@@ -44,6 +44,9 @@ OPTIONS
 	Remove everything in body before a scissors line (see
 	linkgit:git-mailinfo[1]).
 
+---no-scissors::
+	Do not obey to a scissors line (see linkgit:git-mailinfo[1]).
+
 -q::
 --quiet::
 	Be quiet. Only print error messages.
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 823ab82..55b8c5e 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -62,6 +62,12 @@ This is useful if you want to begin your message in a discussion thread
 with comments and suggestions on the message you are responding to, and to
 conclude it with a patch submission, separating the discussion and the
 beginning of the proposed commit log message with a scissors line.
++
+This can enabled by default with the configuration option mailinfo.scissors.
+
+--no-scissors::
+	Do not obey to a scissors line. This is only useful if mailinfo.scissors is
+	enabled (see --scissors).
 
 <msg>::
 	The commit log message extracted from e-mail, usually
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 7d22fd7..d498b1c 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -1004,7 +1004,7 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 }
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors] msg patch < mail >info";
+	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
diff --git a/git-am.sh b/git-am.sh
index 26ffe70..f242d1a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 c,scissors      strip everything before a scissors line
+no-scissors     don't obey to a scissors line (default)
 whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
 ignore-whitespace pass it through git-apply
-- 
1.6.5.rc0.168.gdcd6e
