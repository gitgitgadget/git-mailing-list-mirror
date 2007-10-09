From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fixed crash in fetching remote tags when there is not tags.
Date: Tue, 9 Oct 2007 20:20:43 +0200
Message-ID: <20071009182043.GA2997@steel.home>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi> <1191919868-4963-2-git-send-email-v@pp.inet.fi> <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Tue Oct 09 20:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfJhV-000723-UL
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 20:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690AbXJISUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbXJISUr
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 14:20:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:20570 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbXJISUr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 14:20:47 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo57) (RZmta 13.4)
	with ESMTP id w02e32j99FabAs ; Tue, 9 Oct 2007 20:20:44 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 993FC277AE;
	Tue,  9 Oct 2007 20:20:44 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 44E3BC502; Tue,  9 Oct 2007 20:20:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60427>

V=E4in=F6 J=E4rvel=E4, Tue, Oct 09, 2007 12:52:01 +0200:
> Hi,
>=20
> These patches should have been numbered, sorry, The test patch was =20
> supposed be number 1 of 2.
>=20
> The patches were done on top of next. The fix should be checked, as =20
> it's mostly a quick fix to get it to work, probably not the correct =20
> way to fix that bug, or is it?

Your test does not crash on my system and your fix is obviously bogus.
Just take a look at the only call site of the tail_link_ref: ret
cannot be NULL. alloc_ref will crash in memset, if this were the case.

If you can reproduce the crash reliably, try compiling git with -g and
run it in your test with valgrind or gdb (assuming these are available
to you).
