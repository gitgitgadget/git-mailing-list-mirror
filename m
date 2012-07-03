From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Tue, 03 Jul 2012 10:16:46 -0700
Message-ID: <7vobnwwyrl.fsf@alter.siamese.dyndns.org>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net> <m2vci5n5r5.fsf@igel.home>
 <20120703032345.GA7143@sigill.intra.peff.net>
 <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
 <20120703051426.GA12965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 19:16:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm6id-0004rB-LQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 19:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933289Ab2GCRQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 13:16:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933201Ab2GCRQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 13:16:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA6687A6;
	Tue,  3 Jul 2012 13:16:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sc9D7kG7Dkro5AcjbtUTNXtvnDo=; b=KeR/rg
	plVjT+rCl1/3emhGmZMJMuy0vq0s9yUURJlKCbnhHLypK6J/cy8idvbE021FMbZv
	YEFUOePGLbiAk/HTeHRXWQxXGXUwep1w8isOQXwOD/JCx1rXgOGH8laSvTQrQhHP
	Ew0X32HAC+H4PoyqptFs5PKtAI9x/EiONuGhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DFOii/F0b+RoBtcWfhuL9j98KzZ0bfeU
	jrPooDw3BeF59wqtpR0i/enj4G9HmE2FaOU7Njobr5DgaO3asA9ZIvtfNLBlqbev
	yRF7wm1qT0D3i7Y01wMnjY1KF4Z5Cf9pultmCaBxbc3xBRfmNyWbDdPm1AKG8hh8
	6qX4KhB/3jk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A151887A4;
	Tue,  3 Jul 2012 13:16:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3974187A3; Tue,  3 Jul 2012
 13:16:48 -0400 (EDT)
In-Reply-To: <20120703051426.GA12965@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jul 2012 01:14:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF416120-C532-11E1-9825-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200919>

Jeff King <peff@peff.net> writes:

> Hmm. According to gettext(3):
>
>   ERRORS
>          errno is not modified.
>
> And googling for "gettext" and "errno" reveals several bugfixes in GNU
> gettext to make sure that gettext preserves errno. I wonder if there are
> systems where that is not the case, though; I don't know what non-GNU
> gettext implementations are in common use these days. I'd still be
> curious to hear what platform the server is for this bug report.

Yes, I am also curious.

Regardless, we may need your "save_errno" patch if the bulk of it
may have to be made conditional on NEED_SAVE_ERRNO_IN_GETTEXT=YesPlease
or something.

Thanks for digging.
