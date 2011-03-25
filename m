From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 0/3] gitweb: Split gitweb.js, improve JavaScript
Date: Fri, 25 Mar 2011 22:46:23 +0100
Message-ID: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 22:46:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3EqN-0003YM-OF
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 22:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab1CYVqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 17:46:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38717 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab1CYVqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 17:46:49 -0400
Received: by wwa36 with SMTP id 36so1856664wwa.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=pDJtqu05FrbkxkSPZ6L8TI4awWfP7YOzUUns/HCyKdg=;
        b=AGFg8up5/Pp/WKAq7iCJ7/mQJit0Be5SF9wxEgKVLYVaZ9S50DWM7sJkqWVygMDOEV
         uf9DPaG2pkJT9m18832ygGz0KbDtrdO899KEC/Dat1IsbAbl4SlVPe0BLZjfHFskZymt
         ZWMW6rVsiaPiFxPDO9Cs3NqekBkMJMIQXk72k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=S2yzUpFbpGWq1Lf/+xGnwHopMbWSqSg6BGcCzjBw2ZFZogDqHptObyoEj6TtTOSRTe
         ItCwl6s1NaqNkaUyHMOxyxwvwSD4R2fVqMqz2uh1VA4C8c/+ekj6ya0yCATOhVEkRR9L
         /MPbFerVG9Dy64OH7YevYF23d1HJy8SUzvK7A=
Received: by 10.216.180.76 with SMTP id i54mr230306wem.33.1301089605950;
        Fri, 25 Mar 2011 14:46:45 -0700 (PDT)
Received: from localhost.localdomain (abwo211.neoplus.adsl.tpnet.pl [83.8.238.211])
        by mx.google.com with ESMTPS id g7sm647802wby.14.2011.03.25.14.46.43
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 14:46:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170021>

This patch series is inspired by patch by John 'Warthog9' Hawley

  [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
  Message-Id: <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
  http://thread.gmane.org/gmane.comp.version-control.git/169384/focus=169882

that added a few new JavaScript files for the new feature that this
patch implemented.

This is marked as RFC mainly because other patches in series,
especially the last one fixing bug in gitweb's JavaScript code, should
be send independently on gitweb.js splitting.

Jakub Narebski (3):
  gitweb: Split JavaScript for maintability; concatenate on build
  gitweb: Update and improve comments in JavaScript files
  gitweb: Fix parsing of negative fractional timezones in JavaScript

 .gitignore                                         |    1 +
 gitweb/Makefile                                    |   12 +-
 .../static/{gitweb.js => js/blame_incremental.js}  |  216 ++------------------
 gitweb/static/js/common-lib.js                     |  191 +++++++++++++++++
 gitweb/static/js/detect-javascript.js              |   44 ++++
 5 files changed, 261 insertions(+), 203 deletions(-)
 rename gitweb/static/{gitweb.js => js/blame_incremental.js} (75%)
 create mode 100644 gitweb/static/js/common-lib.js
 create mode 100644 gitweb/static/js/detect-javascript.js

-- 
1.7.3
