From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: introduce CHILD_PROCESS_INIT
Date: Mon, 18 Aug 2014 09:59:02 -0700
Message-ID: <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
References: <53EFE15B.7030805@web.de> <53F05DE2.5080806@kdbg.org>
	<20140817084832.GL23808@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:59:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJQHM-0005Wz-1K
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 18:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaHRQ7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2014 12:59:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53326 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590AbaHRQ7O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2014 12:59:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 414FA305D4;
	Mon, 18 Aug 2014 12:59:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kdlN02Wg9Jhf
	PlTrA6PaOBeEokw=; b=vCk2suvC3ssUv54IjJn6Bgvg8qMzYNqEIFTTPu/gX2Kk
	QMoWD7HxVGDEfFW9CTSSXT9JgrR+ZcuEDBEjDUCobX7fdmI16yFET8vslcWJDQQe
	4fdhlKCLTzuQrJNT8c44ZlBTrBvVrm6xghWPnST1Lefs4pT6PrSV6AsEf5+HQ4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nfCISJ
	0nKPYqTyVfSV/83jkzOsPi7MPEBiP80fC+cKCOL1ZMFVz2WH+CrlXzYyVO0/mG61
	ZbFZhB6OaES8o5835ntO1zrf7J5qjhCR0OKQ9vBgy4R80E0415Wds8IDB9T9jSXl
	8xqdg+a0DfNnM+1YjXcNzRqo/IBPYGHazIm54=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3833A305D2;
	Mon, 18 Aug 2014 12:59:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7BED8305C3;
	Mon, 18 Aug 2014 12:59:04 -0400 (EDT)
In-Reply-To: <20140817084832.GL23808@peff.net> (Jeff King's message of "Sun,
	17 Aug 2014 04:48:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F5C7A34E-26F8-11E4-97B7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255400>

Jeff King <peff@peff.net> writes:

> I'm a little worried, though, that use sites without initializers wou=
ld
> be left behind. For example, git_proxy_connect uses xcalloc to alloca=
te
> the child_process, which results in all-bits-zero. If we want to star=
t
> caring about the initialization, we probably need to provide a
> child_process_init() function and use it consistently.

Thanks.  Perhaps I can expect a v2 from Ren=C3=A9?
