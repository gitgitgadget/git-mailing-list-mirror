From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Thu, 21 Apr 2016 16:20:07 -0700
Message-ID: <xmqqfuuer1lk.fsf@gitster.mtv.corp.google.com>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
	<20160421225116.GF1096@LykOS>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Fri Apr 22 01:20:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atNtR-0007ya-Mp
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 01:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbcDUXUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 19:20:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752076AbcDUXUK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 19:20:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0ECDB1618A;
	Thu, 21 Apr 2016 19:20:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q54rDmbXd5N9ZGEhWeVJDpZAiOw=; b=D11c6S
	HCTuVbFs+RfBHmWA2KboemqOy18tBOJcvN+eApUk/O7AagMJqBgjSMsFsvpUJ98H
	HAh0VPxHoIue3T/0M7Y8k20blS77leMc3hSfCZrmWKhaFUlxVrHAyKRbnOTxrg5N
	dLb49aPNndmSpUmvJ2ZRZkUGamzix2HXv6Aic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jl6i51Nfgn7Xfi9+bSBJa3Fo5hWyr3Uz
	pk1qzSGXVStdj1Iso6W5lOXQv1Gl+//METTdbrxDvg3hNJRAh/xOCmzZ8iUmN0vx
	DRIbuaFN/ycbSO5uw7kPTj5UW57wqVvhOnan/3+Cvojglp8QqMFatC3eerY8nZod
	cHaCrVuM2cA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 058E016189;
	Thu, 21 Apr 2016 19:20:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67B7716187;
	Thu, 21 Apr 2016 19:20:08 -0400 (EDT)
In-Reply-To: <20160421225116.GF1096@LykOS> (Santiago Torres's message of "Thu,
	21 Apr 2016 18:51:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 968B7804-0817-11E6-90DC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292164>

Santiago Torres <santiago@nyu.edu> writes:

> On Thu, Apr 21, 2016 at 03:20:39PM -0700, Junio C Hamano wrote:
>> * st/verify-tag (2016-04-19) 6 commits
>>  - tag -v: verfy directly rather than exec-ing verify-tag
>>  - verify-tag: move tag verification code to tag.c
>>  - verify-tag: prepare verify_tag for libification
>>  - verify-tag: update variable name and type
>>  - t7030: test verifying multiple tags
>>  - builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
>> 
>>  Unify internal logic between "git tag -v" and "git verify-tag"
>>  commands by making one directly call into the other.
>> 
>>  Will merge to 'next'.
>
> Hi Junio, 
>
> Ramsay Jones[1] Suggested we dropped the extern qualifier on the
> declaration of verify-tag() in tag.c as it is causing a warning with
> sparse.
>
> Should I re-roll this before it's merged into next?

Yes please.
