From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/2] More diffs for commit/status
Date: Tue,  3 Mar 2015 15:16:20 +0100
Message-ID: <cover.1425390756.git.git@drmicha.warpmail.net>
References: <54B8C82E.8000707@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 15:16:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSncc-0007Wf-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 15:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbbCCOQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 09:16:25 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37316 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754819AbbCCOQY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 09:16:24 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C0A6820BF5
	for <git@vger.kernel.org>; Tue,  3 Mar 2015 09:16:22 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 03 Mar 2015 09:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=mcY3D+jJCcc7Fx
	bWijGvFpCjXTk=; b=iohQbYirsgN6GmrnHtHRofv00MmOf/4pJWgso/lQuCqh1G
	xs/HY0+ge/rsTkHCDJa3zCVcWEcVpLFmouHuomZ5RGvk6wtVZL4G7sSuv0GXDuF3
	NnYujTRKOqV2laEV0HYzYLyn7pS+Kdeyw0nkXByF61HShf3ejylCKTm5RmTrI=
X-Sasl-enc: fGOzMuRBPEBTIEadt01/Q2w7wTjgzWr3BsUtW6RGaj6X 1425392183
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5B2B1C0029D;
	Tue,  3 Mar 2015 09:16:23 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <54B8C82E.8000707@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264659>

Trying to clean up my old RFCs, so here's a mini-series that

1) adds a test for "status -v" (the diff between HEAD and index) and
2) implements "status -v -v" (additional diff between index and worktree).

The idea is that in a case where "commit -v" would list fils with unstaged
changes one would get the diff for these changes with '-v -v' easily.

2/2 also sets the diff prefixes (a/,b/ etc.) for both diffs in the '-v -v'
case to a really verbose version to avoid any confusion between the two
types of diffs. We may want to do that for '-v' already, although that
would be a change in behavior.

The wording for the new prefixes is chosen after the status hints, although
they are not localised.

Michael J Gruber (2):
  t7508: test git status -v
  commit/status: show the index-worktree diff with -v -v

 Documentation/git-commit.txt |  4 ++++
 t/t7508-status.sh            | 49 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 10 +++++++++
 3 files changed, 63 insertions(+)

-- 
2.3.1.303.g5174db1
