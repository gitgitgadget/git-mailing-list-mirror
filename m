From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "remote-hg: update bookmarks when pulling"
Date: Thu, 16 May 2013 16:14:40 -0700
Message-ID: <7vsj1m34bj.fsf@alter.siamese.dyndns.org>
References: <1368708195-1044-1-git-send-email-felipe.contreras@gmail.com>
	<7v4ne27ubp.fsf@alter.siamese.dyndns.org>
	<7vbo8a6b9c.fsf@alter.siamese.dyndns.org>
	<CAMP44s3HKgWE=8SU+aBMBWzwe-fQ8Rjf0yGmGQxcdedhYCNJmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:14:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7Nq-00043g-4J
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab3EPXOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:14:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754821Ab3EPXOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:14:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 301001F9AE;
	Thu, 16 May 2013 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wO0PSbwsWEj8jrE0Xy6UhRMKqxA=; b=f7TQQG
	ak7NW13fdp5ivoCoTrEJ8AahmeevtFeatD2SjK2e6epWIVhsVMRbIxlj8FgZstL3
	XcsZsrg06qTG4Pdo9FfS6nw1Hbn37bfqamovbDXaIUxpE5UoqlaxMDcb6Ol0OWPJ
	6A0knOHml3BwxgkvcJ7c7Jklv0gokIMWs4WMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OiQGWy+8aHvBRqWhIo2DVCAbqh1d9XWJ
	Grx/0FvNrRjRMRItfoJz3phyYrJri1CCurA+sZHsLShQVfbfjya4wYWTZtgHpdNM
	BpA4LntD93hTwyM61rbQuQQ7ooy/tWOr5xy2LfBeIoqh2BlkYxEZLqg9QmPZgRHX
	uOBEKPnwikU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 235851F9AD;
	Thu, 16 May 2013 23:14:42 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96EFE1F9AB;
	Thu, 16 May 2013 23:14:41 +0000 (UTC)
In-Reply-To: <CAMP44s3HKgWE=8SU+aBMBWzwe-fQ8Rjf0yGmGQxcdedhYCNJmQ@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 18:04:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63561B64-BE7E-11E2-8F7A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224631>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 16, 2013 at 1:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> This reverts commit 24317ef32ac3111ed00792f9b2921dc19dd28fe2.
>>>>
>>>> Different versions of Mercurial have different arguments for
>>>> bookmarks.updatefromremote(), while it should be possible to call the
>>>> right function with the right arguments depending on the version, it's
>>>> safer to restore the old behavior for now.
>>>>
>>>> Reported by Rodney Lorrimar.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>
>>>> Intended for master (v1.8.3).
>>>
>>> Hmm, is this the one we merged yesterday?
>>
>> Just double-checking.
>
> Yes.

OK.  Thanks for keeping an eye on real user reports.

Please relay our thanks to Rodney as well.
