From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Sun, 16 Dec 2007 23:27:25 -0800
Message-ID: <7vir2xeq76.fsf@gitster.siamese.dyndns.org>
References: <20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	<20071213180347.GE1224@artemis.madism.org>
	<1197570521.28742.0.camel@hinata.boston.redhat.com>
	<1197571656.28742.13.camel@hinata.boston.redhat.com>
	<20071214040803.GA10169@sigill.intra.peff.net>
	<7vir31vmsn.fsf@gitster.siamese.dyndns.org>
	<20071214083943.GA24475@artemis.madism.org>
	<7v63z1qakt.fsf@gitster.siamese.dyndns.org>
	<20071215110311.GA11321@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4AOU-0000IT-J6
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 08:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761899AbXLQH1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 02:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761682AbXLQH1k
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 02:27:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760374AbXLQH1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 02:27:39 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 030105582;
	Mon, 17 Dec 2007 02:27:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C2595581;
	Mon, 17 Dec 2007 02:27:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68508>

Pierre Habouzit <madcoder@debian.org> writes:

>   Yep, let's do it then. Note that's the reason why I felt we need a
> manual page about this, because we should give some guidelines of what
> is safe for scripting.

There are some fallouts from the series, though.  I've fixed up git-tag
but I strongly suspect all of parseopt users now need careful auditing.
If we cannot be confident with the parseoptified commands within
reasonably short timeframe by -rc1, we may end up having to revert the
parseopt changes from them, which I'd rather avoid, but if you look at
the git-tag change (especially for -l) you would understand it.  The
"must stick" restriction feels Ok on paper but in practice it looks
rather draconian and very user unfriendly.

I'll be sending out two patches shortly.  The result will sit in 'pu'
waiting for an Ack and/or improvement, but that will happen only when I
got around pushing things out, which may come later than you see the
patches.
