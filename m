From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/2] travis-ci: enable sequential test execution for t9113 and 9126
Date: Mon, 23 May 2016 14:22:16 -0700
Message-ID: <xmqq60u48o6v.fsf@gitster.mtv.corp.google.com>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
	<1463649009-56941-3-git-send-email-larsxschneider@gmail.com>
	<20160519100658.GA20225@dcvr.yhbt.net>
	<xmqqwpmqj7m1.fsf@gitster.mtv.corp.google.com>
	<7A9DE9C1-4AC7-4FF3-B8B1-26DE84BA625B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:22:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xIv-00010A-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbcEWVWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 17:22:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751167AbcEWVWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:22:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12B531C939;
	Mon, 23 May 2016 17:22:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WJPd2/jY5fvQBlSV6eck0e6QVlU=; b=nCE41Z
	jEPxVfH4k4Bb3+PIaXjUu+QOp8r8hHE50EUrFI0rby/ILfED0DcpmfDKXQFDQOm4
	3pE/FJlquWe0m7hk4WbISZ37YMSEYPxaRd2YnkImiXhCeBbjxfgMgOS8e2GYJUbG
	jwEzEHcv29uKSQ28H6cEfMuEq0c260TUfYXFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iLSQZ17t22kKVAS2Rd+d1ecSEmngnelb
	SBO2N6nEGRQ6hiBf+MTAbCbj0zWDFUcw0KWtatXSX7UPmhl8xsFsePK9w0khjLYs
	PEcbToce7//1vz2q45FvNSTpnzPDbGf1MBBZgNRbkQko4Fj50m+3KR2QKPC+6VYn
	9ySb98uquoY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 096F01C938;
	Mon, 23 May 2016 17:22:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 767CA1C935;
	Mon, 23 May 2016 17:22:19 -0400 (EDT)
In-Reply-To: <7A9DE9C1-4AC7-4FF3-B8B1-26DE84BA625B@gmail.com> (Lars
	Schneider's message of "Sun, 22 May 2016 12:10:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E5929AC-212C-11E6-AFFE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295394>

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 19 May 2016, at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Eric Wong <e@80x24.org> writes:
>> 
>>> Anyways, how about making the tests run on separate ports and
>>> not worry about serializing them at all?
>> 
>> Yeah, that does sound like a more sensible approach.
>
> Makes sense. However, it's not something I will tackle soon.
> Would you be willing to pick up $gmane/295048 (the first patch) as is 
> and drop $gmane/295050 (the patch discussed here)? Then the majority
> of Git SVN tests would run on Travis CI.

I am not sure if adding git-svn alone would be a good change.
Wouldn't it invite false failures from running these conflicting
tests at the same time?
