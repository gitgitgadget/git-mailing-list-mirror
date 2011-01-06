From: Yann Droneaud <yann@droneaud.fr>
Subject: [PATCH/RFC 0/4] en_US.UTF-8 locale detection
Date: Thu,  6 Jan 2011 15:22:13 +0100
Message-ID: <cover.1294312018.git.yann@droneaud.fr>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr> <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost> <1274720888.4838.13.camel@localhost>
Cc: Yann Droneaud <yann@droneaud.fr>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 06 15:31:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paqri-0001ez-Tb
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 15:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab1AFOa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 09:30:56 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:35150 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1AFOay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 09:30:54 -0500
Received: from deela.quest-ce.net ([80.12.81.242])
	by mwinf5d25 with ME
	id sENm1f0075DhHAg03ENmif; Thu, 06 Jan 2011 15:22:49 +0100
Received: from deela.quest-ce.net (localhost.localdomain [127.0.0.1])
	by deela.quest-ce.net (8.14.4/8.14.4) with ESMTP id p06EMQ40031804;
	Thu, 6 Jan 2011 15:22:39 +0100
Received: (from ydroneaud@localhost)
	by deela.quest-ce.net (8.14.4/8.14.4/Submit) id p06EMQse031802;
	Thu, 6 Jan 2011 15:22:26 +0100
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1274720888.4838.13.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164631>

Following discussions[1] about test t9129 UTF-8 locale detection,
here's a generic rewrite of the en_US.UTF-8 locale detection
to be used with all other tests.

[1] http://thread.gmane.org/gmane.comp.version-control.git/147283

The proposed mechanism could work for system without "locale" command,
and would detect en_US.UTF-8 locale when named en_US.utf8 or some other
variations.

It must be tested on a wider range of systems (especially non-Linux).

Yann Droneaud (4):
  test: added a library to detect an en_US.UTF-8 locale
  test-lib.sh: added test_utf8() function
  test: use test_utf8 and GIT_LC_UTF8 where an en_US.UTF-8 locale is
    required
  t9129: use "$PERL_PATH" instead of "perl"

 t/lib-locale.pl                        |  167 ++++++++++++++++++++++++++++++++
 t/t9100-git-svn-basic.sh               |   25 ++---
 t/t9129-git-svn-i18n-commitencoding.sh |   13 +--
 t/test-lib.sh                          |   14 +++
 4 files changed, 192 insertions(+), 27 deletions(-)
 create mode 100755 t/lib-locale.pl

-- 
1.7.3.4
