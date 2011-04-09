From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 00/11] gitweb: Change timezone
Date: Sun, 10 Apr 2011 00:49:15 +0200
Message-ID: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 00:49:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gyW-00052U-0n
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab1DIWtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 18:49:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40519 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab1DIWtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:49:47 -0400
Received: by fxm17 with SMTP id 17so2942648fxm.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=w0KYfzOgIekfD992l0Ze35bRK/HzTcUBV5/wC4JHJ3U=;
        b=rgpmKsDXZMU1h3wzU/M2TA/L0ph8TNfBpS0cq9quPAKlyT216LcAttEb86ZsKSx2h/
         oJec6xZej1USEmKIj7gxChYG8jmhb5Ma8uoVcEpQVgrR7NaMbNPdZmz/YBa8OfvQrHB0
         lJThU5PyRRY4PtRVuYSDpYfoLFJyu0KXqvUVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aIsbkmR9sPOk4GWQEH4DTQje5Lu24oH0qjYVp4Otg5Qbzol6VzrkWd8xSn2VaJIvHf
         la0mYUHipo3cUGKwwptex0t5yLUEEGpokjl6NP82Gw3xmowldiWR4AEQAFCrfRph1x5l
         za9ZYeuXSayOvyI5+ZSmacthxeNBeKbJ0t65w=
Received: by 10.223.127.210 with SMTP id h18mr3759808fas.79.1302389385838;
        Sat, 09 Apr 2011 15:49:45 -0700 (PDT)
Received: from localhost.localdomain (abwd67.neoplus.adsl.tpnet.pl [83.8.227.67])
        by mx.google.com with ESMTPS id j12sm1188601fax.33.2011.04.09.15.49.43
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 15:49:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171212>

This is split version (with assorted cleanups) of J.H. patch adding
JavaScript-base ability to change timezone in which dates are
displayed.

  [PATCH 0/1] Gitweb: Change timezone
    [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
  Message-Id: <1300925335-3212-1-git-send-email-warthog9@eaglescrag.net>
  http://thread.gmane.org/gmane.comp.version-control.git/169384/focus=169881

Below there is copy of original J.H. announcement:
JH>
JH> This is just a javascript implementation of Kevin's localtime
JH> feature.  It's pretty straight forward, though date handling in
JH> Javascript is, special (head bangingly so).
JH> 
JH> This should be good to run on any browser, with the safe fallback
JH> of UTC being the default output should Javascript not work / be
JH> available.


Table of contents:
~~~~~~~~~~~~~~~~~~
* [PATCH 01/11] gitweb: Split JavaScript for maintability, combining on build

  Addresses issue with 'add several javascript files to be loaded'

* [PATCH 02/11] gitweb.js: Update and improve comments in JavaScript files
  [PATCH/RFC 03/11] gitweb.js: Provide default values for padding in padLeftStr and padLeft

  Both are post-split cleanup

* [PATCH 04/11] gitweb.js: Extract and improve datetime handling
  [PATCH 05/11] gitweb.js: Introduce gitweb/static/js/lib/cookies.js
  [PATCH 06/11] gitweb.js: Provide getElementsByClassName method (if it not exists)

  Creating JavaScript library

* [PATCH 07/11] gitweb: Refactor generating of long dates into format_timestamp_html
  [RFC/PATCH 08/11] gitweb: Unify the way long timestamp is displayed

  Preparing gitweb.perl for changes

* [PATCH 09/11] gitweb: JavaScript ability to adjust time based on timezone
  [PATCH/RFC 10/11] gitweb.js: Add UI for selecting common timezone to display dates
  [PATCH/RFC 11/11] gitweb: Make JavaScript ability to adjust timezones configurable

  The main part.


Shortlog:
~~~~~~~~~
Jakub Narebski (9):
  gitweb: Split JavaScript for maintability, combining on build
  gitweb.js: Update and improve comments in JavaScript files
  gitweb.js: Provide default values for padding in padLeftStr and padLeft
  gitweb.js: Extract and improve datetime handling
  gitweb.js: Introduce gitweb/static/js/lib/cookies.js
  gitweb.js: Provide getElementsByClassName method (if it not exists)
  gitweb: Refactor generating of long dates into format_timestamp_html
  gitweb: Unify the way long timestamp is displayed
  gitweb: Make JavaScript ability to adjust timezones configurable

John 'Warthog9' Hawley (2):
  gitweb: JavaScript ability to adjust time based on timezone
  gitweb.js: Add UI for selecting common timezone to display dates

Diffstat:
~~~~~~~~~
 .gitignore                                         |    1 +
 gitweb/Makefile                                    |   19 ++-
 gitweb/gitweb.perl                                 |   75 ++++--
 gitweb/static/gitweb.css                           |   25 ++
 gitweb/static/js/README                            |   20 ++
 gitweb/static/js/adjust-timezone.js                |  281 ++++++++++++++++++++
 .../static/{gitweb.js => js/blame_incremental.js}  |  228 +---------------
 gitweb/static/js/javascript-detection.js           |   43 +++
 gitweb/static/js/lib/common-lib.js                 |  224 ++++++++++++++++
 gitweb/static/js/lib/cookies.js                    |  114 ++++++++
 gitweb/static/js/lib/datetime.js                   |  176 ++++++++++++
 11 files changed, 965 insertions(+), 241 deletions(-)
 create mode 100644 gitweb/static/js/README
 create mode 100644 gitweb/static/js/adjust-timezone.js
 rename gitweb/static/{gitweb.js => js/blame_incremental.js} (74%)
 create mode 100644 gitweb/static/js/javascript-detection.js
 create mode 100644 gitweb/static/js/lib/common-lib.js
 create mode 100644 gitweb/static/js/lib/cookies.js
 create mode 100644 gitweb/static/js/lib/datetime.js

Dirstat:
~~~~~~~~
  42.5% gitweb/static/js/lib/
  29.5% gitweb/static/js/
  18.9% gitweb/static/
   8.9% gitweb/

-- 
1.7.3
