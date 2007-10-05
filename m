From: Pierre Habouzit <madcoder@debian.org>
Subject: strbuf `filter' API
Date: Fri,  5 Oct 2007 22:19:29 +0200
Message-ID: <1191615571-15946-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdteI-0002Dq-6B
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 22:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763966AbXJEUTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 16:19:34 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763952AbXJEUTd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 16:19:33 -0400
Received: from pan.madism.org ([88.191.52.104]:46246 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763900AbXJEUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 16:19:32 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 71D8D237F4;
	Fri,  5 Oct 2007 22:19:31 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1A2A235766E; Fri,  5 Oct 2007 22:19:31 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.208.gc1d91-dirty
In-Reply-To: 20071005155023.GA20305@artemis.corp
References: 20071005155023.GA20305@artemis.corp
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60130>

  Ooookay,

  I wasn't more thrilled about the previous patch than linus is. Here i=
s
a possible API to hide the muck in the strbuf.c module, and have a way
nicer to read code in convert.c.

  It remais as efficient as the previous code, tries to reuse the buffe=
r
as much as possible to avoid reallocations, and deal with even more
cases (it's possible to have the "source" buffer be inside the
destination strbuf now, which could sometimes help a lot).

  I based this on top of master (because it's where my previous patch
was) but it should apply on next properly. It depends upon the previous
patch though.

  I'd say that the previous patch should go in master ASAP, and that
those two could be considered for next (having merged master in it firs=
t
btw).

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
