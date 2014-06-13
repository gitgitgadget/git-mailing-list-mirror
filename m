From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/6] verify-commit: verify commit signatures
Date: Fri, 13 Jun 2014 12:42:42 +0200
Message-ID: <cover.1402655838.git.git@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 12:43:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvOws-0007ft-2W
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 12:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbaFMKmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 06:42:52 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45546 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752150AbaFMKmu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 06:42:50 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3BFE820CE2
	for <git@vger.kernel.org>; Fri, 13 Jun 2014 06:42:50 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 13 Jun 2014 06:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=+KZnQzXyf5WvjtBjsYeBv6/vy
	cA=; b=cxXb/VwguEvaEhRPSqS1TqfUgo/7HWlicetUoGeDA39mh6VWrz31HJfk5
	0efN1XyFdjUPE+PrI9ejtycTgWMXGlTt1LVGnU5F/cnDll/B94KIGn2zS1udxjsu
	Ygf7vUuej0kyqpuav++NNttR3CLjQHLyvKlar6qeRzkMzqEbNA=
X-Sasl-enc: MZuBKYV4UoRpYRVTrQSSLMileT6Yi1qpw4Ju5sY/+AQK 1402656169
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D19C7C00005;
	Fri, 13 Jun 2014 06:42:49 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402063795.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251539>

Patch1: unchanged
Patch2: unchanged
Patch3: as fixed in Junio's tree already (===)
Patch4: minor test fix for t7510
Patch5: tests for the verify-commit
Patch6: make all struct signature_check users employ the same clear helper

Michael J Gruber (6):
  pretty: free the gpg status buf
  gpg-interface: provide access to the payload
  verify-commit: scriptable commit signature verification
  t7510: exit for loop with test result
  t7510: test verify-commit
  gpg-interface: provide clear helper for struct signature_check

 Documentation/git-verify-commit.txt | 28 +++++++++++
 Makefile                            |  1 +
 builtin.h                           |  1 +
 builtin/merge.c                     |  5 +-
 builtin/verify-commit.c             | 95 +++++++++++++++++++++++++++++++++++++
 command-list.txt                    |  1 +
 commit.c                            |  1 +
 git.c                               |  1 +
 gpg-interface.c                     | 14 ++++++
 gpg-interface.h                     |  2 +
 pretty.c                            |  3 +-
 t/t7510-signed-commit.sh            | 24 ++++++++--
 12 files changed, 167 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-verify-commit.txt
 create mode 100644 builtin/verify-commit.c

-- 
2.0.0.426.g37dbf84
