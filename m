From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 0/4] allow more sources for config values
Date: Sun, 10 Mar 2013 17:56:42 +0100
Message-ID: <20130310165642.GA1136@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 17:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEjYp-0004uM-T7
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 17:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab3CJQ4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 12:56:49 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:33565 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab3CJQ4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 12:56:49 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UEjYB-0001iy-Dc; Sun, 10 Mar 2013 17:56:43 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217811>

The following issues still exist:

 * Error handling: If this should be useful to interrogate configs from
   the database during git operations we need a way to recover from
   parsing errors instead of dying.

 * More tests ?

This is an update with the comments of the first iteration[1]
incorporated.

[1] http://thread.gmane.org/gmane.comp.version-control.git/217018/

Heiko Voigt (4):
  config: factor out config file stack management
  config: drop file pointer validity check in get_next_char()
  config: make parsing stack struct independent from actual data source
  teach config parsing to read from strbuf

 .gitignore             |   1 +
 Makefile               |   1 +
 cache.h                |   2 +
 config.c               | 143 ++++++++++++++++++++++++++++++++++++++-----------
 t/t1300-repo-config.sh |  24 +++++++++
 test-config.c          |  40 ++++++++++++++
 6 files changed, 180 insertions(+), 31 deletions(-)
 create mode 100644 test-config.c

-- 
1.8.2.rc0.26.gf7384c5
