From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 9 Jul 2007 14:16:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707091408190.6977@iabervon.org>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org>
 <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707090142130.6977@iabervon.org>
 <469278B3.40905@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-645212812-1184005014=:6977"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jul 09 20:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7xnA-0000Ef-4i
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 20:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbXGISQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 14:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbXGISQ4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 14:16:56 -0400
Received: from iabervon.org ([66.92.72.58]:1442 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbXGISQz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 14:16:55 -0400
Received: (qmail 7371 invoked by uid 1000); 9 Jul 2007 18:16:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jul 2007 18:16:54 -0000
In-Reply-To: <469278B3.40905@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52010>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-645212812-1184005014=:6977
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Jul 2007, Ren=E9 Scharfe wrote:

> Daniel Barkalow schrieb:
> > On Sun, 8 Jul 2007, Junio C Hamano wrote:
> >=20
> >> Are _identifiers with leading underscore Kosher thing to do, I
> >> wonder...  We do have ones with trailing ones (mostly qsort
> >> functions) and I think they are done that way for the sake of
> >> standards conformance.
> >=20
> > I'm not sure; I inherited that bit of code from Julian. Do we have a=20
> > standard idiom for a function that sets a bunch of static variables?
>=20
> You could put all flags and settings into a struct fetch_pack_args.
>=20
> You could then go one step further by exporting the struct definition
> and letting the internal interface take a pointer to such a struct,
> thereby getting rid of static variables and their setup routine.

This code is going to get an extensive refactor at some point (I'd like to=
=20
get to the point where git-fetch uses only a single connection), but=20
that's a much bigger patch, and I want to get builtin-fetch done with=20
minimal changes to other code; passing configuration through to everywhere=
=20
that uses it would add a lot of noise at this stage.

Passing a pointer to a struct instead of a pile of ints in hopefully the=20
right order is probably a worthwhile improvement to reviewability, though,=
=20
so I'll try that much this evening.

=09-Daniel
*This .sig left intentionally blank*
--1547844168-645212812-1184005014=:6977--
