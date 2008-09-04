From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Thu, 04 Sep 2008 17:47:07 +0200
Message-ID: <48C002FB.9010401@lsrfire.ath.cx>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 04 17:48:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbH4L-00009w-56
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 17:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbYIDPrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2008 11:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbYIDPrQ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 11:47:16 -0400
Received: from india601.server4you.de ([85.25.151.105]:49090 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYIDPrP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 11:47:15 -0400
Received: from [10.0.1.200] (p57B7E7FB.dip.t-dialin.net [87.183.231.251])
	by india601.server4you.de (Postfix) with ESMTPSA id E460C2F8045;
	Thu,  4 Sep 2008 17:47:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080904035139.GA28123@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94939>

Jeff King schrieb:
> On Thu, Sep 04, 2008 at 12:06:18AM +0200, Ren=C3=A9 Scharfe wrote:
>> +	case 'd':
>> +		if (add_again(sb, &c->decoration))
>> +			return 1;
>> +		format_decoration(sb, commit);
>> +		c->decoration.len =3D sb->len - c->decoration.off;
>> +		return 1;
>=20
> The add_again chunk code is for things that take a long time (like
> finding the shortest abbreviation for some hashes). I'm not sure this
> counts as "long", as it is just doing a hash lookup on the decoration=
=2E
> On the other hand, I doubt the extra couple of bytes used hurts much.

Yes, you're right -- let's do without caching at first.  If it turns ou=
t
that we're too slow we can easily add it later.

Thanks,
Ren=C3=A9
