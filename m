From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: [PATCH 1/6] Disable IPv6 support for Haiku
Date: Mon, 18 Aug 2008 19:23:35 +0200
Message-ID: <795912D9-BAA1-4E42-A533-435CB1BCCCAC@web.de>
References: <7CCFCB0B-382F-4A94-B8A7-796156A73CEF@web.de> <20080817203335.GB6366@steel.home>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 19:25:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV8TY-0002o3-Qq
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 19:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbYHRRX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2008 13:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbYHRRX7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 13:23:59 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60499 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbYHRRX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2008 13:23:59 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id B184DE9144E4;
	Mon, 18 Aug 2008 19:23:57 +0200 (CEST)
Received: from [91.18.108.215] (helo=[10.0.1.1])
	by smtp08.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KV8ST-00089G-00; Mon, 18 Aug 2008 19:23:57 +0200
In-Reply-To: <20080817203335.GB6366@steel.home>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1/99kKjqIZqqfzbjFjLos1ZUVshzcXtvDvJJp+t
	MX001PjXFvZV4XQm9mZCOxUwc8zBHlFtPH8aSVCs8vRx4WE8vL
	Ug0OyzSWsu/sfX08/Cpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92718>


Am 17.08.2008 um 22:33 schrieb Alex Riesen:

> Andreas F=E4rber, Sun, Aug 17, 2008 10:56:56 +0200:
>> +ifeq ($(uname_S),Haiku)
>> +	NO_IPV6 =3D YesPlease
>> +endif
>
> Does Haiku have no IPv6 support at all, or it is just the getaddrinfo
> and the like functions which are missing?

Haiku does not yet have complete IPv6 support afaik (would've been a =20
GSoC project), it does have getaddrinfo though. Not setting NO_IPV6 =20
currently leads to compilation errors (redefinition of struct =20
sockaddr_in), I assume that should be fixed on their side of things.

In the current series of patches I had not included a check for =20
libnetwork in configure.ac, so that getaddrinfo does not get detected. =
=20
Would you prefer to have it already detected, but to override it via =20
the above Makefile line? (That works as well.) Or to have it detected =20
but have the user manually pass NO_IPV6=3DYesPlease to avoid a future =20
revert of that line?

Andreas
