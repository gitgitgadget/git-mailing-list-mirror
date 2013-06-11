From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Tue, 11 Jun 2013 10:58:36 -0700
Message-ID: <7vppvsbkc3.fsf@alter.siamese.dyndns.org>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<51B4BBB7.8060807@lyx.org>
	<20130610214504.GG13333@sigill.intra.peff.net>
	<CAMP44s2-94LTu54oX1_m14tnE3KfwK+N=pPxgUSqGCgd51EA5A@mail.gmail.com>
	<20130610220627.GB28345@sigill.intra.peff.net>
	<7vk3m1efda.fsf@alter.siamese.dyndns.org>
	<7v8v2hedou.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HM0zFvkGmaHrX2Wq2JSzDNk8uwNSz3bNo12eWxDcL8A@mail.gmail.com>
	<7v4nd5ecmy.fsf@alter.siamese.dyndns.org>
	<7vwqq1ct0g.fsf@alter.siamese.dyndns.org>
	<CAMP44s0r96ByEs3+N1Qo+O18rOmT72rHk4zAEFAyFdU_DsQ8wA@mail.gmail.com>
	<7vtxl4blht.fsf@alter.siamese.dyndns.org>
	<CAMP44s02PqGFNmrGEcJVT6xcQHx8k4NYqJ_TtOTUEY8XHPj0BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Vincent van Ravesteijn <vfr@lyx.org>,
	John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:58:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSqB-0007tE-7B
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab3FKR6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:58:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130Ab3FKR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:58:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25972264DC;
	Tue, 11 Jun 2013 17:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mHwV9aDHHof0bBJW93uCncLxJk8=; b=YoXN2z
	SJEcR+ByS4chtEyOpCo/RtMyM6+pVzarFSOy/t+vBhPZv28lzSm8h4XgwGdT3qNF
	o6geNm7C2yNVfcpW2lBGla3+6ECaE15tSMV2rH+KuF6YDIdFgB0uP9hBHQmjWGiv
	hh+NGDh6cq3JZN32MEzF97aipBKQWfhMxzvfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iZClk0t8zRzo7nH47EaEjpyBlN3vKS7a
	CFGtovLw9tMOPZ0EHxQuIcd826lnXWw5nzp7fhrjC32H/4q0YMqyWY+hHbDYTP1O
	WJl9HIqJ2m9pZKZF5UP1GaAyjvuKwbrpqXBKHSH8zPNElwHeSzBdLIE75cCU7yy8
	prisamkM/0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18DBB264DA;
	Tue, 11 Jun 2013 17:58:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7806E264D6;
	Tue, 11 Jun 2013 17:58:37 +0000 (UTC)
In-Reply-To: <CAMP44s02PqGFNmrGEcJVT6xcQHx8k4NYqJ_TtOTUEY8XHPj0BA@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 11 Jun 2013 12:41:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AA059B8-D2C0-11E2-99B0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227478>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> What are the examples you have in mind, code that we want to forbid
>> standalone from using?
>
> init_copy_notes_for_rewrite(). Nothing outside the 'git' binary would
> need that. If you disagree, show me an example.

"Nothing would need that", if you are talking about the current
codebase, I would agree that nothing would link to it.

But that is not a good justification for closing door to others that
come later who may want to have a standalone that would want to use
it.  Think about rewriting filter-branch.sh in C but not as a
built-in, for example.
