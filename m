From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pretty-print: add --pretty=noexpand
Date: Thu, 17 Mar 2016 16:40:06 -0700
Message-ID: <xmqqk2l0y8q1.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
	<xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
	<xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
	<CA+55aFzeobjmhEmZzMYnvY-sit38S2j32gOXu5STLvbKfz-JAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:40:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aghWi-0003Ol-KJ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 00:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbcCQXkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 19:40:10 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751485AbcCQXkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 19:40:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE3F44D262;
	Thu, 17 Mar 2016 19:40:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vXCBQBKxG7HC3shl9RPZ5mVmHKA=; b=cPyTTe
	ztz0M2y8QpRGGbzRjxngAAWh6XE2+sadXNMOHz2/82eHwxsE2sPkFvT/AHgWIoN4
	6haXk4EQf8iRON8gzisiCmEI+8etBTrhok5LfafWYroYhVpX2vOzF8K7c3Czyg6Q
	mjhudCKmSBViqB1Nm6h1Nw5xXNOtAJJSJ+7aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vjju+MmzrzyKv7s1y5S35L0WkBFa2wR7
	E6luEDohDhibV9Q2Mxpj6pMBc0Xp0w2eHoeEbDqX23zibmLOUOkbaHTsJaGIVuG0
	BjsK/OMEnSChHJMiHmkXD6KKgvdzR11iFC5HA1gJSwMGMQ7Tv6GGQreXuSHRlIEH
	CKYFB6AnmWM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6ACE4D261;
	Thu, 17 Mar 2016 19:40:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 42CB24D260;
	Thu, 17 Mar 2016 19:40:07 -0400 (EDT)
In-Reply-To: <CA+55aFzeobjmhEmZzMYnvY-sit38S2j32gOXu5STLvbKfz-JAg@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 17 Mar 2016 16:23:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 94A7FBAA-EC99-11E5-8389-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289171>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Mar 17, 2016 at 4:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> It is reasonable for tweak the default output mode for "git log" to
>> untabify the commit log message, it sometimes may be necessary to
>> see the output without tab expansion.
>
> Thanks, these all look good to me.
>
> Sorry for not following up, it's just that I'm in the middle of the
> kernel merge window and haven't had the time to worry about it.

Sorry is mutual; I would have done this much earlier if I didn't
have the four-maintenance-tracks-at-the-same-time release today ;-)
