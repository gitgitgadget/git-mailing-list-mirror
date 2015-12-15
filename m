From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/3] format-patch: introduce option to suppress commit hashes
Date: Tue, 15 Dec 2015 01:52:02 +0000
Message-ID: <1450144325-182108-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 02:52:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ems-0000KK-JY
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 02:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859AbbLOBwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 20:52:13 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47196 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932400AbbLOBwM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 20:52:12 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DF0C6282CA;
	Tue, 15 Dec 2015 01:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450144330;
	bh=uKD//4AVzT9x4S/armA02vYKb44E1e8zQ39tSwBh/yc=;
	h=From:To:Cc:Subject:Date:From;
	b=uW6POtAI0wNqTHwpQtw1IDHoTAiBZUNo4qf1m38Bq5zgC6RQV8WsrxaLx0C22qUKE
	 vkCvruVXxsj2eYjFlpFHac75bVGN5a+XLEnhrYR1qm55+Zn32ER2L4aEQsfzkUzJBc
	 aATbJEbXOQ0DnyTQgsqeq/3FZclkO1oQOyQP1poL80uHu74LgkgiZzrwo9qvqEmK3m
	 VhkYRb+BQyR5sHdUEEI3uAeRFC7/Mnceg7ZY1mDPxr/ZTVAmxHqQtEf5XdsfWvuXDJ
	 wfs/Iu2Vm5jSWkclvRzPUf7iabPr08B1MulW8km75Yr2Yy4lw2axd0TIJHMELk5nBy
	 9r77hd3NNW2EfQbN7Ph1TW/wjG0fYUqrGebzaOE4ylz+YTFW96RHMIQYsX/FFSvcxq
	 tfofT/+qgINfoIsrMrngMAAA881mW5sPEof9rsHZej3RMVBPzfAuBNulC4ab8SKQOU
	 7EH7hPGz9sD4n1Z27n1Z+Uw17df25EBUERpcfzjhnDG7uuOPh0k
X-Mailer: git-send-email 2.7.0.rc0.173.g4a846af
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282463>

git format-patch is often used to create patches that are then stored in
version control or displayed with diff.  Having the commit hash in the
"From " line usually just creates diff noise in these cases, so this
series introduces --zero-commit to set that to all zeros.

Changes from v2:
* Improve the tests to be more idiomatic and avoid hard-coding line
  counts.

brian m. carlson (3):
  Introduce a null_oid constant.
  format-patch: add an option to suppress commit hash
  format-patch: check that header line has expected format

 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      |  5 +++++
 cache.h                            |  1 +
 log-tree.c                         |  3 ++-
 revision.h                         |  1 +
 sha1_file.c                        |  1 +
 t/t4014-format-patch.sh            | 14 ++++++++++++++
 7 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.7.0.rc0.194.g1187e4e.dirty
