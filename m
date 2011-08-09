From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 0/2] bisect: add support for bisecting bare repositories
Date: Tue,  9 Aug 2011 11:21:38 +1000
Message-ID: <1312852900-29457-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 03:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqb1G-0005Vb-Ny
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 03:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab1HIBV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 21:21:56 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35417 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab1HIBVz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 21:21:55 -0400
Received: by pzk37 with SMTP id 37so9208568pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 18:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QyPuVhIebHD2t1CnbAAMLXqWuTsyimI96gydztgcHWs=;
        b=PU8+lEL4C3V0D2mv0DZ4ikyJ5m/nZiwEZ3hYd8j+n6J3w6apDSSddKaaMf71FtaxF2
         ELMLx6NHKFEw8+KXD59W0TbR3+dfDkWhaRNj48HSfADPiwbL3Ni0U3Na45xZ5wgIqdDl
         Ghv/71iLy3639xRTwYSAPslDRoTYhz2UX0jCQ=
Received: by 10.142.165.6 with SMTP id n6mr6509863wfe.395.1312852914772;
        Mon, 08 Aug 2011 18:21:54 -0700 (PDT)
Received: from localhost.localdomain (bh02i525f01.au.ibm.com [202.81.18.30])
        by mx.google.com with ESMTPS id v2sm5006171pbi.67.2011.08.08.18.21.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 18:21:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.523.g2ad34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179013>

This extension to js/bisect-no-checkout (currently in pu) adds support for bisecting bare repositories.

It does this by relaxing the requirement that git bisect is invoked in a repository with a working tree and by 
defaulting to --no-checkout in the case of a bare repository.

Two tests are included to demonstrate this behaviour.

Revisions
=========
v2:
	Squashed documentation patch into code change patch.
	Simplified test, per Jonathan Nieder.	
v1:
	Initial release.


Jon Seymour (2):
  bisect: relax requirement for a working tree.
  bisect: add tests for bisection on bare repositories

 Documentation/git-bisect.txt |    2 ++
 git-bisect.sh                |    8 ++++++--
 git.c                        |    2 +-
 t/t6030-bisect-porcelain.sh  |   31 +++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

-- 
1.7.6.522.g810f.dirty
