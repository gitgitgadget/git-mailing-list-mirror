From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 21:49:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: msysgit+bncBCZPH74Q5YNRB56P66KQKGQESTAP36I@googlegroups.com Fri Dec 27 21:50:01 2013
Return-path: <msysgit+bncBCZPH74Q5YNRB56P66KQKGQESTAP36I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f184.google.com ([209.85.128.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB56P66KQKGQESTAP36I@googlegroups.com>)
	id 1VweM4-0004iL-OO
	for gcvm-msysgit@m.gmane.org; Fri, 27 Dec 2013 21:50:01 +0100
Received: by mail-ve0-f184.google.com with SMTP id jz11sf2084308veb.11
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 12:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=k7emxdaMS7jzziovDW0aRGcc/TqrpWQ2kxI20lAKAMo=;
        b=PfvZaSQWUK1rFE2b65Y+9I9MM22CflCNq5TiZehzIO4zKw/YTYoZa2exJ6/VzB80EC
         2GPsHvqStdfEnRe5zTUwI+WGD0R2jZos+3CxNhulWgMxS7PSAyC7hqpu4J16Bm5Py1bF
         YBKRh4pfssn/jcsYiRE9NoqLh0xnvenA3Xj81htmzfQ6G7yh4/XuJgdhwyBBlnKI4VGR
         1ys0u3ZRCK8RfjSPmW2l9SJuMWdzYlqfXp1Tinjk6VfsGMNVowoaF/RQEQtolELv1I9S
         EGkgFmzHFJ9DtxEtpLES9CIdOsEBo17byUxj4bwItGutFnCRXqrai/5g5vZul+TOxvVS
         qRng==
X-Received: by 10.182.118.170 with SMTP id kn10mr63157obb.20.1388177399817;
        Fri, 27 Dec 2013 12:49:59 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.205.163 with SMTP id lh3ls1169813obc.84.gmail; Fri, 27 Dec
 2013 12:49:59 -0800 (PST)
X-Received: by 10.182.153.68 with SMTP id ve4mr20722615obb.39.1388177399449;
        Fri, 27 Dec 2013 12:49:59 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id m7si1999852vdj.2.2013.12.27.12.49.59
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2013 12:49:59 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MDR21-1VfrUh0K3p-00GnVu
 for <msysgit@googlegroups.com>; Fri, 27 Dec 2013 21:49:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:imESBztBzLYVxVeaOOm45bQy6ilQMMI8suut0bmGyjBEh4YheVX
 NHkIONpcR0wX6DG25k6Suu5mps7eI+gByPJVE9aN+oZ76qxlsYlEN1rEVW5vzI2zDr9uVb5
 +ufrKRhFZHB+IRwCC1bArv6vrssmTnbfZR71+RC2Lj5DVSLc9jZTLAIK+HH8pzrbzvIosKm
 zzN9epZNnuEfb1CIjm5Kg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239745>


Support for grafts predates Git's strbuf, and hence it is understandable
that there was a hard-coded line length limit of 1023 characters (which
was chosen a bit awkwardly, given that it is *exactly* one byte short of
aligning with the 41 bytes occupied by a commit name and the following
space or new-line character).

While regular commit histories hardly win comprehensibility in general
if they merge more than twenty-two branches in one go, it is not Git's
business to limit grafts in such a way.

In this particular developer's case, the use case that requires
substantially longer graft lines to be supported is the visualization of
the commits' order implied by their changes: commits are considered to
have an implicit relationship iff exchanging them in an interactive
rebase would result in merge conflicts.

Thusly implied branches tend to be very shallow in general, and the
resulting thicket of implied branches is usually very wide; It is
actually quite common that *most* of the commits in a topic branch have
not even one implied parent, so that a final merge commit has about as
many implied parents as there are commits in said branch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/blame.c |  8 ++++----
 commit.c        | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1407ae7..9047b6e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1804,17 +1804,17 @@ static int prepare_lines(struct scoreboard *sb)
 static int read_ancestry(const char *graft_file)
 {
 	FILE *fp = fopen(graft_file, "r");
-	char buf[1024];
+	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
-	while (fgets(buf, sizeof(buf), fp)) {
+	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
-		int len = strlen(buf);
-		struct commit_graft *graft = read_graft_line(buf, len);
+		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
 		if (graft)
 			register_commit_graft(graft, 0);
 	}
 	fclose(fp);
+	strbuf_release(&buf);
 	return 0;
 }
 
diff --git a/commit.c b/commit.c
index de16a3c..57ebea2 100644
--- a/commit.c
+++ b/commit.c
@@ -196,19 +196,19 @@ bad_graft_data:
 static int read_graft_file(const char *graft_file)
 {
 	FILE *fp = fopen(graft_file, "r");
-	char buf[1024];
+	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
-	while (fgets(buf, sizeof(buf), fp)) {
+	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
-		int len = strlen(buf);
-		struct commit_graft *graft = read_graft_line(buf, len);
+		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
 		if (!graft)
 			continue;
 		if (register_commit_graft(graft, 1))
-			error("duplicate graft data: %s", buf);
+			error("duplicate graft data: %s", buf.buf);
 	}
 	fclose(fp);
+	strbuf_release(&buf);
 	return 0;
 }
 
-- 
1.8.4.msysgit.0.1109.g3c58b16

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
