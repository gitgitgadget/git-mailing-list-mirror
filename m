From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/5] grep parseopt conversion
Date: Thu, 07 May 2009 21:43:00 +0200
Message-ID: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 21:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29Uy-0001eg-M3
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbZEGTnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbZEGTnI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:43:08 -0400
Received: from india601.server4you.de ([85.25.151.105]:37350 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbZEGTnH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:43:07 -0400
Received: from [10.0.1.101] (p57B7C554.dip.t-dialin.net [87.183.197.84])
	by india601.server4you.de (Postfix) with ESMTPSA id E1A582F8003;
	Thu,  7 May 2009 21:43:05 +0200 (CEST)
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118511>

This series converts git-grep to parseopt.  The first three patches
extend the parser to accept inverse bit options, numerical options
and options without dashes:

   [PATCH 1/5] parseopt: add OPT_NEGBIT
   [PATCH 2/5] parseopt: add OPT_NUMBER_CALLBACK
   [PATCH 3/5] parseopt: add PARSE_OPT_NODASH

The fourth patch is a cleanup:

   [PATCH 4/5] grep: remove global variable builtin_grep

The last patch uses the added infrastructure in git-grep:

   [PATCH 5/5] grep: use parseopt

 Documentation/technical/api-parse-options.txt |   12 +
 builtin-grep.c                                |  416 +++++++++++--------------
 grep.h                                        |   28 +-
 parse-options.c                               |   63 ++++-
 parse-options.h                               |   14 +-
 t/t0040-parse-options.sh                      |   56 ++++-
 test-parse-options.c                          |   11 +
 7 files changed, 348 insertions(+), 252 deletions(-)
