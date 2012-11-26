From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] emacs: make 'git-status' work with separate git dirs
Date: Mon, 26 Nov 2012 15:30:52 -0800
Message-ID: <7vboekosb7.fsf@alter.siamese.dyndns.org>
References: <1353599934-23222-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <7v4nkeyzfb.fsf@alter.siamese.dyndns.org> <87ehjit5ke.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:31:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td88t-0003kJ-UC
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290Ab2KZXa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:30:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756408Ab2KZXaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:30:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25A45958A;
	Mon, 26 Nov 2012 18:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b0tPbrrliqnrBmUbfrFU/+8an6o=; b=UfqbEi
	2/qGEh60zrKEHm/E6EZ4WkKSpdQiDLPlhHJlXMdzenCXp2obdfO/HEEfR4UOqRAe
	zjUM82J/6LNcKHRydbIXvUuoInbT6LRN8XvgLkve3AWUbFf0PVJLsu7dbAJ2yCcH
	UnyjJVuOhfPA0OMH4W1InO9phvMevmF+zfqdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tBuL1DlK0SIu8eAXutzBXUxbU86d5KiH
	VrEkO1KDvqYfNLgVqxV2kp3EMjaf//mAyndS2h2KbOKR1RPbBdIoiOtdBEyb+ARx
	/8kYMwg9enTQ2xEKQinRvTjSVDt86zQB2XdeyVQMzq5n0cZejHP2f+DQ6cfuAYff
	FuSwjj3KDtg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13F4D9588;
	Mon, 26 Nov 2012 18:30:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7655B9584; Mon, 26 Nov 2012
 18:30:54 -0500 (EST)
In-Reply-To: <87ehjit5ke.fsf@wine.dyndns.org> (Alexandre Julliard's message
 of "Sun, 25 Nov 2012 10:06:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5292572C-3821-11E2-BF14-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210515>

Alexandre Julliard <julliard@winehq.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Enrico Scholz <enrico.scholz@sigma-chemnitz.de> writes:
>>
>>> when trying 'M-x git-status' in a submodule created with recent (1.7.5+)
>>> git, the command fails with
>>>
>>> | ... is not a git working tree
>>>
>>> This is caused by creating submodules with '--separate-git-dir' but
>>> still checking for a working tree by testing for a '.git' directory.
>>>
>>> The patch fixes this by relaxing the existing detection a little bit.
>>>
>>> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>>> ---
>>
>> This script already relies on the assumption that nobody sane would
>> create a directory named ".git" that is not a git repository, and
>> this loosens the assumption that nobody would create a file named
>> ".git", either.  So I would think it is a sane thing to do, but just
>> in case if the area expert has better ideas, I am forwarding it.
>>
>> Ack?
>
> Sure, that's fine.

Thanks, both.  Applied.
