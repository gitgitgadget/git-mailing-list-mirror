From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH v2 0/4] Improve hideRefs when used with namespaces
Date: Tue,  3 Nov 2015 08:58:13 +0100
Message-ID: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 09:13:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWiz-000157-Ae
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 09:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbbKCH6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:58:22 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:44899 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbKCH6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 02:58:21 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id b9e56c70;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 3 Nov 2015 08:58:18 +0100 (CET)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280782>

This is a first set of patches improving documentation and behavior of
the transfer.hideRefs feature as discussed in [1]. In particular,
hideRefs is changed to generally match stripped refs by default and
match full refs when prefixed with "^". The documentation is updated
accordingly. Basic tests are added.

Changes since v1:

* Improvements in the code for denying pushing hidden refs.
* Simplification of the tests as suggested by Eric.
* New tests for the code for denying pushing hidden refs.
* Comments.

[1] http://marc.info/?l=git&m=144604694223920

Lukas Fleischer (4):
  Document the semantics of hideRefs with namespaces
  upload-pack: strip refs before calling ref_is_hidden()
  Add support for matching full refs in hideRefs
  t5509: add basic tests for hideRefs

 Documentation/config.txt         |  8 ++++++++
 builtin/receive-pack.c           | 27 ++++++++++++++++++++------
 refs.c                           | 15 ++++++++++++---
 refs.h                           | 10 +++++++++-
 t/t5509-fetch-push-namespaces.sh | 41 ++++++++++++++++++++++++++++++++++++++++
 upload-pack.c                    | 13 ++++++++-----
 6 files changed, 99 insertions(+), 15 deletions(-)

-- 
2.6.2
