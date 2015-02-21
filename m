From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Support customized reordering in version sort
Date: Fri, 20 Feb 2015 21:37:18 -0800
Message-ID: <xmqqh9ufygdt.fsf@gitster.dls.corp.google.com>
References: <20150218191417.GA7767@peff.net>
	<CACsJy8B_zkAecL2Wag8a5c9-_C9eoA9dYj4ciBXqXRVmRW77zw@mail.gmail.com>
	<20150220071342.GB8763@peff.net>
	<CAPc5daVJ_nYk=tWqpUYPpsX6Z50H429jOh8QfMwUdNDdTDMq9w@mail.gmail.com>
	<20150221030209.GA567@lanh>
	<CAPc5daXtmvfgkFA_YeQxunjSWYGUQB0uWCQVgfxMP_M9fB9qEw@mail.gmail.com>
	<CACsJy8BFZ2O62f+QofSqZRoQ9BOX0SLnXHY_g93iMnyikW8H7g@mail.gmail.com>
	<CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 06:37:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP2l1-0002wq-Eq
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 06:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbbBUFhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 00:37:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750746AbbBUFhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 00:37:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91B1F3AD82;
	Sat, 21 Feb 2015 00:37:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qd3kJquiKy/5bT0woekBy+mac4A=; b=JAtXYZ
	FeJJnCRXZ+mB/rKK6OuF3P8cXEgXOWGIgsaFQgDDKusC//U2AkgY616hY3BAKN4k
	/iqFViEvkK/dasJqzmIJ9libiRpaMEJP9jN8nnZ+cBXlqX970QsWVW0ZOGJL3clw
	iSMky8DMTCIKdcdta+cMyV7xV/STH4ZWz046Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LcUWaDYx6U/suRL7RoD883JQoyGrNLFr
	piDSbp+zshJWusB8iRnUDnNikpeWTC6am8vZJ8+hbMXP3ycY1BZlRQVwgt6BnQt2
	RjFL1bxMmR0YRIyFuUEp07Y6C+yaxeY/pZJ2Au5Nfiu60+OgaKBf4Zb/8S5iSjDC
	FLTHkNAyDDk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 88A293AD80;
	Sat, 21 Feb 2015 00:37:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1061D3AD7F;
	Sat, 21 Feb 2015 00:37:19 -0500 (EST)
In-Reply-To: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
	(Junio C. Hamano's message of "Fri, 20 Feb 2015 21:12:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B414A804-B98B-11E4-A9FF-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264208>

Junio C Hamano <gitster@pobox.com> writes:

> You can define values to optional negatives and optional positives to
> express a more
> elaborate sort order e.g.
>
>   1.0-pre12 < 1.0-rc0 < 1.0 < 1.0-post1
>
> even though "-post" does not have to be declared as optional positive.

... that is, you say "-pre" is a more negative optional than "-rc"
that is also a negative optional.
