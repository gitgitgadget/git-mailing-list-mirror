From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 09:23:55 +0100
Message-ID: <20110322082355.GE14520@neumann>
References: <4D871972.7080008@elegosoft.com>
	<7vhbawno11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 09:24:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1wtD-0000WG-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 09:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683Ab1CVIY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 04:24:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:63841 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab1CVIYX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 04:24:23 -0400
Received: from localhost6.localdomain6 (p5B130955.dip0.t-ipconnect.de [91.19.9.85])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MNezy-1Q4ftm3DKc-007H4h; Tue, 22 Mar 2011 09:23:57 +0100
Content-Disposition: inline
In-Reply-To: <7vhbawno11.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:QdlOjHvcOZmEJD003QJtfJSgjzASVvjQZ4KQvKQXose
 szBOFZyDOYENn4bLYeo+XgzRAy0oLgg18jB3XQNortKADcU0xB
 IxBHKiWVMU3hYUzi3MJ3RtTFTt/H2BK3ac+6ntPClPM4QAeNi2
 YyygzqZbMI3u9D1dsxSdIGSyd7pVYutzkP0kdxLA37H0FourUn
 bMzxoTNe7NQNa5K2X6gBA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169708>

On Mon, Mar 21, 2011 at 02:48:10PM -0700, Junio C Hamano wrote:
> Jakob Pfender <jpfender@elegosoft.com> writes:
>=20
> > Enable bash completion for "git help <alias>", analogous to "git
> > <alias>", which was already implemented.
> >
> > Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
> > ---
> >  contrib/completion/git-completion.bash |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash
> > b/contrib/completion/git-completion.bash
> > index 893b771..f9a74d3 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1506,7 +1506,7 @@ _git_help ()
> >  		;;
> >  	esac
> >  	__git_compute_all_commands
> > -	__gitcomp "$__git_all_commands
> > +	__gitcomp "$__git_all_commands $(__git_aliases)
> >  		attributes cli core-tutorial cvs-migration
> >  		diffcore gitk glossary hooks ignore modules
> >  		repository-layout tutorial tutorial-2
>=20
> This patch may not be _wrong_ per-se, but it it useful in practice?
>=20
> I dunno.

I think most people use 'git help <cmd>' to bring up the man page of
given git command.  Since my aliases don't have a man page (and I
doubt that any alias will have one), I would never run 'git help
<alias>' myself, because it would only lead to a 'man page not
available' error.  Well, at least so I thought, because I never knew
that 'git help <alias>' actually prints the definition of the alias.
It's definitely shorter and easier than 'git config --get
alias.<alias>', but on the other hand it clutters 'git help <TAB>
output, especially if you have a lot of aliases.  If I had aliases
like 'ci' or 'co' instead of 'commit' and 'checkout', then I would
definitely not want to see them after 'git help <TAB>'.

So I don't know either.

Sidenote: the completion for 'git help' already lists custom git
commands (i.e. a script named 'git-<cmd>' somewhere in $PATH'), and
those are likely not documented either.

> Don't people usually use aliases so that they do not have to type lon=
g
> command names that would need completion?

I mostly use aliases for a command and a couple of options (e.g. a
custom log format), and give them meaningful names.


Best,
G=E1bor
