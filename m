From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 00/10] Column display
Date: Tue, 28 Feb 2012 18:58:41 +0700
Message-ID: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 12:59:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Lhj-00050Y-3P
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965405Ab2B1L6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 06:58:46 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53635 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965344Ab2B1L6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:58:45 -0500
Received: by daed14 with SMTP id d14so2265513dae.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 03:58:45 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.197.134 as permitted sender) client-ip=10.68.197.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.197.134 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.197.134])
        by 10.68.197.134 with SMTP id iu6mr50673077pbc.81.1330430325308 (num_hops = 1);
        Tue, 28 Feb 2012 03:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=w5cELpO57+jvrxKK6Ngh9TzV+qFfWOivL4RKbzAa/Sk=;
        b=vwU/nftXAyzJvi2JGCh54RuUsCrhxzgqpYn3stC1ZGEKNNGii137YkogykRdGudE4Y
         p5AAerZoxP9XH0zBbAh8+IsNAqAYuiQBJQWQ3GmxEd2cBvAVk1x+7p/Vu2T25avU9kFF
         zVgcbPoZDxZVDYqJjavBto6g2n+ugzOv1flTg=
Received: by 10.68.197.134 with SMTP id iu6mr42772966pbc.81.1330430325261;
        Tue, 28 Feb 2012 03:58:45 -0800 (PST)
Received: from tre ([115.74.56.186])
        by mx.google.com with ESMTPS id h3sm15499491pbr.75.2012.02.28.03.58.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 03:58:43 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 28 Feb 2012 18:58:51 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191715>

Changes from v6 [1]:

 - Merge the first two patches into one
 - Make "help -a" support column.ui
 - Remove redundant code Ramsay pointed out in 01/10
 - Reword COL_DENSE commit message, 04/10

[1] http://article.gmane.org/gmane.comp.version-control.git/191522

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  Add git-column for columnar display
  Stop starting pager recursively
  column: add columnar layout
  column: add dense layout support
  column: add column.ui for default column output settings
  help: reuse print_columns() for help -a
  branch: add --column
  status: add --column
  column: support piping stdout to external git-column process
  tag: add --column

 .gitignore                   |    1 +
 Documentation/config.txt     |   38 ++++
 Documentation/git-branch.txt |    9 +
 Documentation/git-column.txt |   53 +++++
 Documentation/git-status.txt |    7 +
 Documentation/git-tag.txt    |    9 +
 Makefile                     |    3 +
 builtin.h                    |    1 +
 builtin/branch.c             |   32 +++-
 builtin/column.c             |   62 ++++++
 builtin/commit.c             |    6 +
 builtin/help.c               |    7 +-
 builtin/tag.c                |   26 ++-
 column.c                     |  476 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   40 ++++
 command-list.txt             |    1 +
 git.c                        |    1 +
 help.c                       |   54 ++----
 help.h                       |    2 +-
 pager.c                      |    2 +-
 parse-options.h              |    2 +
 t/t3200-branch.sh            |   77 +++++++
 t/t7004-tag.sh               |   44 ++++
 t/t7508-status.sh            |   24 ++
 t/t9002-column.sh            |  161 ++++++++++++++
 wt-status.c                  |   28 +++-
 wt-status.h                  |    1 +
 27 files changed, 1119 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh

--=20
1.7.8.36.g69ee2
