From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 00/10] gitweb: 'blame' view improvements
Date: Sat, 25 Jul 2009 00:44:00 +0200
Message-ID: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:39:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTQM-0005tA-5z
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbZGXWjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbZGXWjX
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:39:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:62374 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbZGXWjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:39:22 -0400
Received: by fg-out-1718.google.com with SMTP id e21so527877fga.17
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=zUAAZi41yglhMHd50G2AXOm/MAsgDWfNUd8O913NYTc=;
        b=Q9sGeYhajVt8ARy0K3EiQIViwz1M04Kqt0TxFxVH6tRddII+3S7WRNwqGqYdanvvqf
         1CWFmGTW21BiMJRofMI+ge6sFVtJHWO7EhyX+NyfzpTzp5EyPNHYozrATcYh5xnsqiJC
         ZgNxxxAH2DiPPuXZAL8AVGJWFhhqjpCj8xRr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MToqQO9q4xLKiU5qaSkN2OPu2piuhxVsynjCac9Yp2PzBqrwIGtKeMPbod7FZERVT8
         BkYfiA12ENyqIMcy8EkFi9/rMBzviZT0wT3137SDlJnoibkYQfozl5dYbyPAmE/ddGky
         jjwJVD13nCuW7eFlaeziE830gS2Fa+9DVUGpA=
Received: by 10.86.51.20 with SMTP id y20mr158241fgy.72.1248475162107;
        Fri, 24 Jul 2009 15:39:22 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id 3sm9218108fge.23.2009.07.24.15.39.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:39:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMit4O005707;
	Sat, 25 Jul 2009 00:45:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMiUob005704;
	Sat, 25 Jul 2009 00:44:30 +0200
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123957>

This is second version of my improvements to gitweb's 'blame' view,
  Subject: [PATCH 0/3] gitweb: 'blame' view improvements
  Message-Id: <200907102354.43232.jnareb@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/123085

including some further improvements, and this time including
preparation and AJAX-y 'blame_incremental' view in series proper.
It also finally creates 'blame_incremental' links (last patch in
series).

The changes are also available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/web

Jakub Narebski (10):
  gitweb: Make .error style generic
  gitweb: Mark boundary commits in 'blame' view
  gitweb: Use "previous" header of git-blame -p in 'blame' view
  gitweb: Mark commits with no "previous" in 'blame' view
  gitweb: Add author initials in 'blame' view, a la "git gui blame"
  gitweb: Use light/dark for class names also in 'blame' view
  gitweb: Add -partial_query option to href() subroutine
  gitweb: Add optional "time to generate page" info in footer
  gitweb: Incremental blame (proof of concept)
  gitweb: Create links leading to 'blame_incremental' using JavaScript

 Makefile           |    6 +-
 git-instaweb.sh    |    7 +
 gitweb/blame.js    |  634 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.css  |   43 +++-
 gitweb/gitweb.perl |  332 ++++++++++++++++++++-------
 5 files changed, 930 insertions(+), 92 deletions(-)
 create mode 100644 gitweb/blame.js


Jakub Narebski (10):
  gitweb: Make .error style generic
  gitweb: Mark boundary commits in 'blame' view
  gitweb: Use "previous" header of git-blame -p in 'blame' view
  gitweb: Mark commits with no "previous" in 'blame' view
  gitweb: Add author initials in 'blame' view, a la "git gui blame"
  gitweb: Use light/dark for class names also in 'blame' view
  gitweb: Add -partial_query option to href() subroutine
  gitweb: Add optional "time to generate page" info in footer
  gitweb: Incremental blame (proof of concept)
  gitweb: Create links leading to 'blame_incremental' using JavaScript

 Makefile           |    6 +-
 git-instaweb.sh    |    7 +
 gitweb/blame.js    |  634 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.css  |   43 +++-
 gitweb/gitweb.perl |  332 ++++++++++++++++++++-------
 5 files changed, 930 insertions(+), 92 deletions(-)
 create mode 100644 gitweb/blame.js
