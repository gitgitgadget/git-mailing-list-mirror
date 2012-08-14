From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 11:49:55 -0700
Message-ID: <7vlihh9ulo.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 20:50:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1MBo-0006C6-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 20:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab2HNSt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 14:49:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246Ab2HNSt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 14:49:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBD387D4B;
	Tue, 14 Aug 2012 14:49:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Kc5im9Lbm52pi9altk0s3DB9kc=; b=Fk+QXM
	k+pVfmWy8ANZKyqwpDo2UJmxCIi8ONXmSC7dNkUH1QPFMf7XWu4H9IjU8qvSfDtG
	a2cNklhnPy6QexIjoOc6Q42NgcqEiRRvrRTFYP0TvHQxpIM/KW0kWPPgUEsgRKZA
	hYQZ5YevW+YusGmMdK7x+6z10Myx75Aj0FcsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B59dNLW8z0D/kHCShtUKhz7WQ6c2m2dr
	PUNT5cLl6poFX8GvEpWKEctpgZ4Vk0kDaeGGz9gIGbybzNALqHl6fCWt0edl8S14
	l9II1jodn6e2NqYLurlxSpfLx+w+AbdXHMM8Sr+PO0TUF6oxz9/hvQS7onBUqKPw
	4Id3T+sit1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9E677D4A;
	Tue, 14 Aug 2012 14:49:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 442377D49; Tue, 14 Aug 2012
 14:49:57 -0400 (EDT)
In-Reply-To: <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com> (Hilco
 Wijbenga's message of "Tue, 14 Aug 2012 11:32:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7EEBBB4-E640-11E1-843E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203422>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> I suppose I'm not entirely clear on how this two step process is
> "safer". Doing "git fetch" would seem to be harmless, right? So the
> problem is with "git merge" but master should always be "behind"
> origin/master so that "git merge" should just FF to origin/master
> which *should* be completely safe. Does that make sense? Especially
> given our use of master as an integration branch?
>
> [Given the trouble I have with getting people to use Git properly, I
> prefer things as simple as possible. :-) ]

Between the two procedures Thomas gave you, "fetch & rebase" is
safer than "fetch & reset --hard", exactly because it does not have
to rely on the validity of your "which should always be behind"
claim.

If it is behind, there won't be any difference, but if it is *not*,
the user will notice and won't lose his work on 'master' (which you
may argue that he shouldn't have done).  "rebase" will notice it.

The key for a procedure to be safe is not having to rely on the
claim of users such as "my history *should* always and already be
behind", and not silently lose information when these *should*s are
violated for whatever reason.  After all, if all these *should*s
were true, the user wouldn't have been having problems in the first
place and posting to the list asking for help in the first place ;-)
