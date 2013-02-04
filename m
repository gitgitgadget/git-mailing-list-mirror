From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support
Date: Mon, 04 Feb 2013 16:32:49 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87vca7sr26.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:33:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Tf7-0004hu-Jt
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 22:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab3BDVcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 16:32:51 -0500
Received: from z.lifelogs.com ([173.255.230.239]:41486 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab3BDVcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 16:32:50 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 07368DE0CA;
	Mon,  4 Feb 2013 21:32:50 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <20130204211726.GB13186@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Feb 2013 16:17:26 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215423>

On Mon, 4 Feb 2013 16:17:26 -0500 Jeff King <peff@peff.net> wrote: 

JK> Do you need to quote "\n" here?

Fixed.

JK> Hmm, so it's not an error (just a warning) to say:

JK>   git credential-netrc -f /does/not/exist

JK> but it is an error to say:

JK>   git credential-netrc

JK> and have it fail to find any netrc files. Shouldn't the latter be a
JK> lesser error than the former?

Fixed, they should both exit(0).

>> +	next unless m/([^=]+)=(.+)/;

JK> Should this regex be anchored at the start of the string?

Fixed.

>> +	printf STDERR "searching for %s = %s\n", $_, $q{$_} || '(any value)'
>> +	 foreach sort keys %q;
JK> Leftover one-char indent.

Fixed.

Ted
