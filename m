From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff annoyance / feature request
Date: Thu, 25 Aug 2011 13:27:43 -0700
Message-ID: <7vippljkxs.fsf@alter.siamese.dyndns.org>
References: <4E569F10.8060808@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:27:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwgWj-0003kJ-7p
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab1HYU1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 16:27:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973Ab1HYU1q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:27:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A38442AB;
	Thu, 25 Aug 2011 16:27:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pGCAQiZSDx9uYF89KxjdTIG/gaw=; b=FxUc8d
	wHxXy/BZs0IKeTS05YrGr2r25afNjlXWWBdjMv81gQqykbgI9M9okNq6lUf9O66d
	FivCxuFIHkxsfCpuUBVSGx14BUJXsCoRiEu1M1bbz6Y9tCrdfV0U1+z0rywt+cgv
	R13FEp67jS9KQt68JfThMFFrBY1vP6O9ht2kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pFTpqeJeMhyzKvLJ0IWLsclZPqP5mH34
	0TU8VT1Dxz2fqYqgO14EaZRDteof2PoLnUsFr2yPvSfQNNAmB0IIs6loyZsnFgej
	sUKClDPRzPhtQWOXaTXOS0g0r9F8nbdNJteZixP7nzTgZmQCH/16cYHcAez+lLul
	jk6KHbtPHTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 920A642AA;
	Thu, 25 Aug 2011 16:27:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 133EF42A9; Thu, 25 Aug 2011
 16:27:44 -0400 (EDT)
In-Reply-To: <4E569F10.8060808@panasas.com> (Boaz Harrosh's message of "Thu,
 25 Aug 2011 12:14:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0C515C4-CF58-11E0-B681-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180111>

Boaz Harrosh <bharrosh@panasas.com> writes:

> I mean. The label "try_again" is not at all unique in my file. As a
> reader I would like to see where is that code going to. The function
> name is a unique file identifier that tells me exactly where the change
> is going. The label is not. (It's not freaking BASIC)
>
> I bet all this was just inherited from diff. Would it be accepted if
> I send a patch to fix it? What you guys think a goto label makes any
> sense at all?

The default tries to mimic what GNU used to do when we added the feature.

The diff.*.xfuncname configuration variable is there exactly for people
like you to tweak what we use for hunk headers. Please experiment with it
and if you come up with a better set of patterns, people may want to copy
it and use it themselves. we may even consider updating the built-in
default with your patterns, once they got adopted by wider audiences.

Personally, I would have to say that the source wouldn't be using too many
labels with the same name for this behaviour to be problematic, especially
if it is not freaking BASIC ;-), so...
