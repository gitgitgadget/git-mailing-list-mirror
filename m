From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 0/3] git-gui: more robust handling of fancy repos
Date: Sun,  6 Dec 2009 09:06:38 +0100
Message-ID: <1260086801-4331-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 09:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHC9f-0002t5-FN
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 09:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbZLFIHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 03:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbZLFIHb
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 03:07:31 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:65247 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbZLFIHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 03:07:31 -0500
Received: by fxm5 with SMTP id 5so3872218fxm.28
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 00:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PzIDCxntMFiMY4e0jKBLQrWaSHrJIrMTvfATBJZ9vZ0=;
        b=VJuTt1lLcKgoogRHIXtkhyImt7cxXFRv9ovYtjQwTPtNZuEFbnMtOKTgmHQhkv+abi
         rVvWP+UJ+mwoyn+da1/du5TkSayxZNfOa4gGyH78ilVZS7i7ZAjU5zg0BOz+cizVUmV1
         a3r0P34EPl0ppTQPnH6zxDO+RptWMATDDJq3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mEiVfHqsqvrfnLICcuQ7N3KTxyOX6wGfH7m7s5IWwAKTLhB2FdJazm1sWsRiUW/M5o
         DonOV6FASQfOMmnawduOdSlKJ1YVqX3cQWSx9icYHatzsFEut/3YUaQgct5IT0KDNUzS
         K4nDV9BNlJ3vfYZRRTb4s4o9whdkfPro/FyUY=
Received: by 10.86.249.26 with SMTP id w26mr4284934fgh.49.1260086856695;
        Sun, 06 Dec 2009 00:07:36 -0800 (PST)
Received: from localhost (host-78-13-51-245.cust-adsl.tiscali.it [78.13.51.245])
        by mx.google.com with ESMTPS id e11sm14253063fga.14.2009.12.06.00.07.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 00:07:35 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134651>

This is a resend with the patches rebased on current 'next'.

The first patch allows git gui to work with respotiories for which
the worktree is not the parent of the gitdir.

The second patch refactors bare repository detection, improves the error
message if the bare support feature is disabled, and disabled
inapplicable menu entries.

The third patch allows git-gui to work properly when launched from the
.git directory itself, solving the issue Markus Heidelberg was having in
http://thread.gmane.org/gmane.comp.version-control.git/115044

Giuseppe Bilotta (3):
  git-gui: handle non-standard worktree locations
  git-gui: handle bare repos correctly
  git-gui: work from the .git dir

 git-gui/git-gui.sh |   88 +++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 73 insertions(+), 15 deletions(-)
