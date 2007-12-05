From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 05 Dec 2007 22:46:51 +0100
Organization: Home - http://www.obry.net
Message-ID: <47571C4B.5060907@obry.net>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <1196869526-2197-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 22:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J025O-0002nD-5A
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 22:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbXLEVq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 16:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXLEVq5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 16:46:57 -0500
Received: from smtp28.orange.fr ([80.12.242.101]:32381 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbXLEVq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 16:46:57 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2816.orange.fr (SMTP Server) with ESMTP id 90D8470000B3
	for <git@vger.kernel.org>; Wed,  5 Dec 2007 22:46:55 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-88-105.w86-205.abo.wanadoo.fr [86.205.126.105])
	by mwinf2816.orange.fr (SMTP Server) with ESMTP id 0F55A700008A;
	Wed,  5 Dec 2007 22:46:55 +0100 (CET)
X-ME-UUID: 20071205214655628.0F55A700008A@mwinf2816.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <1196869526-2197-1-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67200>

Jakub Narebski a =E9crit :
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This patch needs checking if it correctly sets OLD_ICONV
> when needed.  I have checked only that it is not set when
> with new iconv() declaration.  Could people using Cygwin
> (and other with OLD_ICONV: Darwin) test it?

Not working on Cygwin:

   $ autoconf
   $ ./configure --prefix=3D/usr/local --build=3Di686-pc-cygwin
   ...
   configure: CHECKS for header files
   checking for old iconv()... no

It should be yes above. And in config.mak.autogen we have:

   OLD_ICONV=3D

Note also that you should remove all the hard-coded settings in Makefil=
e
anyway.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
