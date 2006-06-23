From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH 0/5] Rework diff options
Date: Sat, 24 Jun 2006 01:15:38 +0300
Message-ID: <20060624011538.9bb179e7.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:17:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fttxf-0004P0-Uc
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbWFWWRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbWFWWRH
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:17:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:45557 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752121AbWFWWRF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:17:05 -0400
Received: by nf-out-0910.google.com with SMTP id m19so277746nfc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 15:17:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=HT3+KsStsyNCGk+7YYWLQIE4SZcltg/fSiIfkZ1HU6o095jU9MlzmXwHH0E2l1KucLz26wqOw03XNdReMWU9/w+iuQ+gLob8WVbqpvU9m+eAeui9WivpWouQ4RhMTcZ8eEWw2WE9aTjgF46OPyXdXgCEHI709YyXNqgPAzQaLR0=
Received: by 10.48.163.7 with SMTP id l7mr2872589nfe;
        Fri, 23 Jun 2006 15:17:04 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id b1sm3374081nfe.2006.06.23.15.17.04;
        Fri, 23 Jun 2006 15:17:04 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22443>

This patch series cleans up diff output format options.

This makes it possible to use any combination of --raw, -p, --stat and
--summary options and they work as you would expect.

These patches passed all tests but patch 2/5 is quite intrusive...

 b/builtin-diff-files.c  |   10 +-
 b/builtin-diff-index.c  |    4 
 b/builtin-diff-stages.c |    3 
 b/builtin-diff-tree.c   |    3 
 b/builtin-diff.c        |   74 ++++++-----------
 b/builtin-log.c         |   12 +-
 b/combine-diff.c        |   45 +++-------
 b/diff.c                |  207 +++++++++++++++++++++++-------------------------
 b/diff.h                |   29 +++---
 b/git-merge.sh          |    3 
 b/log-tree.c            |   15 ++-
 b/revision.c            |    5 -
 12 files changed, 196 insertions(+), 214 deletions(-)

-- 
http://onion.dynserv.net/~timo/
