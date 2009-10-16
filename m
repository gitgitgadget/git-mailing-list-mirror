From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add proof-of-concept
 %[w(width,in1,in2)<<any-string>>%] implementation
Date: Fri, 16 Oct 2009 16:23:20 -0700
Message-ID: <7v7huurkif.fsf@alter.siamese.dyndns.org>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
 <m33a5jfc6p.fsf@localhost.localdomain>
 <7v3a5jupr7.fsf@alter.siamese.dyndns.org>
 <200910170020.01756.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 01:24:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myw9O-0006Sf-U2
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 01:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbZJPXX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 19:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbZJPXX2
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 19:23:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbZJPXX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 19:23:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EFAC7AAE4;
	Fri, 16 Oct 2009 19:23:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nry25Xqd0IVQPUw+vXxszc59ZUY=; b=ucms4+
	l9QyrrywQfWp2UuR9zewL0BAfwd9f1Gmf79pVPfrhjygKqVUUnhDSM693mGmr3hY
	+wr+ZwBcydS9cLgLiDqJFp6Oe8Rl83yVgpZoQwHAqQj6nW/XXCr5zlJKZ9vlo9lN
	Ts+4elcOV/KsshbaX8Zz95k2tNlyl3i09QNFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HtJajhY6UikmCTDE96h1FUGFcOhsfTGj
	rDKA6no+Q7ifeHYW3RbC1/Q0eVEr5zt2saiWKGx/7RfamFZq2ZBQK+lKi3vB8JK+
	uOVAF8SnW47xK6FFXml1JHBVghOALg/zNCwo7XKUOhHPC7dYmcBK7qY6I2kAGHgF
	7wRZts7QskQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 555C37AAE2;
	Fri, 16 Oct 2009 19:23:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE0C37AAE1; Fri, 16 Oct 2009
 19:23:21 -0400 (EDT)
In-Reply-To: <200910170020.01756.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat\, 17 Oct 2009 00\:19\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8597148-BAAA-11DE-AC0C-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130536>

Jakub Narebski <jnareb@gmail.com> writes:

> I think better solution might be to give _string_ to use for initial and
> subsequent indent rather than number of spaces... well, at least more
> generic one, allowing one to use e.g. "\t" (TAB) character to indent,
> or indent in the following way:

I do not see there is anything _better_ or _worse_.  It may simply be a
useful _addition_.  I'd usually say "care to send in a patch?" here, but
given that the general framework and the "wrap like the shortlog" hasn't
been plugged-in yet, there is no need to rush.

> But even with original w(<width>,<indent1>,<indent2>) we can get output
> of bare "git log" using pretty format... well, almost; it would be the
> same if there was ability to put infinite width, and there doesn't seem
> to be specifier for the whole, unchanged commit message (subject,
> unwrapped + separating lines + body).

I think I already discussed this when I sent out %s%+b patch.  You would
need to adjust and apply both series, but essentially it would become
something like:

    %s%+[w(-1,4,4)%b]

I.e. a single subject line, potentially followed by a LF and body indented
by 4-place, but the LF will be there only when the body is not empty.
