From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 09:44:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1103220943200.1561@bonsai2>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1103212302000.1561@bonsai2> <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	lee.marlow@gmail.com, markus.heidelberg@web.de, szeder@ira.uka.de,
	spearce@spearce.org, bebarino@gmail.com, ted@tedpavlic.com,
	tlikonen@iki.fi, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 09:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1xD5-00011t-JB
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 09:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab1CVIo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 04:44:58 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:35757 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753875Ab1CVIo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 04:44:56 -0400
Received: (qmail invoked by alias); 22 Mar 2011 08:44:54 -0000
Received: from pD9EB235B.dip0.t-ipconnect.de (EHLO noname) [217.235.35.91]
  by mail.gmx.net (mp072) with SMTP; 22 Mar 2011 09:44:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199CslGnYN9PiB9s410cBIFfb0R1mHhyZ2TGAxYYc
	dr6moGcwGPMdDX
X-X-Sender: gene099@bonsai2
In-Reply-To: <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169709>

Hi,

On Tue, 22 Mar 2011, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > diff --git a/contrib/completion/git-completion.bash
> >> > b/contrib/completion/git-completion.bash
> >> > index 893b771..f9a74d3 100755
> >> > --- a/contrib/completion/git-completion.bash
> >> > +++ b/contrib/completion/git-completion.bash
> >> > @@ -1506,7 +1506,7 @@ _git_help ()
> >> >  		;;
> >> >  	esac
> >> >  	__git_compute_all_commands
> >> > -	__gitcomp "$__git_all_commands
> >> > +	__gitcomp "$__git_all_commands $(__git_aliases)
> >> >  		attributes cli core-tutorial cvs-migration
> >> >  		diffcore gitk glossary hooks ignore modules
> >> >  		repository-layout tutorial tutorial-2
> >> 
> >> This patch may not be _wrong_ per-se, but it it useful in practice?
> >> 
> >> I dunno.
> >> 
> >> Don't people usually use aliases so that they do not have to type long
> >> command names that would need completion?
> >
> > Yes. And if you use a lot of aliases, or a lot of machines with evolving 
> > aliases, the easiest way to inspect the alias is "git help <alias>". Not 
> > seeing it completed is an unexpected behavior.
> 
> I've queued the patch and I already said that this is not wrong, but I
> think your argument cuts it both ways.
> 
> I have "co" aliased to "checkout", but with this change "git help 
> co<TAB>" now will interfere with my expectation that it would complete 
> to commit, config and the like, but exclude an alias that I myself 
> defined and know how to spell but forgot what its exact definition was, 
> in order to avoid cluttering the choices offered.

In a corporate environment, one would now do a market research as to what 
is the common expectation.

> This is a constructive tangent but if we are going to run 
> $(__git_aliases) every time we run _git_help, perhaps it would want a 
> hack similar to the way the value for $__git_all_commands is generated 
> just once?

Indeed.

Ciao,
Johannes
