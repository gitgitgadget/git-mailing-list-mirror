From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 21:25:18 +0100
Message-ID: <20110322202518.GA30604@neumann>
References: <4D871972.7080008@elegosoft.com>
	<7vhbawno11.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1103212302000.1561@bonsai2>
	<7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
	<20110322085027.GF14520@neumann>
	<AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
	<20110322100903.GG14520@neumann>
	<AANLkTik8BaAJCnCRdDNTdu=nV1Q7cFLiwOuV_4wdXUE6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>, <lee.marlow@gmail.com>,
	<markus.heidelberg@web.de>, <spearce@spearce.org>,
	<bebarino@gmail.com>, <ted@tedpavlic.com>, <tlikonen@iki.fi>,
	<trast@student.ethz.ch>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:25:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q288s-0007Ea-BS
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 21:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab1CVUZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 16:25:21 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:16134 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab1CVUZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 16:25:20 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 22 Mar
 2011 21:25:17 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 22 Mar
 2011 21:25:18 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTik8BaAJCnCRdDNTdu=nV1Q7cFLiwOuV_4wdXUE6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169772>

On Tue, Mar 22, 2011 at 11:28:01AM +0100, Erik Faye-Lund wrote:
> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> > On Tue, Mar 22, 2011 at 10:16:16AM +0100, Erik Faye-Lund wrote:
> >> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> >> > On Tue, Mar 22, 2011 at 12:53:43AM -0700, Junio C Hamano wrote:
> >> >> This is a constructive tangent but if we are going to run $(__g=
it_aliases)
> >> >> every time we run _git_help, perhaps it would want a hack simil=
ar to the
> >> >> way the value for $__git_all_commands is generated just once?
> >> >
> >> > I think this is not necessary. =A0We already run __git_aliases()=
 every
> >> > time after 'git <TAB>', and it was not an issue so far. =A0And i=
ndeed, I
> >> > just created 50 aliases, and the time required for __git_aliases=
()
> >> > seems to be negligible:
> >> >
> >> > =A0$ time __git_aliases
> >> > =A0<bunch of aliases>
> >> >
> >> > =A0real =A0 =A00m0.028s
> >> > =A0user =A0 =A00m0.016s
> >> > =A0sys =A0 =A0 0m0.004s
> >> >
> >>
> >> Unfortunately, the situation is not quite so good on Windows:
> >> $ time __git_aliases
> >> <bunch of aliases>
> >>
> >> real =A0 =A00m0.112s
> >> user =A0 =A00m0.030s
> >> sys =A0 =A0 0m0.015s
> >>
> >> This is with 50 aliases, with 0 aliases I get this:
> >> $ time __git_aliases
> >> test
> >>
> >> real =A0 =A00m0.063s
> >> user =A0 =A00m0.015s
> >> sys =A0 =A0 0m0.015s
> >
> > I see. =A0However, on Windows everything git-related tends to be sl=
ow,
> > so this is nothing new.
>=20
> That's not the case. Every thing Git-related isn't slow on Windows,
> but there are some things in Git that is.
>=20
> > The question is whether the slowness of a known slow platform would
> > justify the regression on all platforms.
> >
>=20
> Windows isn't slow. Get over this way of thinking, it's just wrong.
> Windows has some different performance characteristics for some
> operations than e.g Linux, but saying that it's slow is just wrong.
> However, _Bash for Windows_ is quite slow, much due to Windows' lack
> of fork(), which means that some very involved emulation needs to be
> performed.

I meant the above only in the context of git, based on my last -- it
seems outdated -- experiences with msysgit about (more than?) a year
ago, when I found such builtins like commit and checkout to be quite
noticeably slow.  I'm glad to hear that things are changing for good.

Anyway, with the following silly "benchmarking" on top of the
thread-starter patch[*] ...


diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d2b8746..12aa613 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2742,7 +2742,7 @@ _git ()
 	fi
=20
 	local completion_func=3D"_git_${command//-/_}"
-	declare -f $completion_func >/dev/null && $completion_func && return
+	declare -f $completion_func >/dev/null && time $completion_func && re=
turn
=20
 	local expansion=3D$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then


=2E.. the time required for 'git help <TAB>' with msysgit is around
120-140ms.

With the caching of aliases for 'git help' ...


diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 12aa613..466578b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -963,6 +963,12 @@ __git_aliases ()
 	done
 }
=20
+__git_aliases=3D
+__git_compute_aliases ()
+{
+	: ${__git_aliases:=3D$(__git_aliases)}
+}
+
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
@@ -1508,7 +1514,8 @@ _git_help ()
 		;;
 	esac
 	__git_compute_all_commands
-	__gitcomp "$__git_all_commands $(__git_aliases)
+	__git_compute_aliases
+	__gitcomp "$__git_all_commands $__git_aliases
 		attributes cli core-tutorial cvs-migration
 		diffcore gitk glossary hooks ignore modules
 		repository-layout tutorial tutorial-2

=2E.. it goes down to around 50ms.

Looking at the numbers it seems to be a significant improvement, but
in practice I'm not sure I noticed anything; perhaps it's more
noticeable on slower hardware.  Just for the record, the numbers on
linux are ~50ms without and ~40ms with alias caching.

> But even so, at least 25% of the git user base is on Windows,
> according to the latest Git User Survey. That makes this stuff matter=
=2E

The other point of view is that it will cause a regression without a
compensating benefit for maybe more than 75% of the user base ;)


Best,
G=E1bor


[*] - off topic: Was it just me, or that simple patch really couldn't
be applied with a simple 'git am' on today's master?  What exactly
caused the conflict?  I looked quite hard, but couldn't find
anything...
