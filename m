From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport, send-pack: append period to up-to-date message
Date: Wed, 25 May 2016 15:55:59 -0700
Message-ID: <xmqqy46xycg0.fsf@gitster.mtv.corp.google.com>
References: <1464123104-45513-1-git-send-email-junk@humanoriented.com>
	<CAGZ79kayB59-U52oAw=13a2CAhJLsfmoD6JbAURbt0p8g8a8fg@mail.gmail.com>
	<20160525224733.GF13776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Yong Bakos <junk@humanoriented.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	barkalow@iabervon.org, Yong Bakos <ybakos@humanoriented.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 00:56:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hil-0004Er-Jm
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbcEYW4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:56:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751829AbcEYW4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:56:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CC021F5CF;
	Wed, 25 May 2016 18:56:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xSdfa7naesPbwTUZvodt3EdVRTY=; b=EFYya1
	ky1FjgX/J647ZU1gwNgvflPN3Bx2D8T8U4hKN82osKTaE4kHmJT4DUXgBXLuVO4E
	bCDNWNVHSGWYgpRklRlz0LCkQraeUQvlMv3OpYvduE7w8BySTaT7zqGZlg2Gg15c
	R+dC+k0UIcr31VMNkTvUZf6XRXxv0wkBtdnf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aKj9vM68A4eg5HCesjGjhnwV1d0nSNha
	7yZqexgVJL33EgrbdzeH6hmzhQBWd7ADIGVpBP12+bm24qAqJBok+OMocR7k7CCX
	RJn6fD9c8u+UpcwDUGoEk1yP79FHPzopfzCacaQKYLVulE4h9osxVvTascbt+5SN
	iKU15gsMQnQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F5061F5CE;
	Wed, 25 May 2016 18:56:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E24D1F5CC;
	Wed, 25 May 2016 18:56:01 -0400 (EDT)
In-Reply-To: <20160525224733.GF13776@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 May 2016 17:47:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA02E6D4-22CB-11E6-9FFB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295611>

Jeff King <peff@peff.net> writes:

> I think messages to stderr are generally fair game for changing, even in
> plumbing. In many cases they are also translated (and I would argue that
> these messages probably should be translated, too).

I think I agree.  My first reaction to this thread indeed was "Why
isn't this marked for translation?"; as to the change proposed by
the patch itself, my reaction actually was "Meh" ;-)

> That being said, CodingGuidelines says:
>
>    - Do not end error messages with a full stop.

Thanks for pointing it out---I forgot about that one.

I do not think there was a concrete reason why they should not end
with a full stop, other than "be consistent with existing ones that
do not end with a full stop", though.

> This isn't an error message exactly, but I think it's in the same vein.
> I will note that we have not historically been consistent here, though
> (as evidenced by the noted message in git-merge).
