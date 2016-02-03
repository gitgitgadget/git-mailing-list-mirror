From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/20] "git worktree move" preview
Date: Wed,  3 Feb 2016 16:35:30 +0700
Message-ID: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtr2-0004ma-Fw
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbcBCJf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:35:57 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34855 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCJfx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:35:53 -0500
Received: by mail-pf0-f170.google.com with SMTP id 65so11047395pfd.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=4ciDyAcmdAYlhPyCBCGTVeHglyxElrF3bO0a0hVOJDo=;
        b=Tve7O9toLZr/m3ow9aZ3ZZveX+19OjunqOt8rZVmupy7g9UMjUJwh/qGdStf+MhwKA
         tj/6iPbNQ3WKCa+xR4TZCnikns4623K+3TxjGk407k4WhQSNZZeAXJxu2NxotA5kBcOn
         HwWeFwhLDuUpz4WHdKlBeDDE57gEv/oPkBrxSoDDmdTRLAZI4nsPXsE4N0udM23i3Ln/
         lqG/Phwaz0o0CWloMQSRd9MZj8eLm808AXzPh7Uw7Wbv9AHBavVsrVPBBtKEqX3ISFCW
         z4kJhY1DmC5sT3d+5gIrAlMhGKw+gOe8K8A8vaIiCxE6vlPnerAxe098pn5HYGRyKdqR
         QItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=4ciDyAcmdAYlhPyCBCGTVeHglyxElrF3bO0a0hVOJDo=;
        b=Wk5WRRPUsSaK2ZuT43WRghxRAHhu8idw07xFO6ZxCyGC8nLUwdEp12w2tUnt7vPJmy
         OP7p29fc9Jo89C19r/UXw5f9V6e/l49ZNB5hf+ZyeevXdZqsp+ijAHwLxjnJbkip6Fv4
         w3rIjrkeDK5OFM2T1JXO3YQLH5BhDLqiCjjR6Au/j1ie5uxLQ2K5/s4KMum9MQ4Ifjwx
         6OUsTvB0gma5Scl4PGRpDtK8SpidDrSyvNOxDRVRs9zzNt8EUF9hdFRy706D20icTpxI
         nkziwo6hZ8rmzSdXURtQnub3QJ/sJ+aiit+Zqwo+iQXfqPz45j6IZGFSqR//72Y6U7L7
         6wQQ==
X-Gm-Message-State: AG10YOQoQRETvCstx0h5ygk3O0UC2xjt1IcuuJr+OaAqr6DF+PySRrFm/SN2S5ZJqXHeVA==
X-Received: by 10.98.8.153 with SMTP id 25mr698290pfi.51.1454492152978;
        Wed, 03 Feb 2016 01:35:52 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id t87sm8425924pfa.14.2016.02.03.01.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:35:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:03 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285344>

This is the rough first cut of "git worktree move" for early
feedback. The series adds "git worktree move" which can

 - move a linked worktree to another place
 - move .git repository away

The first use case is obvious. The second less so.

Main worktree has always been an odd ball because it does not always
behave like a linked worktree. You can't move it (because you'll be
moving the repo along), you don't know where it is from 'worktree
list' because it's not tracked the same way. The move of .git dir will
automatically convert the main worktree to linked one, making it equal
to all other worktrees.

At the code level, it should be noted that I import copy_file() from
busybox for whole directory copy that preserves file permission and
stuff. Either that or I need to rely on POSIX command "cp" or "mv".
But that would make Windows adaptation harder later on.

A little off topic. The first two patches adds sys_error() that, like
die_errno(), automatically do strerror(). There's a 38 patches series
to convert error("...: %s", ..., strerror(errno)) to use it. I think
it's a good idea. So unless somebody objects, I'll post it some time
later.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (20):
  usage.c: move format processing out of die_errno()
  usage.c: add sys_error() that prints strerror() automatically
  path.c: add git_common_path() and strbuf_git_common_path()
  path.c: add is_git_path_shared()
  copy.c: add copy_dir_recursively()
  worktree.c: use is_dot_or_dotdot()
  worktree.c: store "id" instead of "git_dir"
  worktree.c: add clear_worktree()
  worktree.c: add find_worktree_by_path()
  worktree.c: add is_main_worktree()
  worktree.c: recognize no main worktree
  worktree.c: add update_worktree_location()
  worktree.c: add update_worktree_gitfile()
  worktree.c: add collect_per_worktree_git_paths()
  worktree: avoid 0{40}, too many zeroes, hard to read
  worktree: simplify prefixing paths
  worktree: add "move" commmand
  worktree: refactor add_worktree()
  worktree: move repo, simple case
  worktree: move repo, convert main worktree

 builtin/worktree.c                | 297 ++++++++++++++++++++++++------
 cache.h                           |   6 +
 copy.c                            | 371 ++++++++++++++++++++++++++++++=
++++++++
 git-compat-util.h                 |   1 +
 path.c                            |  56 +++++-
 t/t2028-worktree-move.sh (new +x) |  77 ++++++++
 usage.c                           |  35 +++-
 worktree.c                        | 161 +++++++++++++++--
 worktree.h                        |  42 ++++-
 9 files changed, 963 insertions(+), 83 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

--=20
2.7.0.377.g4cd97dd
