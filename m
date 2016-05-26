From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/6] pack-objects hook for upload-pack
Date: Thu, 26 May 2016 09:44:20 -0700
Message-ID: <xmqqzircwyzf.fsf@gitster.mtv.corp.google.com>
References: <20160518223712.GA18317@sigill.intra.peff.net>
	<CAPc5daV6bdUKS-ExHmpT4Ppy2S832NXoyPw7aOLP7fG=WrBPgg@mail.gmail.com>
	<20160526054418.GB21580@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 18:44:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yOa-0003Dy-2U
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbcEZQoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:44:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750985AbcEZQoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:44:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 17C711DD5A;
	Thu, 26 May 2016 12:44:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oGN1Txt1jkYZfc/Mw01RdMPMVac=; b=Lpukle
	vCT1Gbeq1i9jqbXFrh0DrqfuOicLAYUfuxp5Lmee+hoHgQCX5XuDJa1++f1/C0X9
	1oQyibCkthmK9wTa3X0YGQ9BGazGlzCgMEQ6ogNbYFl2JRDw8aI4+Ego9ljpeneN
	iLoxmLbz9QeHo8R5vTeMXZEkd/1r1TnjOSb8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vc1X6BV6AWdctDxjhfs9Jyrf1doIytYi
	aPg3OX6Jqh5dqeU2+BuH0P40madtLLCyvjj4VKggBIdXXaMNLplgrxKTXjIHS1NO
	CC47TBY73Yiia0ab5vXhU84+OLxEI3CiFX8S3Wijnqyb+ltBqkmpnKw63CGbsFJF
	o0WwAH9G8Pk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F6DC1DD59;
	Thu, 26 May 2016 12:44:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 884981DD58;
	Thu, 26 May 2016 12:44:22 -0400 (EDT)
In-Reply-To: <20160526054418.GB21580@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 01:44:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 195D518A-2361-11E6-9251-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295669>

Jeff King <peff@peff.net> writes:

> Yeah, I had the same thought while working on this, but just didn't want
> to have to tweak every config callback. As you say, I don't think this
> makes anything fundamentally worse, though. I'm inclined to go with this
> strategy, especially with the extra die("BUG") safety added here.

Fine by me.

> PS Did you have any thoughts on the t/helper problem mentioned in:
>
>      http://article.gmane.org/gmane.comp.version-control.git/295029
>
>    I suspect it will bite you if you try merging/testing this.

It already did but thanks to that message I didn't have to panic ;-).
