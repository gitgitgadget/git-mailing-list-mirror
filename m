From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsck: treat a NUL in a tag header as an error
Date: Fri, 20 Nov 2015 21:18:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511202118340.1686@s15462909.onlinehome-server.info>
References: <564DF6BE.6020609@web.de> <564DF7FB.3090704@web.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-2092968461-1448050734=:1686"
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:19:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzs9T-0003pL-MB
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 21:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163412AbbKTUTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 15:19:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:63869 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162547AbbKTUTN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 15:19:13 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LmeGF-1aY6xx2pql-00aB9x;
 Fri, 20 Nov 2015 21:18:54 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <564DF7FB.3090704@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:SgaBJewjAIQtBHuaV//DU8qHlkTyFY6u4ykAdXSWDeSltwuQ3Yh
 NLPbCT1NAg/nRsKWAxphgyhQdBcuk2AQ7fF0vTCSwc+quh+aHbZj9Q+vg+UoqLF5pKhkAr7
 4OZXLUmdDhqM+0hcILusr/vc50yMLcPg+6mHCWhXPzB3RnAk8TwUYbGuAH3gqjnIqXJci63
 axLidbh/ZdDdKpFhP9DEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VtzObfAxLuQ=:+KkLAtsl4qc+gjc6Uom7nN
 EmBnSbTd90JpWVW2Pzl1gz9jiOJ59mGnEA1oWg+YZugB6wmtUntsQ488pVtrS00ulaqykb0MW
 ht0mbSH9dxkJjIXjaWGZInzUwQ/SXQmeuaDFy/4eT9Ywqh4ikKKpsxKLrOPnqT4vANMv/NUOR
 pveqG2uh7jMZIYZj5/spRus/sWGIRXb+17Eg9sFCAuMU/r7XNBCUbkZ3uicpVfZUuPROr1kfM
 aj6S0F83ZPNBbUtUY8hxovN5ztNhRCD037bISrkxL5FobJ+Bui7Dm9JhnGPOx/9tNuFmkDn1O
 UzMtMKQhmMMjjlr6NOBq/zj7XzjzfGkAIZPy6m1ET99nhCqqc6ybL9iuIc7GUOKsz4zaznjrX
 XX0d+r4ySu6XH/D29XRG9evqxnWvZ/nsyc4ETXG72ERRe6MnsM1KBG5FAgqh/s8Yob+BzM6EM
 M5z8J8oztGnh9bJPgVukvcFF1YFsdWkQtIL0Y6pxBOoEa4RCVr1An2NafiD1ZcuODLypFIgcX
 HOzylV6cPV1meyrMhNMkZnAYshn+I6u5cljH6l1sPGejWG+Fizkox6SJJDs1x53VNzcWzgP02
 34o/3c3vl7fKrJhPaRQSTzUirspQHiUQz4G1amOjLVPUpG0AXiIwdUqfeGV1DJGEUWsAQ+BHH
 GawRNNOv1KSiX5mGYb9b8KaZpAi38gWbjZtcCVgFs9H4asny7CeRCwW1ZRVLjRrAShzx4Q+SA
 lPAXcDZPRRSrVnoCXQdISJ2LUeRCtVnd14RDojwIP5jyvFi/x49Kb0BFX2mst0OAxAocc7Nq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281529>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-2092968461-1448050734=:1686
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Thu, 19 Nov 2015, Ren=C3=A9 Scharfe wrote:

> We check the return value of verify_header() for commits already, so do
> the same for tags as well.

Thanks for catching and fixing my bug!

Ciao,
Dscho
--1784107012-2092968461-1448050734=:1686--
