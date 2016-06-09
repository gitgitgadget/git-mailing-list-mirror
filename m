From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adds *~ to the .gitignore
Date: Thu, 09 Jun 2016 15:48:12 -0700
Message-ID: <xmqqd1nqges3.fsf@gitster.mtv.corp.google.com>
References: <1465506629-16577-1-git-send-email-Lars.Vogel@vogella.com>
	<xmqqh9d2girw.fsf@gitster.mtv.corp.google.com>
	<20160609213809.GA23059@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Vogel <lars.vogel@gmail.com>, git@vger.kernel.org,
	Lars Vogel <Lars.Vogel@vogella.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:48:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB8kO-0002dl-3u
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 00:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbcFIWsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 18:48:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751331AbcFIWsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 18:48:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65571238F2;
	Thu,  9 Jun 2016 18:48:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OPu1CBDucOjgPUoTMbNhgTz2N+w=; b=JDhK/0
	pMY7d6IsiQGIpJsYr9hyy8zLKtHxxoLIrAsdQeBhFWHl9hn5odwojONTLxp9Kxny
	YTjgQBK+sIcYDMC/fPwBk+W3TOvUJ7wOAMAu6RwojJG0jippvmcH5lDjJSX8negX
	Kii7P+t6Yfyz2PY5e059SZEGN3zKIdDixKbYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TqdfieaXoicZI57YGWk0o6NzLl/8aiVk
	Wz9SeOwYcgkSkeoDeUWs893lpeZkel43nN9WcXxlg5wUhmqNHp6vKUXxcjhf+nKl
	cMFNqZJcmMfRMCMjg4aU/9mp+ErHOcHU32ZGRW0GNEnsXm63KHuezXPshfrbmAKd
	CVnUYKzH2Yc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D0E5238F1;
	Thu,  9 Jun 2016 18:48:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8112238F0;
	Thu,  9 Jun 2016 18:48:13 -0400 (EDT)
In-Reply-To: <20160609213809.GA23059@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jun 2016 17:38:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3FA19CB4-2E94-11E6-8E9F-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296937>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 09, 2016 at 02:21:55PM -0700, Junio C Hamano wrote:
>
>> Lars Vogel <lars.vogel@gmail.com> writes:
>> 
>> > This helps contributors (like me) using editors which automatically create ~ copies of the changed data
>> >
>> > Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
>> > ---
>> 
>> We deliberately left this out and kept it out of .gitignore for the
>> past 10 years.  The justification was that use of Emacs is merely a
>> personal choice that is better served by .git/info/excludes; we do
>> not add .swp for vim users, either, for the same reason.
>
> I think a better choice than .git/info/excludes these days is
> ~/.config/git/ignore. Then it is associated with the user, not the
> project (which seems a better fit, since it is the user who is picking
> the editor; this should apply across all projects).

Yes, that is a better alternative you can use these days, of course.

Thanks.

As I said, however, I could support a move to add some selected
small number of common file extensions, as long as we have some
(social) mechanism to avoid churning this file every time somebody
new comes and complains their favourite editor or other tools are
not supported.
