From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: handle non UTF-8 text
Date: Tue, 29 May 2007 01:21:39 +0200
Message-ID: <20070528232139.GU4489@pasky.or.cz>
References: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 29 01:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsoX2-00082Z-Lq
	for gcvg-git@gmane.org; Tue, 29 May 2007 01:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXE1XVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 28 May 2007 19:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbXE1XVl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 19:21:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59248 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011AbXE1XVl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 19:21:41 -0400
Received: (qmail 15417 invoked by uid 2001); 29 May 2007 01:21:39 +0200
Content-Disposition: inline
In-Reply-To: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48652>

On Mon, May 28, 2007 at 10:47:34PM CEST, Martin Koegler wrote:
> gitweb assumes, that everything is in UTF-8. If a text contains inval=
id
> UTF-8 character sequences, the text must be in a different encoding.
>=20
> This patch interprets such a text as latin1.
>=20
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
> For correct UTF-8, the patch does not change anything.
>=20
> If commit/blob/... is not in UTF-8, it displays the text
> with a very high probability correct.=20
>=20
> As git itself is not aware of any encoding, I know no better
> possibility to handle non UTF-8 text in gitweb.

I don't think this is a reasonable approach; I actually dispute the hig=
h
probability - in western Europe it's obvious to assume latin1, but does
majority of users using non-ascii characters come from there? Or rather
from central Europe (like me, Petr Baudi=C5=A1? ;-))? Somewhere else?

If we do something like this, we should do it properly and look at
configured i18n.commitEncoding for the project. (But as config lookup
may be expensive, probably do it only when we need it.)

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
