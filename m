From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v6 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
Date: Tue, 25 Jun 2013 12:55:30 +0400
Message-ID: <21a6f94ba53a1e130fd2153af46aae7467f6e0b5.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 10:57:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrP4S-00011C-4a
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 10:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab3FYI5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 04:57:31 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:34795 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab3FYIzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 04:55:50 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so11496841lab.21
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=OQLVd0TLilP99mfJofmc39WBbBmPHu4FIrNRqH4ujvo=;
        b=iSDZ1vupjaybKTMf3sB7z98A9v9RW+tQGy0mWSHdyYucqDRu0UrrVGtf8XQWCzrLR6
         J1TtbhbvmJJcGlrZBFah8PlDN/7crJJXLtZv8Dd0iM+yTm5AsHVXHf4IyTsqg55/dfH3
         eqhYiMg4JSfsL3Ons1xlixVP7lPx+6iNjNsBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=OQLVd0TLilP99mfJofmc39WBbBmPHu4FIrNRqH4ujvo=;
        b=JfA6Hvew0mWUK8J9Gu1lKu4UFnxn6041h7ypvv22z+wznEOOOWEvGkNazZqMANKGr4
         xphxPgBFZOTSttpi51Q2ckQLyEzBUpp5CKsqHXga8hiVXCHscTgHzFSxjm1pUJtPEDox
         JInca2B0VBdSyX2CZFYIX1Ca1BtvO6rrSanpPnRdf9HSVqYDuP6tZ0wQlv7ry6bQW7kg
         q4T/RyDYItNwfPokrXkDHnumNxWCoknJr81Z8qYOuOTvjOlydNsDsDMAO5p7zTr4t3iV
         WpdvlGV0VvMEhR2+/Bps7M2LLwEsCO5d/+y/iQQeHilh0YnD/zZq4YRRvZRAG8VD2v0w
         hLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=OQLVd0TLilP99mfJofmc39WBbBmPHu4FIrNRqH4ujvo=;
        b=WRWjsqS6mzQleSNtO8utwHRfy8p/eEGc2YLh/41fMtJWyqmVMb96P92PDcZQVamMre
         8eLSjWKGE+5My3zRLil+0RxdRJ68ZtTk+ZI27sDcrfxPtCQuEuScxuP9B0cAe8bDQ+sp
         j2u5b/jd4wUTJ60WZ1L3PEWNtwiqn2YLtvbhabHA4JW27zGEBoUmX38kjutscMC4mcgz
         wnjctYSAK+dRoVAK49uq0Lr0BtuPkyZHCf1Tq2ns/tURFqWzoASIePKdz6fqX0RkzmL/
         ZpyCvKMERdDMbnM0auR3WeQg1nIPjSJL0TAOsRlI5h89sJtSpEfe+CxoRkVBIg6Wf+jZ
         3CDg==
X-Received: by 10.112.218.100 with SMTP id pf4mr14813018lbc.2.1372150547987;
        Tue, 25 Jun 2013 01:55:47 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id a9sm4017369lbj.9.2013.06.25.01.55.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 01:55:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372149305.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com> <cover.1372149305.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQnY/qD1+vmd+pOnFKaiS2C7mP6yEmeqh5G/XEhxU0Au9BuB/l9mcW2mtEx0diSBFQ8OyGR7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228952>

The expected SHA-1 digests are always available in variables. Use
them instead of hardcoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 48 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 26fbfde..73ba5e8 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -101,7 +101,11 @@ test_expect_failure 'NUL termination with --stat' '
 
 test_expect_success 'setup more commits' '
 	test_commit "message one" one one message-one &&
-	test_commit "message two" two two message-two
+	test_commit "message two" two two message-two &&
+	head1=$(git rev-parse --verify --short HEAD~0) &&
+	head2=$(git rev-parse --verify --short HEAD~1) &&
+	head3=$(git rev-parse --verify --short HEAD~2) &&
+	head4=$(git rev-parse --verify --short HEAD~3)
 '
 
 test_expect_success 'left alignment formatting' '
@@ -117,18 +121,18 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting at the nth column' '
-	git log --pretty="format:%h %<|(40)%s" >actual &&
+test_expect_success 'left alignment formatting at the nth column' "
+	git log --pretty='format:%h %<|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
-fa33ab1 message two                    Z
-7cd6c63 message one                    Z
-1711bf9 add bar                        Z
-af20c06 initial                        Z
+$head1 message two                    Z
+$head2 message one                    Z
+$head3 add bar                        Z
+$head4 initial                        Z
 EOF
 	test_cmp expected actual
-'
+"
 
 test_expect_success 'left alignment formatting with no padding' '
 	git log --pretty="format:%<(1)%s" >actual &&
@@ -195,18 +199,18 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'right alignment formatting at the nth column' '
-	git log --pretty="format:%h %>|(40)%s" >actual &&
+test_expect_success 'right alignment formatting at the nth column' "
+	git log --pretty='format:%h %>|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
-fa33ab1                      message two
-7cd6c63                      message one
-1711bf9                          add bar
-af20c06                          initial
+$head1                      message two
+$head2                      message one
+$head3                          add bar
+$head4                          initial
 EOF
 	test_cmp expected actual
-'
+"
 
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty="format:%>(1)%s" >actual &&
@@ -234,18 +238,18 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'center alignment formatting at the nth column' '
-	git log --pretty="format:%h %><|(40)%s" >actual &&
+test_expect_success 'center alignment formatting at the nth column' "
+	git log --pretty='format:%h %><|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
 	qz_to_tab_space <<\EOF >expected &&
-fa33ab1           message two          Z
-7cd6c63           message one          Z
-1711bf9             add bar            Z
-af20c06             initial            Z
+$head1           message two          Z
+$head2           message one          Z
+$head3             add bar            Z
+$head4             initial            Z
 EOF
 	test_cmp expected actual
-'
+"
 
 test_expect_success 'center alignment formatting with no padding' '
 	git log --pretty="format:%><(1)%s" >actual &&
-- 
1.8.3.1.15.g5c23c1e
