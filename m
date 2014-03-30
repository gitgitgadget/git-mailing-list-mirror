From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/18] git-ls
Date: Sun, 30 Mar 2014 20:55:51 +0700
Message-ID: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGDY-0002mY-AD
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbaC3Nzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:55:43 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45824 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbaC3Nzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:55:42 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so1525160pab.5
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nRpEMhYEbigCVfPWRA+KYL8H1BLER+itaRBv8cgM7Qk=;
        b=pUqfWcThfKM7ZMc0NjvDgt3jf1IfgKAIj5dCzLZVKGWvrgGDHN6+zmnGAlIWaw8/E/
         yD1cMpv5iwSotoOV4v/7xfUSDH8vcgifVEAeGyBZtXHluPDEwuJz8BR4MRUYTR+mZ9BW
         LHs4U77ojvQRteSd1UCsu3AMYnhW5vge8gi1lQL+yTG44EFb74NlJZN9f9PjIviWWd1e
         u+2AYao8S7hVwyK6YATvha2faWuJec6DEKjYSVm/xysr2g/LjDWjAYB+nnGhQuoi1Jci
         PW9TyCca5C7G2s12vnQ3flzn3oNUG9Xl8DEjd9jD0GjnxTi2RWeq6W9UVteEwEl9nGCh
         EOxA==
X-Received: by 10.68.240.5 with SMTP id vw5mr3449792pbc.113.1396187742368;
        Sun, 30 Mar 2014 06:55:42 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id pi1sm26218535pac.14.2014.03.30.06.55.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:55:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:56:39 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245464>

All comments by Eric are fixed in v3. -F is added. And the command
name is now list-files, not ls. 'ls' is saved for the user to make
an alias with better default options.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (18):
  ls_colors.c: add $LS_COLORS parsing code
  ls_colors.c: parse color.ls.* from config file
  ls_colors.c: add a function to color a file name
  ls_colors.c: highlight submodules like directories
  ls-files: buffer full item in strbuf before printing
  ls-files: add --color to highlight file names
  ls-files: add --column
  ls-files: support --max-depth
  Add git-list-files, a user friendly version of ls-files and more
  list-files: -u does not imply showing stages
  list-files: add -R/--recursive short for --max-depth=3D-1
  list-files: add -1 short for --no-column
  list-files: add -t back
  list-files: sort output and remove duplicates
  list-files: do not show duplicate cached entries
  list-files: show directories as well as files
  list-files: add -F/--classify
  list-files -F: show submodules with the new indicator '&'

 .gitignore                             |   1 +
 Documentation/config.txt               |  22 ++
 Documentation/git-list-files.txt (new) |  99 +++++++
 Documentation/git-ls-files.txt         |  20 ++
 Makefile                               |   2 +
 builtin/ls-files.c                     | 358 ++++++++++++++++++++++--
 color.h                                |  10 +
 command-list.txt                       |   1 +
 git.c                                  |   1 +
 ls_colors.c (new)                      | 496 +++++++++++++++++++++++++=
++++++++
 10 files changed, 980 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/git-list-files.txt
 create mode 100644 ls_colors.c

--=20
1.9.1.345.ga1a145c
