From: Johan Herland <johan@herland.net>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Fri, 4 May 2007 13:53:10 +0200
Message-ID: <200705041353.17992.johan@herland.net>
References: <loom.20070502T111026-882@post.gmane.org> <200705040921.33443.johan@herland.net> <81b0412b0705040236w1d5f26bx8ac351ade2f4ea6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1631445.4tUiTDAa7Q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 14:00:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjwSg-0001cB-JJ
	for gcvg-git@gmane.org; Fri, 04 May 2007 14:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbXEDL7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 07:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754401AbXEDL7j
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 07:59:39 -0400
Received: from sam.opera.com ([213.236.208.81]:41567 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378AbXEDL7h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 07:59:37 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2007 07:59:36 EDT
Received: from pc052.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l44BrIoE009733
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 May 2007 11:53:22 GMT
User-Agent: KMail/1.9.6
In-Reply-To: <81b0412b0705040236w1d5f26bx8ac351ade2f4ea6a@mail.gmail.com>
X-Face: yd/RLXZ@3u;&:C1I$AEH?\d18w+mK:]sZDl52'=Pa{>%,97])P+G2Z<=?utf-8?q?An=5C=5Fs-+5=5DS5USYj=0A=09ZV9-=27+?="}0!v$zY.4.~5V*'(.9b`>|'YyP1]1%Ge/"bi}Z9PaqbK.9K"yXj#v-CuX,=?utf-8?q?i=26=2E8=5D=0A=09?=)yTm>+T04D
X-Virus-Scanned: ClamAV 0.90.1/3204/Thu May  3 18:46:39 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46174>

--nextPart1631445.4tUiTDAa7Q
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 04 May 2007, Alex Riesen wrote:
> On 5/4/07, Johan Herland <johan@herland.net> wrote:
> > 1. "Reverts": Mark a commit as reverting another commit. This could be
> > used by git-log to cancel out pairs of commits, resulting in a cleaner
> > view of history. It can help blame/annotate. There are probably other
> > tools that can benefit from this information also.
> >
> > 2. "Cherry-Pick": When cherry-picking a commit onto another branch, you
> > should be able to tell git which commit you are cherry-picking
> > (git-cherry-pick would of course do this automatically). This could
> > enable git to make smarter decisions when merging the two branches: If
> > the cherry-picked commit would cause a conflict with the original
> > commit, git can either skip it (since it knows that one version of this
> > patch is already present), or it can at least present the conflict to
> > the user with some more context than what is available today. Not to
> > mention how this information could be used by blame/annotate.
>
> These are completely useless after the first "git gc --prune" or "git
> clone" unless these tools taught to preserve the reverted or cherry-picked
> commits (and all their history). And if you are about to teach them that,
> please notice that as for now cloning and repacking does not even look at
> the
> objects contents.
> You'll absolutely kill their performance.

Of course I don't want "git gc --prune" or "git clone" to follow these link=
s,=20
or know anything about them at all.

As for "Reverts", the commit pointed to should already be in your history,=
=20
since you cannot revert something that hasn't already been applied at an=20
earlier point in your history. In other words, the reverted commit will=20
automatically be included in your "git gc --prune" or "git clone" regardles=
s=20
of the "Reverts" fields, since "Reverts" can only point to an ancestor.

As for "Cherry-Pick", it's a fairly weak relationship that shouldn't affect=
=20
anything except to give a hint to merge, blame, and similar tools.=20
If "Cherry-Pick" identifies an object not in your repo (because of "git=20
gc --prune" or "git clone"), that is obviously equivalent to not having=20
a "Cherry-Pick" field in the first place. "Cherry-Pick" is only useful when=
=20
you have access to the original commit (pointed to by "Cherry-Pick"), but i=
n=20
that case I think it could be _really_ useful.


Have fun!

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart1631445.4tUiTDAa7Q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGOx6tBHj4kl4fT1wRAsoGAJ0YMvq7v/ZCS+l1HC7dV2yBidIoGgCeMTih
t7AA3V/VgsGYA9ZFfnqH/wg=
=QfkV
-----END PGP SIGNATURE-----

--nextPart1631445.4tUiTDAa7Q--
