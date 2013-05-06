From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Mon, 06 May 2013 10:11:26 -0700
Message-ID: <7vd2t4rq2p.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
	<CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
	<7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
	<CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
	<7vvc6xt5ov.fsf@alter.siamese.dyndns.org>
	<CA+gHt1Aq+Hi5Uf-s+q5WaigHXP1Qyq100N=C4x4pwFf8-Q=GcA@mail.gmail.com>
	<CA+gHt1DAy+OF-A8PiANM8k3=HdpsH8B-EWV5a3Dqv9svxCbZfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon May 06 19:11:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZOwn-0003QN-F2
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 19:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab3EFRL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 May 2013 13:11:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525Ab3EFRL3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 13:11:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 848441C516;
	Mon,  6 May 2013 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lk5cCG5xkDK9
	86SH78fLE3tcQ/8=; b=tFVSOtzRn3IeCWdHIcv1lkMKOtllJeX6L6UKFHJD9UoZ
	6v4qlwXZOCATduZQE5529Wc/xtSEBV8vsHB19YASHJkzSfZwivDCfkyhgP/TcYMl
	vs6Lz2Lyca5ziF2NwB9e63qDTzt6UpSQIcft38AtwQkbr2DJESp9scziA67o8Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OqyQYH
	lHG3XwsfYlPDof6NHTJeeNWK14fnZlgyFs/rqI3AcPY7ZvtsMMa2kzXbLTRENTii
	rPd303oM7R3QNSsOp2RuoIDtjjnDiRgopQoRzu3kVE4UF3wgYtMWeyrIjLFOrk8z
	DLSvVUuB84bLNJWwTF4EPt2n+N/tDue30mLI0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 793F91C515;
	Mon,  6 May 2013 17:11:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDF131C50E;
	Mon,  6 May 2013 17:11:27 +0000 (UTC)
In-Reply-To: <CA+gHt1DAy+OF-A8PiANM8k3=HdpsH8B-EWV5a3Dqv9svxCbZfA@mail.gmail.com>
	("Santi =?utf-8?Q?B=C3=A9jar=22's?= message of "Mon, 6 May 2013 03:04:29
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD2E0EC0-B66F-11E2-B0D4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223474>

Santi B=C3=A9jar <santi@agolina.net> writes:

> The next question could be: why not make it work with $url too? As in=
:
>
> $ git merge git://git.kernel.org/pub/scm/git/git.git//master

You need to remember "merge" is a local operation, working in your
local repository.  Like it or not, the UI of Git makes distinction
between operations that are local and those that go to other
repositories (e.g. "git pull").

That of course does _not_ prevent you from writing an alternative UI
"got merge <anything>" that interprets <anthing> part and invokes
"git merge" or "git pull" as its helper (after all, Git is designed
to be scripted).
