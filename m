From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 0/4] CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 23:18:41 -0500
Message-ID: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 05:19:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpvKj-0007jo-9J
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 05:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab1BQETE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 23:19:04 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41140 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab1BQETC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 23:19:02 -0500
Received: by qyk12 with SMTP id 12so2315930qyk.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 20:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=ZSqWZwIoBbHkPulOREBPOdUOjZsxOmNYVCv/aBaHXzM=;
        b=Zhvkd1L14vDZN4qjVvFd5WMKfb96PV74NvwO3VJb09p0XGPuz6AMG7sw42rQJiQJwh
         WgU2r/qhdDJkq+BTIcSxrqGHrkpaMaOoBNXfFS0O81cs1IoIHvr7Grldq4JblpTvz0mJ
         Tktc4frztxvJaN9U0JlTxE7nnVB/SuJ8OFldA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dYzbq6nseqgopjHehlbNnLQVt4ZFOQRR2saXiWdMRX8+mEBPIXHdo1tZNgFPm0+WYL
         s05rzVzPn3z7X5dGIkU0m0KjAdN6/E/40WG/DPuEHUT+oDqpECTeGmTfPw5U+zsWiJRw
         a5ba9UJnIIXOf+ZT1IjEUmVpPqtiT9MS6iEJE=
Received: by 10.224.20.65 with SMTP id e1mr1876187qab.371.1297916341531;
        Wed, 16 Feb 2011 20:19:01 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id l17sm410289qck.20.2011.02.16.20.19.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 20:19:01 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.g7fe09
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167031>

Incorporating feedback from http://thread.gmane.org/gmane.comp.version-control.git/166945

Jay Soffian (4):
  Introduce CHERRY_PICK_HEAD
  bash: teach __git_ps1 about CHERRY_PICK_HEAD
  commit.c: replace some literal strings with constants
  Teach commit about CHERRY_PICK_HEAD

 Documentation/git-cherry-pick.txt      |   19 +++
 Documentation/git-commit.txt           |    7 +-
 Documentation/revisions.txt            |    5 +-
 branch.c                               |    1 +
 builtin/commit.c                       |  196 ++++++++++++++++++++++----------
 builtin/merge.c                        |    7 +
 builtin/revert.c                       |   74 ++++---------
 contrib/completion/git-completion.bash |    2 +
 t/t3507-cherry-pick-conflict.sh        |  138 ++++++++++++++++++++++-
 t/t7509-commit.sh                      |   29 +++++
 wt-status.c                            |    4 +-
 wt-status.h                            |    9 ++-
 12 files changed, 371 insertions(+), 120 deletions(-)

-- 
1.7.4.1.30.g7fe09
