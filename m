From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/10] builtin/replace: teach listing using short, medium or full formats
Date: Thu, 19 Dec 2013 10:58:18 -0800
Message-ID: <xmqqbo0cfz1x.fsf@gitster.dls.corp.google.com>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
	<20131211074614.11117.96106.chriscool@tuxfamily.org>
	<52B196F1.3060003@gmail.com>
	<CAP8UFD3UsdcDg2D2nysMZgGAxLebYm-qQX3LZfqdwF9gNbyxgA@mail.gmail.com>
	<xmqqioumjc1n.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1+kydjrjhTxKDSMmOa+KiOYgMGK5gyxCe-LPih02=VYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 19:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtini-0002E7-Hf
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 19:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab3LSS6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 13:58:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677Ab3LSS6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 13:58:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7425BCF2;
	Thu, 19 Dec 2013 13:58:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CvDtyolsSE/wH68nBQ8tNPCsrBc=; b=VSSKPs
	tpLy6Y9KTL8XZbB8SZWkDYGlNna+W1XjbFdprzwQ225zyMIPbt6NzOiIOCVdVMMh
	7JDrkc8J/HkvsYlTw1LgkbTws4P294wNUMsLCPiFNkrmnNK9sTDU7zPwOSlXLfhk
	axUnE78F+P9CjllSsgCE9pC2deZtmuM+/NnAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JuPsOj+o7VMqn2r4B2z53VZ7HZFM6uE5
	SpDbwTBhhqZX+SyEVLEbvF8UMqetogiYRFq0fY55eL0Ps9FEp7LDgnJtEPmFLegb
	+JYJMMMm2mv5Ck9CBNbDoahSZc7XfZik7YZU4D9vjJWkRI3CtnbHD2FDjMAJqNQG
	D39Rm5Kh7WE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C2715BCF1;
	Thu, 19 Dec 2013 13:58:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64C855BCEF;
	Thu, 19 Dec 2013 13:58:20 -0500 (EST)
In-Reply-To: <CAP8UFD1+kydjrjhTxKDSMmOa+KiOYgMGK5gyxCe-LPih02=VYQ@mail.gmail.com>
	(Christian Couder's message of "Thu, 19 Dec 2013 17:36:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 871AE42E-68DF-11E3-B6B2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239532>

Christian Couder <christian.couder@gmail.com> writes:

> I think this last one might be useful for people replacing objects
> with objects that have another type.

... which IIUC is strongly discouraged---didn't you have to tighten
it recently?

And that makes it "useful primarily for debugging" unusual
situations.

> And as we let people do that using --force, it could be useful for
> them to have a way to easily see what they have done.
>
> Thanks,
> Christian.
