From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 0/5] git help: group common commands by theme
Date: Thu, 14 May 2015 14:59:05 +0200
Message-ID: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 14 15:00:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yssk8-0007Eo-G5
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 15:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbbENM7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 08:59:54 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35684 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933435AbbENM7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 08:59:48 -0400
Received: by wgnd10 with SMTP id d10so72228979wgn.2
        for <git@vger.kernel.org>; Thu, 14 May 2015 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=CjEFRokwED00sajHPUeKNYG7lcC6yMn/xKEIR4Hhx6M=;
        b=g5Ofq4IjcPBcgWMSkvY1sGECDiJhOQH5cyn6u+FaQfjuOVMT4QgvUnPwSHBU+XGXlx
         IRB6IhevyM47YcCGpGMW8lMfvXXXiofeuosydcPkeMv9NV+ZPemU8rnEAXgdZRATLL7N
         ocxsbcyMxf+HSJh3fUKOF4r99aqVrb6S1LVpYVhk1ncO4LZKWaaVfWHag8BRsrAgrIJU
         IYwDZbcF5IHDFZti0cQqH3z8XLrBXmbcBFM25xEkIgvvvsoq7JqRH85TJxIeo7VheSNY
         IIqx7UcbdNlk4WqZGNR0XEfQfTVBRh0It3iOnvdGLUzcKgKWpRMznzrgwZneUQYGHHm/
         O5XA==
X-Received: by 10.194.134.40 with SMTP id ph8mr7951346wjb.147.1431608387292;
        Thu, 14 May 2015 05:59:47 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id pj5sm32671676wjb.40.2015.05.14.05.59.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 05:59:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269031>

This v6 is very similar in content to the v5=C2=A0[1], except minor for=
matting
adjustments in 'git help' output and recommendations from Eric.

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
  command-list.txt: add with [common] block
  command-list.txt: drop the common- prefix
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
