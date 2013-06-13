From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Thu, 13 Jun 2013 10:39:47 -0700
Message-ID: <7vk3lxvrj0.fsf@alter.siamese.dyndns.org>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
	<1370798000-2358-3-git-send-email-artagnon@gmail.com>
	<7vip1moq3k.fsf@alter.siamese.dyndns.org>
	<CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
	<7v4nd6l31d.fsf@alter.siamese.dyndns.org>
	<CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
	<7vwqq2j7c9.fsf@alter.siamese.dyndns.org>
	<CALkWK0mfWs3LBocvn=QMcX0_ZCROx4Nw=+xjpCbKLQU0JzSdXg@mail.gmail.com>
	<7vobbdhjeg.fsf@alter.siamese.dyndns.org>
	<CALkWK0mDDKETE1O=g7X5s5MJvU7UA_NQiMNESor_8=phW0WR-A@mail.gmail.com>
	<7vehc6vtvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:39:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBV4-0003B2-76
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab3FMRju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:39:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab3FMRjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:39:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D770275B3;
	Thu, 13 Jun 2013 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ebWCTR0WbDJvY3gkFRwTmgPPlC0=; b=morl+m
	SSo3LJrq8KtKm88ck6YK1QoMenwYJznXlQKHkAw1jHgEG6ZMjeF8I102s0wTvbYE
	SgCaV+FGMfLi4QRfqAm12aWDhxy23X6Qtolox6ftUkMguSvB9gM6qS+P/aRZ3Qyc
	4fYs1JI0Et94FY43jqnqZOvQzos4SFJfolO4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qqdnIsuQt2msM4mJaxIq6NkZiCKiPVbs
	ZkdS63+QUDy4gU9qRLqyPKB+v/e0V0uoOFdvKnIQGQkIqO7yxtpTFKB4jqhklCct
	RBcy2awmcPHLhXddS4qhORefgA3Wyc5YutqdOI3M+Z04UZQFrcV5QroalnGpNeiW
	BB9fgcGzOeo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 111E3275B2;
	Thu, 13 Jun 2013 17:39:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 874E8275B0;
	Thu, 13 Jun 2013 17:39:48 +0000 (UTC)
In-Reply-To: <7vehc6vtvt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 13 Jun 2013 09:48:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E810640-D450-11E2-9F91-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227753>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>
>>> [...]
>>
>> Okay, so what you're saying makes sense.
>
> That is not a very useful style of quoting; what did you just agree to?

Ahh.

I took your response as "I'm still resisting [to what was quoted
before it].  But to the part [...] that I am not quoting I would
agree", hence my question.

Did you mean "I'm still resisting, but after reading [...] I think
it makes sense"?  If so, please discard my question.
