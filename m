From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/4] nd/pathspec-wildcard
Date: Sat, 24 Nov 2012 11:33:47 +0700
Message-ID: <1353731631-20593-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 05:34:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc7Rd-0005YB-FU
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 05:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697Ab2KXEeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2012 23:34:05 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44365 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2KXEeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 23:34:03 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6867625pbc.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 20:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=xzKpy+kBw3XiDo6bL++uabe4kzlhK1bg2YMJ3r3ZM/Y=;
        b=yU/YHt2dBwZuuZQH+YDUhbcakCwIzH9Kg3CdqDQhm9cjXMDjAJ1+UxD3dAQ2S7xoTo
         OYG8UA8BGasu3dnfBPFnf5yQX1yoWZTdKpZOq9s5kAncVL/JlbMW3/N46o+HFEJVG/Vm
         fXOuqzo81qw9Ku/0Ow5wQuJ8PSBps4sHv+o6rc6uq0XJ/F5tPv3P9uSCQx4gpgXbjGYY
         rVWTv6QgIauSJS5+w3o1+VQz+z4/yAeBet3SN3psjt8Br5xKkGku24KattJKlDcMsLib
         n1KvAJTh2T0NuH01v2kFKXr+cnIYn79YSStwcmt+2sZNxj3HiziECaUWhvqAfvTdm9Y3
         OFcQ==
Received: by 10.68.219.164 with SMTP id pp4mr19353541pbc.72.1353731642583;
        Fri, 23 Nov 2012 20:34:02 -0800 (PST)
Received: from lanh ([115.74.35.242])
        by mx.google.com with ESMTPS id vn2sm4852038pbc.31.2012.11.23.20.33.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 20:34:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 24 Nov 2012 11:33:56 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210311>

The only change (apart from what Junio's made after I sent the series)
is rename GF_* to GFNM_* and PSF_* to PATHSPEC_* with a brief explanati=
on
for each flag.

=2Egitignore code does not have "foo*oob" bug that the original series =
has.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  pathspec: save the non-wildcard length part
  pathspec: do exact comparison on the leading non-wildcard part
  pathspec: apply "*.c" optimization from exclude
  tree_entry_interesting: do basedir compare on wildcard patterns when
    possible

 builtin/ls-files.c |  2 +-
 builtin/ls-tree.c  |  2 +-
 cache.h            |  5 +++-
 dir.c              | 36 +++++++++++++++++++++++---
 dir.h              |  9 +++++++
 tree-walk.c        | 75 ++++++++++++++++++++++++++++++++++++++++++++++=
++++----
 6 files changed, 118 insertions(+), 11 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
