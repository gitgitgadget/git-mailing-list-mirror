From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 0/3] gitweb: Categories support
Date: Tue,  8 Mar 2011 00:13:32 +0100
Message-ID: <1299539616-19991-1-git-send-email-jnareb@gmail.com>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Petr Baudis <pasky@suse.cz>, "J.H." <warthog9@kernel.org>,
	Sebastien Cevey <seb@cine7.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 00:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwjcx-0004la-CP
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 00:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab1CGXOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 18:14:04 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56633 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab1CGXOC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 18:14:02 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so4166784bwz.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 15:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Mnvsmhwi2EW97rH07TNt+UAacN38KT8wW9DW0BShL/o=;
        b=uQuf274GeH1nIOAULDTZOvloKtsWYNoAr8BnRFcp5T7X6Wmcd3iKAmMFI7/wqRHptF
         bgFE+GY1gGRjr6j5nqKGlPHX0fK2iAmp4xaH2OtjJcy/Jbvr/mYT18lwnZdLt+lr/JWj
         AmKt5k5ebpN1RQ8YIhDgtMfHzuFiJpaISqLAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=u8+kJtWwU0pXO0UYcrO8m5RP4QmvZwPSgG8zvGcOkA3qiwd94iQpd/BPb8PnZLbMoi
         bOLJsZRgaIzyfMPgAKevoMT+2+qmINfEgXiBj/wckzRsZA5YKYOI11bHMyfB3pWiHM9g
         rP6Vd5VSvYTW1s6SlBU3PeM5OTqd9Hw3S/3g4=
Received: by 10.204.19.20 with SMTP id y20mr2367311bka.170.1299539640522;
        Mon, 07 Mar 2011 15:14:00 -0800 (PST)
Received: from localhost.localdomain (abvd192.neoplus.adsl.tpnet.pl [83.8.201.192])
        by mx.google.com with ESMTPS id l1sm75621bkl.1.2011.03.07.15.13.58
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 15:13:59 -0800 (PST)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168616>

This series is based on

  "[PATCHv2/RFC] gitweb: Restructure projects list generation"
  http://thread.gmane.org/gmane.comp.version-control.git/167996/focus=168321

  http://repo.or.cz/w/git/jnareb-git.git/commit/420071752d13dcecd59e794d82285e7e142ef75f
  ('gitweb/web' branch in http://repo.or.cz/w/git/jnareb-git.git repository)

which is the main reason why this series is marked as an RFC.

This series is long in wait port of Sebastien Cevey series from
December 2008

  http://thread.gmane.org/gmane.comp.version-control.git/102844

to modern gitweb.  It was waiting for abovementioned restructuring of
projects list generation.

Uwe, it might be an alternative to use ctags (content tags, aka
project labels).

Sebastien Cevey (3):
  gitweb: Split git_project_list_body in two functions
  gitweb: Modularized git_get_project_description to be more generic
  gitweb: Optional grouping of projects by category

 gitweb/README                          |   16 +++
 gitweb/gitweb.perl                     |  166 +++++++++++++++++++++++---------
 gitweb/static/gitweb.css               |    7 ++
 t/t9500-gitweb-standalone-no-errors.sh |    8 ++
 4 files changed, 151 insertions(+), 46 deletions(-)

-- 
1.7.3
