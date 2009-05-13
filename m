From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 22:57:12 +0200
Message-ID: <op.utvy5mie1e62zd@merlin.emma.line.org>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
 <20090512151403.GS30527@spearce.org>
 <20090512161638.GB29566@coredump.intra.peff.net>
 <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>
 <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Esko Luontola" <esko.luontola@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 22:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4LW1-0003GA-TG
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 22:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761316AbZEMU5Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 16:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758054AbZEMU5Q
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 16:57:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:38024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757188AbZEMU5P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 16:57:15 -0400
Received: (qmail invoked by alias); 13 May 2009 20:57:15 -0000
Received: from g225203118.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.225.203.118]
  by mail.gmx.net (mp043) with SMTP; 13 May 2009 22:57:15 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18+MMRORp4+NI5OV8HYR5QfgQG87NGMrx753MR0xS
	3IQO2V4BzHpR2a
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id A88BF94385;
	Wed, 13 May 2009 22:57:12 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119103>

Am 13.05.2009, 19:12 Uhr, schrieb Linus Torvalds =20
<torvalds@linux-foundation.org>:

> Use <stringprep.h> and stringprep_utf8_nfkc_normalize() or something =
to =20
> do the actual normalization if you find characters with the high bit =
=20
> set. And since I know that the OS X filesystems are so buggy as to no=
t =20
> even do that whole NFD thing right, there is probably some OS-X speci=
fic =20
> "use this for
> filesystem names" conversion function.

Sorry for interrupting, but NF_K_C? You don't want that (K for =20
compatibility, rather than canonical, normalization) for anything excep=
t =20
normalizing temporary variables inside strcasecmp(3) or similar. Probab=
ly =20
not even that. The normalizations done are often irreversible and also =
=20
surprising. You don't want to turn 2=C2=B3.c into 23.c, do you?

--=20
Matthias Andree
