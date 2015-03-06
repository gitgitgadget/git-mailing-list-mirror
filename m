From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/2] branch output for detached HEAD
Date: Fri,  6 Mar 2015 16:04:05 +0100
Message-ID: <cover.1425653932.git.git@drmicha.warpmail.net>
References: <54EB4579.3000103@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 16:04:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTtnT-0002ct-5K
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 16:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbbCFPEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 10:04:11 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36827 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753754AbbCFPEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 10:04:09 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 926032093D
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 10:04:07 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 06 Mar 2015 10:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=7uxEK8iUMgGKmy
	vjzVPv996+s4E=; b=Ce1cuYbdE4iASoxFjb/JlP80hBBaJdtOKjgSWB5hJUD74T
	9AWPYHdVQ7SLznSK0aniv2pOWCXoz2dJSuOcAS0sCLw6V5sjGCh2ar/WaaY20DtB
	oaY2OXhO5+qdqjpKbbgrBMsdbtnDG3GCxFgbSlueGLFZRbUz4s4zqwRhBUrSk=
X-Sasl-enc: ZnlrMyLGmwE6H2fnwvsHXTLw3tRc+PZIKSk+TQGlp8QQ 1425654248
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6FC3B68017B;
	Fri,  6 Mar 2015 10:04:08 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <54EB4579.3000103@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264926>

So here's a little refactoring of wt-status, to help branch
use the same logic regarding from/at for a detached HEAD.

Michael J Gruber (2):
  wt-status: refactor detached HEAD analysis
  branch: name detached HEAD analogous to status

 builtin/branch.c         | 13 ++++++++++---
 t/t3203-branch-output.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 wt-status.c              |  6 +++---
 wt-status.h              |  1 +
 4 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.3.1.303.g5174db1
