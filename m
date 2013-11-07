From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Thu, 07 Nov 2013 10:02:01 -0800
Message-ID: <xmqqvc045bvq.fsf@gitster.dls.corp.google.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
	<1383212774-5232-2-git-send-email-artagnon@gmail.com>
	<xmqq38nh411p.fsf@gitster.dls.corp.google.com>
	<CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
	<xmqqli182mde.fsf@gitster.dls.corp.google.com>
	<CALkWK0k-8noAJbgzPx3NEx-ucUdZoS4VmqNCKjm3R_5eqFnR7w@mail.gmail.com>
	<xmqqzjpkyqtf.fsf@gitster.dls.corp.google.com>
	<CALkWK0k0wxoK-MZk-KXiUiUgxVBKQGROFJBZbRs2LjNLA9iopA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 19:02:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeTuM-0004Ns-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 19:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab3KGSCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 13:02:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43511 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752972Ab3KGSCM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 13:02:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A44014F809;
	Thu,  7 Nov 2013 13:02:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NnUE087MqCdLrhbA0xCw+sLVHos=; b=sEJYOv
	a4IhWqertMvmm1X/ZrP8uXznGbyqn+tmL7j2S2DUwBS64tTQPUU8BIIX6Vqp3JXC
	ffXApc+ItoSTrXjTIo51dKitVMLpdWcdkonJZPKBfReJ/+WMzHoapyoVar+ogzpU
	nh+uRWenrI1GIaTCmR3kMiLph4AAhtkLGGVU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DW1leC0bOu6JQRTBCvVr4alIsRk54vFO
	pWLjJBdAaqSywnaWN12R3GJypyjpzNohKijNzzFFlDVTFVAikUk2SOt4Zi38fc9X
	hqO62HnysnKvGn4nY2ENYU8fI7jXSv5VdzP1GceFmbvWixWQZrHEEktEKKpsn3iP
	jx1ARy3Zs9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 974EC4F808;
	Thu,  7 Nov 2013 13:02:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE1434F807;
	Thu,  7 Nov 2013 13:02:10 -0500 (EST)
In-Reply-To: <CALkWK0k0wxoK-MZk-KXiUiUgxVBKQGROFJBZbRs2LjNLA9iopA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 7 Nov 2013 14:36:13 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B95515D8-47D6-11E3-8184-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237418>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> ... users of for-each-ref format will be _more_ familiar with
>> formats used by for-each-ref, and it would make a lot more sense to
>> keep the syntactic resemblance between existing features to show
>> magic things in for-each-ref and the new feature to show color
>> (which is merely one new "magic" to the vocabulary in the context of
>> for-each-ref), no?
>
> Okay, so what do you suggest in place of %C(...)?

If %(authordate) is "I want to see the author date here", and
%(authordate:short) is "I want to see the author date here in the
short form", you would expect "I want colored output in green" to be
spelled as %(color:green), or something, perhaps?
