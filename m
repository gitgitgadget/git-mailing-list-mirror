From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 23:43:07 +0100
Message-ID: <m2ei66ofes.fsf@igel.home>
References: <20110316095632.GA8277@elie>
	<1300272453-25891-1-git-send-email-cmn@elego.de>
	<20110316105214.GB8277@elie>
	<1300273819.7214.12.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzzR0-0007rp-0U
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 23:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab1CPWnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 18:43:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50714 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab1CPWnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 18:43:12 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DC51B188A199;
	Wed, 16 Mar 2011 23:43:09 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id E34F71C000B9;
	Wed, 16 Mar 2011 23:43:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id AfMYZfvyhset; Wed, 16 Mar 2011 23:43:09 +0100 (CET)
Received: from igel.home (ppp-88-217-100-5.dynamic.mnet-online.de [88.217.100.5])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 16 Mar 2011 23:43:09 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id B462CCA2A0; Wed, 16 Mar 2011 23:43:08 +0100 (CET)
X-Yow: I'm a nuclear submarine under the polar ice cap and I need a Kleenex!
In-Reply-To: <1300273819.7214.12.camel@bee.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Wed, 16 Mar 2011 12:10:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169204>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>  Looking at that header, strlen is one of the few functions not being
> replaced by its __builtin version, and I only see __builtin_strlen in
> the C++ patches. I'll rephrase to something like "Some versions of
> strlen use SSE which then get inlined" to avoid blaming anyone in
> particular, though thinking about it, it does seem logical that it's
> GCC's builtin strlen.

All processor optimized versions of strlen in glibc are out-of-line, so
any use of SSE can only come from __builtin_strlen.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
