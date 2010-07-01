From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] Documentation: 'cherry' does not cope well with merges from upstream
Date: Thu, 01 Jul 2010 14:33:18 -0700
Message-ID: <1278019489-sup-4929@pimlott.net>
References: <1278012954-sup-3724@pimlott.net> <20100701210919.GA4283@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	=?utf-8?q?Fr=C3=A9d=C3=A9ric_Bri=C3=A8re?= <fbriere@fbriere.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	=?utf-8?q?Bj=C3=B6rn_Steinbrink?= <b.steinbrink@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 23:33:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OURO5-0002Kn-Gw
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 23:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247Ab0GAVdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 17:33:24 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from pimlott.net ([72.249.23.100]:1348 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933123Ab0GAVdU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 17:33:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=default; d=pimlott.net;
	h=Received:Content-Type:Cc:Subject:From:To:In-reply-to:References:Date:Message-Id:User-Agent:Content-Transfer-Encoding;
	b=P8V+S5lVi93TIx0U89MPs9+vxaWOJW3QXX0erMfY0kuL3wqn2QQLpF6EdVY+zZM5J5jCT11+SBQ5trIrvVemhTAP/kGAYwUlZwEtaB0Aevc9KQpLpLEUeoWZRF6MGiBjwj4PvUF4NGmlijXYFtILM8hkPzh4gtJd7pmthX9oMRI=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.69)
	(envelope-from <andrew@pimlott.net>)
	id 1OURNm-0001jq-Q9; Thu, 01 Jul 2010 14:33:18 -0700
In-reply-to: <20100701210919.GA4283@burratino>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150087>

Excerpts from Jonathan Nieder's message of Thu Jul 01 14:09:19 -0700 20=
10:
> Example:
>=20
>  o---o---F---X'---G---U [upstream]
>           \        \
>            X----Y---M---T [topic]
>=20
> Suppose the author of the =E2=80=98topic=E2=80=99 branch starts from =
upstream
> commit F and makes a few changes.  One is applied upstream, and
> additionally there is some other useful upstream change, so he
> performs a merge to include the upstream updates into topic.
> The expected output from =E2=80=98cherry=E2=80=99 is:
>=20
>  + T
>  + Y
>  - X
>=20
> Consider the author of a different branch, also called =E2=80=98topic=
=E2=80=99, but
> this one starts from commit G.  Some infrastructure from an existing=20
> branch is needed, so first she merges that.  Then she adds her own
> commit.  The expected output from =E2=80=98cherry=E2=80=99 is:
>=20
>  + T
>  + Y
>  + X
>=20
> since none of the new commits have been applied upstream since
> the fork point.
>=20
> =E2=80=98cherry=E2=80=99 cannot distinguish between these two cases

Thanks for the awesome explanation!  (I looked at the code but would no=
t
have pulled this understanding.)  I would still say the first output is
the more reasonable: it's more likely (in my estimate) the wanted
result, and in the case where it's not it's at least easily
comprehended. =20

Anyway, the doc patch helps, and I would love git cherry --full.

Andrew
