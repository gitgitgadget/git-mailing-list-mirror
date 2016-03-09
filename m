From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Tue, 08 Mar 2016 16:45:21 -0800
Message-ID: <xmqqy49siin2.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
	<xmqqlh5ungct.fsf@gitster.mtv.corp.google.com>
	<xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
	<xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
	<CACsJy8AgPQ__aVgoJc860yapWs_rTbXfBuGSBNRG-FT+v+rK1w@mail.gmail.com>
	<xmqq7fhcjxt8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 01:46:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adSGr-00005C-9E
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 01:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbcCIAqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 19:46:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753488AbcCIApY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 19:45:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 415C64C076;
	Tue,  8 Mar 2016 19:45:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vht4N0hTn3PlSQWw+XpIwQcFOwI=; b=Lx9LNR
	JQkgahghX9WmR7douH25r0IzEIVrXB0mWWOUMtUo5jG2UtgbO7xFjNnIogsbt0gl
	3ntRVZTGu/p4YlGvbwF+iDHItz8VGX47tKUZoxxs5faS4/Wz76kJvX5Ugj4vFnuz
	qo9Ulbu7MYo+wTOCswqSwtYfvKXBWPH4laYRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h0AEdg8RXrRkMZQriKHUgwG/fitIdKRy
	0NVKFCWUDOpcjpLnKhs8jAUbeWS4PtfKg7yXJWkwajnpEl+Kv7jkZm9l87rvDtGs
	3ytHXgWakId7Y8HtJqq4cj9jiJQSyOzR5niHDGbAg7pjJ7pLHUX44xJhlGOOj7b0
	dXab4tCbqgY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C4234C075;
	Tue,  8 Mar 2016 19:45:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 948C34C074;
	Tue,  8 Mar 2016 19:45:22 -0500 (EST)
In-Reply-To: <xmqq7fhcjxt8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 08 Mar 2016 16:32:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34A9955C-E590-11E5-8CA7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288466>

Junio C Hamano <gitster@pobox.com> writes:

> It is between (1) the current code is good enough ...
> or (2) the half-way implementation we
> have does not give enough advancement ... and we
> are better off reverting the whole thing to go back to 2.7.2
> behaviour, planning to do a better job in the next cycle.
>
> I was hoping that (1) would be the case.

Oh and of course I still am--otherwise I wouldn't have been
attempting these documentation updates.  I just wanted to make sure
that I covered most (if not all) of the corner cases that we know
the current code does not work by documenting workarounds.
