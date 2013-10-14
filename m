From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 0/3] relative path regression fix
Date: Mon, 14 Oct 2013 10:29:37 +0800
Message-ID: <cover.1381717700.git.worldhello.net@gmail.com>
References: <52570EC8.3050207@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 04:30:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVXv7-0002eL-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 04:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654Ab3JNCaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 22:30:01 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:54561 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab3JNCaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 22:30:00 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so6712895pbc.3
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 19:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5f3NPeMU3rEz3UZlZAj+4BxESSAyJta0h9XIDnTYm0=;
        b=RAA7ROGZ+QWctsL8zhOBB6wAKgXRmzPJ1n1aSzt6u9oxU275A8p97SOrEJ3hksOzEe
         mHKEF+2tVi4ufJ6VLzsVCq/6CTyJreSH7jnDhuMUjUeli8+pXaecoFHQLBmLJnrcsfFx
         Dx6QJntpbeBCdxkcxIdfbTeiOxw5O1ZyY7iyO3iuRonMxweRr6yxD2pjhj6F/ZENJP4j
         5/mHoz2toy4iYSMZ5REdQtL+xHJBcYHTWFKPrc0eb8/DPmNhVAi6dQL87cZvXBW/zjhe
         GmGuh01qOLYS+eTZnMOspd6rDFtWG1+JeUSVAx2TDutNY32TGNcDegf9v7MB1FMPzp0u
         AZ3Q==
X-Received: by 10.66.228.38 with SMTP id sf6mr35365144pac.21.1381717800146;
        Sun, 13 Oct 2013 19:30:00 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.111])
        by mx.google.com with ESMTPSA id gh2sm74692626pbc.40.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 19:29:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4
In-Reply-To: <52570EC8.3050207@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236086>

Update since v4:

 * Update commit logs with the help from Sebastian Schuberth:

   s/MINGW/MSYS/i
   s/dos-driver-prefix/dos-drive-prefix/

Jiang Xin (3):
  test: use unambigous leading path (/foo) for MSYS
  relative_path should honor dos-drive-prefix
  Use simpler relative_path when set_git_dir

 cache.h               |  1 +
 path.c                | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 setup.c               |  5 +---
 t/t0060-path-utils.sh | 60 +++++++++++++++++++++++++----------------------
 4 files changed, 99 insertions(+), 32 deletions(-)

-- 
1.8.4
