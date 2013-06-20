From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v5 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
Date: Thu, 20 Jun 2013 13:26:19 +0400
Message-ID: <8ca30465721ee9f98613397c1778640e3fcc0f83.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 11:27:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upb8z-00038i-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 11:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256Ab3FTJ06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 05:26:58 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:64228 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965226Ab3FTJ0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 05:26:55 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so5521546lbi.26
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=P7YGS8SQx0PdTthNL8VAJkghlYSVzUBka4cvRWVNcg8=;
        b=gwyW8lfUgsObnE4ZJnQbbcG+dRN0lOi5ngbUkPPUlnX7deNKEGJLmby9/RfNkPDRJU
         w5eh3oAs48zCBk7sPxKa42hAI21QDwjsKe2uJiFuTak0fACv7NAbV9QYcqnqRa5TnyQs
         fDBjyhRvssQacWBT+0D/gwLcbLSHCqZnXYo8Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=P7YGS8SQx0PdTthNL8VAJkghlYSVzUBka4cvRWVNcg8=;
        b=mMjhKCwvUyosa41bdTFnD0SvO7HaVbIOwDu9xfejUSdzJnfZGAuIcYrrVOtz7n35Vb
         SzzXJoYeI64YlcfsOKq+BkNj+tpNbC58vYGqmHNR1nHvMQii4XYUJSafbDv3VwLw9x1G
         Nm2oAWJD9O4yv1QjrsucQF/Nvtw/P+Hol/tyQNVqQyrt15EJJK4ZdVMIj50nxfsrE7bY
         MdCNUo6+nD87G+J7dIlE/TU55OH4EBagPycngx5UXIAstdfqaZjAHpBb43uQfjdAy0Bg
         GUx3R83rVGc2moGVKf9YiyhrYJRbBpN7sIOQb6iL6AxbmA5petxYYjw2SXqZxzkFW1ho
         ezfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=P7YGS8SQx0PdTthNL8VAJkghlYSVzUBka4cvRWVNcg8=;
        b=FYFSAahptYBuwQhlPr53OpGYd+xCHmCzsbVo4xOxIPJFkn5+eVPIl+YqfqvvDeQqJV
         5rBJ9o2dWFgaj8sZn/fV2WLxVpNkHjgsivAU36cbWEgJCe8bjvLU3jek0d+cbp2dGf6E
         yQxXh1SGnuyMo3ichspUe1XFaidGZXt49bAScmVtupnJtvYTNDe69uzyfT21Bz4OiQT6
         Y/QbHLoFj2jIuzL8kGXhoxbcDIxEu6fduUVWd2+UieM2Rt/1FN2yb6LgomoTZUmKZny1
         ur4XFdB5RkFKmX0wl9S6Ikd74ycoaIn8Pt8ut02MzRK+0DfpH0Y3V9VyH6sk6Iew9dGP
         GHfA==
X-Received: by 10.112.235.104 with SMTP id ul8mr5104799lbc.36.1371720414012;
        Thu, 20 Jun 2013 02:26:54 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id rx1sm34444lbb.0.2013.06.20.02.26.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 02:26:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1371720245.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com> <cover.1371720245.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQnuDWhDR+Ps4CCWHyHNAKpoIIptKXUyk1I3WnXY00VblBCXauJi2UrOiGoGYFRTnc6lbXMP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228471>

The expected SHA-1 digests are always available in variables. Use
them instead of hardcoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 48 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 26fbfde..6d8d457 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -101,7 +101,11 @@ test_expect_failure 'NUL termination with --stat' '
 
 test_expect_success 'setup more commits' '
 	test_commit "message one" one one message-one &&
-	test_commit "message two" two two message-two
+	test_commit "message two" two two message-two &&
+	head1=$(git rev-list --max-count=1 --abbrev-commit HEAD~0) &&
+	head2=$(git rev-list --max-count=1 --abbrev-commit HEAD~1) &&
+	head3=$(git rev-list --max-count=1 --abbrev-commit HEAD~2) &&
+	head4=$(git rev-list --max-count=1 --abbrev-commit HEAD~3)
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
