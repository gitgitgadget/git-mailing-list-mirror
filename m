Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF4C1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbdCMSv6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:51:58 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:34939 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbdCMSv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:51:56 -0400
Received: by mail-it0-f42.google.com with SMTP id m27so34393697iti.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=auvik.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=QoSBlJljpI8DFLnEQCAEUBQo9NDyqi3MoMPCkPckjWk=;
        b=amF/oZFkbzYWntJNizpDF1+wUNlfX1UaT0eqIxYfEhYP6ePOk0UXAy9iy6Iy2cs1ce
         nyw0f9VQ51+yPtqocNo/uIyDM1rq0h/KL/qEZFTlB93aSVqM7x2F+wbxBjYqKc/v1NCP
         st7Qn+ulDJrDGWv6/mUvIb1pqhbk8EHJ0YQJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=QoSBlJljpI8DFLnEQCAEUBQo9NDyqi3MoMPCkPckjWk=;
        b=PdvVaMryyOIXHgEgsZ7o+MAa6RjNJQrKQ1TIRU9OxJ3TW5KzxEUaC1Dnq+EoxE8Xbi
         OxfTUun484tbTQYrI6zKcGS2bP0M//DOS3XpzDJCXn0NUbPZkm2NX6TwpZGDTmXbNofr
         pbpgy/vLzoKtFwIh8lOKXPx+vcWvJysFak6TcvG+SKmb7ZpFe3PQA+WcolKERO3aAk+U
         6DO7ndOFsYUchqpY0o4VsXQnrYt2EkIVyLxU/oQ4tEUlQO+bLSUKkR4uIUBRWNmVu32R
         VmiaAEuzC4gg9KXE6xT7XIzbl7lNr0rGG2Q71qkOvhAaRQH8keWoftrDatA9p6KUoSo+
         2VTA==
X-Gm-Message-State: AFeK/H07/Rd7uVJfvAdCmlg570Xe+5GtgiZ47K36Wm30/AbLIBBCTAoKQcsmVZMZtHQggWJI
X-Received: by 10.36.204.136 with SMTP id x130mr12456432itf.93.1489431115083;
        Mon, 13 Mar 2017 11:51:55 -0700 (PDT)
Received: from [10.0.40.22] ([206.174.182.138])
        by smtp.gmail.com with ESMTPSA id h15sm4001611ita.20.2017.03.13.11.51.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 11:51:53 -0700 (PDT)
From:   Anthony Scian <ascian@auvik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: 'git add --patch' no longer allows you to select files before
 selecting patches 
Message-Id: <DF55CDE6-E556-4C07-B661-0F5AA00D306E@auvik.com>
Date:   Mon, 13 Mar 2017 14:51:52 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similarly the patch sub-command in =E2=80=98git add =E2=80=94interactive=E2=
=80=99 goes immediately to selecting patches starting with the first =
file.
Is there a git configuration that would being back the old behaviour? =
Why was this changed?

here is a sample interaction that shows the =E2=80=98r=E2=80=99 =
sub-command still retains the desired behaviour of asking what files to =
involve but the =E2=80=98p=E2=80=99
sub-command immediately assumes all files are important and starts =
stepping through all the patches=E2=80=A6

:~$ brew list
... git ...
:~$ which git
/usr/local/bin/git
:~$ git version
git version 2.12.0
:~$=20
:~$  git add --interactive
           staged     unstaged path
  1:    unchanged       +43/-2 =
core/src/main/scala/com/company/npl/planner/TrAc.scala
  2:    unchanged        +4/-4 =
core/src/main/scala/com/company/npl/tools/AnFu.scala
  3:    unchanged      +59/-12 =
core/src/main/scala/com/company/npl/tools/CoFu.scala
  4:    unchanged        +7/-1 =
module/reports/src/main/scala/com/company/npl/reports/ReStCo.scala
  5:    unchanged      +10/-23 =
runtime/src/main/npl/migrationSchemas/schema_for_migration_to_W4.npl
  6:    unchanged        +5/-3 =
runtime/src/main/scala/com/company/npl/table/adapter/InPe.scala
  7:    unchanged      +39/-82 =
runtime/src/main/scala/com/company/npl/table/migrations/schema_for_W4.scal=
a
  8:    unchanged       +14/-1 =
ui/modules/admin/app/assets/javascripts/defs/de_sub.js

*** Commands ***
  1: status	  2: update	  3: revert	  4: add untracked
  5: patch	  6: diff	  7: quit	  8: help
What now> r
           staged     unstaged path
  1:    unchanged       +43/-2 =
core/src/main/scala/com/company/npl/planner/TrAc.scala
  2:    unchanged        +4/-4 =
core/src/main/scala/com/company/npl/tools/AnFu.scala
  3:    unchanged      +59/-12 =
core/src/main/scala/com/company/npl/tools/CoFu.scala
  4:    unchanged        +7/-1 =
module/reports/src/main/scala/com/company/npl/reports/ReStCo.scala
  5:    unchanged      +10/-23 =
runtime/src/main/npl/migrationSchemas/schema_for_migration_to_W4.npl
  6:    unchanged        +5/-3 =
runtime/src/main/scala/com/company/npl/table/adapter/InPe.scala
  7:    unchanged      +39/-82 =
runtime/src/main/scala/com/company/npl/table/migrations/schema_for_W4.scal=
a
  8:    unchanged       +14/-1 =
ui/modules/admin/app/assets/javascripts/defs/de_sub.js
Revert>> 5
           staged     unstaged path
  1:    unchanged       +43/-2 =
core/src/main/scala/com/company/npl/planner/TrAc.scala
  2:    unchanged        +4/-4 =
core/src/main/scala/com/company/npl/tools/AnFu.scala
  3:    unchanged      +59/-12 =
core/src/main/scala/com/company/npl/tools/CoFu.scala
  4:    unchanged        +7/-1 =
module/reports/src/main/scala/com/company/npl/reports/ReStCo.scala
* 5:    unchanged      +10/-23 =
runtime/src/main/npl/migrationSchemas/schema_for_migration_to_W4.npl
  6:    unchanged        +5/-3 =
runtime/src/main/scala/com/company/npl/table/adapter/InPe.scala
  7:    unchanged      +39/-82 =
runtime/src/main/scala/com/company/npl/table/migrations/schema_for_W4.scal=
a
  8:    unchanged       +14/-1 =
ui/modules/admin/app/assets/javascripts/defs/de_sub.js
Revert>> 7
           staged     unstaged path
  1:    unchanged       +43/-2 =
core/src/main/scala/com/company/npl/planner/TrAc.scala
  2:    unchanged        +4/-4 =
core/src/main/scala/com/company/npl/tools/AnFu.scala
  3:    unchanged      +59/-12 =
core/src/main/scala/com/company/npl/tools/CoFu.scala
  4:    unchanged        +7/-1 =
module/reports/src/main/scala/com/company/npl/reports/ReStCo.scala
* 5:    unchanged      +10/-23 =
runtime/src/main/npl/migrationSchemas/schema_for_migration_to_W4.npl
  6:    unchanged        +5/-3 =
runtime/src/main/scala/com/company/npl/table/adapter/InPe.scala
* 7:    unchanged      +39/-82 =
runtime/src/main/scala/com/company/npl/table/migrations/schema_for_W4.scal=
a
  8:    unchanged       +14/-1 =
ui/modules/admin/app/assets/javascripts/defs/de_sub.js
Revert>>=20
reverted 2 paths

*** Commands ***
  1: status	  2: update	  3: revert	  4: add untracked
  5: patch	  6: diff	  7: quit	  8: help
What now> p
diff --git a/core/src/main/scala/com/company/npl/planner/TrAc.scala =
b/core/src/main/scala/com/company/npl/planner/TrAc.scala
index 938cdc2a1b..669dc5f95b 100644
--- a/core/src/main/scala/com/company/npl/planner/TrAc.scala
+++ b/core/src/main/scala/com/company/npl/planner/TrAc.scala
@@ -24,8 +24,7 @@ import com.company.npl.tools.CoFu
  */
 case class TrAc(action: View with Generator, when: View, exceptWhen: =
Option[View], required: Boolean) {
   private def mergeAction(rhs: TrAc): View with Generator =3D action =
match {
-    case Always | Never =3D>
-      rhs.action
+    case Always | Never =3D> rhs.action
     case _ =3D>
       require(rhs.action =3D=3D Always || rhs.action =3D=3D Never)
       action
Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? q

*** Commands ***
  1: status	  2: update	  3: revert	  4: add untracked
  5: patch	  6: diff	  7: quit	  8: help
What now> q
Bye.
:~$



