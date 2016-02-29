From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Mon, 29 Feb 2016 09:17:48 -0800
Message-ID: <xmqq37sbe8qr.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
	<56D078F3.9070905@web.de>
	<xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
	<56D0D2DF.1040807@web.de>
	<xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
	<20160227032907.GB10313@sigill.intra.peff.net>
	<56D14C56.6070306@web.de>
	<20160229101808.GD2950@sigill.intra.peff.net>
	<CAPig+cQkP++rnE4L1QSr-sW8VkS8ce7CyY9KAscebLao2Hw73A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 18:17:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaRSI-0000fY-JD
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 18:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbcB2RRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 12:17:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752041AbcB2RRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 12:17:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0305447AEA;
	Mon, 29 Feb 2016 12:17:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7NTof+RSHdfJx91VdvgWtt9n0FQ=; b=i0b4GO
	yXpzBM7kuqChou9zKsgP+4PD3P00Pz8eUHfriQ8wVuWO2Fej7qOcG5b4rXsT05CJ
	tjLLAhgOQwDO9L5JCY5pg4uVorxtGPTHADVmqkMVmTPO6S4st8biak030um++5GN
	Fi8ye91qxI7O2uvRzHnNhtOjv93Dm07uNHYT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B6dKKqKsqTT8pj+jJxwDOyTJribAuJNd
	RdXC+fPymj1lbYfa9bZMBvPBt9n/oZIqUmmpnqUoO0bf8Zt0OANk2QYicIQasN2w
	Twlx+SaQjhIuo4HTkxyHo8/z+ogdLSx0nB3Kzo8JeR3znwHcTJ8BLXRKKq3IEpqA
	xNW9faAfS+g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC77947AE9;
	Mon, 29 Feb 2016 12:17:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5937A47AE8;
	Mon, 29 Feb 2016 12:17:50 -0500 (EST)
In-Reply-To: <CAPig+cQkP++rnE4L1QSr-sW8VkS8ce7CyY9KAscebLao2Hw73A@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 29 Feb 2016 11:28:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C2C2F56-DF08-11E5-90C5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287850>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Your suggestion elsewhere in the thread to just use clang instead sounds
>> good to me. :)
>
> If possible, for the moment, I'd prefer to hold off on that
> sledge-hammer approach of unconditionally making the build use clang.
> It would be nice to have a more detailed understanding of what exactly
> is triggering the Apple compiler bug, and I've been trying to find
> time to check it out on my old Mac.

The (fixed) patch posted was "on OSX 10.6, use clang by default"; I
think that for majority of the users, that is a reasonable thing to do.

The result of the patch still allows those who want to see how badly
old Gcc breaks to do so with "make CC=gcc", doesn't it?
