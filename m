From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/6] Disable IPv6 support for Haiku
Date: Mon, 18 Aug 2008 22:04:29 +0200
Message-ID: <20080818200429.GD3262@steel.home>
References: <7CCFCB0B-382F-4A94-B8A7-796156A73CEF@web.de> <20080817203335.GB6366@steel.home> <795912D9-BAA1-4E42-A533-435CB1BCCCAC@web.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andreas =?iso-8859-15?Q?F=E4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 18 22:06:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVAzF-0000IK-3X
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 22:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbYHRUEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2008 16:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYHRUEd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 16:04:33 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:24456 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYHRUEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 16:04:33 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44hO88yw==
Received: from tigra.home (Fa968.f.strato-dslnet.de [195.4.169.104])
	by post.webmailer.de (klopstock mo46) (RZmta 16.47)
	with ESMTP id D00c76k7IG8TLG ; Mon, 18 Aug 2008 22:04:30 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 66D34277AE;
	Mon, 18 Aug 2008 22:04:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4911956D2A; Mon, 18 Aug 2008 22:04:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <795912D9-BAA1-4E42-A533-435CB1BCCCAC@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92734>

Andreas F=E4rber, Mon, Aug 18, 2008 19:23:35 +0200:
> Am 17.08.2008 um 22:33 schrieb Alex Riesen:
>> Andreas F=E4rber, Sun, Aug 17, 2008 10:56:56 +0200:
>>> +ifeq ($(uname_S),Haiku)
>>> +	NO_IPV6 =3D YesPlease
>>> +endif
>>
>> Does Haiku have no IPv6 support at all, or it is just the getaddrinf=
o
>> and the like functions which are missing?
>
> Haiku does not yet have complete IPv6 support afaik (would've been a =
=20
> GSoC project), it does have getaddrinfo though. Not setting NO_IPV6 =20
> currently leads to compilation errors (redefinition of struct =20
> sockaddr_in), I assume that should be fixed on their side of things.

Ah, that's what it was...

> In the current series of patches I had not included a check for =20
> libnetwork in configure.ac, so that getaddrinfo does not get detected=
=2E =20
> Would you prefer to have it already detected, but to override it via =
the=20
> above Makefile line? (That works as well.) Or to have it detected but=
=20
> have the user manually pass NO_IPV6=3DYesPlease to avoid a future rev=
ert of=20
> that line?

I think your patch as-is will be preferred (it just works).
It is not a big deal to change it later.
