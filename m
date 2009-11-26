From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] git-merge-file --ours, --theirs
Date: Wed, 25 Nov 2009 23:05:28 -0800
Message-ID: <7vvdgxbwav.fsf@alter.siamese.dyndns.org>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <7vy6ltdd2l.fsf@alter.siamese.dyndns.org>
 <20091126153726.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Avery Pennarun" <apenwarr@gmail.com>, <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 08:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDYQE-0003LF-BM
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 08:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758742AbZKZHFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 02:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758741AbZKZHFd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 02:05:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740AbZKZHFb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 02:05:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F6CD8314F;
	Thu, 26 Nov 2009 02:05:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uxa4gt4awBPa5fdQVedstcI/MCw=; b=CvIYIU
	Y+XeQ0ffI5K6Tym8ECZoz8NpeDiNFYhWaGQHjBk84CRp1HwfKI/eSmogYm7LA9SP
	l+LLDTAB4gwpWnFMkjeB8n7jcNS6bP8q92kkrlB8s+TVwHyojMsWg9mh4bUY6ytR
	bnYmAWnxHoM8Nftxhm4uA5XKqETymE/wtJ/tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jv648xT5YkYh65sWOBNm7vYu+KkejA5r
	EdahWjivs/Vf4RN6590+qPt6kAZcudJsWS0aqjTpwX7lHCSXnNH6cK9MBjuWyuej
	Bn8yFy3Qc9Sklt10wBXOhN28D/3dD6t9ZYqwqUQhzxyJkHVs9tlRGvTsl7ygn4em
	Vi5RORZhs4E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA9908314E;
	Thu, 26 Nov 2009 02:05:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C00258314D; Thu, 26 Nov
 2009 02:05:29 -0500 (EST)
In-Reply-To: <20091126153726.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu\, 26 Nov 2009 15\:37\:26 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 172FA20C-DA5A-11DE-8B03-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133771>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> Except for parse-optification, this one is more or less a verbatim copy of
>> my patch, and I think I probably deserve an in-body "From: " line for this
>> [PATCH 1/8], [PATCH 6/8] and [PATCH 8/8] to take the full authorship of
>> them.
>
> Could you give an guideline to decide when to take authorship and when to
> give it to others?  The above seems somewhat arbitrary to me.

It might seem that way to you, as you do not write much C, but I am
reasonably sure Avery understands after having worked on the series.

Imagine that Avery were an area expert (the subsystem maintainer) on "git
merge" and downwards, and somebody who did not know that "merge" has
already been rewritten in C, nor some parts of the system have been
rewritten to use parse-options, submitted a patch series for review and
Avery is helping to polish it up [*1*].

As the subsystem maintainer, Avery looks at the patches, updates parts of
the code that is based on obsolete infrastructure, adds lacking tests and
documentation as necessary, and forwards the tested result upwards for
inclusion.  How would the messages from Avery to me look?

Patches that were majorly reworked should be attributed to Avery, and
obviously new patches that are added for missing tests should be, too.
For example, changes made to git-merge.sh by the original submitter must
be discarded and redone from scratch to builtin-merge.c, and if you look
at the changes, it would be quite obvious that the original patch wouldn't
have served as anything more than giving the specification.

But the ones with minor updates should retain the original authorship.
It unfortunately is not black-and-white, though.

In any case, where does Avery's credit go?  Is there a point in helping to
polish others' patches?

It is recoded on the Signed-off-by line.  When somebody passes a patch
from somebody else, an S-o-b is added for DCO purposes, but it also leaves
the "patch trail"---these people looked at the patch, spent effort to make
sure it is suitable for inclusion by reviewing, polishing, and enhancing.
A subsystem maintainer, or anybody who helps to polish others
contribution, may not necessarily have his name as the "author" of the
patch, and if the patch forwarding is done via e-mail, his name won't be
on the "committer" line either.  But the contribution is still noted and
appreciated, and the hint to pay attention to is by counting non-author
S-o-b and Tested-by lines in the commit messages.

cf. http://lwn.net/SubscriberLink/363456/50efdecf49af77ba/ check the last
table.


[Footnote]

*1* That somebody happens to be me from 18 months ago, but the important
point here is that the person is not Avery as the subsystem maintainer (in
other words, it is immaterial that it happens to be the same person as the
toplevel maintainer).
