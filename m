From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH v3 0/4] Improve hideRefs when used with namespaces
Date: Thu,  5 Nov 2015 07:07:27 +0100
Message-ID: <1446703651-9049-1-git-send-email-lfleischer@lfos.de>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 07:08:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuDiJ-0002xH-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 07:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbbKEGHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 01:07:55 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:43646 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752805AbbKEGHy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:07:54 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 7d81a91c;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Thu, 5 Nov 2015 07:07:32 +0100 (CET)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280899>

This is a first set of patches improving documentation and behavior of
the transfer.hideRefs feature as discussed in [1]. In particular,
hideRefs is changed to generally match stripped refs by default and
match full refs when prefixed with "^". The documentation is updated
accordingly. Basic tests are added.

Changes since v2:

* Reword the additions to the documentation as suggested by Junio.
* Fix the return value in show_ref_cb().

[1] http://marc.info/?l=git&m=144604694223920

Lukas Fleischer (4):
  Document the semantics of hideRefs with namespaces
  upload-pack: strip refs before calling ref_is_hidden()
  Add support for matching full refs in hideRefs
  t5509: add basic tests for hideRefs

 Documentation/config.txt         |  9 +++++++++
 builtin/receive-pack.c           | 27 ++++++++++++++++++++------
 refs.c                           | 15 ++++++++++++---
 refs.h                           | 10 +++++++++-
 t/t5509-fetch-push-namespaces.sh | 41 ++++++++++++++++++++++++++++++++++++++++
 upload-pack.c                    | 13 ++++++++-----
 6 files changed, 100 insertions(+), 15 deletions(-)

-- 
2.6.2
