From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/18] Search and set up repository early for builtin commands
Date: Sun,  7 Mar 2010 11:55:49 +0700
Message-ID: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:06:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8hW-0001tK-3L
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229Ab0CGFGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:06:45 -0500
Received: from mail-pz0-f200.google.com ([209.85.222.200]:43825 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0CGFGo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:06:44 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Mar 2010 00:06:44 EST
Received: by pzk38 with SMTP id 38so400180pzk.33
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=sdL5i07+RRg9wOYB/7BkusolFy9xCarqQWVEsXUyHzQ=;
        b=Cgzb0Ea0f2fJcRKF29N30jADOP6w6anW6j2LrF1qvAVIgObUIVYrik/grBFH+4RTTh
         V6Hbj8/pRIlMkNuVV7d79tXV4NHvzx0b0bPOa3ec3c+bAr3rgAfvPe3Cxgm9PA5aiGzB
         R36TYYqGITsUuF1qU/aE7uKCIrY3J6FiL7ekI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=uWmY4I3tjTaIXcrqhGc5eEAzNfVyzNHGxqJM2q5YZgMJsqn/NeUcvQ1Ix6BeqrM35i
         Hj4Wli0+qZVgiywMuBjVrVAdQAj8FwV+Kn+G8oVtQ87vmEQVDm4c+eb9YFe5qwDESmYo
         ixB6Yi/fgBAOs6ny4Lf4S/5/9Pi0wm5oFELQ0=
Received: by 10.142.210.17 with SMTP id i17mr2089782wfg.146.1267937963963;
        Sat, 06 Mar 2010 20:59:23 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 22sm3254285pzk.1.2010.03.06.20.59.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 20:59:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:08 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141665>

This is a simpler part of my Git setup cleanup WIP [1], to introduce
RUN_SETUP_GENTLY and make most of commands use it.

The commands that do not have RUN_SETUP* are:
 - Init/Clone commands
 - Server commands
 - Helpers that have nothing to do with repositories
 - git-rev-parse

[1] http://mid.gmane.org/1266336317-607-1-git-send-email-pclouds@gmail.=
com

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (18):
  builtin: introduce startup_info struct
  builtin: Support RUN_SETUP_GENTLY to set up repository early if found
  config: use RUN_SETUP_GENTLY
  hash-object: use RUN_SETUP_GENTLY
  shortlog: use RUN_SETUP_GENTLY
  grep: use RUN_SETUP_GENTLY
  builtin: USE_PAGER should not be used without RUN_SETUP*
  archive: use RUN_SETUP_GENTLY
  mailinfo: use RUN_SETUP_GENTLY
  check-ref-format: use RUN_SETUP_GENTLY
  verify-pack: use RUN_SETUP_GENTLY
  apply: use RUN_SETUP_GENTLY
  bundle: use RUN_SETUP_GENTLY
  diff: use RUN_SETUP_GENTLY
  help: use RUN_SETUP_GENTLY
  ls-remote: use RUN_SETUP_GENTLY
  var: use RUN_SETUP_GENTLY
  merge-file: use RUN_SETUP_GENTLY

 builtin/apply.c       |    7 ++---
 builtin/archive.c     |    2 +-
 builtin/bundle.c      |    6 +---
 builtin/config.c      |    6 +---
 builtin/diff.c        |    6 +---
 builtin/grep.c        |    9 ++-----
 builtin/hash-object.c |    9 ++++---
 builtin/help.c        |    2 -
 builtin/ls-remote.c   |    3 --
 builtin/mailinfo.c    |    3 --
 builtin/merge-file.c  |    4 +--
 builtin/shortlog.c    |    4 +--
 builtin/var.c         |    2 -
 cache.h               |    7 +++++
 environment.c         |    1 +
 git.c                 |   61 ++++++++++++++++++++++++++++-------------=
--------
 setup.c               |   14 ++++++++++-
 17 files changed, 76 insertions(+), 70 deletions(-)
