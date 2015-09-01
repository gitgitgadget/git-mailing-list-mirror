From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Tue,  1 Sep 2015 22:55:38 +0100
Message-ID: <cover.1441144343.git.john@keeping.me.uk>
References: <20150901083731.GE30659@serenity.lan>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 23:56:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtXF-0005ks-8G
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 23:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbIAV4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 17:56:05 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:59871 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbIAV4D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 17:56:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 689D9866017;
	Tue,  1 Sep 2015 22:56:02 +0100 (BST)
X-Quarantine-ID: <ZHIVZmoQRO-m>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZHIVZmoQRO-m; Tue,  1 Sep 2015 22:56:01 +0100 (BST)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 73A8ACDA56C;
	Tue,  1 Sep 2015 22:55:50 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <20150901083731.GE30659@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277043>

Jeff's first patch is unmodified but I've squashed the fixed currently
on "pu" into the second.  I also realised while adding the tests that
"raw-local" is meaningless so I've modified the code to reject it in the
same way as "relative-local".

Jeff King (2):
  fast-import: switch crash-report date to iso8601
  date: make "local" orthogonal to date format

John Keeping (4):
  t6300: introduce test_date() helper
  t6300: make UTC and local dates different
  t6300: add test for "raw" date format
  t6300: add tests for "-local" date formats

 Documentation/rev-list-options.txt |  21 ++++--
 builtin/blame.c                    |   1 -
 cache.h                            |   2 +-
 date.c                             |  77 +++++++++++++-------
 fast-import.c                      |   2 +-
 t/t6300-for-each-ref.sh            | 139 +++++++++++++++++++------------------
 6 files changed, 140 insertions(+), 102 deletions(-)

-- 
2.5.0.466.g9af26fa
