From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/10] i18n relative dates, help, remote, apply, index-pack and bundle
Date: Mon, 23 Apr 2012 19:30:20 +0700
Message-ID: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:34:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMISu-0005Bw-Bk
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab2DWMd4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:33:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56844 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126Ab2DWMdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:33:55 -0400
Received: by pbcun15 with SMTP id un15so3836495pbc.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=pFJi6ndp+NL2JyWhWTkBrKjh2iQ1Z2sf7UYeZh3poIg=;
        b=JvkdckePRI7sChRwNu4PKejFYO72d3bSMZGCe7rM1F94uUmw6mxZ7ZZNTcSDQ6UOsE
         5sEvFHfPyJwtT5rImiaRd4fi9iSkJXQ68smLfgh7GdQdPPTRt5OyFG/yHx5mE+p6YgBc
         EHWCAFP4o2X8JG80omuB2NlDfTCCBP9s+ifzaUPKQB8gYxzIRe2EPts7IH4vB4Pf6LQR
         Q9TTRD7Ehzv8F1DTtff/o9NeOCpxq2vFoLlYmAHph86oM2jWX09wLJeyG8WQZLbO9/Y8
         dvjxnvckuL2Z/6j/8Doglgu2c9bcdH3IxAlnyNarqa83bs/g+Snk+E318C7VrPWdUUtc
         tAmg==
Received: by 10.68.132.36 with SMTP id or4mr29617792pbb.115.1335184434520;
        Mon, 23 Apr 2012 05:33:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id 2sm14285053pbw.57.2012.04.23.05.33.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:33:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:30:37 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196114>

Compared to v1 [1], parseopt patch is taken out. I attempted to
convert all struct option, and it turned into a huge series [2]. Not
sure how to submit that series yet.

Apart from that, Makefile is updated to make sure xgettext scan all
files, including header files. fprintf_ln() now uses fputc (so do a
few other places). About 4 more sentences in plural forms are detected
and converted to Q_().

[1] http://thread.gmane.org/gmane.comp.version-control.git/195623
[2] https://github.com/pclouds/git/tree/parseopt-i18n

Jonathan Nieder (1):
  i18n: mark relative dates for translation

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  Makefile: feed all header files to xgettext
  Add three convenient format printing functions with \n automatically
    appended
  i18n: help: mark strings for translation
  i18n: make warn_dangling_symref() automatically append \n
  i18n: remote: mark strings for translation
  i18n: apply: mark strings for translation
  i18n: apply: update say_patch_name to give translators complete
    sentence
  i18n: index-pack: mark strings for translation
  i18n: bundle: mark strings for translation

 Makefile             |   49 +++++++----
 builtin/apply.c      |  206 ++++++++++++++++++++++++------------------=
---
 builtin/fetch.c      |    4 +-
 builtin/help.c       |   48 +++++-----
 builtin/index-pack.c |  125 +++++++++++++++-------------
 builtin/remote.c     |  227 +++++++++++++++++++++++++++---------------=
--------
 bundle.c             |   38 +++++----
 cache.h              |    6 +-
 date.c               |   95 ++++++++++++---------
 generate-cmdlist.sh  |    2 +-
 git.c                |    2 +-
 help.c               |   32 +++++---
 refs.c               |    1 +
 strbuf.c             |   33 +++++++
 strbuf.h             |    7 ++
 test-date.c          |    7 +-
 16 files changed, 504 insertions(+), 378 deletions(-)

--=20
1.7.8.36.g69ee2
