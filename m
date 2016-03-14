From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] wt-status: allow "ahead " to be picked up by l10n
Date: Mon, 14 Mar 2016 16:30:33 +0100
Message-ID: <3b88641beff6b34ae8b86bf353e6fbb8f9e636f1.1457969307.git.git@drmicha.warpmail.net>
References: <56E6D8C4.2010205@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 16:30:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afUS8-0007JL-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 16:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509AbcCNPah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 11:30:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35264 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965025AbcCNPaf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2016 11:30:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B971F21459
	for <git@vger.kernel.org>; Mon, 14 Mar 2016 11:30:34 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 14 Mar 2016 11:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=BsP/PBfuYlqNuJearqTIzE0F2ww
	=; b=TWhbV+cwWc+i/AohfUNwvm4KpBfaVD/u0DivW42Gc+fb2NzX+lkwIZofrjV
	KIsCF246Se6cDMEss6SFkesT0ogtZlQVZp8CtaasTyDnU6/uVRMsdWuckSVxJ5ef
	43y7ukDR1n9DEL+XyJQm3WiizuQbW+9k0q6fQN9jbsh1DwyE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=BsP/
	PBfuYlqNuJearqTIzE0F2ww=; b=A6rp+GHf2s7SNWGmf2+IoqGMRds+45g3UeNf
	Lt+gvB8mojP/Kc6Nh/r5pkVIHllDL/Q+6Jc5G1uUa7cFHAfJy8h9AvhTIyRH/JCb
	RSDYwD33oRg5aO5FKzpepJSTZVyBj/UfCsdPFqto0W0zuOD2EWRcKkDyezkeyheI
	BxNTatA=
X-Sasl-enc: sE2EDcPZ3I6yOKPWBWbdW4CQr2kztzZn6rhgycBHokOH 1457969434
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 52FF2C0001D;
	Mon, 14 Mar 2016 11:30:34 -0400 (EDT)
X-Mailer: git-send-email 2.8.0.rc2.197.g3b88641.dirty
In-Reply-To: <56E6D8C4.2010205@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288783>

The extra pair of parentheses keeps the l10n engine from picking up the
string. Remove them so that "ahead " ends up in git.pot.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ab4f80d..ef74864 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1677,10 +1677,10 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		color_fprintf(s->fp, header_color, LABEL(N_("behind ")));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	} else if (!num_theirs) {
-		color_fprintf(s->fp, header_color, LABEL(N_(("ahead "))));
+		color_fprintf(s->fp, header_color, LABEL(N_("ahead ")));
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
 	} else {
-		color_fprintf(s->fp, header_color, LABEL(N_(("ahead "))));
+		color_fprintf(s->fp, header_color, LABEL(N_("ahead ")));
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
 		color_fprintf(s->fp, header_color, ", %s", LABEL(N_("behind ")));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
-- 
2.8.0.rc2.197.g3b88641.dirty
