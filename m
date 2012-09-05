From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive --format zip utf-8 issues
Date: Wed, 05 Sep 2012 21:36:32 +0200
Message-ID: <5047A9C0.9020200@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx> <5026D081.2040906@tu-clausthal.de> <20120830222603.GA20289@sigill.intra.peff.net> <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 21:37:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9LPJ-0000vx-6L
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 21:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab2IETgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Sep 2012 15:36:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:42076 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab2IETgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 15:36:52 -0400
Received: from [192.168.2.105] (p4FFD8565.dip.t-dialin.net [79.253.133.101])
	by india601.server4you.de (Postfix) with ESMTPSA id DDCD6FD;
	Wed,  5 Sep 2012 21:36:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <7vehmh8prt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204841>

Am 04.09.2012 23:03, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>> +	if (has_non_ascii(path)) {
>
> Do we want to treat \033 as "ascii" in this codepath?  The function
> primarily is used by the log formatter to see if we need 8-bit CTE
> when writing out in the e-mail format.

Argh, yes, I'd think so. The function name mislead me.  This won't=20
matter for compatibility testing, but should be corrected before inclus=
ion.

Just checked: unzip strips the ESC character when extracting (whether=20
the UTF-8 flag is set or not) and 7-Zip replaces it with an underscore.=
=20
The built-in ZIP extractor of Windows 7 skips such a file; it doesn't=20
even show up in archive directory listings.

Ren=C3=A9
