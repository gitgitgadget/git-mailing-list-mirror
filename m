From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: Faster and imrpoved project search
Date: Sat,  4 Feb 2012 13:47:23 +0100
Message-ID: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtf1s-0003Yi-5S
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 13:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab2BDMrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 07:47:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45531 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab2BDMrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 07:47:35 -0500
Received: by eaah12 with SMTP id h12so1791879eaa.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EvcektPdY6w0q9RG98SYANk6T0AQzlSUGGzGcCKsAM8=;
        b=oFQzGhvbaC6cHoRlpVEFnvrXG2D5jP2LFVjjtTgB3f0DRVrgv7lgokzgVgfylQ8zIt
         EELoDD2VtpivCP+jk0UzBhLQtGRSvmt6pbUj2nuOGHzHNsj00WICRhePbM7W5FlKjOLK
         pnibcshqBTQ44puLP3HwxONniJaCU+Humz4fQ=
Received: by 10.213.22.202 with SMTP id o10mr307105ebb.104.1328359654433;
        Sat, 04 Feb 2012 04:47:34 -0800 (PST)
Received: from localhost.localdomain (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id z47sm26890568eeh.9.2012.02.04.04.47.32
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 04:47:33 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189864>

This patch series, though independent, is best applied on top of
"[PATCH 0/2] gitweb: Project search improvements" series, or in other
words on top of 'bl/gitweb-project-filter' branch.

First two patches in this series are about speeding up project search
(and perhaps in the future also project pagination).  Those two could
be squashed together.

Next two patches are about making it more visible what are we
searching for, or rather what was matched (important especially with
regexp match).  The last patch is speculative patch about showing
match using shortened description.

Jakub Narebski (5):
  gitweb: Option for filling only specified info in
    fill_project_list_info
  gitweb: Faster project search
  gitweb: Highlight matched part of project name when searching
    projects
  gitweb: Highlight matched part of project description when searching
    projects
  gitweb: Highlight matched part of shortened project description

 gitweb/gitweb.perl |  122 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 108 insertions(+), 14 deletions(-)

-- 
1.7.9
