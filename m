From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 04 Mar 2016 17:35:30 -0800
Message-ID: <xmqq60x1yae5.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
	<CACsJy8CcwaZ-zLX3iBKPDNkpMv5vRU=hHYFeBK7o0tnOq6uDJA@mail.gmail.com>
	<1457139624.4135861.540124922.0A8B3F69@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Kevin Daudt <me@ikke.info>,
	Git Mailing List <git@vger.kernel.org>
To: Charles Strahan <charles@cstrahan.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 02:35:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac18B-00089B-As
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 02:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759066AbcCEBfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 20:35:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755567AbcCEBfd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 20:35:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DAD74A305;
	Fri,  4 Mar 2016 20:35:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pRFIlsN1bHABI6RY3L+PbKia8Ic=; b=rMMdhd
	Z2CfXqFuBgFG8d3+znC6v4/DEMi0DdvYFcO2IdO3lAFritFKcP+RG8etwZgEWfYs
	OkCTzr2XQ3UKK4xPU9VVTSSaKtUI/uw7lGyjNMu9NpDZjBuirLfitKgTIx1nAC+x
	pOrlNiA/mH43g0aZg/AmKGfOHU0M63karmyUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqRnvHljHCglYuWog6ad5CCLxNr2HZyF
	Qv2PPyasC7lwFDtVyjvPaaYmhRZVVbPdSZyaHAmb+ZpZEI5Xnkdqx9UT/tTz8XgP
	SU0OpptKxgjHep/jnraB9Rjnb541SilTFcvFNx4ICrQEnGzsoM8Jthm5qRRKA1UO
	jiiQwsR8pyw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35CE44A303;
	Fri,  4 Mar 2016 20:35:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF0954A302;
	Fri,  4 Mar 2016 20:35:31 -0500 (EST)
In-Reply-To: <1457139624.4135861.540124922.0A8B3F69@webmail.messagingengine.com>
	(Charles Strahan's message of "Fri, 04 Mar 2016 20:00:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C9385B4-E272-11E5-B569-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288289>

Charles Strahan <charles@cstrahan.com> writes:

> ...as Duy suggests, I think the new behavior makes a bit
> more sense.

After re-reading your original example, I am inclined to agree with
this.

> Either way, of course, I'd like for it to not change back and
> forth between releases :).
>
> Perhaps just an announcement of the new behavior would suffice -
> 2.7.0 has been out for a while anyway. If people were going to
> complain, I figure they would have done so by now.

Yup, I think a documentation update to clarify how positive and
negative ignore patterns interact with each other may be necessary,
with some examples.

Care to work on a patch?

Thanks.
