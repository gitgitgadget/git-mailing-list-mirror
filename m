From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] commit --cleanup=<scissors marker>
Date: Sun, 16 Feb 2014 10:37:17 +0700
Message-ID: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 04:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEsXi-0008Ha-Lh
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 04:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbaBPDhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 22:37:16 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:39711 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbaBPDhP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 22:37:15 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so13857496pbb.6
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 19:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Bre5nEKQU6XuANZecoN82mZMTz7/wYID91YgHpY016w=;
        b=mo9YDil+vMYQj/iRxiknVyZQEwUyHOvVjtawwChdJjWEX0VfJUC7xAFW8WENgs/+1r
         3SqQZrj9/VGz2SiTZIWVXmaruGTgdJQvnZRsg8PQiERHsa3hKvowntAphE+5YUywnE83
         +G0+TYOjzqCHCpManxRr1ydiCA+T9RAB7H47nTgqwnnyP2MzGKS+MjpBaRl9oGO1/ID5
         rq0ZEBjAbR+oEUHzP2BLjpjT8bwV1jGFq9s8VwxduXhYGBeVuAx7g87omUiDMMBbYCdo
         GjHXPk3NhggWcXi+n5UuqvqmngY0Qv7Sy8FPGL/SvtfXpBYnDISkfYSxaHstFOTJPlgC
         MxdA==
X-Received: by 10.68.137.195 with SMTP id qk3mr18584418pbb.9.1392521834344;
        Sat, 15 Feb 2014 19:37:14 -0800 (PST)
Received: from lanh ([115.73.213.123])
        by mx.google.com with ESMTPSA id bz4sm31980706pbb.12.2014.02.15.19.37.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 19:37:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Feb 2014 10:37:23 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242208>

I've been bitten by --cleanup=3Ddefault stripping my "#" lines a few
times. Cutting "git status" with a long scissors marker line reduces
chances of that happening. Most of the code is already there in
1a72cfd. This is just to add the UI.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  wt-status.c: make cut_lines[] const to shrink .data section a bit
  wt-status.c: move cut-line print code out to wt_status_add_cut_line
  commit: add --cleanup=3Dscissors

 Documentation/git-commit.txt |  7 ++++++-
 builtin/commit.c             |  9 +++++++--
 t/t7502-commit.sh            | 16 ++++++++++++++++
 wt-status.c                  | 21 +++++++++++++--------
 wt-status.h                  |  1 +
 5 files changed, 43 insertions(+), 11 deletions(-)

--=20
1.8.5.2.240.g8478abd
