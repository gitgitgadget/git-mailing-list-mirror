From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] ls-tree fixes
Date: Sun, 30 Nov 2014 16:04:59 +0700
Message-ID: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 10:05:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0RV-00064n-U8
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 10:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbaK3JFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 04:05:12 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52804 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbaK3JFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 04:05:06 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so9141989pac.36
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 01:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=2ZOg+YPQCGrq40h6de6Hhdli/0rZB7RgaCUIaXdF3Ow=;
        b=sFmr+PBaETUd6Y/QKUk7xBE7oIhE2kQh6Piym7pKQUnc8PPRqtYl5N/0MEZxzObCMO
         GzeziCi9X7ZJzxjPgxOjSVMD6OrQXjuY7zaf4deYA9w0uexVEwpgkZAJ5e8jnLD17gtI
         OdX13M2DO47ROKM2I7QnZ0wfLCQi/akA1gWgZRkxecuv1aoUBp+4h6hTqrRQI+OAWVnc
         VzUIfvKSMrq+phrYlYKcXaS7eXiqozbGYk97tjj0s14pcHPOAtnHgZxlonHpwUVYEdou
         uHPw4axwztEXpn6+M8tMlKsLPKiyR0BbF1gjAdX0fHJgPk5c0qL1QWVbDYF44P2l90/r
         KQSQ==
X-Received: by 10.68.69.109 with SMTP id d13mr88627468pbu.57.1417338306267;
        Sun, 30 Nov 2014 01:05:06 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id th7sm14467475pac.47.2014.11.30.01.05.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 01:05:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 16:05:03 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260443>

The first two fix ls-tree's unable to handle relative paths outside
$PWD. The last one rejects negative pathspec. This is a resend from

http://thread.gmane.org/gmane.comp.version-control.git/259233/focus=3D2=
59264

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  tree.c: update read_tree_recursive callback to pass strbuf as base
  ls-tree: remove path filtering logic in show_tree
  ls-tree: disable negative pathspec because it's not supported

 archive.c                    | 34 +++++++++++++++++++++-------------
 builtin/checkout.c           |  8 ++++----
 builtin/log.c                |  2 +-
 builtin/ls-tree.c            | 20 +++++++++++---------
 merge-recursive.c            | 15 ++++++---------
 quote.c                      | 21 ---------------------
 quote.h                      |  2 --
 t/t3102-ls-tree-wildcards.sh |  8 ++++++++
 tree.c                       | 16 +++++++++++-----
 tree.h                       |  3 ++-
 10 files changed, 64 insertions(+), 65 deletions(-)

--=20
2.2.0.60.gb7b3c64
