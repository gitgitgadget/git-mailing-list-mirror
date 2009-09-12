From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 10/14] Teach notes code to free its internal data
 structures on request.
Date: Sat, 12 Sep 2009 11:40:08 -0700
Message-ID: <7vmy50f1mf.fsf@alter.siamese.dyndns.org>
References: <200909121752.07523.johan@herland.net>
 <1252771728-27206-11-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXWb-0002hr-4A
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbZILSkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbZILSkc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:40:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbZILSkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:40:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82CA04EB78;
	Sat, 12 Sep 2009 14:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=12CFt/YLR69JHDEt9Q0fWgDyZ9U=; b=MHo0WN
	Bg51I4WAl/+nfhJJmVKgNrKf1+zf6C4SgOE3yEjF1dIjZrYqfhe8vCXXfu1kagDr
	P3/c5yY5Uua7gZBD9GasD114ink+yEoTiC+EpQBtsUpPyeAtMxW4wJFPtnZImKq1
	Kk6s3jfqlQro7FLmySH2Q4E7hCzywAKU90wxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R/hDZFN3WMxL2+W27PVZInk7VjHPFe1h
	/3y23Egnr/IzHk8Np00opADdfwmTzICCnRgLR0FFN1WTwpwAHgq+dJaeU1SzPqGZ
	mc95lKnVMo1Q/47jF+aTdLZll6JAFQcl0hxiaD04aYsMpfh/bsnLfBjeTc+evnHz
	Joez4B1we9A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1766E4EB74;
	Sat, 12 Sep 2009 14:40:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BF72E4EB6F; Sat, 12 Sep 2009
 14:40:09 -0400 (EDT)
In-Reply-To: <1252771728-27206-11-git-send-email-johan@herland.net> (Johan
 Herland's message of "Sat\, 12 Sep 2009 18\:08\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC16C0D0-9FCB-11DE-88AD-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128280>

Johan Herland <johan@herland.net> writes:

> There's no need to be rude to memory-concious callers...

Will squash this in.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 12 Sep 2009 11:34:24 -0700
Subject: [PATCH] notes.[ch] fixup: avoid old-style declaration

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 notes.c |    2 +-
 notes.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index 008c3d4..9ed2c87 100644
--- a/notes.c
+++ b/notes.c
@@ -161,7 +161,7 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 	free(msg);
 }
 
-void free_commit_notes()
+void free_commit_notes(void)
 {
 	free(hash_map.entries);
 	memset(&hash_map, 0, sizeof(struct hash_map));
diff --git a/notes.h b/notes.h
index 41802e5..d1dd1d1 100644
--- a/notes.h
+++ b/notes.h
@@ -7,6 +7,6 @@
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 		const char *output_encoding, int flags);
 
-void free_commit_notes();
+void free_commit_notes(void);
 
 #endif
-- 
1.6.5.rc0.82.g1c5d9
