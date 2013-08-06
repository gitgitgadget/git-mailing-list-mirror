From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/16] line-range-format.txt: clarify -L:regex usage form
Date: Tue,  6 Aug 2013 09:59:35 -0400
Message-ID: <1375797589-65308-3-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:00:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hoa-0003Su-Kd
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab3HFOAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:30 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:55943 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab3HFOA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:29 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so761133oag.15
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebbXip0bNidHnrQXgy75QKA/EpvJ/DQ4Uzkf0oUlEe8=;
        b=JUWWX/TqCgxivykKGN0VDxNKdKx2UkNXPZ1ODoBfDZ0Ib4y81g0m/YkxADBEJwn4Pp
         GwWQkwKZCgfldo/WT+iAQ5oEW65My7RzfIB0phiO+boMPUT9oPWDw6OP5HzvNTEJ0MPp
         VfIfMI92jKjXpZbd3Gmtu6tD3+kMdISroEcbrDUan+LH3ViTrjHvN4bLxHhiHuq1pcyC
         QVrdr54dZtRCQxY5nwcmsE1lEq7GPqnuS/nRJQ5C7ZXfpXhaZ1+g0AcCDNEqFmr1VQIw
         Lfx9xw5U859QhOlgFfPtF6nseGVgwMqmQ8FQC7a6My44mgE2CfIlHHyvpQpxmNhruZO2
         r5qA==
X-Received: by 10.60.132.84 with SMTP id os20mr1056432oeb.94.1375797628270;
        Tue, 06 Aug 2013 07:00:28 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231743>

blame/log documentation describes -L option as:

  -L<start>,<end>
  -L:<regex>

  <start> and <end> can take one of these forms:

    * number
    * /regex/
    * +offset or -offset
    * :regex

which is incorrect and confusing since :regex is not one of the valid
forms of <start> or <end>; in fact, it must be -L's lone argument.

Clarify by discussing :<regex> at the same indentation level as "<start>
and <end>...":

  -L<start>,<end>
  -L:<regex>

  <start> and <end> can take one of these forms:

    * number
    * /regex/
    * +offset or -offset

  If :<regex> is given in place of <start> and <end> ...

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/blame-options.txt     | 2 --
 Documentation/git-log.txt           | 2 --
 Documentation/line-range-format.txt | 7 +++----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 4e55b15..489032c 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -15,8 +15,6 @@
 	``-L <start>'' or ``-L <start>,'' spans from <start> to end of file.
 	``-L ,<end>'' spans from start of file to <end>.
 +
-<start> and <end> can take one of these forms:
-
 include::line-range-format.txt[]
 
 -l::
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index fe04e06..34097ef 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -72,8 +72,6 @@ produced by --stat etc.
 	give zero or one positive revision arguments.
 	You can specify this option more than once.
 +
-<start> and <end> can take one of these forms:
-
 include::line-range-format.txt[]
 
 <revision range>::
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index 3e7ce72..a1b2f4e 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -1,3 +1,5 @@
+<start> and <end> can take one of these forms:
+
 - number
 +
 If <start> or <end> is a number, it specifies an
@@ -15,11 +17,8 @@ starting at the line given by <start>.
 +
 This is only valid for <end> and will specify a number
 of lines before or after the line given by <start>.
-+
 
-- :regex
 +
-If the option's argument is of the form :regex, it denotes the range
+If ``:<regex>'' is given in place of <start> and <end>, it denotes the range
 from the first funcname line that matches <regex>, up to the next
 funcname line.
-+
-- 
1.8.4.rc1.409.gbd48715
