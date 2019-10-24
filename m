Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6281F4C1
	for <e@80x24.org>; Thu, 24 Oct 2019 23:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfJXXgc (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:36:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29143 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727309AbfJXXga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571960189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Rbfjg8jjKhKxyMZMnQVoQJtkdX2yyeBQxAgO1sYJ/Q=;
        b=RJDXMaH/fsGWC95ACwvOMmuV/n1FFRJIGJEu5Am/A0MO0uR1B57nsp5UAAIEAJDYOF6S/A
        HNrk+L2g7Wf0e/MU5NcnZhbNm1pXFywSKUXvv5f1P6ExgCml97iGHkaNUo2SaG0RZjp/22
        lE6sBW4GDYqsRZ993uVIw0rYRhjeDno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-tL8KllvmMoCoQ3c32Wd5gw-1; Thu, 24 Oct 2019 19:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B481800D6B;
        Thu, 24 Oct 2019 23:36:24 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76467600C6;
        Thu, 24 Oct 2019 23:36:23 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com, Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v3 1/3] t6006: Use test-lib.sh definitions
Date:   Thu, 24 Oct 2019 19:36:15 -0400
Message-Id: <20191024233617.18716-2-prarit@redhat.com>
In-Reply-To: <20191024233617.18716-1-prarit@redhat.com>
References: <20191024233617.18716-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tL8KllvmMoCoQ3c32Wd5gw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use name and email definitions from test-lib.sh.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 t/t6006-rev-list-format.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index cfb74d0e0354..1f7d3f7acc9c 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -111,14 +111,14 @@ EOF
 # we don't test relative here
 test_format author %an%n%ae%n%ad%n%aD%n%at <<EOF
 commit $head2
-A U Thor
-author@example.com
+$GIT_AUTHOR_NAME
+$GIT_AUTHOR_EMAIL
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 commit $head1
-A U Thor
-author@example.com
+$GIT_AUTHOR_NAME
+$GIT_AUTHOR_EMAIL
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
@@ -126,14 +126,14 @@ EOF
=20
 test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<EOF
 commit $head2
-C O Mitter
-committer@example.com
+$GIT_COMMITTER_NAME
+$GIT_COMMITTER_EMAIL
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 commit $head1
-C O Mitter
-committer@example.com
+$GIT_COMMITTER_NAME
+$GIT_COMMITTER_EMAIL
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
@@ -410,7 +410,7 @@ test_expect_success 'empty email' '
 =09test_tick &&
 =09C=3D$(GIT_AUTHOR_EMAIL=3D git commit-tree HEAD^{tree} </dev/null) &&
 =09A=3D$(git show --pretty=3Dformat:%an,%ae,%ad%n -s $C) &&
-=09verbose test "$A" =3D "A U Thor,,Thu Apr 7 15:14:13 2005 -0700"
+=09verbose test "$A" =3D "$GIT_AUTHOR_NAME,,Thu Apr 7 15:14:13 2005 -0700"
 '
=20
 test_expect_success 'del LF before empty (1)' '
@@ -495,7 +495,7 @@ test_expect_success '%gd shortens ref name' '
 '
=20
 test_expect_success 'reflog identity' '
-=09echo "C O Mitter:committer@example.com" >expect &&
+=09echo "$GIT_COMMITTER_NAME:$GIT_COMMITTER_EMAIL" >expect &&
 =09git log -g -1 --format=3D"%gn:%ge" >actual &&
 =09test_cmp expect actual
 '
--=20
2.21.0

