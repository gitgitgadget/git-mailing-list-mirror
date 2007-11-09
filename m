From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 00:20:22 +0100
Message-ID: <4734EB36.2030408@lsrfire.ath.cx>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045256.GD31760@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:21:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqd9w-0008PZ-Ji
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759891AbXKIXUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 18:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760824AbXKIXUn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:20:43 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54671
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760738AbXKIXUm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 18:20:42 -0500
Received: from [10.0.1.201] (p57B7F63C.dip.t-dialin.net [87.183.246.60])
	by neapel230.server4you.de (Postfix) with ESMTP id 79FDD873BA;
	Sat, 10 Nov 2007 00:20:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071109045256.GD31760@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64274>

Jeff King schrieb:
> On Fri, Nov 09, 2007 at 01:49:42AM +0100, Ren=E9 Scharfe wrote:
>=20
>> +	strbuf_expand(sb, format, placeholders, format_commit_item, (void =
*)commit);
>=20
> This void cast is pointless, since all pointers types convert implici=
tly
> to void pointers anyway. At best, it does nothing, and at worst, it
> hides an actual type error if the function signature or the type of
> 'commit' change.

When commit (of type const struct commit*) is implicitly converted to
void *, gcc complains because the "const" qualifier is silently dropped=
=2E
