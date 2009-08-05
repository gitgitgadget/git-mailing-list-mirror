From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Revamping "git status"
Date: Wed, 05 Aug 2009 11:05:34 -0700
Message-ID: <7v3a869lw1.fsf@alter.siamese.dyndns.org>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <7vbpmub3la.fsf@alter.siamese.dyndns.org>
 <200908051937.36255.trast@student.ethz.ch>
 <200908051940.48110.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:05:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYks0-0004CA-W7
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbZHESFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbZHESFl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:05:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZHESFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:05:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 114CC1EC52;
	Wed,  5 Aug 2009 14:05:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE98B1EC51; Wed,  5 Aug 2009
 14:05:35 -0400 (EDT)
In-Reply-To: <200908051940.48110.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 5 Aug 2009 19\:40\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95A11E5E-81EA-11DE-8699-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124935>

Thomas Rast <trast@student.ethz.ch> writes:

> Meh, this stops before the git-status because merge signals a
> conflict.  However, the following really crashes.  Promise.

Thanks.

 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index f73bf47..6370fe2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -236,7 +236,7 @@ static int unmerged_mask(const char *path)
 
 	mask = 0;
 	pos = -pos-1;
-	while (pos <= active_nr) {
+	while (pos < active_nr) {
 		ce = active_cache[pos++];
 		if (strcmp(ce->name, path))
 			break;
