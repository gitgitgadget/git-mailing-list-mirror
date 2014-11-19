From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Wed, 19 Nov 2014 14:34:12 -0800
Message-ID: <xmqq61earfa3.fsf@gitster.dls.corp.google.com>
References: <20141119013532.GA861@peff.net> <20141119013739.GC2135@peff.net>
	<20141119020009.GR6527@google.com> <20141119020451.GA2734@peff.net>
	<20141119020713.GT6527@google.com> <20141119222852.GA12236@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 23:34:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrDpP-0004be-7F
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 23:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933180AbaKSWeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 17:34:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932923AbaKSWeP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 17:34:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DF7120A2C;
	Wed, 19 Nov 2014 17:34:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RK6ZMommRYI13X036rjFs+E/+Nk=; b=ewAPIz
	UUNYBXOMlmWdAw6mtECnSKNrqj3kTbvcB0BdHuWJHCV5P5T6Z3JrLYrPw/QO3Nby
	mJXDXBvV/6OKKOLVyr8QjUvkekCmQuSS+LQwLNlJPy2eYUgCKQb8SdiQ6JOpnvey
	mOOen/J52XSebwoEQKvif5ib49NigKGIlBeGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pKlQ+w4zb9aies2/+uY+O8/mI++yNm9B
	OnSs/OXbl2NSckAYFBLitc0nNhuLbheRVOspUumZZm81duDjNifSviqNcLbLIFo9
	qm1+udj2ej/tQvdOUZ7wNSpn+/IQqpmZ8wQiLtUDVX8ENW6CM/oKbcy/Tz9FfeOb
	X++rSjVhgm4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94DF020A2B;
	Wed, 19 Nov 2014 17:34:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1567D20A2A;
	Wed, 19 Nov 2014 17:34:14 -0500 (EST)
In-Reply-To: <20141119222852.GA12236@peff.net> (Jeff King's message of "Wed,
	19 Nov 2014 17:28:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30706CD8-703C-11E4-9979-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So we still have to keep the last_errno handling in error_return.
> Meaning that we need to drop patch 2 (even though the other cases don't
> need errno saved/restore, since the goto does it unconditionally, we
> still need to set last_errno). And therefore patch 1 is not helping
> anyone (we could still apply it, but there's no immediate benefit).
> ...
> So here is that patch, with my explanation. Thanks for your patience in
> my running around in circles. :)

My head has been spinning, but I think I can relax now ~@~ ;-)

> Subject: lock_ref_sha1_basic: do not die on locking errors

Will queue; thanks.
