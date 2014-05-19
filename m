From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v3 1/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
Date: Mon, 19 May 2014 19:28:16 +0400
Message-ID: <69a0e0d286e3c2999e47e9591a91901baaa52327.1400513063.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 17:28:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPUm-00043V-5H
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbaESP2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 11:28:51 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:45485 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbaESP2u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:28:50 -0400
Received: by mail-lb0-f181.google.com with SMTP id u10so518021lbd.12
        for <git@vger.kernel.org>; Mon, 19 May 2014 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uZxoyyMvM0lDVQusVtXKvUZqCQQIpIeVwz0gUM3J+CM=;
        b=LQCVHYnGvmShcPrEodW3u5ZDkfeKtvjix21F8+Qftagpurltj7IJQ4H2DwmO8itsq/
         NKSovc1sghCdzByCKygrX8Vegr2wjdPcxfAKsn42r1nPQ2251zm+KXWSAlN4CIyK3Fqw
         Vx4Ar3bTFAQbk7fx7D3CgkWbmTKs8qHvuZVAw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uZxoyyMvM0lDVQusVtXKvUZqCQQIpIeVwz0gUM3J+CM=;
        b=kSN0+91xnrHlzHpR7iE3NfQCFvbWsHYKyP0y+d/Nq1G6NDhsXzBaA7wmKZwx0fh/H4
         9Bv/dGktFk/XiWzR9mIeHjhnDsuFM/DuFcb1fKZAwFcZdGtrC77xxICUWaZKSjFZOvfE
         xc+VmdghHC9QA/urbCmO+OsRXg1v5eABwebj5KhWoDGiJX0/VQUH+VhUnBjVVSYINmKg
         7g/U0QIL6zPdlVWaBRpftykMXv+DXIyyVWxTsSGlRX21qc1jmVJEtdlxtxO+CfqWpuPJ
         gwLyYNMF9ra7IDmin2jl8VTUZBhJqj4Tu//gM2aZkzQ9nmTvIDjPiGJLUqUnB8tb4ECd
         NTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=uZxoyyMvM0lDVQusVtXKvUZqCQQIpIeVwz0gUM3J+CM=;
        b=bZsvOzP5FpxiTPJxB0hSWWVckdnVAp7QFSxCed89GV5q00w0/peHH4L8Q8dL7TNsU6
         KquankKR0WIXgdq/6ANoW9PO66wgUlvs5wvKUqncU+zT1CSM8+fYbMPzld4PAeMJmD6t
         jp+afefymum41PJHV/zbv7jLnBbuUfUlApI1H984yzw0OmgW+iYyNIuaUmkgPYkpQmUp
         6CQy4jPWh/sWIADgLJND/brWyXQosLiyvjsKtr4U/rUT++J8axKLi+b8XOW+tZ27lyPu
         X36+HlKpEKGHIFaiDJ9wVpJ/FBIgZhJxINGTqzNF+o1JewpskZMYFXAVI1r0LQpJKahc
         9aBA==
X-Gm-Message-State: ALoCoQmKSSRDCfgqgd0EvImTtiAv3u/pwxYlCnIsBns/XCjuxBe2qt3mZjEcN6sI7OlV8cKw3uRQ
X-Received: by 10.112.118.236 with SMTP id kp12mr2805791lbb.56.1400513328222;
        Mon, 19 May 2014 08:28:48 -0700 (PDT)
Received: from localhost (ppp91-77-214-38.pppoe.mtu-net.ru. [91.77.214.38])
        by mx.google.com with ESMTPSA id k8sm20122082lae.1.2014.05.19.08.28.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 08:28:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
References: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com> <cover.1400513063.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249585>

The expected SHA-1 digests are always available in variables. Use
them instead of hardcoding.

That was introduced in a742f2a (t4205 (log-pretty-formats): don't
hardcode SHA-1 in expected outputs, 2013-06-26) but unfortunately was
not followed in 5e1361c (log: properly handle decorations with chained
tags, 2013-12-17)

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 2a6278b..f9f33ae 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -296,6 +296,10 @@ EOF
 	test_cmp expected actual
 '
 
+# save HEAD's SHA-1 digest (with no abbreviations) to use it below
+# as far as the next test amends HEAD
+old_head1=$(git rev-parse --verify HEAD~0)
+
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &&
 	git log --pretty="format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
@@ -310,6 +314,10 @@ EOF
 	test_cmp expected actual
 '
 
+# get new digests (with no abbreviations)
+head1=$(git rev-parse --verify HEAD~0) &&
+head2=$(git rev-parse --verify HEAD~1) &&
+
 test_expect_success 'log decoration properly follows tag chain' '
 	git tag -a tag1 -m tag1 &&
 	git tag -a tag2 -m tag2 tag1 &&
@@ -317,9 +325,9 @@ test_expect_success 'log decoration properly follows tag chain' '
 	git commit --amend -m shorter &&
 	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
 	cat <<EOF >expected &&
-6a908c10688b2503073c39c9ba26322c73902bb5  (tag: refs/tags/tag2)
-9f716384d92283fb915a4eee5073f030638e05f9  (tag: refs/tags/message-one)
-b87e4cccdb77336ea79d89224737be7ea8e95367  (tag: refs/tags/message-two)
+$head1  (tag: refs/tags/tag2)
+$head2  (tag: refs/tags/message-one)
+$old_head1  (tag: refs/tags/message-two)
 EOF
 	sort actual >actual1 &&
 	test_cmp expected actual1
-- 
1.9.2-15
