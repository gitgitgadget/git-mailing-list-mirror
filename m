From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/3] Exclude pathspec
Date: Fri,  6 Dec 2013 14:30:46 +0700
Message-ID: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 08:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vopng-0005Bw-OG
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 08:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065Ab3LFH0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Dec 2013 02:26:09 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:60717 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab3LFH0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 02:26:06 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so552195pdj.4
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 23:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ldvDSGRXIaAof2DzgdBW3NIA5zizupeZVSricjTE7/c=;
        b=Cowl4DnyFBxdkhu53DTTkdfuiy5lAaSM4WjPb8W1AvLFt88XXM+WtGJ7R/JhJEUJ6j
         gBTQh5XTe/3B8Jd/lEyIKUs38lu0z4XjsUb7SMmseNDNcOkn5Fmj2DZp1Bw8wdo3Q6JU
         1d2zTAfgzFo5FDPXaW77xz9o+gfAR+dv2aUuFvwdKDtGCDr5sQLmFoXPNur7z9lMZ+/l
         uqQA0BCViQ7sFMzlkd6FxWoKztIGTAGfCNkxtfa8c3cZBUs+tT9vfTCBcIo1XyLIY5M9
         J/7C25yzPXY6B4UZEA7msC37GJU2DOLag4P7g0ICd1+5kxW1tGoKDQo04HwvIE0t8tWx
         IGaQ==
X-Received: by 10.68.222.225 with SMTP id qp1mr2385852pbc.41.1386314766186;
        Thu, 05 Dec 2013 23:26:06 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id sy10sm173960823pac.15.2013.12.05.23.26.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 23:26:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Dec 2013 14:30:50 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238925>

A WIP patch [1] was posted a while ago. This is the polished version
with tests and stuff. '!' is used as the shortcut instead of '-'. You
can now say "select this path except this subpath..." for nearly all
commands that take pathspec.

[1] http://thread.gmane.org/gmane.comp.version-control.git/234835/focus=
=3D238062

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  glossary-content.txt: rephrase magic signature part
  Support pathspec magic :(exclude) and its short form :!
  pathspec.c: support adding prefix magic to a pathspec with mnemonic m=
agic

 Documentation/glossary-content.txt   |  34 +++----
 builtin/add.c                        |   5 +-
 dir.c                                |  47 +++++++--
 pathspec.c                           |  37 ++++---
 pathspec.h                           |   4 +-
 t/t6132-pathspec-exclude.sh (new +x) | 184 +++++++++++++++++++++++++++=
++++++++
 tree-walk.c                          |  83 +++++++++++++++-
 7 files changed, 354 insertions(+), 40 deletions(-)
--=20
1.8.5.1.25.g8667982
