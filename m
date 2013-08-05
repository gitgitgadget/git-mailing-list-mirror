From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: allow "-" as abbreviation of '@{-1}'
Date: Mon, 05 Aug 2013 09:27:35 -0700
Message-ID: <7vmwowm7bc.fsf@alter.siamese.dyndns.org>
References: <1375506913-3390-1-git-send-email-hiroshige88@gmail.com>
	<87wqo33v4f.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hiroshige Umino <hiroshige88@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NdH-0006nJ-MJ
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3HEQ1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:27:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab3HEQ1i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:27:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 137A136801;
	Mon,  5 Aug 2013 16:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FWouY0E+m6/zKGA9xj4arIISwwg=; b=moFKQm
	ukKrrWjOevxlPb4cAo+rbt8MxwolHM4NCCKhcr9E4v1MFLtABHyjcJIvZ66ZKC01
	X+8t5/mvDXCCkgv3K4SuU/TInET5OAZcPurlK0T/6+HfVKgRgXwlJOF/Q2/RtWhm
	LS7hJBtL8yZtJYH3v/jEc2e6nMalPiBSXFnpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ju2H+FQBqBp74to0r0naIKNz+Krl4dUw
	buETGc1ceBM6MMoDVoOXjZ1aYLSlQQPFeNK6L5c7Ebv1gvQT5A0Xpp7fCEyg5qNT
	Jh7q6dPYAwW7kbV4d2n6PeJcjshsDY28rVHUt22r9kwLnKFD94+3EqNLvo/deTGn
	VEBKMT+dhR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECA3136800;
	Mon,  5 Aug 2013 16:27:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12275367FC;
	Mon,  5 Aug 2013 16:27:36 +0000 (UTC)
In-Reply-To: <87wqo33v4f.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Sat, 3 Aug 2013 12:51:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0A271D2-FDEB-11E2-9BEA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231672>

Thomas Rast <trast@inf.ethz.ch> writes:

> Hiroshige Umino <hiroshige88@gmail.com> writes:
>
>> As "git cherry-pick -" or "git merge -" is convenient to
>> switch back to or merge the previous branch,
>> "git cherry-pick -" is abbreviation of "git cherry-pick @{-1}"
>> to pick up a commit from the previous branch conveniently.
>
> The first line is confusing.  Did you mean to invoke the existing 'git
> *checkout* -' and 'git merge -' functionality as a reason why 'git
> cherry-pick -' should exist?

I think that is what was meant.  Just like "-" abbreviation is handy
for users of "checkout" and "merge", "cherry-pick" might.  I am not
sure if you would often cherry-pick from the previous branch, but
for the sake of completeness and uniformity, the guiding principle
could be "at any point on the command line where a branch name is
accepted, if a '-' could not possibly mean any other thing is wanted
(e.g. doing something on the standard input), it should stand as the
name of the previous branch".

I agree with everything you said in your review.  The patch is going
in the right direction, but it needs a bit more work.

Thanks.
