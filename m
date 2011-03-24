From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] merge: match the help text with the documentation
Date: Thu, 24 Mar 2011 00:35:27 -0700
Message-ID: <7vlj05as3k.fsf_-_@alter.siamese.dyndns.org>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
 <7vpqphasbr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 08:35:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2f52-0003YU-PS
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 08:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933400Ab1CXHfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 03:35:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab1CXHff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 03:35:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F2663CA8;
	Thu, 24 Mar 2011 03:37:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UpA61LBEddg5UuTTtaq/TfsVDJY=; b=J16pRi
	zxCLfX3inBoZFBuu59frlYAoXVzJjRIQRE3euLfCZKeDy+ro9C5Zd2hF0G6k5XsJ
	SCVZ/bDKDv/CrFOEaHw3KPRY1l/SxCR5Y3GRXME2NgxbmuJ+p6OVzByGtkkDJ6vH
	mf0fJUtLUQWJPEkJdQwZl5OJFpL9vAxdwL1E8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cfAAc3ajwF58E9QRtTqHt6rQ2aAPb/RP
	AaPbp1OCfJw5HLYZ2OxOXXn0JNRrFdbF5PxJ2GyI8BcZxcinEttBzeml+Aenj83Z
	H1Mjm30sLGde18MEYYUD15qFi7ru23HoJ+eAbDLtAowMKXcOMFVOccar8o+ZujR0
	CVsPjMWH+XQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7BA073CA7;
	Thu, 24 Mar 2011 03:37:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D5533CA5; Thu, 24 Mar 2011
 03:37:10 -0400 (EDT)
In-Reply-To: <7vpqphasbr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 24 Mar 2011 00:30:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88EF967A-55E9-11E0-85E6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169898>

From: Jared Hance <jaredhance@gmail.com>
Date: Thu, 10 Feb 2011 18:52:41 -0500

We used to be very casual in terminology and used <branch>, <ref>,
<remote> and <rev> more or less interchangeably with <commit> when it
is clear from the context. Match the help text given by "git merge -h"
with that of the documentation.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Jared said <branch> but 57bddb1 (Documentation/git-merge: reword
   references to "remote" and "pull", 2010-01-07) updated it to <commit>,
   which is both technically more correct and equally understandable, so I
   chose to match the documentation.  Also --abort was not described as a
   different mode.

 builtin/merge.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..a2105ef 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,8 +37,9 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	"git merge [options] <remote>...",
-	"git merge [options] <msg> HEAD <remote>",
+	"git merge [options] <commit>...",
+	"git merge [options] <msg> HEAD <commit>",
+	"git merge --abort",
 	NULL
 };
 
-- 
1.7.4.1.433.gcd306
