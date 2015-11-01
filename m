From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH 0/4] Improve hideRefs when used with namespaces
Date: Sun,  1 Nov 2015 20:34:19 +0100
Message-ID: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 20:34:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsyOh-0000JD-6M
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbbKATeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:34:31 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:8371 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKATea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:34:30 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id c8e084a4;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sun, 1 Nov 2015 20:34:29 +0100 (CET)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280659>

This is a first set of patches improving documentation and behavior of
the transfer.hideRefs feature as discussed in [1]. In particular,
hideRefs is changed to generally match stripped refs by default and
match full refs when prefixed with "^". The documentation is updated
accordingly. Basic tests are added.

[1] http://marc.info/?l=git&m=144604694223920

Lukas Fleischer (4):
  Document the semantics of hideRefs with namespaces
  upload-pack: strip refs before calling ref_is_hidden()
  Add support for matching full refs in hideRefs
  t5509: add basic tests for hideRefs

 Documentation/config.txt         |  8 ++++++++
 builtin/receive-pack.c           | 22 ++++++++++++++++------
 refs.c                           | 14 +++++++++++---
 refs.h                           |  2 +-
 t/t5509-fetch-push-namespaces.sh | 29 +++++++++++++++++++++++++++++
 upload-pack.c                    | 13 ++++++++-----
 6 files changed, 73 insertions(+), 15 deletions(-)

-- 
2.6.2
