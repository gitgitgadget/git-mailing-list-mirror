From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 13:48:42 -0700
Message-ID: <7vvcic7a6t.fsf@alter.siamese.dyndns.org>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
 <7vfw9g8pqn.fsf@alter.siamese.dyndns.org>
 <7vbok48pfu.fsf@alter.siamese.dyndns.org>
 <7v4npw8pdo.fsf@alter.siamese.dyndns.org>
 <7vzk7o7am5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 22:48:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzAW-0002xE-Mm
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab2F0Usp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:48:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab2F0Usp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:48:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC6296AD;
	Wed, 27 Jun 2012 16:48:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kfrC6Sh7OL9ztv3XMOjmOFrd6Wc=; b=jd0H7d
	KyJdgZCTr7hjo4knPyWRvnj9s4FZHtFRQVl6aPwZVwd2yN7XQ/Z+uPi0+BvOy5ij
	DYax1FHgT/lBhZpOEsjvz96wZRtVwq2n9UQncJLMmqSGXXvkftO5u1V4E6/A8VNo
	IkLv0iWBSn3XvGIUXEaZYIKL9SSHIVp7u9Ga8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9D5cSWL76KfpQ3e1XhmaREmPCdvOdOQ
	/sYKuWGm8RXMVb9twHnAovsoDFf7SjyLwvQyOvCIXv2LwouB71pguGby4JUZtMtx
	6AiO0hpL77KsbxQHsl3Wp9HLJIrFhcFxmuyt/0K0gWQ2x5lgOErbWtH3vFHngua+
	AMyYOX+uctU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3CFA96AC;
	Wed, 27 Jun 2012 16:48:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55C3D96AB; Wed, 27 Jun 2012
 16:48:44 -0400 (EDT)
In-Reply-To: <7vzk7o7am5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Jun 2012 13:39:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C2C10F0-C099-11E1-AB89-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200746>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Jeff King <peff@peff.net> writes:
>>>>
>>>>> but that code path should be fixed properly (with a use_stdin flag in
>>>>> the filespec).
>>>>
>>>> Yes, just as I said; I am finding more and more issues with the
>>>> no-index hack that I have been fixing a bit by bit since I send the
>>>> message you responded to.
>>>
>>> It is not ready yet, but here are a few patches WIP.
>>
>> And this is the second clean-up
>
> And this is the third one.

Some of the other breakages that comes from the "no-index" codepath
that we may want to consider addressing I have found so far are:

 - We say on the "diff --git" header uglyness like "a/-", "b/-";
   likewise in the metainfo;

 - We show on the "index" header "0*" value for these entries, even
   though we should be able to compute it (after all we do so for
   files on disk in a non-git directory);

 - We still apply attributes and textconv as if we are dealing with
   a regular file "-" at the root level.
