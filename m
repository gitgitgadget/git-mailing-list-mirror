From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC PATCH v2 0/2] git-gui: (un)stage a range of changes
	at once
Date: Mon, 7 Dec 2009 13:54:35 +0100
Message-ID: <20091207125435.GA43609@book.hvoigt.net>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net> <20091026193903.GA27319@unpythonic.net> <20091205213613.GG5610@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 13:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHd6x-00064W-VS
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 13:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933632AbZLGMyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 07:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933597AbZLGMyb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 07:54:31 -0500
Received: from darksea.de ([83.133.111.250]:33012 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755126AbZLGMya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 07:54:30 -0500
Received: (qmail 3658 invoked from network); 7 Dec 2009 13:54:35 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Dec 2009 13:54:35 +0100
Content-Disposition: inline
In-Reply-To: <20091205213613.GG5610@spearce.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134754>

On Sat, Dec 05, 2009 at 01:36:13PM -0800, Shawn O. Pearce wrote:
> Jeff Epler <jepler@unpythonic.net> wrote:
> > I've found another problem, which I'll work on as soon as I find a
> > chance.
> >=20
> > When staging multiple "+" lines preceded by a "-" line that must be
> > turned into context, the converted "-" line must come after *all* t=
he
> > "+" lines, not just the first one.
>=20
> So the reason this series got stuck was this message, this bug is
> enough to suggest we shouldn't apply it to my tree yet, so I've
> been waiting for an update on the topic.

In an attempt to help this series forward I tried to reproduce this bug
but were unsuccessfull. It seems that a change like this:

@@ -13,7 +13,9 @@ set appvers {@@GITGUI_VERSION@@}
 set copyright [encoding convertfrom utf-8 {
 Copyright =A9 2006, 2007 Shawn Pearce, et. al.
=20
-This program is free software; you can redistribute it and/or modify
+Blabla
+blubblub
+lalala
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

and then trying to stage part of the '+' lines is not enough. Jeff coul=
d you
clarify or provide an example?

cheers Heiko
