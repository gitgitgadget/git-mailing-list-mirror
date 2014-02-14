From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Fri, 14 Feb 2014 08:13:24 -0800
Message-ID: <xmqqbny9k6zf.fsf@gitster.dls.corp.google.com>
References: <20140210191521.GA3112@sigill.intra.peff.net>
	<20140210212931.GA16154@sigill.intra.peff.net>
	<xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
	<20140211200445.GA27946@sigill.intra.peff.net>
	<xmqqzjlxnqvw.fsf@gitster.dls.corp.google.com>
	<20140212214753.GA6799@sigill.intra.peff.net>
	<xmqq38jom037.fsf@gitster.dls.corp.google.com>
	<xmqqfvnmlsb2.fsf@gitster.dls.corp.google.com>
	<20140214095841.GA27161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 14 17:13:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WELOW-0002RS-5v
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 17:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaBNQNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 11:13:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbaBNQNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 11:13:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7BB6C02E;
	Fri, 14 Feb 2014 11:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rDiV6Sc8jpud3rOspe9RBhxmPrQ=; b=LgAhX2
	3YBp0o9E+8VDM46wsa8alu0+rZ95yHUDmhwfnYTdG5MEmeSDsQN4Yjm0GPm+GHv7
	hxQkkUQRGNegR9D0cBqlucJqwoY6tm2IV1TSNQ4VieCmH8QvDrhXTvL29minNphs
	erGYB8WICFHBaXbcAwreFcN5m5h0dZo9pS0gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sn/mLbQSMtf2L/s0CEaG+v0WsJVngY9K
	LEhNDW+EJ8WMKxtcR44mLC8cKJ8mqyagRka8aW8fgoFpHmrSTS3k6RQ/UPSeAtMV
	/ey9GhfWqFt4CzGrb+3BZCylfWTuBnBTRzG8Q10uQWWDYF22aa8dmFJcj1C2EVND
	mpNekeVxhBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 492F36C02C;
	Fri, 14 Feb 2014 11:13:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3B1C6C026;
	Fri, 14 Feb 2014 11:13:26 -0500 (EST)
In-Reply-To: <20140214095841.GA27161@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 14 Feb 2014 04:58:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EFA2A81C-9592-11E3-B5EE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242107>

Jeff King <peff@peff.net> writes:

>>  - We may want to do something similar in cvsserver and git-gui to
>>    make them more robust.
>> 
>>    $ git grep -e true --and -e 1 --and -e yes
>
> I assume the "something" here is to respect bool options more
> consistently?

Yeah, mostly by employing your 'git -c magic.var=X config --bool'
trick and check only for 'false' and 'true', instead of keeping a
hard-coded logic like the lines that hit the above query do.

> I have no problem with that, but nor do I care too much
> about those programs (that is partially laziness, but also partially
> that I do not want to deal with introducing a regression).

True, too ;-)

>>  - Do we want to do something similar to GIT_TEST_CREDENTIAL_HELPER?
>
> No, it is not a boolean. It is a bit of a hack, but it is meant to be
> used like:
>
>   GIT_TEST_CREDENTIAL_HELPER=foo ./t0303-*
>
> to test some random git-credential-foo you have in your PATH. There is
> nothing to run "by default" there.

Ah, OK.  I was only grepping for "test -z .*GIT_TEST_".
>> tri-state is "auto" (or empty), but report an error when it is
>
> You probably want to drop this "or empty" or change it to "or unset",

Thanks, I totally missed that.
