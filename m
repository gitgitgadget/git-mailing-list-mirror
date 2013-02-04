From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Mon, 04 Feb 2013 15:28:52 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87a9rju8l7.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<xa1tmwvk9gy1.fsf@mina86.com> <878v74vwst.fsf@lifelogs.com>
	<20130204201040.GA13272@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michal Nazarewicz <mina86@mina86.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2SfH-0000js-AC
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 21:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab3BDU25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 15:28:57 -0500
Received: from z.lifelogs.com ([173.255.230.239]:56307 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754919Ab3BDU24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 15:28:56 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 729DADE0CA;
	Mon,  4 Feb 2013 20:28:53 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <20130204201040.GA13272@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Feb 2013 15:10:40 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215417>

On Mon, 4 Feb 2013 15:10:40 -0500 Jeff King <peff@peff.net> wrote: 

JK> Technically you can speak a particular protocol on an alternate port:

JK>   https://example.com:31337/repo.git

JK> In this case, git will send you the host as:

JK>   example.com:31337

JK> You might want to map this to "port" in .autoinfo separately if it's
JK> available.

That would create the following possibilities:

* host example.com:31337, protocol https
* host example.com:31337, protocol unspecified
* host example.com, protocol https
* host example.com, protocol unspecified

How would you like each one to be handled?  My preference would be to
make the user say "host example.com:31337" in the netrc file (the
current situation); that's what we do in Emacs and it lets applications
request credentials for a logical service no matter what the port is.

It means that example.com credentials won't be used for
example.com:31337.  In practice, that has not been a problem for us.

Ted
