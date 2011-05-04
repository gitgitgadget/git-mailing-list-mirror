From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] specifying ranges: we did not mean to make ".." an
 empty set
Date: Wed, 04 May 2011 11:00:35 -0700
Message-ID: <7v8vumfirg.fsf@alter.siamese.dyndns.org>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
 <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
 <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org>
 <20110502210141.GA15753@sigill.intra.peff.net>
 <4DBFA31E.40207@drmicha.warpmail.net>
 <7vvcxrit07.fsf@alter.siamese.dyndns.org>
 <4DC0F845.2080903@drmicha.warpmail.net>
 <7vpqnyfpey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 04 20:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHgNY-0001KM-QR
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 20:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151Ab1EDSAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 14:00:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab1EDSAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 14:00:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2DF34B1C;
	Wed,  4 May 2011 14:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tdSpOub3OWizNyazC4pT6jnRUtM=; b=B7kao+
	NgQuWO9uasTjwJGcikWG9mFzUABXgz3WlgNnDiFIn2N0FJi8/0nZoaeJIp4TkMsk
	DM9tCyaEBwuhkNda0FIQmO//x8piqwvBoGe6zQQC0vjROPVB4RGn6SQHG7InxrFz
	k6kytq/oov0yWYdCOf3u8wp5ag/EtBz4uYWTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=La+FlMetL2ksEHJ8w9JV67L9+O4cBJz7
	ySBBsWRHdJXnevXOq70ypLi/+KF0DR1y/boT0kjy5aZEAM9103Elf+2LsDqRaqsA
	2dmubqJkBDIVoSoDKk4Qh6/sc6RQRPx8YrB8VD2E5GLCahx7o0AQminLnAld9uRM
	fdxC4L/sYTU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8CBFE4B1B;
	Wed,  4 May 2011 14:02:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 57F434B14; Wed,  4 May 2011
 14:02:42 -0400 (EDT)
In-Reply-To: <7vpqnyfpey.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 May 2011 08:36:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7536E42-7678-11E0-8021-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172752>

Junio C Hamano <gitster@pobox.com> writes:

> As to changing the semantics of "..", I am moderately against it, but I
> consider that is a separate topic.  I am not opposed to giving a range
> that is common and useful (be it @{u}.., ..@{u}, or anything else) a
> short-hand, but that short-hand should not be "..".

After re-reading 1654a46 (specifying ranges: we did not mean to make ".."
an empty set, 2011-05-02), I found that I was contradicting myself in the
patch.

The last part of the documantation update in that patch is clearly wrong.
The patch does not change what ".." means.  The only thing it does is to
widen the heuristics that is used to disambiguate when the input could be
ambiguous.

 Documentation/revisions.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index fd043f7..80e5a47 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -187,10 +187,10 @@ It is the set of commits that are reachable from either one of
 In these two shorthands, you can omit one end and let it default to HEAD.
 For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
 did I do since I forked from the origin branch?"  Similarly, '..origin'
 is a shorthand for 'HEAD..origin' and asks "What did the origin do since
-I forked from them?"  Note that you cannot omit both ends.  '..' is not
-an empty range that is both reachable and unreachable from HEAD.
+I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
+empty range that is both reachable and unreachable from HEAD.
 
 Two other shorthands for naming a set that is formed by a commit
 and its parent commits exist.  The `r1{caret}@` notation means all
 parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
