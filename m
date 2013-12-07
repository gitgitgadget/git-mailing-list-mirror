From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 0/6] transport-helper: fixes
Date: Sat,  7 Dec 2013 15:08:06 -0600
Message-ID: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 22:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpPE6-0002rD-D2
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 22:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab3LGVPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 16:15:45 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:65009 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab3LGVPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 16:15:45 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so2250429obb.32
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M9fdzYaxWIW7YRiV67SniQayqlUAdA7v5blbHWdNQ8g=;
        b=FbyAHIea5cQjvwYBQICAKON1FzrLwjLOaifNBCVHhuHVmUGpCUV31yd43F89mgCfbr
         txf+PwR23pjfCh77bjJT00a6lS+EN/RPUCLEZFFKWPRQDACEL/k7SHtMgd0yoB15zr6X
         WkBj3MV6T8p4SJbEzPQVkWppqoqhMJFCG/2H+xJnfsGNVrWya1H9eEn+VIH27ATXX163
         FyuWOJSFXYuvWXs96Bd4ecam2L9Fpn26Q9oa0kuuLK1guQ3QzG5lx31qKMnlxv4oY9v3
         nTCmoFz81yM7g7oRENaW0tcK3q7Z1jocBD7tSI5L+0vJ7WApfujynJxDHGCZM3VZj/J2
         grVw==
X-Received: by 10.182.213.97 with SMTP id nr1mr7511193obc.48.1386450942559;
        Sat, 07 Dec 2013 13:15:42 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ee7sm7816383oeb.5.2013.12.07.13.15.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 13:15:41 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239021>

Hi,

These patches add support for remote helpers --force, --dry-run, and reporting
forced update.

No changes since last version.

The later patches for renaming branches, deleting them, custom refspecs have
beend dropped because Junio doesn't like the name --refspec, although the
argument is clearly a refspec as it's used that way extensively through Git.

Felipe Contreras (4):
  transport-helper: mismerge fix
  transport-helper: don't update refs in dry-run
  transport-helper: add 'force' to 'export' helpers
  transport-helper: check for 'forced update' message

Richard Hansen (2):
  test-hg.sh: tests are now expected to pass
  remote-bzr: support the new 'force' option

 Documentation/gitremote-helpers.txt   |  4 ++++
 contrib/remote-helpers/git-remote-bzr | 31 ++++++++++++++++++++++++++++++-
 contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
 contrib/remote-helpers/test-hg.sh     |  4 ++--
 git-remote-testgit.sh                 | 18 ++++++++++++++++++
 t/t5801-remote-helpers.sh             | 13 +++++++++++++
 transport-helper.c                    | 25 +++++++++++++++++--------
 7 files changed, 105 insertions(+), 12 deletions(-)

-- 
1.8.5.1+fc1
