From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Opinions] Integrated tickets
Date: Thu, 06 Nov 2014 10:45:16 -0800
Message-ID: <xmqqvbmsgocj.fsf@gitster.dls.corp.google.com>
References: <20141105124429.GF15384@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 19:45:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmS3i-0004hY-Eb
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 19:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbaKFSpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 13:45:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751156AbaKFSpV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 13:45:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 225461BE3D;
	Thu,  6 Nov 2014 13:45:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zXoJGv03Crjb7FFu7TJPo6xXklQ=; b=DXxs8q
	32j4s4sXdajr9h2r5yJGi2qwysIUK+Tla2cbFaa7/ZKZcQkfXu1a/IyB3i3sji/s
	L1jrYoofKsdTGH4fNy2ZwaBMoJSnOV/zapuSMeN340HqQmyv3097OCB/90KJ6uHW
	PYzxUFyZC4J6TWl2JVxRPnstEMnF7faH70DzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HAFWCE9CJljuQ5LAbxn+rAPXbWMZHaeU
	1ETf+DVSEqMl+xZzK7KFAtGKUY/UDbk/P+eSLUG98EHP5nYE+eUIK362ad3GZjn8
	M0jI5gwgpugMiga14UlcEnhv4fkWWwKIMPWkDzS/ZXIXB2SRbLR8TZueP8GpLYpG
	Ccb9Ib5ST10=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B6801BE3C;
	Thu,  6 Nov 2014 13:45:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43B5F1BE36;
	Thu,  6 Nov 2014 13:45:18 -0500 (EST)
In-Reply-To: <20141105124429.GF15384@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Wed, 5 Nov 2014 13:44:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0DE329F0-65E5-11E4-8848-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> So my question is:
>
> what's your opinions on building an integrated ticket system on top of git?
>
> and (maybe mostly for Junio)
>
> Would such system possible be included in git.git?
>
> TL;DR;
> Is an integrated ticket system something for git?

Integrated?  Not really, unless we already have a clear winner in
the marketplace that we can just ship in contrib/ or something, and
even then, the Git ecosystem is now rich enough and the userbase
strong enough that having something in contrib/ adds much less value
than additional burden of having to keep up with the upstream, and
user confusion coming from possible version skew from the upstream.
It used to make a lot of sense to ship Git with things like gitweb
and gitk when we were trying to gain momentum, but it is no longer
2005 ;-).  Even kernel.org does not run gitweb anymore.

This is a tangent, but I personally do not think "ticket" meshes
very well with "commit".  If you already know which commit was
problematic, why are you annotating it with a ticket before
reverting it first?
