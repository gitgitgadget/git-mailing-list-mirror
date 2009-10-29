From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Smarter snapshot names
Date: Thu, 29 Oct 2009 23:07:40 +0100
Message-ID: <1256854062-25496-1-git-send-email-jnareb@gmail.com>
Cc: Mark Rada <marada@uwaterloo.ca>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 23:08:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3dA8-0006jt-Vg
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 23:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbZJ2WHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 18:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756158AbZJ2WHs
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 18:07:48 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53898 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbZJ2WHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 18:07:47 -0400
Received: by mail-bw0-f227.google.com with SMTP id 27so2871367bwz.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=ZGgQWduDmDGs1hklE7zUYIv28FHIUES5xM1ybl2PyzE=;
        b=AHLvgd7Rt8j9ac9dvi0VLaO79zRxTdqd2ZhJluJsZy8Wk9trldM2YbCmgkz6zOsQd/
         4GIiBbgokT7Ixw6ayP402aml/ZViJx6lEz/lm8ic7DOlLt0G39nNSr8eJKdjsXBmF+WW
         FEewxaK55gp3xSReMrU4KpaItP+kKlMJf/svA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NxauyozAJq32jZXTviWTICBF3mTpecY6erYSK5fYc9CYLSmCK9G/Afdrno5eL7YI87
         jecIDRyGt2ed5Rn5OuuiTy2MQs0UXLX1ExZVjYDJNka5ClSKQJFMQSleFbj+8o474+4J
         1tYyeGlErdcorooC983WV3X+MjnxIeka5wZZY=
Received: by 10.204.36.206 with SMTP id u14mr466359bkd.138.1256854071803;
        Thu, 29 Oct 2009 15:07:51 -0700 (PDT)
Received: from localhost.localdomain (abwt44.neoplus.adsl.tpnet.pl [83.8.243.44])
        by mx.google.com with ESMTPS id 13sm174727bwz.6.2009.10.29.15.07.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 15:07:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9TM7oDC025532;
	Thu, 29 Oct 2009 23:07:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9TM7nED025531;
	Thu, 29 Oct 2009 23:07:49 +0100
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131660>

This series is proposed proposed replacement for a single top commit
in 'mr/gitweb-snapshot' branch, which was merged into pu.

Those two patches are meant to replace the following commit:
b411a7a (gitweb: append short hash ids to snapshot files, 2009-09-26)

Jakub Narebski (1):
  t/gitweb-lib.sh: Split gitweb output into headers and body

Mark Rada (1):
  gitweb: Smarter snapshot names
  (formerly: gitweb: append short hash ids to snapshot files)

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCH 1/2] t/gitweb-lib.sh: Split gitweb output into headers and body
 [RFC/PATCH v6 2/2] gitweb: Smarter snapshot names

 gitweb/gitweb.perl                        |   76 +++++++++++++++----
 t/gitweb-lib.sh                           |    6 ++-
 t/t9502-gitweb-standalone-parse-output.sh |  112 +++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 17 deletions(-)
 create mode 100755 t/t9502-gitweb-standalone-parse-output.sh

-- 
Jakub Narebski
Poland
