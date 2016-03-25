From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Fri, 25 Mar 2016 09:25:04 -0700
Message-ID: <xmqqa8lm5xun.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
	<1458775426-2215-1-git-send-email-gitster@pobox.com>
	<56F391A4.6090603@web.de>
	<xmqqmvpn91o2.fsf@gitster.mtv.corp.google.com> <56F50608.10606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:25:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajUY1-0001GR-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbcCYQZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 12:25:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753716AbcCYQZI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 12:25:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C24C34D48C;
	Fri, 25 Mar 2016 12:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FuFGZI0pN02O
	zeoCRrnYNjXJvo4=; b=CykiC8AIdca6LQkTWpVnual2eiZo0uayexpXMDpL4ri0
	L95uU2xlPnyGXCubxMDEwDSKh+wZoQuB0uGE0Cfy3ICBUTQKwa+7P9F6YOkhyNzR
	Uoqu/n+jliPn8oc4pbY+8rBcbnzGQ9a+8fmT8I3y7izgNCLQ7DbdHOJOIULANaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gXh/zb
	DDgwlliSOwN9hw0dViMRFlM0gyviOn4wNhEzCtpCjCHQXHAXyRZ0z0rMRA8z8O0F
	dDnwS3bTKae5hDiEC0WR/HrFBd/Pakw2I9YwwUylw83YbrS0SbXml0Z8KgnCq8d9
	QL8MICtNI4ycAWOx4n4AuPwViHZP4osCLbNYs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BAA354D48B;
	Fri, 25 Mar 2016 12:25:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF8BC4D486;
	Fri, 25 Mar 2016 12:25:05 -0400 (EDT)
In-Reply-To: <56F50608.10606@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Fri, 25 Mar 2016 10:34:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 22614C46-F2A6-11E5-BD3E-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289898>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2016-03-24 19.22, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> Would it make sense to have
>>> git log --tab-size=3D8
>>> (or similar)
>>>
>>> and add a config variable like
>>> git config ui.logtabsize
>>> which is 0 by default to get the old handling and 8 for the new one=
 ?
>>=20
>> That may be a good approach (I agree with you that --tab-size is not
>> the best name).  Want to try it as a replacement?
>
> May be log.tabwidth ?

The reason why I thought "--tab-size=3D4" is not the best name is
because it only states that the user prefers a non-standard tab
stops that are every 4 display spaces, and does not say what we
with do that information, i.e. it does not hint "We expand tabs
to spaces according to this setting" in its name.

I think log.tabwidth shares the same characteristics.
