From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Please pull git-po master branch
Date: Wed, 2 May 2012 09:54:20 +0200
Message-ID: <87d36n2f2r.fsf@thomas.inf.ethz.ch>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: Jiang Xin <worldhello.net@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 02 09:54:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPUOO-0001kV-F4
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 09:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab2EBHy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 03:54:27 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:25519 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619Ab2EBHyY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 03:54:24 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 2 May
 2012 09:54:22 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.188) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 2 May
 2012 09:54:22 +0200
In-Reply-To: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
	(Jiang Xin's message of "Wed, 2 May 2012 10:45:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196792>

Hi Xin (is that how you are properly addressed?)
Hi Ralf

Jiang Xin <worldhello.net@gmail.com> writes:
> Ralf Thielow (3):
>       l10n: Add the German translation team and initialize de.po
>       l10n: Initial German translation
>       l10n: Update German translation

Junio C Hamano <gitster@pobox.com> writes:
> Both branches pulled; I found it somewhat iffy to *add* new language =
support
> on the maintenance track, but decided to let it pass this time.
>=20
> A new lang.po file is very unlikely to introduce regression to anybod=
y
> else, so it probably is OK.

Objection.

Jan "jast" Kr=C3=BCger and me had most of the following "in the works",=
 and
couldn't get it shaped up before the pull request went out.  Any
translation mistakes are mine, we drafted it in German.

Consider this addressed to Ralf w.r.t. the content, but I think it
constitutes a general argument as to why a new translation should *not*
be merged and immediately released, much less in the maintenance track.


We (Jan and me) looked at your translation while it was WIP at [1].  We
have both toyed with translating Git to German, and got stuck with some
pitfalls.

To put it bluntly, we have significant concerns with your translation s=
o
far.  That's usually not a problem in OSS -- release early and release
and release often -- but the maint release would require you to get it
Right(tm) the first time.

The basic issues correlate with those found in many translations of
non-professionals.  (We wrote the list while looking at the WIP version
5c98748a2.  I have briefly checked that the points mentioned here are
still in the released version, but may have missed many other changes.)

* One tends to stick too closely to the English text, frequently missin=
g
  an opportunity to completely restructure sentences.  In some cases th=
e
  translation may be outright wrong, even though the words are correctl=
y
  translated.

  Example, if a bit harmless:
    Original: "If you are sure you want to delete it, [...]"
    Your translation: "Wenn du sicher bist diesen Zweig zu entfernen, [=
=2E..]"
    Alternative: "Wenn du ihn wirklich entfernen willst, [...]"

* Frequently there is an ambiguity, or overloading of terms, in one or
  both languages.  The context (of the original message) will make clea=
r
  *for the translator* what the meaning is, but it may be lost on the
  user.

  A related issue is when a single word splits into several in German.

  Examples:

  "commit" -> "Eintrag/Version/eintragen"
  "committer" -> "Einreicher/Eintragender"
  "remote" -> "entfernt" (weg? Aber ich hab's doch gar nicht gel=C3=B6s=
cht...?)
  "tracked/untracked" -> "verfolgt/unverfolgt" (Paranoia? "Unverfolgt" =
ist
      zudem nicht unbedingt ein Wort aus dem Sprachgebrauch)

* Translating technical terms may turn them into something that is
  completely unknown to anybody in German.

  Examples:

  "commit" -> usually translated simply as "Commit", e.g. in the SVN Re=
d
              Book

  "staging area/index/stage" -> "Bereitstellung/bereitstellen" is
      correct (e.g. in military usage), but gives the user little
      intuition.  "Index" isn't good either (same issue as in the
      original).  We don't have a really good idea either, and haven't
      heard of one.  However, this is one of the most important
      translations: the index is very central to git, but few users kno=
w
      it already.  You can try finding a good term (perhaps taking some
      liberties) but otherwise "Index" may be the lesser evil.

      On a related note, an earlier unfinished translation translated
      "to stage" as "vormerken".  We think that captures the essence
      very nicely.  It then tried to completely avoid referring to the
      index as a noun.

* The translator may not be sufficiently familiar with the context
  and the tool to correctly translate.

  Example:
  Original: Cloning into bare repository '%s'...
  Translation: Klone in leeres Projektarchiv '%s'...
  [for non German speakers: "leer" means "empty"]
  "bare" denotes a repository that does not have a worktree associated
  with it.  It is *not* usually empty.


Please don't take this personal.  We are happy that you picked up the
effort of translating it, since all previous efforts have stalled.
It's also a bit too late now for the German translation, since it has
already been released.

However, we do feel that git is so complex and has so much confusing
(not your fault really) terminology associated with it that translation=
s
should not go straight from translator to release.

Some ideas on how we can do better in the next language, and proceed
from here:

* Make a glossary of the relevant terminology first.  Sadly
  gitglossary(7) has gotten somewhat stale, and perhaps can also benefi=
t
  from an overhaul.  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason recently ma=
de a list[4] of
  the most important terms, which is a good start.

* If you are interested in collaboration, IRC may be a good choice for
  the many little questions that probably arise?  We hang out in
  #git-devel on Freenode[3].  Email is of course also an option, but
  more time-consuming.

Note that in the context of Git, a major problem is that the
documentation and books are only available in English.  There isn't eve=
n
a glossary.  For example, you translated "detached" as "losgel=C3=B6st"=
=2E
=46rom our experience the detached HEAD is something that users stumble
into, rather than learn about beforehand.  They usually come crying for
help when they've already lost their work in the "void" of unreachable
commits.  Now put yourself into the position of a user.  Where can he
look up what the root of his problem is?  At least for "detached HEAD"
there is a wealth of blog posts that rescue the poor user.

We think -- pardon the strong words -- that your current draft
translation makes things harder, not easier, for German users.  The
issues mentioned above, especially when it comes to ambiguities, splits
into several terms and mistakes, add up to considerable bad weather, an=
d
the lack of reference material leaves the user out in the rain.

Of course now that it has been released, we'll also have to file patche=
s
in the true open source spirit.  Sigh.

Regards / Liebe Gr=C3=BCsse
Thomas

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
