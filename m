From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 00/19] index-helper/watchman
Date: Mon,  9 May 2016 16:48:30 -0400
Message-ID: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:50:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs76-0003nz-Tt
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbcEIUtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 16:49:06 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34182 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbcEIUtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:04 -0400
Received: by mail-qg0-f42.google.com with SMTP id 90so95692047qgz.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlA5zVrYxBrd1hXVDVOOZ6dR1VcZo3D2hUWXPeW5L5w=;
        b=r4qRnvWbNCP+8SPYYFWQoUDBhoejDTFOfZ3Yfc2jVdrcWWVjn/S2KFx5hj7ijaZfDp
         WRZhTY/t7hPyiypI3aG0OKJRkQCd5Nmb50mI0saJ26awmO/iqheRKz4FTruxBCbg7QL9
         KfaoK+nj0oqVs4nCf46Tq9Q8fO2dFXbRgoHaFhO0dstA5a/A8wu91MGQ/jie8Fw70JQC
         5VW4eDHjORl8M8nmWvHE6j1olMiiN440wzODqZ9WlmiYknlLaCA+AdIMAQ6AM9nQTkHU
         lxUFbrOLH2qEdP/LYqq7Guxcp6g55o0GMGTru2PDORE0fvxzul1ewVWDmxhrz6wukOQU
         MTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlA5zVrYxBrd1hXVDVOOZ6dR1VcZo3D2hUWXPeW5L5w=;
        b=Xk9nma/MSfBaP35plpmTCIOP3FKTxnwAPfH2BGtyH7JbIHjxNAxF4zikfog005YdPG
         5CgfxnSlx6S/XzDHfRFb5DPenabbpceNaap/D2USG72oVJ1W5m8N94ue32IWgEFZBt88
         afqptb2Ffsl6HMpJm07HTq/aFV5gTCvFlQb7vYeSiWT0VD3SovCBer4lBZYnKsJ/7PGU
         UY+06sqqmt9BuCLiEVuV0GhM28dSTAhzE5ulO/k7c+gJkr60DArRDsQd06d9WZJEhbrc
         FE4wSEjz4ro8qa70eShq3wa3mvBTE8S0C/IpRONAgSMO1LvQhsvqrO9awaZErwqLq+VW
         oJ3w==
X-Gm-Message-State: AOPr4FWAdA1rSc4nI7xwJbKAOuyDuGdgxNIAcB6gfz83nVDeZbEZoeBAjAMc81bdozxFOg==
X-Received: by 10.140.147.135 with SMTP id 129mr38336788qht.54.1462826942397;
        Mon, 09 May 2016 13:49:02 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:00 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294056>

=46ormatting and patch naming fixes from Junio.  No substantive changes=
=2E

David Turner (8):
  index-helper: log warnings
  unpack-trees: preserve index extensions
  watchman: add a config option to enable the extension
  index-helper: kill mode
  index-helper: don't run if already running
  index-helper: autorun mode
  index-helper: optionally automatically run
  untracked-cache: config option

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  read-cache.c: fix constness of verify_hdr()
  read-cache: allow to keep mmap'd memory after reading
  index-helper: new daemon for caching index and related stuff
  index-helper: add --strict
  daemonize(): set a flag before exiting the main process
  index-helper: add --detach
  read-cache: add watchman 'WAMA' extension
  watchman: support watchman to reduce index refresh cost
  index-helper: use watchman to avoid refreshing index with lstat()
  update-index: enable/disable watchman support
  trace: measure where the time is spent in the index-heavy operations

 .gitignore                               |   2 +
 Documentation/config.txt                 |  12 +
 Documentation/git-index-helper.txt       |  81 +++++
 Documentation/git-update-index.txt       |   6 +
 Documentation/technical/index-format.txt |  22 ++
 Makefile                                 |  18 ++
 builtin/gc.c                             |   2 +-
 builtin/update-index.c                   |  16 +
 cache.h                                  |  25 +-
 config.c                                 |   5 +
 configure.ac                             |   8 +
 daemon.c                                 |   2 +-
 diff-lib.c                               |   4 +
 dir.c                                    |  25 +-
 dir.h                                    |   6 +
 environment.c                            |   3 +
 git-compat-util.h                        |   1 +
 index-helper.c                           | 506 +++++++++++++++++++++++=
++++++
 name-hash.c                              |   2 +
 preload-index.c                          |   2 +
 read-cache.c                             | 534 +++++++++++++++++++++++=
+++++++-
 refs/files-backend.c                     |   2 +
 setup.c                                  |   4 +-
 t/t1701-watchman-extension.sh            |  37 +++
 t/t7063-status-untracked-cache.sh        |  22 ++
 t/t7900-index-helper.sh                  |  69 ++++
 t/test-lib-functions.sh                  |   4 +
 test-dump-watchman.c                     |  16 +
 unpack-trees.c                           |   1 +
 watchman-support.c                       | 135 ++++++++
 watchman-support.h                       |   7 +
 31 files changed, 1558 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100755 t/t1701-watchman-extension.sh
 create mode 100755 t/t7900-index-helper.sh
 create mode 100644 test-dump-watchman.c
 create mode 100644 watchman-support.c
 create mode 100644 watchman-support.h

--=20
2.4.2.767.g62658d5-twtrsrc
