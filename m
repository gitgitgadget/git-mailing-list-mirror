From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Thu, 11 Nov 2010 09:21:11 -0800
Message-ID: <7vsjz7hj3s.fsf@alter.siamese.dyndns.org>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
 <m3iq06fa9i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGapx-0001h9-7R
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab0KKRVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 12:21:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab0KKRVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 12:21:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49F8F324F;
	Thu, 11 Nov 2010 12:21:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ncGG4lazpOlpw9YdS4RV4ptnYc=; b=vfL7/B
	a3L5kouvby8htEh9HoAb4u9nociFNd3LIgTBf64vHS+bNfRn3o0V41VpHeOpbJXx
	ruJf9Qiaw/ns57euFuF5jXfGSDt10f5F3sri5UDsk6L6Cyu1QfzIX1pxBurhY5CH
	cRWNFnz8Md2TAEJ6R3NSrHy9iNk0mbLlCpRgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aR+BIBz6aVaGrta/VrKdZB5ydpVS480A
	61TrsjAXKmiU4PnUeQElAWtanl8go+C/MsoiNx4eKBG+9ODs031mGf4B+xtrH5pK
	wzv9+VtjPG+t8uu+1r8PCXZAtgsGJu/Ms4OuXMSQXd3UDSyx8IcAsYdU++O4F45A
	ohZ55UZQ44w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F203324C;
	Thu, 11 Nov 2010 12:21:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FB543248; Thu, 11 Nov 2010
 12:21:16 -0500 (EST)
In-Reply-To: <m3iq06fa9i.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue\, 09 Nov 2010 13\:38\:49 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 196EB5D6-EDB8-11DF-B814-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161272>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> * jh/gitweb-caching (2010-11-01) 4 commits
>>  - gitweb: Minimal testing of gitweb caching
>>  - gitweb: File based caching layer (from git.kernel.org)
>>  - gitweb: add output buffering and associated functions
>>  - gitweb: Prepare for splitting gitweb
>>  (this branch uses jn/gitweb-test.)
>
>> * jn/gitweb-test (2010-09-26) 4 commits
>>   (merged to 'next' on 2010-11-05 at 90b3adf)
>>  + gitweb/Makefile: Include gitweb/config.mak
>>  + gitweb/Makefile: Add 'test' and 'test-installed' targets
>>  + t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
>>  + gitweb: Move call to evaluate_git_version after evaluate_gitweb_config
>>  (this branch is used by jh/gitweb-caching.)
>
> These two branches have simple to resolve but non-trivial conflict.
> Should I rebase 'jh/gitweb-caching' on top of 'jn/gitweb-test' then,
> resolving this conflict?

In general, when a conflict between topic A and B is simple to resolve
(and I have the correct resolution already in 'pu'), I'd rather prefer to
keep topic A independent of topic B than rebasing topic A on top of topic
B, unless topic A is far from ready and topic B is truly ready and about
to graduate, so that we can leave a door open for A to graduate before B
does (or vice versa).

In this case, I think it is overdue (iow, sorry I've been slow) for the
gitweb-test topic to graduate, so the separation does not really matter.

> BTW. this would allow me to improve 'gitweb: Minimal testing of gitweb
> caching'.

Then I probably should leave gitweb-caching out of 'next' when gitweb-test
graduates to master so that you can refresh the caching series.  Thanks
for a heads-up.
