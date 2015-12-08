From: Junio C Hamano <gitster@pobox.com>
Subject: Re: best practices against long git rebase times?
Date: Mon, 07 Dec 2015 16:18:29 -0800
Message-ID: <xmqqio49lrmy.fsf@gitster.mtv.corp.google.com>
References: <20151204150546.GA17210@inner.h.apk.li>
	<20151204153103.GP18913@serenity.lan>
	<20151206164345.GH22288@inner.h.apk.li>
	<20151207210212.GF30203@sigill.intra.peff.net>
	<xmqqmvtllvfi.fsf@gitster.mtv.corp.google.com>
	<20151207225957.GB3785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 01:18:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a65zL-0000ZY-Ap
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 01:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbbLHASf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 19:18:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754620AbbLHASe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 19:18:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F323E320C8;
	Mon,  7 Dec 2015 19:18:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hoj4kMmf5E08iJ+CLsTHnp2hxNY=; b=NOFHbK
	LSTI//tZa11n4SkjETMrbZTT8KEzj2oMo1ptUw6unorZuDN2EbYSr2rvhpJKyI5V
	Il8xVmHHDYd9M2EP+/xVLgyi9KMHpITG7vQsXYpgBPu2PLWP8I0Ae4h8+LPGhBno
	B1lg2+nHLXDiRw6FNXu2VOGqGLmpH15CYoSK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BKAK+iZ5enhoi+ah8GlRB5/HzylBoDZU
	turyXOgEi4PPmu+B3ohStgs0A+cK03svCVe7ZLrkRds5jPSOJRaPztwommEQrM1Y
	Z1AAxvrg7XVvPAAKeGIX7I9Bgj3d7aMU4ZJUlpCJ1DaBZOCjAFdjo7g7xGLLgxPM
	4ZfzNujmtWI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3C28320C7;
	Mon,  7 Dec 2015 19:18:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 628B5320C6;
	Mon,  7 Dec 2015 19:18:31 -0500 (EST)
In-Reply-To: <20151207225957.GB3785@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 7 Dec 2015 17:59:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 364D8C8E-9D41-11E5-B192-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282141>

Jeff King <peff@peff.net> writes:

> I think you missed John's earlier response which gave several pointers
> to such caching schemes. :)

Yeah, you're right.

>
> I used to run with patch-id-caching in my personal fork (I frequently
> use "git log --cherry-mark" to see what has made it upstream), but I
> haven't for a while. It did make a big difference in speed, but I never
> resolved the corner cases around cache invalidation.
>
> -Peff
