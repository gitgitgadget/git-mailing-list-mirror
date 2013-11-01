From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 01 Nov 2013 08:05:33 -0700
Message-ID: <xmqqli182mde.fsf@gitster.dls.corp.google.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
	<1383212774-5232-2-git-send-email-artagnon@gmail.com>
	<xmqq38nh411p.fsf@gitster.dls.corp.google.com>
	<CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 01 16:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcGIA-0004P1-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 16:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab3KAPFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 11:05:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab3KAPFi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 11:05:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ACF74B6A5;
	Fri,  1 Nov 2013 11:05:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K1OnpIaoY7rJUmlHdi4cTnW1/uU=; b=Q5fIb6
	m+8CdS6uAo1VTB7DDE7iz2RRQ2Vjiin/gd1ZQnLkotKO8mpUY15uONBGPVMGWWFx
	q5VrBxFbRj/ewcoPvsyNkQeGuEJnh3ai2jfRrZLVrZFrmfT2NrcSWOBcgW4Gj4z9
	Ty8uVMBAnhufRgs7LzAgB6vXbXiFE4nU8rdC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C1VP5l1+Amk5nzpVx2YMm9RHMOrB3IF3
	4m2LP/P7leQucxkMrqBCoI1XWRqoHCjSIm7CeIy9BoksAsaSQJUKc1tGsxvAcPiS
	HCtBBlVLYDjudCkr+RTAE8e+N5Tf08eZFEuJm9Q05v9KPzqexNsvMzyYZO4fPS0W
	2qSu6Mm7TRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 790D44B6A4;
	Fri,  1 Nov 2013 11:05:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7AAE4B6A1;
	Fri,  1 Nov 2013 11:05:36 -0400 (EDT)
In-Reply-To: <CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 1 Nov 2013 14:07:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1048C148-4307-11E3-A271-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237212>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> Enhance 'git for-each-ref' with color formatting options.  You can now
>>> use the following format in for-each-ref:
>>>
>>>   %C(green)%(refname:short)%C(reset)
>>
>> So far, every magic for-each-ref takes were of form %(...); was
>> there a reason why this had to be %C(...), not %(color=blah), or
>> something more in-line with the existing other magic?
>
> It is in-line with the color specification in pretty-formats. Would
> you strongly prefer something else?

This patch is about for-each-ref and your series does not seem to
aim to unify it in any way with pretty-formats, so I would have
expected an enhancement in line with the former, not the latter.
