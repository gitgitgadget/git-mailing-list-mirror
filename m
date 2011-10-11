From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Provide API to invalidate refs cache
Date: Tue, 11 Oct 2011 10:26:59 -0700
Message-ID: <7v4nzfh21o.fsf@alter.siamese.dyndns.org>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
 <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
 <7vty7ggzum.fsf@alter.siamese.dyndns.org> <4E93D932.6020001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 19:27:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDg6l-0003uf-2H
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 19:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab1JKR1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 13:27:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943Ab1JKR1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 13:27:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E0A4EE7;
	Tue, 11 Oct 2011 13:27:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HMosWOV4bISmWuPtPEPIi2vlo4A=; b=kTkisZ
	SzYpCqtBpaRz7e04Om1YabHcOiyA9jMYPKDoNBNMbwRQkmVj7te5osYJTttbOfm7
	/w1mCXAJcDQHYrOwJaEXGbtBr3LaPTQzfRLpxRqApTv0e2IaWq8ahDFT28A7Vxua
	bNVdlwBR43WoruDghO80GlIH5h2obE+0HGEyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1fCdzDdzYkufvL8Zd0I10LZ4NzbUG3I
	FSw5mnexaoO6zGk4zJ0xjwla6G5Uo80Gr8zJWuc4/q0bCRn6ib+yUuZv9D2yu0bS
	FKsSv0NelsuH60MI7mebf9KUhpDW68ELth73EzqEx/eAjATaLYJDp7Wk6O7JNu4n
	oajHmaUS0tI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291064EE6;
	Tue, 11 Oct 2011 13:27:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 752554EE5; Tue, 11 Oct 2011
 13:27:00 -0400 (EDT)
In-Reply-To: <4E93D932.6020001@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 11 Oct 2011 07:50:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A5235FC-F42E-11E0-B818-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183308>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/11/2011 02:02 AM, Junio C Hamano wrote:
> ...
>> I could rebase your series, but it always is more error prone to have
>> somebody who is not the original author rebase a series than the original
>> author build for the intended base tree from the beginning.
>
> I don't mind rebasing this little series on jp/get-ref-dir-unsorted.
> ...
> Rebasing 78 patches is going to be a morass of clerical work.

I do not think it is "clerical" in the first place.

Realistically, I expect that a 50+ patch series that touch fairly an
important part of the system to take 2 cycles and a half before it hits a
released version, judging from our recent experience with the recursive
merge fix-up series.

When we already have a patch that has been discussed well enough on the
list to fix somebody's real world problem, can we afford to block it and
give an exclusive write lock to part of the codebase for 2 cycles to your
series, or anybody's for that matter?

> Is there any alternative?

I think an alternative is not to hold on to a series before it gets so
large to make you feel adjusting to the needs to other changes in the
codebase is "clerical". Commit often and early while developing the
initial pass, re-read often and throughout the whole process looking for
things you regret you would have done in early in the series that you
didn't (aka "oops, here is a fixup for the thinko in the early patch in
the series), and clean-up early while preparing to publish. Reorder the
parts that you are more confident that they do not need to change to come
early in the series, and unleash these early parts when you reach certain
confidence level.

I think your iterate-refs series was an example of good execution. It made
the codeflow a lot clearer by reducing the special casing of the submodule
parameter. In your grand scheme of things (e.g. read only parts of the ref
namespace as needed) you might consider it a mere side effect, but the
series by itself was a good thing to have.

Sometimes you may feel that a part of your series when taken out of
context would not justify itself like the iterate-refs series did, until
later parts of the series start taking advantage of the change. But that
is what commit log messages are for: e.g. "this change to encapsulate
these global variables into a single structure does not make a difference
in the current codebase, but in a later patch this and that callers will
need additional pieces of information passed aruond in the callchain, and
will add new members to the structure".

> ...  So maybe
> I brought this whole mess down on my own head :-(

No, it is not anybody's fault in particular. That's life and open source.
