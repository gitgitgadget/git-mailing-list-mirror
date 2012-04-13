From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 13:14:37 +0200
Message-ID: <20120413111437.GF2164@goldbirke>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120413091236.GC2164@goldbirke> <20120413094500.GD2164@goldbirke>
	<CAMP44s3g8acV4fjaSvnUo_jnhj40-TWR0az6zOwRNfv9_Qa23g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 13:14:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIeSj-00047y-Sn
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 13:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725Ab2DMLOk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 07:14:40 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:51285 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760966Ab2DMLOj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 07:14:39 -0400
Received: from localhost6.localdomain6 (p5B130584.dip0.t-ipconnect.de [91.19.5.132])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MErMM-1SUF313UWQ-00G185; Fri, 13 Apr 2012 13:14:38 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3g8acV4fjaSvnUo_jnhj40-TWR0az6zOwRNfv9_Qa23g@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:nrFe98jzkBaIEfvChWWTXuki5Llkq1PyYD6lFzw7qEM
 0i2+R1cQQqayJZtHkWHq/J3v6sxQRtRpn+r4/EzgOUHQUfUW4O
 FWsNNiZ/REL93Ae1i51aGoshf13tdqJclFRc6CRo5LyzowJHRl
 bocNnAb36qZR1S72koXMvEo8cgIjrF1K+UG5EN5VhQLVG6/wGB
 KF0gZ8k755mK31o1ZPZYoniaIRSBV46n8OkPTVIlDaAdYUyV58
 OadSRKPic/3flLVA+D43xX+o/E/R1ZeO9v44MJbPl7JFPHa/xJ
 9H+3BpiR0yrnCQpPYQI2Sn7QVZMTSirAagNku7u6X7xErkaTV4
 kqOylhGBkb62NYYBHZw0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195420>

On Fri, Apr 13, 2012 at 01:48:51PM +0300, Felipe Contreras wrote:
> 2012/4/13 SZEDER G=E1bor <szeder@ira.uka.de>:
> > On Fri, Apr 13, 2012 at 11:12:36AM +0200, SZEDER G=E1bor wrote:
> >> On Thu, Apr 12, 2012 at 12:57:03AM +0300, Felipe Contreras wrote:
> >> > +. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
> >> > +
> >> > +_get_comp_words_by_ref ()
> >> > +{
> >> > + =A0 while [ $# -gt 0 ]; do
> >> > + =A0 =A0 =A0 =A0 =A0 case "$1" in
> >> > + =A0 =A0 =A0 =A0 =A0 cur)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur=3D${_words[_cword]}
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> >> > + =A0 =A0 =A0 =A0 =A0 prev)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev=3D${_words[_cword-1]}
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> >> > + =A0 =A0 =A0 =A0 =A0 words)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 words=3D("${_words[@]}")
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> >> > + =A0 =A0 =A0 =A0 =A0 cword)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cword=3D$_cword
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> >> > + =A0 =A0 =A0 =A0 =A0 esac
> >> > + =A0 =A0 =A0 =A0 =A0 shift
> >> > + =A0 done
> >> > +}
> >>
> >> Git's completion script already implements this function. =A0Why
> >> override it here?
> >
> > Ah, ok, I think I got it.
> >
> > Of course, the words on the command line must be specified somehow =
to
> > test completion functions. =A0But the two implementations of
> > _get_comp_words_by_ref() for bash and zsh in the completion script
> > take the words on the command line from different variables, so we
> > need a common implementation to test completion functions both on b=
ash
> > and zsh. =A0Hence the _get_comp_words_by_ref() above, which takes t=
he
> > words on the command line and their count from $_words and $_cword,
> > respectively, and run_completion() below, which fills those variabl=
es
> > with its arguments.
>=20
> Well, yeah, that's one reason, but also I don't see the point in
> trying to fill the internal bash completion variables, maybe there
> would be some conflicts? Plus, the bash version of
> _get_comp_words_by_ref is rather complicated, so I decided to start
> with something simple that I could understand and see exactly what's
> going on. And for zsh I would definitely prefer to override
> _get_comp_words_by_ref than to mess with the internal variables,
> although I haven't found a way to test completion for zsh.

The tests are run in a non-interactive shell, which by default doesn't
load bash completion with its complicated _get_comp_words_by_ref().
So these tests use _get_comp_words_by_ref() from git's completion
script.


Anyway, out of curiosity I quickly tried this on top of b8574ba7 (i.e.
your patch from today's pu):

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3bbec79b..6c1ea956 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -27,27 +27,6 @@ complete ()
=20
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
=20
-_get_comp_words_by_ref ()
-{
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=3D${_words[_cword]}
-			;;
-		prev)
-			prev=3D${_words[_cword-1]}
-			;;
-		words)
-			words=3D("${_words[@]}")
-			;;
-		cword)
-			cword=3D$_cword
-			;;
-		esac
-		shift
-	done
-}
-
 print_comp ()
 {
 	local IFS=3D$'\n'
@@ -56,10 +35,10 @@ print_comp ()
=20
 run_completion ()
 {
-	local -a COMPREPLY _words
-	local _cword
-	_words=3D( $1 )
-	(( _cword =3D ${#_words[@]} - 1 ))
+	local -a COMPREPLY COMP_WORDS
+	local COMP_CWORD
+	COMP_WORDS=3D( $1 )
+	(( COMP_CWORD =3D ${#COMP_WORDS[@]} - 1 ))
 	_git && print_comp
 }

i.e. to set COMP_WORDS and COMP_CWORD in run_completion() and it
worked.  However, I agree that it feels iffy to mess with a
shell-specific variable, and I'm afraid that this just happened to
work on my system, but it might be broken in previous or future bash
versions.


Best,
G=E1bor
