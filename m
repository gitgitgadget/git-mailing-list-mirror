Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87331F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbfJXXgb (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:36:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732305AbfJXXga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571960189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/dRfvcKyRiSx6sur9HPxhHXoOsrIQRsMz+gqbKC7K4=;
        b=UYlEMPYUwXOVNezOfLw2cRrEs2+15KKQCE9xQc2TM3foHz0VDv7hoaul8tPIbmDGmKTVbu
        eEj8mJEMHmQqAQOdJLTEK6ZzAF29bbOfMVoewnIgOGVHaCQPXNbaZIlLaeAv51xGDywwHn
        Nou9iT2KiX+vOQSrofwXytqRzvUzixw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-qj0bbrdmOIOBpJSY4WrP9A-1; Thu, 24 Oct 2019 19:36:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17691476;
        Thu, 24 Oct 2019 23:36:25 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 539BE600C6;
        Thu, 24 Oct 2019 23:36:24 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com, Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v3 2/3] t4203: Use test-lib.sh definitions
Date:   Thu, 24 Oct 2019 19:36:16 -0400
Message-Id: <20191024233617.18716-3-prarit@redhat.com>
In-Reply-To: <20191024233617.18716-1-prarit@redhat.com>
References: <20191024233617.18716-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qj0bbrdmOIOBpJSY4WrP9A-1
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
 t/t4203-mailmap.sh | 94 +++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 918ada69eb96..e8f9c0f5bc8c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -13,8 +13,8 @@ fuzz_blame () {
 }
=20
 test_expect_success setup '
-=09cat >contacts <<-\EOF &&
-=09A U Thor <author@example.com>
+=09cat >contacts <<- EOF &&
+=09$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 =09nick1 <bugs@company.xx>
 =09EOF
=20
@@ -33,19 +33,19 @@ test_expect_success 'check-mailmap no arguments' '
 '
=20
 test_expect_success 'check-mailmap arguments' '
-=09cat >expect <<-\EOF &&
-=09A U Thor <author@example.com>
+=09cat >expect <<- EOF &&
+=09$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 =09nick1 <bugs@company.xx>
 =09EOF
 =09git check-mailmap \
-=09=09"A U Thor <author@example.com>" \
+=09=09"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" \
 =09=09"nick1 <bugs@company.xx>" >actual &&
 =09test_cmp expect actual
 '
=20
 test_expect_success 'check-mailmap --stdin' '
-=09cat >expect <<-\EOF &&
-=09A U Thor <author@example.com>
+=09cat >expect <<- EOF &&
+=09$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 =09nick1 <bugs@company.xx>
 =09EOF
 =09git check-mailmap --stdin <contacts >actual &&
@@ -66,8 +66,8 @@ test_expect_success 'check-mailmap bogus contact' '
 =09test_must_fail git check-mailmap bogus
 '
=20
-cat >expect <<\EOF
-A U Thor (1):
+cat >expect << EOF
+$GIT_AUTHOR_NAME (1):
       initial
=20
 nick1 (1):
@@ -90,7 +90,7 @@ nick1 (1):
 EOF
=20
 test_expect_success 'default .mailmap' '
-=09echo "Repo Guy <author@example.com>" > .mailmap &&
+=09echo "Repo Guy <$GIT_AUTHOR_EMAIL>" > .mailmap &&
 =09git shortlog HEAD >actual &&
 =09test_cmp expect actual
 '
@@ -122,7 +122,7 @@ Internal Guy (1):
=20
 EOF
 test_expect_success 'mailmap.file override' '
-=09echo "External Guy <author@example.com>" >> internal_mailmap/.mailmap &=
&
+=09echo "External Guy <$GIT_AUTHOR_EMAIL>" >> internal_mailmap/.mailmap &&
 =09git config mailmap.file internal_mailmap/.mailmap &&
 =09git shortlog HEAD >actual &&
 =09test_cmp expect actual
@@ -178,8 +178,8 @@ test_expect_success 'name entry after email entry, case=
-insensitive' '
 =09test_cmp expect actual
 '
=20
-cat >expect <<\EOF
-A U Thor (1):
+cat >expect << EOF
+$GIT_AUTHOR_NAME (1):
       initial
=20
 nick1 (1):
@@ -195,18 +195,18 @@ test_expect_success 'No mailmap files, but configured=
' '
 test_expect_success 'setup mailmap blob tests' '
 =09git checkout -b map &&
 =09test_when_finished "git checkout master" &&
-=09cat >just-bugs <<-\EOF &&
+=09cat >just-bugs <<- EOF &&
 =09Blob Guy <bugs@company.xx>
 =09EOF
-=09cat >both <<-\EOF &&
-=09Blob Guy <author@example.com>
+=09cat >both <<- EOF &&
+=09Blob Guy <$GIT_AUTHOR_EMAIL>
 =09Blob Guy <bugs@company.xx>
 =09EOF
-=09printf "Tricky Guy <author@example.com>" >no-newline &&
+=09printf "Tricky Guy <$GIT_AUTHOR_EMAIL>" >no-newline &&
 =09git add just-bugs both no-newline &&
 =09git commit -m "my mailmaps" &&
-=09echo "Repo Guy <author@example.com>" >.mailmap &&
-=09echo "Internal Guy <author@example.com>" >internal.map
+=09echo "Repo Guy <$GIT_AUTHOR_EMAIL>" >.mailmap &&
+=09echo "Internal Guy <$GIT_AUTHOR_EMAIL>" >internal.map
 '
=20
 test_expect_success 'mailmap.blob set' '
@@ -266,12 +266,12 @@ test_expect_success 'mailmap.blob defaults to off in =
non-bare repo' '
 =09git init non-bare &&
 =09(
 =09=09cd non-bare &&
-=09=09test_commit one .mailmap "Fake Name <author@example.com>" &&
+=09=09test_commit one .mailmap "Fake Name <$GIT_AUTHOR_EMAIL>" &&
 =09=09echo "     1=09Fake Name" >expect &&
 =09=09git shortlog -ns HEAD >actual &&
 =09=09test_cmp expect actual &&
 =09=09rm .mailmap &&
-=09=09echo "     1=09A U Thor" >expect &&
+=09=09echo "     1=09$GIT_AUTHOR_NAME" >expect &&
 =09=09git shortlog -ns HEAD >actual &&
 =09=09test_cmp expect actual
 =09)
@@ -305,26 +305,26 @@ test_expect_success 'cleanup after mailmap.blob tests=
' '
 '
=20
 test_expect_success 'single-character name' '
-=09echo "     1=09A <author@example.com>" >expect &&
+=09echo "     1=09A <$GIT_AUTHOR_EMAIL>" >expect &&
 =09echo "     1=09nick1 <bugs@company.xx>" >>expect &&
-=09echo "A <author@example.com>" >.mailmap &&
+=09echo "A <$GIT_AUTHOR_EMAIL>" >.mailmap &&
 =09test_when_finished "rm .mailmap" &&
 =09git shortlog -es HEAD >actual &&
 =09test_cmp expect actual
 '
=20
 test_expect_success 'preserve canonical email case' '
-=09echo "     1=09A U Thor <AUTHOR@example.com>" >expect &&
+=09echo "     1=09$GIT_AUTHOR_NAME <AUTHOR@example.com>" >expect &&
 =09echo "     1=09nick1 <bugs@company.xx>" >>expect &&
-=09echo "<AUTHOR@example.com> <author@example.com>" >.mailmap &&
+=09echo "<AUTHOR@example.com> <$GIT_AUTHOR_EMAIL>" >.mailmap &&
 =09test_when_finished "rm .mailmap" &&
 =09git shortlog -es HEAD >actual &&
 =09test_cmp expect actual
 '
=20
 # Extended mailmap configurations should give us the following output for =
shortlog
-cat >expect <<\EOF
-A U Thor <author@example.com> (1):
+cat >expect << EOF
+$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> (1):
       initial
=20
 CTO <cto@company.xx> (1):
@@ -370,7 +370,7 @@ test_expect_success 'Shortlog output (complex mapping)'=
 '
 =09git commit --author "CTO <cto@coompany.xx>" -m seventh &&
=20
 =09mkdir -p internal_mailmap &&
-=09echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
+=09echo "Committed <$GIT_COMMITTER_EMAIL>" > internal_mailmap/.mailmap &&
 =09echo "<cto@company.xx>                       <cto@coompany.xx>" >> inte=
rnal_mailmap/.mailmap &&
 =09echo "Some Dude <some@dude.xx>         nick1 <bugs@company.xx>" >> inte=
rnal_mailmap/.mailmap &&
 =09echo "Other Author <other@author.xx>   nick2 <bugs@company.xx>" >> inte=
rnal_mailmap/.mailmap &&
@@ -384,27 +384,27 @@ test_expect_success 'Shortlog output (complex mapping=
)' '
 '
=20
 # git log with --pretty format which uses the name and email mailmap place=
markers
-cat >expect <<\EOF
+cat >expect << EOF
 Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>
-Committer C O Mitter <committer@example.com> maps to Committed <committer@=
example.com>
+Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$G=
IT_COMMITTER_EMAIL>
=20
 Author claus <me@company.xx> maps to Santa Claus <santa.claus@northpole.xx=
>
-Committer C O Mitter <committer@example.com> maps to Committed <committer@=
example.com>
+Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$G=
IT_COMMITTER_EMAIL>
=20
 Author santa <me@company.xx> maps to Santa Claus <santa.claus@northpole.xx=
>
-Committer C O Mitter <committer@example.com> maps to Committed <committer@=
example.com>
+Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$G=
IT_COMMITTER_EMAIL>
=20
 Author nick2 <nick2@company.xx> maps to Other Author <other@author.xx>
-Committer C O Mitter <committer@example.com> maps to Committed <committer@=
example.com>
+Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$G=
IT_COMMITTER_EMAIL>
=20
 Author nick2 <bugs@company.xx> maps to Other Author <other@author.xx>
-Committer C O Mitter <committer@example.com> maps to Committed <committer@=
example.com>
+Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$G=
IT_COMMITTER_EMAIL>
=20
 Author nick1 <bugs@company.xx> maps to Some Dude <some@dude.xx>
-Committer C O Mitter <committer@example.com> maps to Committed <committer@=
example.com>
+Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$G=
IT_COMMITTER_EMAIL>
=20
-Author A U Thor <author@example.com> maps to A U Thor <author@example.com>
-Committer C O Mitter <committer@example.com> maps to Committed <committer@=
example.com>
+Author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> maps to $GIT_AUTHOR_NAME <$GIT=
_AUTHOR_EMAIL>
+Committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> maps to Committed <$G=
IT_COMMITTER_EMAIL>
 EOF
=20
 test_expect_success 'Log output (complex mapping)' '
@@ -412,14 +412,14 @@ test_expect_success 'Log output (complex mapping)' '
 =09test_cmp expect actual
 '
=20
-cat >expect <<\EOF
+cat >expect << EOF
 Author: CTO <cto@company.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Other Author <other@author.xx>
 Author: Other Author <other@author.xx>
 Author: Some Dude <some@dude.xx>
-Author: A U Thor <author@example.com>
+Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 EOF
=20
 test_expect_success 'Log output with --use-mailmap' '
@@ -427,14 +427,14 @@ test_expect_success 'Log output with --use-mailmap' '
 =09test_cmp expect actual
 '
=20
-cat >expect <<\EOF
+cat >expect << EOF
 Author: CTO <cto@company.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Other Author <other@author.xx>
 Author: Other Author <other@author.xx>
 Author: Some Dude <some@dude.xx>
-Author: A U Thor <author@example.com>
+Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 EOF
=20
 test_expect_success 'Log output with log.mailmap' '
@@ -443,28 +443,28 @@ test_expect_success 'Log output with log.mailmap' '
 '
=20
 test_expect_success 'log.mailmap=3Dfalse disables mailmap' '
-=09cat >expect <<-\EOF &&
+=09cat >expect <<- EOF &&
 =09Author: CTO <cto@coompany.xx>
 =09Author: claus <me@company.xx>
 =09Author: santa <me@company.xx>
 =09Author: nick2 <nick2@company.xx>
 =09Author: nick2 <bugs@company.xx>
 =09Author: nick1 <bugs@company.xx>
-=09Author: A U Thor <author@example.com>
+=09Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 =09EOF
 =09git -c log.mailmap=3DFalse log | grep Author > actual &&
 =09test_cmp expect actual
 '
=20
 test_expect_success '--no-use-mailmap disables mailmap' '
-=09cat >expect <<-\EOF &&
+=09cat >expect <<- EOF &&
 =09Author: CTO <cto@coompany.xx>
 =09Author: claus <me@company.xx>
 =09Author: santa <me@company.xx>
 =09Author: nick2 <nick2@company.xx>
 =09Author: nick2 <bugs@company.xx>
 =09Author: nick1 <bugs@company.xx>
-=09Author: A U Thor <author@example.com>
+=09Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 =09EOF
 =09git log --no-use-mailmap | grep Author > actual &&
 =09test_cmp expect actual
@@ -500,8 +500,8 @@ test_expect_success 'Only grep replaced author with --u=
se-mailmap' '
 '
=20
 # git blame
-cat >expect <<\EOF
-^OBJI (A U Thor     DATE 1) one
+cat >expect <<EOF
+^OBJI ($GIT_AUTHOR_NAME     DATE 1) one
 OBJID (Some Dude    DATE 2) two
 OBJID (Other Author DATE 3) three
 OBJID (Other Author DATE 4) four
--=20
2.21.0

