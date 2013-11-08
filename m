From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 08 Nov 2013 09:30:31 -0800
Message-ID: <xmqqppqaol6w.fsf@gitster.dls.corp.google.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
	<1383212774-5232-2-git-send-email-artagnon@gmail.com>
	<xmqq38nh411p.fsf@gitster.dls.corp.google.com>
	<CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
	<xmqqli182mde.fsf@gitster.dls.corp.google.com>
	<CALkWK0k-8noAJbgzPx3NEx-ucUdZoS4VmqNCKjm3R_5eqFnR7w@mail.gmail.com>
	<xmqqzjpkyqtf.fsf@gitster.dls.corp.google.com>
	<CALkWK0k0wxoK-MZk-KXiUiUgxVBKQGROFJBZbRs2LjNLA9iopA@mail.gmail.com>
	<xmqqvc045bvq.fsf@gitster.dls.corp.google.com>
	<CALkWK0=w1G2O_W1LnfstqzaMjOQ0GWqJXeeRN4ymfsvohQBfyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 18:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeptI-0005M1-HR
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 18:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707Ab3KHRag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 12:30:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756953Ab3KHRaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 12:30:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EED7E4F426;
	Fri,  8 Nov 2013 12:30:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eVwVyJ7to14xkNB5ucq00DjXZck=; b=EMyBl5
	4XlpQwOfArkYMbDXKgXa6av/zDXd+0Tv4lS3XcN0rJZMjDlD+JIBGT60VC61IVag
	EX0bABzSclAzQxmurwopvbdZxmeHDT2WhwzMFAUVfPwrCNlenNVTtftWZb8pqJX0
	IhOMDh9MsdJhugW5qSaps00bFVMicuPzFk4g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XoF5hS7uQAteyYIqGVwqXI90JG6kmAdr
	IQWjjxx6CJUnRT9BO2bPVZganGzwe94kLkZuhfTTxOmEzXoxQEvFwSTg6dMFmYiI
	MCOkmqtQCTjDqgk0THgohBXpS0U/SilG8KHrLOnK1lyyyOA0X1C41y6D9N9gORSt
	P014RTy6CsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0C574F425;
	Fri,  8 Nov 2013 12:30:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FFCB4F424;
	Fri,  8 Nov 2013 12:30:34 -0500 (EST)
In-Reply-To: <CALkWK0=w1G2O_W1LnfstqzaMjOQ0GWqJXeeRN4ymfsvohQBfyA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 8 Nov 2013 20:14:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 794B5496-489B-11E3-85D0-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237458>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ... %C(...) is
> different in that it doesn't actually output anything, but changes the
> color of tokens following it. While I'm not opposed to %(color:...), I
> would prefer a color syntax that is different from other-token syntax,
> like in pretty-formats.

You may prefer it, but I do not see why users prefer to memorize
that a magic that consumes no display output columns uses a syntax
different from all the other magic introducers that follows %(name
of the magic with string after colon to give more specifics to the
magic) syntax.

In all honesty, the %XY mnemonic syntax in pretty-format is a
syntactic disaster.  It is perfectly OK to have a set of often used
shorthand, but because we started without a consistent long-hand, we
ended up with %Cred and %C(yellow), leading us to a nonsense like
this (try it yourself and weep):

    $ git show -s --format='%CredAnd%CyellowAreNotTheSameColor'

It would have been much saner if we started from %(color:yellow),
%(subject), etc., i.e. have a single long-hand magic introducer
%(...), and added a set of often-used short-hands like %s.

I am not opposed to unify the internal implementations and the
external interfaces of pretty, for-each-ref and friends, but
modelling the external UI after the "mnemonic only with ad hoc
additions" mess the pretty-format uses is a huge mistake.
