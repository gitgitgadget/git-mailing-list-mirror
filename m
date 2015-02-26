From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Thu, 26 Feb 2015 12:59:56 -0800
Message-ID: <xmqqmw40l777.fsf@gitster.dls.corp.google.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
	<1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
	<1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
	<xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
	<20150226030416.GA6121@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:00:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5XS-0006fb-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbbBZVAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:00:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754388AbbBZU77 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:59:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D96E3C388;
	Thu, 26 Feb 2015 15:59:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pX3tL6BEdW6sFGH0cfuEP2uF9ss=; b=Z9M4y+
	3XJbkQBjZ6oKCljsFiTXJ2x4+m4rnkoZSr9IN6+00eUSFYGnRmjZusV1zkCjuYSI
	Yc/IgE5J2e0H6n76TZowsZaG3vftOS9UybTVCGAeAUY6kWr8pPmxKkc1Va5d191d
	YGAp5W+SmXeyN5j7prfXoL19janCGsWukSEcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=utp9dP1HD4CS0n4WCaUQHQogqrbNXu54
	rTChAWHdqbrxAHeJXEpLjnqRMovSYAstnLbQMXWGhcedDn7u+xmX8mynOB6S4vjM
	1gPFFN/pofES1OYipO9HEeJbJoRmBUS5C5f8pbeWUQ/8V9SJG5wqHLLsMQDOzeTu
	cuwpizRwWWM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E0DC3C387;
	Thu, 26 Feb 2015 15:59:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3BC63C384;
	Thu, 26 Feb 2015 15:59:57 -0500 (EST)
In-Reply-To: <20150226030416.GA6121@peff.net> (Jeff King's message of "Wed, 25
	Feb 2015 22:04:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6BF4DD50-BDFA-11E4-BE99-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264462>

Jeff King <peff@peff.net> writes:

> Perhaps it would be less risky to stick get_preferred_languages() into
> gettext.c, like the patch below. Then we do not have to worry about
> locale.h introducing other disruptive includes. The function is not
> technically about gettext, but it seems reasonable to me to stuff all of
> the i18n code together.

Yeah, I like that a lot better.  Thanks.
