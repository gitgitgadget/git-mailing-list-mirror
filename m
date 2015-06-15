From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 0/4] submodule config lookup API
Date: Mon, 15 Jun 2015 23:06:10 +0200
Message-ID: <cover.1434400625.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:06:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4bab-0001ys-Js
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 23:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852AbbFOVGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 17:06:36 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:59806 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740AbbFOVGf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 17:06:35 -0400
Received: from [178.11.201.3] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Z4baR-0001ee-69; Mon, 15 Jun 2015 23:06:31 +0200
X-Mailer: git-send-email 2.4.2.391.g2979c89
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271730>

There have been no code changes in since the last iteration. I changed
the title for the first patch since I realized that the cache is just an
implementation detail and what we are really doing is to provide a new
API for reading values from .gitmodules. I also added an extra paragraph
in the commit message explaining that fact.

The last iteration can be found here:

http://article.gmane.org/gmane.comp.version-control.git/270545

There is no interdiff since no code changed.

Heiko Voigt (4):
  implement submodule config API for lookup of .gitmodules values
  extract functions for submodule config set and lookup
  use new config API for worktree configurations of submodules
  do not die on error of parsing fetchrecursesubmodules option

 .gitignore                                       |   1 +
 Documentation/technical/api-submodule-config.txt |  63 +++
 Makefile                                         |   2 +
 builtin/checkout.c                               |   1 +
 builtin/fetch.c                                  |   1 +
 diff.c                                           |   1 +
 submodule-config.c                               | 484 +++++++++++++++++++++++
 submodule-config.h                               |  29 ++
 submodule.c                                      | 122 ++----
 submodule.h                                      |   4 +-
 t/t7411-submodule-config.sh                      | 153 +++++++
 test-submodule-config.c                          |  76 ++++
 12 files changed, 839 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/technical/api-submodule-config.txt
 create mode 100644 submodule-config.c
 create mode 100644 submodule-config.h
 create mode 100755 t/t7411-submodule-config.sh
 create mode 100644 test-submodule-config.c

-- 
2.4.2.391.g2979c89
