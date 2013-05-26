From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/4] nd/clone-connectivity-shortcut updates
Date: Sun, 26 May 2013 08:16:13 +0700
Message-ID: <1369530977-12746-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 03:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgPYE-0007pk-NS
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 03:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758737Ab3EZBPG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 May 2013 21:15:06 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:40716 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758476Ab3EZBPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 21:15:05 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so5598253pab.21
        for <git@vger.kernel.org>; Sat, 25 May 2013 18:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0bFN3hZP0s2CrqKiy2CKYX077VjRWwDS7MoZojpOd6I=;
        b=KKD7HnJHFoCO4zrlxHWq58FBEl1I2GeGNB2uQhzh+ecGfiwJgUrAsB28T6zHdC6ZCv
         1VOXS0iiL15NHUuiU2SzOGo/yYaAPadqiesTJCqGFW3HBbttpNtQHM7a85pT/EcgYm0O
         AN2mA0biLD3cVyRSLPwytjQwl5zshPfRJHKsW7iBeXHKqEnhuayev5Ijm0Na0qvBvJaW
         TCx2zeWbDE1QpAl5S8q1rGK3MZ5UioOccji0EXi9r/MRHs/Z3ceFJBrOZH7Fpcg3UglZ
         td2G3eE0NrC/r+7uO70pFiFTc3qv34kK7sNLPxVm52pjCbFun9mmO3UI/7GWqwoeoBEV
         V+Aw==
X-Received: by 10.66.193.72 with SMTP id hm8mr24419568pac.23.1369530905074;
        Sat, 25 May 2013 18:15:05 -0700 (PDT)
Received: from lanh ([115.73.211.70])
        by mx.google.com with ESMTPSA id tb7sm22368590pbc.14.2013.05.25.18.15.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 25 May 2013 18:15:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 26 May 2013 08:16:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225537>

This addresses the comments from Junio and Eric in v3 [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/219611/focus=
=3D223584

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  clone: let the user know when check_everything_connected is run
  fetch-pack: prepare updated shallow file before fetching the pack
  index-pack: remove dead code (it should never happen)
  clone: open a shortcut for connectivity check

 Documentation/git-index-pack.txt |  3 ++
 builtin/clone.c                  | 15 +++++--
 builtin/index-pack.c             | 38 ++++++++++++------
 commit.h                         |  2 +
 connected.c                      | 34 +++++++++++++++-
 connected.h                      |  5 +++
 fetch-pack.c                     | 84 ++++++++++++++++++++++----------=
--------
 fetch-pack.h                     |  4 +-
 git.c                            |  7 ++++
 shallow.c                        | 42 +++++++++++++++++++-
 t/t5500-fetch-pack.sh            |  7 ++++
 transport.c                      |  4 ++
 transport.h                      |  2 +
 13 files changed, 192 insertions(+), 55 deletions(-)

--=20
1.8.2.83.gc99314b
