From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Mon, 21 Mar 2016 13:01:55 -0700
Message-ID: <xmqqr3f3lhvw.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
	<xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
	<xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
	<56E96096.4020108@drmicha.warpmail.net>
	<CANYiYbFa5i-E0dYYj2dm4pHmQwLJfj3UBc3OspQz93HTP3C3Ng@mail.gmail.com>
	<CAA19uiSUV0C=WQAhgum9MM8r8NixMF8O0XOFxzywSJtBEcGNmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:02:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai61d-0003QU-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbcCUUCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:02:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754735AbcCUUB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:01:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84A4D4ED63;
	Mon, 21 Mar 2016 16:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EbHQk9ZGJ3lUW4ath6H7K3O+X8g=; b=wgCqiv
	Oj0aCyAE5upe8k93fmgUDcbgssAIuVxjtcYbFPqrH9HsAeOeAOYkmeUK5RlmwK9j
	I6vJHem4Pue7010nJBgXCPn4zZLf7Qf6Dtys+hNAZi1fY4TFfRg9neQESgLKv9Qf
	x+uOEdQAIL7n9bttJxxSjy4jsvgzksnENm9C8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jGHUknvHogMebxc+PoEhsC+YVKRxRLCL
	zc3X+pqKbF8pvs5YSk/sS28g0ldOjuy6V0ByKpnrZyGmCImGkNKd9piAwaQcGnJR
	o/C5sQV38RY1rLKL/9WKKlmzHZPHmDmr+TxExdL/ZMI8jDWWhOneEacjct9hUrhe
	nIxr2ydx+wI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46FCD4ED62;
	Mon, 21 Mar 2016 16:01:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 276F64ED5E;
	Mon, 21 Mar 2016 16:01:57 -0400 (EDT)
In-Reply-To: <CAA19uiSUV0C=WQAhgum9MM8r8NixMF8O0XOFxzywSJtBEcGNmQ@mail.gmail.com>
	(Michael J. Gruber's message of "Sun, 20 Mar 2016 16:11:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3FF0C32-EF9F-11E5-B4C5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289451>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I think this is a general question about how to track build
> products.  The proper place may be in a tree that is referenced
> from a note or so.

> Maybe I shouldn't consider git.pot a build product - I don't know,
> as I honestly don't know why we treat it the way we do.

I think your LaTeX output analogy is interesting.  When working with
other people editing a single document, each person may update the
build product (.dvi or .pdf or whatever) in his branch and when you
merge other people's work, this would create an unresolvable mess
but that is perfectly fine, because you wouldn't even attempt to
merge the build product.  Instead, you would merge the source
material, run the formatter, and pretend as if its output is the
result of the merging of .dvi or .pdf or whatever.

But then we need to step back and consider the reason why we keep
the build product in the first place.  Presumably that is to help
those who want to consume the build product without having the
toolchain to build from the source.  If that is the case, perhaps it
is also a valid workflow for these collaborating authors of a single
document not to update the build product, if they know that nobody
cares about how the final output looks like on their individual
fork, until their work is merged to some "mainline".

The primary consumers of git.pot build product are the l10n teams,
and I do not think that they want to (or it is practical to ask them
to) work on translating new messages on individual topics code-side
people work on.  So perhaps it is a valid workflow to leave git.pot
behind until i18n coordinator declares "it is time to catch up" and
regenerates it at some "snapshot" time in the development cycle.
