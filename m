From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v7 0/5] git help: group common commands by theme
Date: Fri, 15 May 2015 20:34:59 +0200
Message-ID: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri May 15 20:35:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtKSA-0002pm-9Z
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 20:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbbEOSfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 14:35:17 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37355 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbEOSfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 14:35:16 -0400
Received: by wibt6 with SMTP id t6so68940729wib.0
        for <git@vger.kernel.org>; Fri, 15 May 2015 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ZQMSivou+/U9u3fxMbXtoflH8OC/KrYGBAtb0D/0YCA=;
        b=JxReRPJJ/pSBq5R9PFKaLK6jtX6IUw+zewYFM6srmijGPIM53ZY2/FAsZh/l0fXjTo
         V1v4hMQ67vIJCp+NjPY3l6qFWMLQOvCQJwBtChJxyIzn2TiDeP9H7auQStHkUiCaknua
         C+3kWzGrj7QLeZgLNjyMsOHF8HvC2kSSSO775X4t12su/WCi/u84v2o6PGvK3HhajyPN
         GLxb54Ft3iwFJT1TSewX0W1618NSxzitVP1sVYQswsdsZOVKFB4kgp3c+W5oCInvzYcG
         8MA6eVygMKrSVN2/YAatW3HVYTU1S4p8XhTmCmJVgmUeVxvyFE05oEnYyYIs77xVDTb3
         xQbw==
X-Received: by 10.180.160.145 with SMTP id xk17mr36560128wib.85.1431714914946;
        Fri, 15 May 2015 11:35:14 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id j12sm3674972wjn.48.2015.05.15.11.35.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 May 2015 11:35:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269167>

This v7 is very similar in content to the v5=C2=A0[1], except minor for=
matting
adjustments in 'git help' output and recommendations from Eric.

rebased on 'next' (a2776d4)

The major change is in the patch series itself. Commits have been
reordered and adjusted so that each 'apply' doesn't break the build, an=
d
preserve bisectability.

Summary: make 'git help' outputs a more usable and friendlier
list of commands, grouped by theme according to the typical Git workflo=
w:

[...]

The typical Git workflow includes:

start a working area (see also: git help tutorial):
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existin=
g one

work on the current change (see also: git help everyday):
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

[...]

Many thanks to Eric Sunshine for the detailed help and advice !

[1]: http://thread.gmane.org/gmane.comp.version-control.git/268701

Eric Sunshine (1):
  generate-cmdlist: parse common group commands

S=C3=A9bastien Guimmara (4):
  command-list.txt: prepare with [commands] header
  command-list.txt: add a [common] block
  command-list.txt: drop the common tag
  help.c: output the typical Git workflow

 Documentation/cmd-list.perl         |  4 +++
 Documentation/howto/new-command.txt |  4 ++-
 Makefile                            |  7 ++---
 command-list.txt                    | 53 ++++++++++++++++++++++-------=
--------
 generate-cmdlist.awk                | 39 +++++++++++++++++++++++++++
 generate-cmdlist.sh                 | 23 ----------------
 help.c                              | 24 ++++++++++++++++-
 7 files changed, 105 insertions(+), 49 deletions(-)
 create mode 100644 generate-cmdlist.awk
 delete mode 100755 generate-cmdlist.sh

--=20
2.4.0
