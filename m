From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 11/13] strbuf: add strbuf_add*_urlencode
Date: Wed, 30 Nov 2011 06:41:37 +0100
Message-ID: <4ED5C211.6040401@lsrfire.ath.cx>
References: <20111124105801.GA6168@sigill.intra.peff.net> <20111124110728.GI8417@sigill.intra.peff.net> <7vzkfessff.fsf@alter.siamese.dyndns.org> <20111129211950.GD1793@sigill.intra.peff.net> <4ED56A1C.9050800@lsrfire.ath.cx> <20111130032028.GA24704@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 06:41:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVcvZ-0005Rt-OP
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 06:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab1K3Flq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Nov 2011 00:41:46 -0500
Received: from india601.server4you.de ([85.25.151.105]:38477 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1K3Flp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 00:41:45 -0500
Received: from [192.168.2.104] (p4FFDA507.dip.t-dialin.net [79.253.165.7])
	by india601.server4you.de (Postfix) with ESMTPSA id 64CFB2F8061;
	Wed, 30 Nov 2011 06:41:44 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111130032028.GA24704@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186101>

Am 30.11.2011 04:20, schrieb Jeff King:
> On Wed, Nov 30, 2011 at 12:26:20AM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>>>>> +static int is_rfc3986_reserved(char ch)
>>>>> +{
>>>>> +	switch (ch) {
>>>>> +	case '!': case '*': case '\'': case '(': case ')': case ';':
>>>>> +	case ':': case '@': case '&': case '=3D': case '+': case '$':
>>>>> +	case ',': case '/': case '?': case '#': case '[': case ']':
>>>>> +		return 1;
>>>>> +	}
>> [...]
>> Sorry for my bikeshedding, but I'd paint it like this:
>>
>> 	return !!strchr("!*'();:@&=3D+$,/?#[]", ch);
>=20
> I was always under the impression that computed jumps via "switch" wo=
uld
> out-perform even an optimized strchr. Of course, I never tested. And =
I
> doubt performance is even relevant here, and I admit I don't care ove=
rly
> much. I find them both equally readable.
>=20
> I'm going to leave it as-is unless somebody else wants to say "I
> strongly prefer version X".

Sure, the second one is significantly slower than the first one.  I jus=
t
prefer it based one its looks in case performance doesn't matter, but
that's probably just me being (sometimes too) fond of terseness. :)

Ren=C3=A9
