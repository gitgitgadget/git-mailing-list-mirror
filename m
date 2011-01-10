From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: explain diff.*.binary option
Date: Mon, 10 Jan 2011 09:59:07 -0800
Message-ID: <7vpqs463o4.fsf@alter.siamese.dyndns.org>
References: <vpqy670brcb.fsf@bauges.imag.fr>
 <20110105051807.GB5884@sigill.intra.peff.net>
 <vpqr5clsy8g.fsf@bauges.imag.fr>
 <20110109201003.GA4406@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 10 18:59:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcM1i-0007iH-TZ
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 18:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab1AJR7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 12:59:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab1AJR7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 12:59:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BED623E1A;
	Mon, 10 Jan 2011 12:59:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CzvSOfXRG0ueu1ctim37k0L0p/Q=; b=Cak3Xh
	on7J56eNS71jl2/ppv5fzrZjoMwA6Orelcj3IdIQmMU7dsN8Jeps82dpAH7W/g98
	BH4NcLHgeVfz9WftYs6eEkGReCkzbXdDqkcN75WeoE+52nzN6Q8N34luhIAiW0eS
	d1AqbAwlDp1/0C5b1K0ox+ljADqcs9zYQf4d8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0N7Lv/8dBgTHHUw8Wanvnuf4+3byZvg
	XWIoU7iLE9gbSPkHKg/Xw6CeZQ/PuWyKqIw+9AOk75fQ/VNLZukAI1tb6C+Bliru
	WKmXu8+NrrQN3heCRGft2rUAoJ1wYCH8gNP+2gf+JqN6IKdC3B2ZRZOkvmnIbjwA
	odroyE4XO6g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 765473E16;
	Mon, 10 Jan 2011 12:59:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5EF9C3E11; Mon, 10 Jan 2011
 12:59:49 -0500 (EST)
In-Reply-To: <20110109201003.GA4406@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 9 Jan 2011 15\:10\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D1653CE-1CE3-11E0-B664-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164889>

Jeff King <peff@peff.net> writes:

> This was added long ago as part of the userdiff refactoring
> for textconv, as internally it made the code simpler and
> cleaner. However, there was never a concrete use case for
> actually using the config variable.
>
> Now that Matthieu Moy has provided such a use case, it's
> easy to explain it using his example.

Thanks.  I take it that this documents 122aa6f (diff: introduce
diff.<driver>.binary, 2008-10-05) where you said...

    This patch introduces a "binary" config option for a diff
    driver, so that one can explicitly set diff.foo.binary. We
    default this value to "don't know". That is, setting a diff
    attribute to "foo" and using "diff.foo.funcname" will have
    no effect on the binaryness of a file. To get the current
    behavior, one can set diff.foo.binary to true.

I am scratching my head about the last sentence, though.  Shouldn't that
be "false"?  In the olden days, setting diff.foo.funcname made it text but
with this change it no longer is the case and instead binaryness is
determined by content inspection, so forcing "text" needs to be done by
saying "this is _not_ binary", no?
