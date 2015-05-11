From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/18] Improve handling of D/F conflicts
Date: Mon, 11 May 2015 10:56:54 -0700
Message-ID: <xmqqwq0fngk9.fsf@gitster.dls.corp.google.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 11 19:57:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrrx3-0004YI-2z
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbbEKR5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:57:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753591AbbEKR5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:57:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91A244FB05;
	Mon, 11 May 2015 13:56:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k1USqlEZGibWIA83wTlhDdGGgZE=; b=E2ps8F
	EvGu5gdfQPzGz0WECCJWsnXAStKjshIRMcyM9G+tawuN0ffvkYke/F15UUoqx7VG
	eum4w/yV8P9NE/f3Hjl3CYC3Wh5iuorod8xnO1LOXUUKWqM95F9i7Df1NhAuuVaD
	oo5OrlY8Z5VpmruuHfOS/Wti7awsPqt+URY88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r883tRqr1Hrx9T1XYLHwkChEAvHDKRUy
	XAIq2kRn/kHe/qfPiWZfpa8taQ15EzBAoiuU7k8pN5HXgNT/iAQzfc3n0qTPcoCj
	3jpkY8F/1Pjm/WbZQ5wq0Z7BQe98T5LT9YJK1stJveKG3vLIXM24w9S9JQGAZVYe
	QvjT3IplKnc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 898E24FB04;
	Mon, 11 May 2015 13:56:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E2644FB03;
	Mon, 11 May 2015 13:56:55 -0400 (EDT)
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 11 May 2015 17:25:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CDE2C20-F807-11E4-90D5-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268809>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * Rebase to master rather than depending on
>   mh/ref-lock-avoid-running-out-of-fds, as did v1. There were no
>   significant dependencies between the two patch series, and now that
>   mh/ref-lock-avoid-running-out-of-fds (now renamed to
>   mh/write-refs-sooner.*) has been backported to 2.2, the dependency
>   makes even less sense.

Thanks, that makes sense.
