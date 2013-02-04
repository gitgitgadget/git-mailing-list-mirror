From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add contrib/credentials/netrc with GPG support
Date: Mon, 04 Feb 2013 11:06:16 -0800
Message-ID: <7vvca7291z.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <7v7gmumzo6.fsf@alter.siamese.dyndns.org> <87pq0l5qbc.fsf@lifelogs.com>
 <20130131193844.GA14460@sigill.intra.peff.net> <87k3qrx712.fsf@lifelogs.com>
 <20130203194148.GA26318@sigill.intra.peff.net>
 <87sj5cvxnf.fsf_-_@lifelogs.com> <7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
 <87k3qoudxp.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 20:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2RNL-0001zc-FI
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 20:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab3BDTGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 14:06:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab3BDTGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 14:06:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2CEECC4D;
	Mon,  4 Feb 2013 14:06:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Q6Ri/CrbkkBPF04/zuOHx58b5Q=; b=H5mJ1Q
	AHovAt+1NfalFv7I76bYZ37/ikhCSqjiQjjHhrzwNpxc4jtVI7RYujsAqDyUksvO
	nzsKyH4Q5eQ1YnkPu7dpgCvaDbMJ00r9o4iCsoFptEFS4E+Qa4IGXjiPUvU5rzwa
	UXSoV9Xpn80kKHkhNS/XpmVXg8+946OPo0sm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fc+WKpkwxRzYxQtqgkYfKPeAQ/Wh0QSd
	rWv5xnIec9jpOpQz0pY5QyWO4MLWOTdhzHtaP8+CysNabCfAbFe/GaPRUJHF7LTF
	6n/lxlNxBBPJf7EWYtrRMsP/gNiv9cBsR3N7PmONeeFoEh3HxmE86hCsvLZThk0n
	cdEBjGtMApc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98260CC4C;
	Mon,  4 Feb 2013 14:06:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17D00CC4B; Mon,  4 Feb 2013
 14:06:18 -0500 (EST)
In-Reply-To: <87k3qoudxp.fsf@lifelogs.com> (Ted Zlatanov's message of "Mon,
 04 Feb 2013 13:33:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F46C3514-6EFD-11E2-98BF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215409>

Ted Zlatanov <tzz@lifelogs.com> writes:

> Sorry, I didn't realize contrib/ stuff was under the same rules.

I had a feeling that this may start out from contrib/ but will soon
prove to be fairly important to be part of the Git proper.

> It would help if the requirements were codified as the fairly standard
> Emacs file-local variables, so I can just put them in the Perl code or
> in .dir-locals.el in the source tree.  At least for Perl I'd like that,
> and it could be nice for the Emacs users who write C too.
>
> Would you like me to propose that as a patch?

I thought that we tend to avoid Emacs/Vim formatting cruft left in
the file.  Do we have any in existing file outside contrib/?

> Either way, I guessed that these settings are what you want as far as
> tabs and indentation (I use cperl-mode but perl-mode is the same):
>
> # -*- mode: cperl; tab-width: 8; cperl-indent-level: 4; indent-tabs-mode: t; -*-

Indent is done with a Tab and indent level is 8 places (check add--interactive.perl
and imitate it, perhaps?).

Thanks.
