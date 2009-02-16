From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] format-patch: thread as reply to cover letter even with in-reply-to
Date: Mon, 16 Feb 2009 21:34:20 +0100
Message-ID: <200902162134.28850.trast@student.ethz.ch>
References: <cover.1234801852.git.trast@student.ethz.ch> <1234810812-30499-1-git-send-email-trast@student.ethz.ch> <76718490902161222p7f1ecbf9x6f965ff94b3cfae7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1804172.rSR10y8Ry0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 21:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZACJ-0007v0-D6
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 21:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbZBPUep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 15:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbZBPUeo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 15:34:44 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:57005 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbZBPUen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 15:34:43 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 21:34:42 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 21:34:41 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <76718490902161222p7f1ecbf9x6f965ff94b3cfae7@mail.gmail.com>
X-OriginalArrivalTime: 16 Feb 2009 20:34:42.0089 (UTC) FILETIME=[FF057190:01C99075]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110237>

--nextPart1804172.rSR10y8Ry0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jay Soffian wrote:
> I think this change may be okay, but I think to go with it the
> cover-letter and all the patches should have a "References:" header
> with the message-id given by --in-reply-to.

That's a completely separate issue.  I'm only proposing to change
what is formatted as a reply to what, the In-Reply-To and References
formatting is handled by the existing code.  That being said...

> RFC 2822 says:
>=20
>    The "In-Reply-To:" and "References:" fields are used when creating a
>    reply to a message.  They hold the message identifier of the original
>    message and the message identifiers of other messages (for example,
>    in the case of a reply to a message which was itself a reply).  The
>    "In-Reply-To:" field may be used to identify the message (or
>    messages) to which the new message is a reply, while the
>    "References:" field may be used to identify a "thread" of
>    conversation.

The References formatting can't satisfy the following requirement, two
paragraphs further down in the RFC,

   The "References:" field will contain the contents of the parent's
   "References:" field (if any) followed by the contents of the parent's
   "Message-ID:" field (if any).

because it doesn't have access to the mail being replied to.  It
merely sets References to the same as In-Reply-To.

(Note that I'm just guessing this from behaviour I can observe, I
haven't actually read the code for that part.)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1804172.rSR10y8Ry0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmZzdQACgkQqUud07tmzP0C0wCcChJm8KHS3Ym05gPbdSn36eID
1z0An2rEjKk7AGax2PE/cnjHqJvcdxXJ
=Dw8a
-----END PGP SIGNATURE-----

--nextPart1804172.rSR10y8Ry0--
