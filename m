From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v5 0/6] git help: group common commands by theme
Date: Sat,  9 May 2015 19:17:30 +0200
Message-ID: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 19:18:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yr8OQ-0000WU-Si
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 19:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbbEIRSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 May 2015 13:18:08 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33892 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbEIRSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 13:18:06 -0400
Received: by wicmx19 with SMTP id mx19so56818990wic.1
        for <git@vger.kernel.org>; Sat, 09 May 2015 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=a4f4nMNKCZCwSF1CKGBs5Wt6DGYrsAn/U8CRhpvSNS8=;
        b=fpUIaRbWuwdjSE0CZAycHrnCedqOwbkvYVAcE8ge34Uwvksm+EOGSxlPNZbNl91zBz
         0vEMHzAfRyoGUILMZO+/0gPoYCOLVdOxnaVIO53xBj0Flp0WMRVLW1Th9Fz30pdEwjPJ
         +PBt+kvxxRSS30YsdtcJPaVuh93kIBkDxriKGQ5aqUk+qpiYdhZG5A+6DDS4TGQtSUg9
         Cjec3LMMO28qAZDTGYNkQCi75rU+U+jVq0ph8IfnCnWnqkW4D7Fn/iejoMeb6hl24Njc
         bp72d6zsoLtRXIa3HhCgHWDF1IjTmux5P5yuvPp/4rtqKvaL/EXNUTR0QWh7bCFKWpng
         zNYw==
X-Received: by 10.194.238.161 with SMTP id vl1mr6158849wjc.144.1431191885103;
        Sat, 09 May 2015 10:18:05 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fo7sm4710675wic.1.2015.05.09.10.18.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 May 2015 10:18:04 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268701>

This v5 includes suggestions from Junio C Hamano, Eric Sunshine and=20
Emma Jane Hogbin Westby, as well as a complete and much cleaner rewrite=
=20
of the generate-cmdlist parser in awk by Eric Sunshine.

The main idea of this version is to go a little further in the idea of
making 'git help' a warmer welcome to the unfamiliar user, by a gentle
summary of the typical Git workflow. Instead of simply telling what
the Git common commands are, we rather explain how they fit in the
typical workflow, ordered in (chrono)logical order:

1. I setup my repo (init)
2. I work on changes (worktree)
3. I gather information on the history (info)
4. I grow, tweak and clean my local history (history)
5. To finally share my nice contribution with the world (remote)

S=C3=A9bastien Guimmara (6):
  generate-cmdlist: parse common group commands
  help.c: output the typical Git workflow
  command-list.txt: group common commands by theme
  Makefile: update to new command-list.txt format
  new-command.txt: mention the common command groups
  cmd-list.perl: ignore all lines until [commands]

 Documentation/cmd-list.perl         |  8 +++++-
 Documentation/howto/new-command.txt |  4 ++-
 Makefile                            |  8 +++---
 command-list.txt                    | 56 ++++++++++++++++++++++-------=
--------
 generate-cmdlist.awk                | 38 +++++++++++++++++++++++++
 help.c                              | 25 +++++++++++++++--
 6 files changed, 109 insertions(+), 30 deletions(-)
 create mode 100644 generate-cmdlist.awk

--=20
2.4.0
