From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 0/2] submodule: drop the top-level requirement
Date: Thu, 18 Apr 2013 20:50:40 +0100
Message-ID: <cover.1366314439.git.john@keeping.me.uk>
References: <cover.1365539059.git.john@keeping.me.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 21:51:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USurN-0006lT-MU
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 21:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936527Ab3DRTvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 15:51:05 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:35176 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab3DRTvD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 15:51:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 745E6CDA5BF;
	Thu, 18 Apr 2013 20:51:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eHh4OLb-qwJY; Thu, 18 Apr 2013 20:51:01 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E11E3CDA618;
	Thu, 18 Apr 2013 20:50:50 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.424.g1899e5e.dirty
In-Reply-To: <cover.1365539059.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221686>

Thanks to Ram and Jens for the feedback on v2.  I've addressed most of
their comments in this version, but I've ignored a couple of Ram's nits
about test cases where leaving it how it is makes the added tests
consistent with those already in the same file.

Since v2, the main improvement is that the output from git-submodule now
contains paths relative to the directory in which the command is run,
not the top-level of the working tree.

John Keeping (2):
  rev-parse: add --prefix option
  submodule: drop the top-level requirement

 Documentation/git-rev-parse.txt |  16 ++++++
 builtin/rev-parse.c             |  24 +++++++--
 git-submodule.sh                | 113 ++++++++++++++++++++++++++++++----------
 t/t1513-rev-parse-prefix.sh     |  96 ++++++++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh      |  27 ++++++++++
 t/t7401-submodule-summary.sh    |  14 +++++
 6 files changed, 258 insertions(+), 32 deletions(-)
 create mode 100755 t/t1513-rev-parse-prefix.sh

-- 
1.8.2.1.424.g1899e5e.dirty
