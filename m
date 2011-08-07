From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/3] bisect: add support for bisecting bare repositories
Date: Sun,  7 Aug 2011 20:50:37 +1000
Message-ID: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 12:51:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq0wu-0006pu-1J
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 12:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab1HGKux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 06:50:53 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50269 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab1HGKux (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 06:50:53 -0400
Received: by pzk37 with SMTP id 37so6576739pzk.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SRw/B3Imyd6Qa1dfa5Pwhq8tlYTHIPWyPb5vgGVZfWc=;
        b=S7Qnoqou93bwqm0A5ybT/pu867HRD94QLpzurdB12oSLwqzKpcwGCapf0Tb2sZTlk8
         u3ZELlEHI59HNNWdQQ8djAQVLPF38NCEl3dDtNRthmUUX0Q7pB2rvcqf6E13Yr3DqoAp
         Of4w5FwuAkNYCWPFfIr+HdWeeGuGpRPVkIuU4=
Received: by 10.143.15.9 with SMTP id s9mr1193141wfi.440.1312714252576;
        Sun, 07 Aug 2011 03:50:52 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id m3sm2740179pbm.28.2011.08.07.03.50.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 03:50:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178898>

This extension to js/bisect-no-checkout (currently in pu) adds support for bisecting bare repositories.

It does this by relaxing the requirement that git bisect is invoked in a repository with a working tree and by 
defaulting to --no-checkout in the case of a bare repository.

Two tests are included to demonstrate this behaviour.

Jon Seymour (3):
  bisect: relax requirement for a working tree.
  bisect: add tests for bisection on bare repositories
  bisect: document that --no-checkout is the default for bare
    repositories

 Documentation/git-bisect.txt |    2 ++
 git-bisect.sh                |    8 ++++++--
 git.c                        |    2 +-
 t/t6030-bisect-porcelain.sh  |   28 ++++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

-- 
1.7.6.363.g9b380.dirty
