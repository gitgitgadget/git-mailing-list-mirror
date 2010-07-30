From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Document -B<n>[/<m>], -M<n> and -C<n> variants of
 -B, -M and -C
Date: Fri, 30 Jul 2010 09:42:01 -0700
Message-ID: <7vk4ocrkfa.fsf@alter.siamese.dyndns.org>
References: <1280310239-16897-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vk4oeuv4b.fsf@alter.siamese.dyndns.org> <vpqmxt93sew.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 30 18:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OesfA-0005Ek-BK
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 18:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab0G3QmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 12:42:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab0G3QmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 12:42:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F8C9C919C;
	Fri, 30 Jul 2010 12:42:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QS5y4tkILOvlVY9jOdz6x3f9Ia4=; b=VzunFy
	oEEil2n+IGz0GYc83573mBw+u7gi8vRrUJDxlUl6kFX4w9dWZ5L2nnbrroXdWKt3
	O6bM1TmmRAzF4KxJY4VLuRyFK9PyPjEsgwLb1ZjJqVdlc607Wvc+1A+cWTJzTm6B
	PCZdFwXRHU4K0n2/KTFhlIIq8cxHnC6tN9F4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JOpoo6BR3/k7iT3h0brJjvn1M3Cfie3S
	ptFQbfBeht7xrP3xaAb5D4bSr7dA6brSG8PdKn+347CVqHeDfroiITYRw75kpHmh
	gxVUy6l2VAbmC3CRfuh3uL2KJ1m0oTeiRkw2+Xib1T1eAHRyrSM5F5XlMQMMZV4S
	wnW2zRT18K8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AA4DC919B;
	Fri, 30 Jul 2010 12:42:06 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25577C919A; Fri, 30 Jul
 2010 12:42:02 -0400 (EDT)
In-Reply-To: <vpqmxt93sew.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri\, 30 Jul 2010 17\:23\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 635F59AE-9BF9-11DF-8F6D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152251>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Explanation of '<m>' might want to clarify why it counts only the deletion
>> and to mention that "100-similarity != dissimilarity", but as the end-user
>> level documentation, these probably are unnecessary.
>
> The thing is: I don't know the anwser myself, so I'm not in a position
> do write such documentation :-(.
> ...
> Likewise, I didn't write "lines" as a white lie, but because of my
> ignorance ... hence my request for help.

Sorry, but I actually do not have much more to say than what eeaa460
(diff: Update -B heuristics., 2005-06-03) says.

When breaking for the purpose of showing a patch as "total rewrite", what
matters is how little the original contents remain in the result.  Imagine
that you start from a 100-line document and removed 97 lines from it.  You
then added 27 lines of new material to make a 30-line document or added
997 lines to make a 1000-line document---either way you rewrote the
document and how dissimilar the result is relative to the original
wouldn't be different in either case.  N.B. this is only true as long as
there are enough new material in the result---removing 97% without adding
anything is not a rewrite.  This 97% is "how much did we discard from the
original", and it is the number you would see as the "dissimilarity index"
('m' in '-Bn/m').

When breaking, tentatively, for the purpose of rename detection, the
amount of the new material starts mattering more.  The reason why we try
to see if we want to break the pair is exactly because we hope that we may
find something similar to the new material in a blob that used to be in
but disappeared from another path in the preimage.  So we count both
deletion and addition to see if the pair has a lot of changes ('n' in
'-Bn/m'), which is similar to the way how "similiarity index" used in the
"rename" codepath is computed, to decide if we want to tentatively break
the pair.  Halves of a pair that is tentatively broken, when they do not
have a matching rename, are merged back together if they were not total
rewrite (i.e. the dissimilarity index for the pair is lower than the
threshold 'm').

In either case, the algorithm to compute how much "stuff" was copied from
the original and how much "stuff" was added anew to the result is not
based on "lines", but based on "bytes".
