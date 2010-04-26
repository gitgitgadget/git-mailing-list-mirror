From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] shortlog: Document and test --format option
Date: Mon, 26 Apr 2010 04:59:37 -0500
Message-ID: <20100426095937.GD31483@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
 <20100426095206.GA31483@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 11:59:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6L5f-0006Fo-Vd
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 11:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0DZJ6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 05:58:49 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:64754 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab0DZJ6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 05:58:45 -0400
Received: by pzk34 with SMTP id 34so5398907pzk.33
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PtIbnR86aN1vdQ9RE3hoMKwKoETop9kzLsjjGF8gvJw=;
        b=GwzXYkF9KahzMIwgNQggR4+YmWjzr1RRLRY2GQiAW8XXA0SIsGfjHZ+/OqVBnp8F7G
         l+ihjQMQLuPMh/8MadGKHUSTA3rjR62/iohTzu2EZBgLf/rBb/MW4u5VRSMxeca3xvYR
         QrP7nYt456Ag4se29B4vP5wJlmm+JsGM2Dl3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EC+jL+iRa1vm+T9OEtX19Z6l+p0sih7Znl8iRlDpkwvO5DKfxRq0155XqOKRCFpqG8
         6qd0QNFwwy4TMvTutdu7L1CqWfoO5nGA89mMOvLgz6JEybIUFGgXpBX9zUCyg5LJqyi8
         0wzL3tO4cKrDrrTly2atgmlRYh9HJSGJArwfo=
Received: by 10.142.119.6 with SMTP id r6mr1671945wfc.34.1272275924916;
        Mon, 26 Apr 2010 02:58:44 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3025326iwn.1.2010.04.26.02.58.43
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 02:58:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426095206.GA31483@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145804>

Do not document the --pretty synonym, since it takes too long to
explain the name to people.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-shortlog.txt |    8 ++++++
 t/t4201-shortlog.sh            |   53 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index dfd4d0c..15e92ed 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -39,6 +39,14 @@ OPTIONS
 --email::
 	Show the email address of each author.
 
+--format[='<format>']::
+	Instead of the commit subject, use some other information to
+	describe each commit.  '<format>' can be any string accepted
+	by the `--format` option of 'git log', such as '* [%h] %s'.
+	(See the "PRETTY FORMATS" section of linkgit:git-log[1].)
+
+	Each pretty-printed commit will be rewrapped before it is shown.
+
 -w[<width>[,<indent1>[,<indent2>]]]::
 	Linewrap the output by wrapping each line at `width`.  The first
 	line of each entry is indented by `indent1` spaces, and the second
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 6bfd0c0..899ddbe 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -39,7 +39,58 @@ test_expect_success 'setup' '
 
 	echo 6 >a1 &&
 	git commit --quiet -m "Commit by someone else" \
-		--author="Someone else <not!me>" a1
+		--author="Someone else <not!me>" a1 &&
+
+	cat >expect.template <<-\EOF
+	A U Thor (5):
+	      SUBJECT
+	      SUBJECT
+	      SUBJECT
+	      SUBJECT
+	      SUBJECT
+
+	Someone else (1):
+	      SUBJECT
+
+	EOF
+'
+
+fuzz() {
+	file=$1 &&
+	sed "
+			s/$_x40/OBJECT_NAME/g
+			s/$_x05/OBJID/g
+			s/^ \{6\}[CTa].*/      SUBJECT/g
+			s/^ \{8\}[^ ].*/        CONTINUATION/g
+		" <"$file" >"$file.fuzzy" &&
+	sed "/CONTINUATION/ d" <"$file.fuzzy"
+}
+
+test_expect_success 'default output format' '
+	git shortlog >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect.template log.predictable
+'
+
+test_expect_success 'pretty format' '
+	sed s/SUBJECT/OBJECT_NAME/ expect.template >expect &&
+	git shortlog --format="%H" >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect log.predictable
+'
+
+test_expect_failure '--abbrev' '
+	sed s/SUBJECT/OBJID/ expect.template >expect &&
+	git shortlog --format="%h" --abbrev=5 >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect log.predictable
+'
+
+test_expect_success 'output from user-defined format is re-wrapped' '
+	sed "s/SUBJECT/two lines/" expect.template >expect &&
+	git shortlog --format="two%nlines" >log &&
+	fuzz log >log.predictable &&
+	test_cmp expect log.predictable
 '
 
 test_expect_success 'shortlog wrapping' '
-- 
1.7.1.3.g5f1e.dirty
