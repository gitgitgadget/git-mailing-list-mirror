From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv7.1 0/4] Gitweb caching v7.1
Date: Mon,  1 Nov 2010 11:24:48 +0100
Message-ID: <1288607092-31458-1-git-send-email-jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 11:25:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCrZw-0005lL-Td
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 11:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757112Ab0KAKZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 06:25:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44181 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab0KAKZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 06:25:14 -0400
Received: by ewy7 with SMTP id 7so3125206ewy.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/nHAkf2TvBPfJkGEN0NEorAVtWi/LbPR6utw9R2PLYg=;
        b=aTG98l9zeOB+xvwFaCtwnCM9SMXWWFNgge/OctS0XBVCPrU78WVYdPCVm17br0wlEw
         ah3JkGR7Lzu40SpulVapDNufYo1ZTLP0fbUl2OspCsuwMfq7ttR+pWdwiMq/04UQVw6M
         vzzqMUVgUJph0A+IbsyHo+2JRlBQ/HqjhbuJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w1O0VPDFbZrr9b9WkT8QcPnEQcceHOHot0DWpixUpUGvfCf2bTq/uumc62j4oC/Pqx
         ZROlnBP0lc3LK1WqutcILFLTfegl5Qr1/Ujs+MVhG73z8RFMOKpqZIIcR4FDu/qOt2LV
         aWPJXMz59YIGqgm3pXHoMbaQVqaac5qmaavK0=
Received: by 10.213.8.210 with SMTP id i18mr2067473ebi.9.1288607112594;
        Mon, 01 Nov 2010 03:25:12 -0700 (PDT)
Received: from roke.localdomain (abvk31.neoplus.adsl.tpnet.pl [83.8.208.31])
        by mx.google.com with ESMTPS id x54sm4069255eeh.11.2010.11.01.03.25.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 03:25:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <201010311021.55917.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160473>

This series is a bit fixed up and a tiny bit cleaned up version of
"Gitweb caching v7" series from John 'Warthog9' Hawley.

This series is based on top of 8ff76f4 (gitweb: Move call to
evaluate_git_version after evaluate_gitweb_config, 2010-09-26)
currently in 'pu'.  This commit fixes a bug in gitweb which shows in
running testsuite.

The patch "gitweb: Add option to force version match" was removed from
this series as it doesn't belong to it, c.f. 
  http://article.gmane.org/gmane.comp.version-control.git/160236

 [PATCHv7.1 1/4] gitweb: Prepare for splitting gitweb
 [PATCHv7.1 2/4] gitweb: add output buffering and associated functions
 [PATCHv7.1 3/4] gitweb: File based caching layer (from git.kernel.org)
 [PATCHv7.1 4/4] gitweb: Minimal testing of gitweb caching

Jakub Narebski (2):
  gitweb: Prepare for splitting gitweb
  gitweb: Minimal testing of gitweb caching

John 'Warthog9' Hawley (2):
  gitweb: add output buffering and associated functions
  gitweb: File based caching layer (from git.kernel.org)

 gitweb/Makefile                           |   20 ++-
 gitweb/gitweb.perl                        |  134 +++++++++++-
 gitweb/lib/cache.pl                       |  348 +++++++++++++++++++++++++++++
 gitweb/static/gitweb.css                  |    6 +
 t/t9500-gitweb-standalone-no-errors.sh    |   19 ++
 t/t9502-gitweb-standalone-parse-output.sh |   39 ++++
 6 files changed, 555 insertions(+), 11 deletions(-)
 create mode 100644 gitweb/lib/cache.pl

-- 
1.7.3
