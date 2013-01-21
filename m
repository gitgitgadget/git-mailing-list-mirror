From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Mon, 21 Jan 2013 14:08:27 -0800
Message-ID: <7vfw1ufauc.fsf@alter.siamese.dyndns.org>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
 <7vwqv7i9su.fsf@alter.siamese.dyndns.org> <kdjip9$4j7$1@ger.gmane.org>
 <2931F4CC43E4406DBB878482C2F0E4F4@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>,
	"Barry Wardell" <barry.wardell@gmail.com>,
	"\"Joachim Schmitz\"" <jojo@schmitz-digital.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxPXw-0000eh-Us
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 23:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab3AUWIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 17:08:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab3AUWIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 17:08:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 739F1CC1A;
	Mon, 21 Jan 2013 17:08:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BHc7Zyt1KP1MZ3JmTEnayv/HPSQ=; b=fGpwTw
	cZ6JgWAN0EnBmExFo+RMB8rKwDP/7fG/tOFH8ZWaLYeMskvNtvDwXfsHgoal7doL
	uWeog+5/Z3NqYhyeI96bSww319xsR287g+LMgw9SrxcHN5LOGFAyHy7pUIZ+PzSQ
	Wb5Ar8bwCHNVqVTIsIMza17iLFYtVzFgSxIao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OpgbBPpkYieFg8xWWAzaT4WdRgH9Kouz
	7N+gRJwnO8TAAUtNfIW1EGNU3Ia88xb2S1lf1Tv8kAsbM4WyVw9IAY6RkiQHpSfz
	GAavDsmHJFn6je96u8ljB4XVgzbjxq81c6rgHB8HvmSM1Y1pnSYX8ABhI97D8UQO
	Vqjw0te5lIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6701FCC19;
	Mon, 21 Jan 2013 17:08:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD299CC15; Mon, 21 Jan 2013
 17:08:29 -0500 (EST)
In-Reply-To: <2931F4CC43E4406DBB878482C2F0E4F4@PhilipOakley> (Philip Oakley's
 message of "Mon, 21 Jan 2013 21:45:53 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 166D7606-6417-11E2-AE3F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214165>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Joachim Schmitz" <jojo@schmitz-digital.de>
> Sent: Monday, January 21, 2013 2:19 PM
>> Junio C Hamano wrote:
>>> Barry Wardell <barry.wardell@gmail.com> writes:
> [...]
>>> Thanks for your persistence ;-) As this is a pretty old topic, I'll
>>> give two URLs for people who are interested to view the previous
>>> threads:
>>>
>>>    http://thread.gmane.org/gmane.comp.version-control.git/192133
>>>    http://thread.gmane.org/gmane.comp.version-control.git/192127
>>>
>>> You would want to mark it as test_expect_failure in the first patch
>>> and then flip it to text_expect_success in the second patch where
>>> you fix the breakage?  Otherwise, after applying the first patch,
>>> the testsuite will break needlessly.
>>
>> I'd just apply them the other way round, 1st fix the problem, 2nd
>> add a test for it
>
> Isn't it a case of, 1st demonstrate the problem with a test, and then
> 2nd  fix the problem.
>
> Those less principled could could simply "fix" a non-existent problem
> merely to get themselves into the change log, or worse, even if one
> may fix-test under the hood.

For a small/trivial fix, fixing the code and protecting the fix from
future breakages by adding tests that expect success in a single
commit is the most sensible thing to do.  People who are interested,
and people who are auditing, can locally revert only the code change
to see the new tests fail fairly easily in such a case.

For a more involved series, it is easier to demonstrate a breakage
by adding tests that expect failure in the first commit, and then in
subsequent commits, to fix a class of bugs in the code and flipping
expect_failure into expect_success for the tests that the updated
code in the commit fixes.

For this particular topic, squashing the two patches into a single
commit may probably be the more appropriate between the two.

Thanks.
