From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sha1_name.c: add an option to abort on ambiguous refs
Date: Wed, 23 Mar 2016 16:45:42 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603231642580.4690@virtualbox>
References: <1458739840-15855-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-986215628-1458747943=:4690"
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:45:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aikyl-00032M-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 16:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbcCWPps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 11:45:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:56129 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbcCWPpr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 11:45:47 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LgNGi-1ZxH8d3WLs-00nfk8; Wed, 23 Mar 2016 16:45:43
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1458739840-15855-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:6Go3LYSpnRSpHa9+e7fSCogCfsIZp/+giWxyejxieaiz6Hh0wTB
 m1P3mneSmUxfHV3gh1J8eIW8qvf4hNoTIlUTBHfxMf5X+s9OUM5KdOgmX6lkA8ygZHjAtVR
 Q3Icr/9OvMuPf1ROgIbVwwXK2TyGVEpPoN6LG+czC9Xymc7q12wjbcUrwkqGQODyojZXk6A
 Li9oqnw5iCKfKgkRlfAQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zU1pkRVlj2A=:zYujK4LjM2GfaHcjLWPsH4
 jASy+EisWNOb9Cf/isiBrXxadSRU2kE+pJwkGISFQq8cFKpgfJwqS8SVQIu+QIggkcshVHmEV
 zCk3EIDIpm74AmKJDapKBi5jMoTbg43+U/f9k19woQaIKUigl1g3SjKoZCZIRA7UZplildm9i
 uer5+iu93txCBnGLqAqicAwWbQmnZSSvOmwXlZlqabN3+HdCtA4c3zGnNd7w1Q7qyBB0ZUEia
 sKSHtmaIxzCvdjXWSJfapNmwmb6WQdfhVtg788F3UraKZuvk8iVFxiYeA5u/c4s62E0Sv69wq
 km3LxMRTOqMNUxsm7ipeUJkoUPdEIjJc9REomOC1wOoVlwTmGaamfMJNOmEeNdPS0DGSuHq+p
 TPiDFxsYNWCCjDyEjyE1myCdzMbswJjQl2wy043EWKy6Jfrr9W9+leMIeeReE2UriVf3DkkhU
 VFVKSgNVQAZuuEQ2+NK7aNcJa2N7ZAFYssH2dWgCSHr/CnvCGhPo2BewL9EuJAmcWnA9tonIt
 OPxwWdNsRaQwWgw68ZVsbhshnm9GKOx2fFqWryr1J/0yc9eTFPsXft8C4EheT9/zvgzJBlgO+
 bk9ckPlZIMNvZgMz9ekJhYo1TZ42l1NeBSwnkWQrTA3rPqr679MDqaXUrjHIbL9kR7Brzeq96
 0yQEKVlD1eUU11n0/X08CSd3UNs6tbCO3Eq7oSvGW2HIFdZbNYZ6mkXI7mm667jydjPt0k7ES
 +Rry+xNh6xgm5EvNfFrJMe3xSL9254QMlw2PKSdk7l2A5FI42rfSHCNKnJ19YcgP9NevzxdZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289660>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-986215628-1458747943=:4690
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 23 Mar 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> There are cases when a warning on ambiguous refs may go unnoticed
> (e.g. git-log filling up the whole screen). There are also cases when
> people want to catch ambiguity early (e.g. it happens deep in some
> script). In either case, aborting the program would accomplish it.

Whenever I see a die() in code outside of builtin/*.c, I cringe. I do that
because it was *exactly* something like that that caused a serious
regression in the builtin am so that we had to resort back to spawning
separate processes *just so* that we could catch error conditions and
run certain code in that case.

Maybe there would be a way to do what you want to do that does not fly in
the face of libification? Maybe some strbuf with an atexit() that
accumulates fatal errors that might be hidden and that are then written at
the end of the program (colorfully, if isatty(2))?

Ciao,
Dscho
--8323329-986215628-1458747943=:4690--
