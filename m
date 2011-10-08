From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5/RFC 0/6] Moving gitweb documentation to manpages
Date: Sat,  8 Oct 2011 20:31:57 +0200
Message-ID: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:33:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCbi9-0007b3-3w
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 20:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab1JHScb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 14:32:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44194 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1JHSca (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 14:32:30 -0400
Received: by bkbzt4 with SMTP id zt4so6340946bkb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gqrZ+gwu03FDmboQIh8EUow4loXESSlYjQtG8uO0NzU=;
        b=LZ5BQ9v3ZqyYPSxz9GsH4IXY/FlneQmCIiMP+/BuuUlqp6H1eoFiJq/MnRtI9aJUNY
         AG5Iaoywd7bW47aDqmAGrj7a85MJ26LP4RlffWKabhl9J1DArB9E+2bdM9AcP8woMP9B
         +F/HLHx1ZsdTaSd/6oYXPHbW67Cb9HjV+PZMg=
Received: by 10.223.61.146 with SMTP id t18mr19825363fah.34.1318098747960;
        Sat, 08 Oct 2011 11:32:27 -0700 (PDT)
Received: from localhost.localdomain (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id m26sm20180604fac.6.2011.10.08.11.32.25
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 11:32:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183166>

The original patch adding manpage for /etc/gitweb.conf was sent by
Drew Northup (as can be seen from shortlog); I have added manpage for
gitweb itself, inspired by his patch.  Unfortunately Drew doesn't
currently have time to work on this patch (patch series), so that is
why it is me resending this series (again).

Compared to previous version

  "[PATCH/RFCv4 0/4] Moving gitweb documentation to manpages"
  http://thread.gmane.org/gmane.comp.version-control.git/181605

it has much improved gitweb.conf.txt manpage, and "Documentation:
Preparation for gitweb manpages" commit message, thanks to feedback
provided by Jonathan Nieder.

New in this series are patches 4 and 5, which add links to the newly
created gitweb documentation and gitweb config variables from other
manpages, respectively.

Note that only "Documentation: Preparation for gitweb manpages" (which
is not strictly necessary) and "gitweb: Add manpage for gitweb" (which
didn't get as much review as "gitweb: Add manpage for gitweb
configuration files" are still marked as RFC.

I have checked that RPM generation of 'gitweb' package works correctly
wrt. gitweb documentation.

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCHv5/RFC 1/6] Documentation: Preparation for gitweb manpages
 [PATCHv5 2/6] gitweb: Add manpage for gitweb configuration files
 [PATCHv5/RFC 3/6] gitweb: Add manpage for gitweb
 [PATCHv5 4/6] Documentation: Link to gitweb(1) and 
   gitweb.conf(5) in other manpages
 [PATCHv5 5/6] Documentation: Add gitweb config variables to
   git-config(1)
 [PATCHv5 6/6] gitweb: Add gitweb manpages to 'gitweb' package in
   git.spec.in

Shortlog:
~~~~~~~~~
Drew Northup (1):
  gitweb: Add manpage for gitweb configuration files

Jakub Narebski (5):
  Documentation: Preparation for gitweb manpages
  gitweb: Add manpage for gitweb
  Documentation: Link to gitweb(1) and gitweb.conf(5) in other manpages
  Documentation: Add gitweb config variables to git-config(1)
  gitweb: Add gitweb manpages to 'gitweb' package in git.spec

Diffstat:
~~~~~~~~~
 Documentation/Makefile         |    7 +-
 Documentation/config.txt       |   17 +
 Documentation/git-instaweb.txt |    4 +
 Documentation/gitweb.conf.txt  |  875 ++++++++++++++++++++++++++++++++++++++++
 Documentation/gitweb.txt       |  703 ++++++++++++++++++++++++++++++++
 command-list.txt               |    1 +
 git.spec.in                    |    7 +
 gitweb/INSTALL                 |   94 +----
 gitweb/Makefile                |    7 +-
 gitweb/README                  |  411 +------------------
 10 files changed, 1647 insertions(+), 479 deletions(-)
 create mode 100644 Documentation/gitweb.conf.txt
 create mode 100644 Documentation/gitweb.txt

-- 
1.7.6
