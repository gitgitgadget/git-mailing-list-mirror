From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/2] jn/gitweb-blame fixes
Date: Thu, 19 Nov 2009 11:44:45 -0800
Message-ID: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:44:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBCw3-0006DE-Uh
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 20:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbZKSTop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbZKSTop
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 14:44:45 -0500
Received: from mail-px0-f180.google.com ([209.85.216.180]:43866 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZKSToo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 14:44:44 -0500
Received: by pxi10 with SMTP id 10so1869429pxi.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=h3Tuw1HQ5qWdFHyfsSEt5oKvBr85cZgmPpLXx6iTpkE=;
        b=PovoqgwKgTOqMHcxPk1Xhrw3P6PDB87igehxlo/zDJ2L0sJ5RfNUHdmNvaNtk89/Ic
         kDhkqd8xssY+/39rXzUfKzgQMpROIztRlLIaeyUzM7i+dbBN4O2v98TssUh67t2jWN4z
         YUKSp1Be/pLyGSHoEgb/cC+YmNYzm8Ld/kXLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oH6z5HwkMmTjnejcZPWLboyWdNOt76/Y+i/NsZqBWcNH3Vy+zwRTuKdOgBENe5fSYJ
         J80TIzwJ4rN9lQYKm+jj9mkxcHLxQu3cNKEsGkI7R3C/WEJcoY1eHMbIxBMqJWCe1LQP
         MWVXLOqGUCArTLNqjNqzQxi1R7331jyhCFGlo=
Received: by 10.114.86.11 with SMTP id j11mr426332wab.73.1258659890491;
        Thu, 19 Nov 2009 11:44:50 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 20sm518478pzk.1.2009.11.19.11.44.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 11:44:50 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Thu, 19 Nov 2009 11:44:47 -0800
X-Mailer: git-send-email 1.6.5.3.433.g11067
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133248>

This series is based on next's jn/gitweb-blame branch.

I was trying out the incremental blame and noticed it didn't work each 
time. The first patch fixes the crashing I experience when blaming
gitweb.perl (ironic ;-)

The second patch fixes a visible bug I see in Firefox. Although I assume
on other browsers it's not a problem? I haven't tested it on others so I
can't be sure.

Stephen Boyd (2):
  gitweb.js: fix null object exception in initials calculation
  gitweb.js: use unicode encoding for nbsp instead of html entity

 gitweb/gitweb.js |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)
