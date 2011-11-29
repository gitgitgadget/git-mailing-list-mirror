From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 11/13] strbuf: add strbuf_add*_urlencode
Date: Wed, 30 Nov 2011 00:26:20 +0100
Message-ID: <4ED56A1C.9050800@lsrfire.ath.cx>
References: <20111124105801.GA6168@sigill.intra.peff.net> <20111124110728.GI8417@sigill.intra.peff.net> <7vzkfessff.fsf@alter.siamese.dyndns.org> <20111129211950.GD1793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 00:26:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVX4L-0002vX-42
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 00:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670Ab1K2X02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 18:26:28 -0500
Received: from india601.server4you.de ([85.25.151.105]:38303 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab1K2X01 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 18:26:27 -0500
Received: from [192.168.2.104] (p4FFDA507.dip.t-dialin.net [79.253.165.7])
	by india601.server4you.de (Postfix) with ESMTPSA id 616832F8061;
	Wed, 30 Nov 2011 00:26:26 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111129211950.GD1793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186095>

Am 29.11.2011 22:19, schrieb Jeff King:
> On Tue, Nov 29, 2011 at 10:19:00AM -0800, Junio C Hamano wrote:
>=20
>>> +static int is_rfc3986_reserved(char ch)
>>> +{
>>> +	switch (ch) {
>>> +	case '!': case '*': case '\'': case '(': case ')': case ';':
>>> +	case ':': case '@': case '&': case '=3D': case '+': case '$':
>>> +	case ',': case '/': case '?': case '#': case '[': case ']':
>>> +		return 1;
>>> +	}
>>> +	return 0;
>>> +}
>>
>> Part of me wonders if we still have extra bits in sane_ctype[] array=
 but
>> that one is cumbersome to update, and the above should be easier to =
read
>> and maintain.
>=20
> We have 2 bits left. I did consider it, but it just seemed excessivel=
y
> cumbersome for something that really doesn't need to be that fast (if=
 it
> is indeed any faster than this case statement).

Sorry for my bikeshedding, but I'd paint it like this:

	return !!strchr("!*'();:@&=3D+$,/?#[]", ch);

Ren=C3=A9
