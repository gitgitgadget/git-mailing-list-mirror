From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 0/4] submodule config lookup API
Date: Sat, 28 Jun 2014 11:58:00 +0200
Message-ID: <20140628095800.GA89729@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 11:58:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0pOq-0004Vs-Pm
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 11:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbaF1J6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 05:58:15 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:34398 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaF1J6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 05:58:14 -0400
Received: from [92.194.105.81] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1X0pOb-0005YB-E6; Sat, 28 Jun 2014 11:58:09 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252601>

Here another iteration with all the comments incorporated:

  * Dropped the hashmap enum parameter patch
  * Renamed the test to t7411
  * Compilation fixes and style

Gmane seems offline for me, so I can not check but this should be the last
iteration:

http://mid.gmane.org/20140605060425.GA23874@sandbox-ub

Heiko Voigt (4):
  implement submodule config cache for lookup of submodule names
  extract functions for submodule config set and lookup
  use new config API for worktree configurations of submodules
  do not die on error of parsing fetchrecursesubmodules option

 .gitignore                                       |   1 +
 Documentation/technical/api-submodule-config.txt |  63 ++++
 Makefile                                         |   2 +
 builtin/checkout.c                               |   1 +
 builtin/fetch.c                                  |   1 +
 diff.c                                           |   1 +
 submodule-config.c                               | 435 +++++++++++++++++++++++
 submodule-config.h                               |  29 ++
 submodule.c                                      | 122 ++-----
 submodule.h                                      |   4 +-
 t/t7411-submodule-config.sh                      | 141 ++++++++
 test-submodule-config.c                          |  70 ++++
 12 files changed, 772 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/technical/api-submodule-config.txt
 create mode 100644 submodule-config.c
 create mode 100644 submodule-config.h
 create mode 100755 t/t7411-submodule-config.sh
 create mode 100644 test-submodule-config.c

-- 
1.9.2.464.g1bbf329
