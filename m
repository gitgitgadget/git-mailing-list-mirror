From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/42] repo setup test cases and fixes
Date: Fri, 29 Oct 2010 13:48:12 +0700
Message-ID: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:49:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBimM-0005le-2c
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab0J2Gt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:49:29 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab0J2Gt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:49:27 -0400
Received: by pwj3 with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Kdt+2oDY+qoAiYq95rjOgocBAKbxOb1R0n0SkhxB4D8=;
        b=p0qrpEHNW+bJocUjSC97kgdZcDNm9UV4Rak9rXPRRmA0BtU33kz0wIWGOwC7Y6Z+L2
         HsJMPN/T6idLisJdOYHQ2mUkql8sZqRKsf+YUodZoimDQz8xBBN+qgJSUPmd7erDc6Tg
         8Jz+mqUMdbkWvGKl0y0X6UR8wk7AoVVVAcV9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ospRB/x2glssD2Vtij43NuEE0FynHhrEdpKb68dWGRChz3m8flFx1P/pEjpBijClxR
         uzaoqh+1mffiMkDmQSFqjcEFo6609ZNXr+jm27AjRbQHbcYL4el4+RPEdJBUCSphFF6/
         xg4gi7tAnUf8rcdni9DxZvfBjyO2AHrxGhv60=
Received: by 10.142.178.12 with SMTP id a12mr1022949wff.85.1288334967345;
        Thu, 28 Oct 2010 23:49:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id v19sm1032529wfh.0.2010.10.28.23.49.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:49:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:49:26 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160268>

I hope this is the last time setup_* functions need to be fixed. There
is still room for improvement though. Two comes to mind are:

 - warn users when GIT_WORK_TREE/core.worktree/core.bare is set but
   ignored
 - turn absolute path to relative where possible

This series includes setup coverage tests (180/376 fail). Then the fixe=
s,
which bring down to zero failed test in the end. 02/42 describes the
rules. New rules are:

 - GIT_WORK_TREE is relative to user's cwd. This is how the code works
   until now (which also makes sense to me).

 - core.worktree won't override core.bare.

Documents may need updates. I'll do that later.


Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (42):
  builtins: print setup info if repo is found
  Add t1510 and basic rules that run repo setup
  t1510: setup case #0
  t1510: setup case #1
  t1510: setup case #2
  t1510: setup case #3
  t1510: setup case #4
  t1510: setup case #5
  t1510: setup case #6
  t1510: setup case #7
  t1510: setup case #8
  t1510: setup case #9
  t1510: setup case #10
  t1510: setup case #11
  t1510: setup case #12
  t1510: setup case #13
  t1510: setup case #14
  t1510: setup case #15
  t1510: setup case #16
  t1510: setup case #17
  t1510: setup case #18
  t1510: setup case #19
  t1510: setup case #20
  t1510: setup case #21
  t1510: setup case #22
  t1510: setup case #23
  t1510: setup case #24
  t1510: setup case #25
  t1510: setup case #26
  t1510: setup case #27
  t1510: setup case #28
  t1510: setup case #29
  t1510: setup case #30
  t1510: setup case #31

Tests


  rev-parse: prints --git-dir relative to user's cwd

Indepdent fix, but is needed after setup_* rework because the new code
will set relative git_dir.


  Add git_config_early()
  Use git_config_early() instead of git_config() during repo setup

Cherry-picked from my old tp/setup series, needed to be able to check
core.{bare,worktree} early.


  Remove all logic from get_git_work_tree()

Break it some more.


  setup: clean up setup_bare_git_dir()
  setup: clean up setup_discovered_git_dir()
  setup: rework setup_explicit_git_dir()

setup_* rework.

  t1510: all failed tests are now fixed

All tests are passed.


 builtin/init-db.c     |   13 +-
 builtin/rev-parse.c   |    6 +-
 cache.h               |    2 +
 config.c              |   19 +-
 environment.c         |   21 +-
 git.c                 |    4 +
 setup.c               |  227 ++-
 t/t1510-repo-setup.sh | 4515 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 trace.c               |   42 +
 9 files changed, 4733 insertions(+), 116 deletions(-)
 create mode 100755 t/t1510-repo-setup.sh
