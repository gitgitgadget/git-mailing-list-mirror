From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add contrib/credentials/netrc with GPG support
Date: Mon, 04 Feb 2013 15:10:45 -0800
Message-ID: <7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
 <7v7gmumzo6.fsf@alter.siamese.dyndns.org> <87pq0l5qbc.fsf@lifelogs.com>
 <20130131193844.GA14460@sigill.intra.peff.net> <87k3qrx712.fsf@lifelogs.com>
 <20130203194148.GA26318@sigill.intra.peff.net>
 <87sj5cvxnf.fsf_-_@lifelogs.com> <7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
 <87k3qoudxp.fsf@lifelogs.com> <7vvca7291z.fsf@alter.siamese.dyndns.org>
 <87lib3uats.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2VBv-0005cl-QT
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 00:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141Ab3BDXKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 18:10:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265Ab3BDXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 18:10:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18F3EBBD6;
	Mon,  4 Feb 2013 18:10:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UckF9qq89b1kcMSGy5bILx0aDv8=; b=YPUBrB
	MpNrjRgTAAA5MT0H9ypf/03mMgNrBWP1coDF6wn4X3yfIV5HkuU6kz4V2QnzGmSM
	2YUg6LZdtZdWkhKuCfJ8ePBuQI3LoM5yELfzn+lfQFuVGW7bQMcA+UExxq4F2KzT
	M4HxdbjGi+QXPwgX/FYMykQv4kIZmdSzGFYdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oNyOxSft+VcZMA1M5pZdZ7IBx7wT6kcX
	Lu1rWmj2479nwvBjsY0NlTmgzQ/MJYu1lR9bBecc3OOuVDTNyE4vs48u2JBdKtNY
	PxZU7GrWxh9KWQPHiu5j27WyNxxxh95dgZvkatMO9B+OwAKlyf0OGR+UyhSLxDS4
	vr8Ht6CFPTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A0FDBBD5;
	Mon,  4 Feb 2013 18:10:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69F7FBBC4; Mon,  4 Feb 2013
 18:10:47 -0500 (EST)
In-Reply-To: <87lib3uats.fsf@lifelogs.com> (Ted Zlatanov's message of "Mon,
 04 Feb 2013 14:40:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C076D74-6F20-11E2-B9A0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215427>

Ted Zlatanov <tzz@lifelogs.com> writes:

> JCH> I thought that we tend to avoid Emacs/Vim formatting cruft left in
> JCH> the file.  Do we have any in existing file outside contrib/?
>
> No, but it's a nice way to express the settings so no one is guessing
> what the project prefers.  At least for me it's not an issue anymore,
> since I understand your criteria better now, so let me know if you want
> me to express it in the CodingGuidelines, in a dir-locals.el file, or
> somewhere else.

Historically we treated this from CodingGuidelines a sufficient
clue:

    As for more concrete guidelines, just imitate the existing code
    (this is a good guideline, no matter which project you are
    contributing to). It is always preferable to match the _local_
    convention. New code added to git suite is expected to match
    the overall style of existing code. Modifications to existing
    code is expected to match the style the surrounding code already
    uses (even if it doesn't match the overall style of existing code).

but over time people wanted more specific guidelines and added
language specific style guides there.  We have sections that cover
C, shell and Python, and I do not think adding Perl would not hurt.
