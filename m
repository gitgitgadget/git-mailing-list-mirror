From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] gc --auto --quiet: make the notice a bit less verboase
Date: Wed, 21 Oct 2009 15:30:35 -0700
Message-ID: <7vfx9cz8fo.fsf_-_@alter.siamese.dyndns.org>
References: <4ADD6026.8070203@zytor.com>
 <7veioyqzeo.fsf@alter.siamese.dyndns.org>
 <200910201054.48315.johan@herland.net>
 <alpine.LFD.2.00.0910201442480.21460@xanadu.home>
 <7v63a9n5i6.fsf@alter.siamese.dyndns.org> <4ADEA93E.7060907@viscovery.net>
 <7vzl7l8b1y.fsf@alter.siamese.dyndns.org>
 <7vaazl8acd.fsf@alter.siamese.dyndns.org> <4ADEC0DB.4000104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0jhs-00034l-3B
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbZJUWau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 18:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbZJUWau
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:30:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbZJUWat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 18:30:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43EA461748;
	Wed, 21 Oct 2009 18:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVcgROwQ5882ECLV/mIvTVDLo4w=; b=BKyb36
	17fYGla0/hV+5XRqe2fCZFTqP6/Lq+kaYySb4dsv1EL00LpoPGX20bme9J4tgH68
	t44mABLa5oqj1BR85iLUbfMjrSxmATy5l2slhV8u1AobYGd7cu3ddCfPjKX1OAAx
	ty29pni7a/kzWaHC6KFW0t0ZCoqBl85DUWexk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rW2YM5wZZqiVm55w3Lg7AyPGh5wL9Qhh
	ToBNkTzBtphhyxWp79aNMvp8fEHdwmz7HtrgJkxX+EmK9WLT5Tua8Tm7UjyzyimI
	c4LzaeQkjQLOvYbdEZUO1fY6/QSoWb+FsxDkxwMyrF/Ulv9Ka1OnCujOLoQhFdq/
	OPAnsDUhn3s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC4AF61745;
	Wed, 21 Oct 2009 18:30:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C32FD6173F; Wed, 21 Oct
 2009 18:30:38 -0400 (EDT)
In-Reply-To: <4ADEC0DB.4000104@viscovery.net> (Johannes Sixt's message of
 "Wed\, 21 Oct 2009 10\:05\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 600C1F08-BE91-11DE-A9F7-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130981>

When "gc --auto --quiet" decides there is something to do, it tells the
user what it is doing, as it is going to make the user wait for a bit.

But the message was a bit too long.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Johannes Sixt <j.sixt@viscovery.net> writes:

 > I'm slightly in favor of adding "--quiet", because even with this option
 > we see some output:
 >
 > $ git gc --auto --quiet
 > Auto packing your repository for optimum performance. You may also
 > run "git gc" manually. See "git help gc" for more information.
 >
 > A compromise would be to reduce this message to the first sentence if
 > --quiet was given.

 builtin-gc.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 7d3e9cc..093517e 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -216,10 +216,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
-		fprintf(stderr, "Auto packing your repository for optimum "
-			"performance. You may also\n"
-			"run \"git gc\" manually. See "
-			"\"git help gc\" for more information.\n");
+		fprintf(stderr,
+			"Auto packing the repository for optimum performance.%s\n",
+			quiet
+			? ""
+			: (" You may also\n"
+			   "run \"git gc\" manually. See "
+			   "\"git help gc\" for more information."));
 	} else
 		append_option(argv_repack,
 			      prune_expire && !strcmp(prune_expire, "now")
-- 
1.6.5.1.107.gba912
