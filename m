From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff: disable compaction heuristic for now
Date: Fri, 10 Jun 2016 13:55:01 -0700
Message-ID: <xmqqk2hwepcq.fsf@gitster.mtv.corp.google.com>
References: <20160610075043.GA13411@sigill.intra.peff.net>
	<20160610083102.GA14192@sigill.intra.peff.net>
	<xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
	<CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
	<xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
	<20160610203026.GA21464@sigill.intra.peff.net>
	<xmqqoa78epmt.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:55:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBTSY-0008Sy-Dg
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932836AbcFJUzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:55:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932447AbcFJUzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:55:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE0C3245F7;
	Fri, 10 Jun 2016 16:55:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SLhHNG4o73ChdmkknB55DMAUtFQ=; b=FFwBqS
	2n+x/jRsgrZZGl67ATWkI8Wd3755E4qAx1HT6ogNImtnxsjBRRv+oNfXVXEcsl5w
	2cqbXYDKFq7kwIszlG1adzsWYfzI26df9xa3NcpaTfplJOngbP9UQwExRCiWq7ID
	knWGPFFQDOTmIcR99i/aHrObmQWjxx+VQ4cVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jCDr0OXhw8MML31NAI/dsXIw1PHnuWuy
	jq+3yWO1JEOeMLGnxxksXvH7rVu8G9iLFzwXKlCvvei/8MyRmlySwK1htnLeoqFp
	gkvkMWhOrARKw1ZBHC8IIqIr9isuIs+HrIdM7wFtUAtG8/wEjZ2mExGlo3241tC8
	sYX96jnrcIE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5CBB245F6;
	Fri, 10 Jun 2016 16:55:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D707245F4;
	Fri, 10 Jun 2016 16:55:03 -0400 (EDT)
In-Reply-To: <xmqqoa78epmt.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Fri, 10 Jun 2016 13:48:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9AA0FF7E-2F4D-11E6-BBE4-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297073>

Junio C Hamano <gitster@pobox.com> writes:

>     Jeff King <peff@peff.net> writes:
>
>     > We probably want a patch to the release notes to note that it's not on
>     > by default. And we may want to advertise the experimental knob so
>     > that people actually try it (otherwise we won't get feedback from the
>     > masses).
>
>     OK, I think that is sensible.  The interdiff is not a strict
>     reversion of 77085a61 (diff: undocument the compaction heuristic
>     knobs for experimentation, 2016-05-02) but stresses that the
>     feature is off by default and is experimental.

This is for 'master' when the topic is merged (will keep it in stash
for now).

 Documentation/RelNotes/2.9.0.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes/2.9.0.txt b/Documentation/RelNotes/2.9.0.txt
index 927cb9b..79b46e1 100644
--- a/Documentation/RelNotes/2.9.0.txt
+++ b/Documentation/RelNotes/2.9.0.txt
@@ -118,9 +118,11 @@ UI, Workflows & Features
  * HTTP transport clients learned to throw extra HTTP headers at the
    server, specified via http.extraHeader configuration variable.
 
- * Patch output from "git diff" and friends has been tweaked to be
-   more readable by using a blank line as a strong hint that the
-   contents before and after it belong to logically separate units.
+ * The "--compaction-heuristic" option to "git diff" family of
+   commands enables a heuristic to make the patch output more readable
+   by using a blank line as a strong hint that the contents before and
+   after it belong to logically separate units.  It is still
+   experimental.
 
  * A new configuration variable core.hooksPath allows customizing
    where the hook directory is.
