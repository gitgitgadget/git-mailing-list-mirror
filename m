From: Junio C Hamano <gitster@pobox.com>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 03 Oct 2007 03:57:02 -0700
Message-ID: <7vd4vwfou9.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
	<7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
	<39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com>
	<85abr0y5ua.fsf@lola.goethe.zz>
	<1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 12:57:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id1uu-0000nM-1w
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 12:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407AbXJCK5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 06:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756225AbXJCK5O
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 06:57:14 -0400
Received: from rune.pobox.com ([208.210.124.79]:41146 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755916AbXJCK5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 06:57:12 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id E96DE140D7F;
	Wed,  3 Oct 2007 06:57:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C216F140D7E;
	Wed,  3 Oct 2007 06:57:26 -0400 (EDT)
In-Reply-To: <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com> (Wincent
	Colaiuta's message of "Wed, 3 Oct 2007 12:05:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59821>

Wincent Colaiuta <win@wincent.com> writes:

> Yes, but editing DocBook (XML) is relatively painful compared to  
> editing plain text. You either have to rely on a bloated XML- 
> validating editor or instead ask your doc authors to manually write  
> valid XML (and I totally agree with Terrence Parr that, "XML makes a  
> lousy human interface
> "; see <http://www.ibm.com/developerworks/xml/library/x-sbxml.html>  
> for his full take).
>
> I know that Linus has argued for AsciiDoc because the source *is* the  
> plain text documentation and is therefore easily readable, but for me  
> the real benefit lies in the fact that *because* the source is plain  
> text it is easily edited (ie. that the source is easily *writeable*),  
> and things like documentation patches are very neat with AsciiDoc.

To give credits to where they are due, most of the structure of
the initial documentation was done during the first week of May
2005 by David Greaves while Linus was vacationing, and the first
person who brought up AsciiDoc was Bert Hubert.

    http://article.gmane.org/gmane.comp.version-control.git/2323

One thing Linus had to say about the issue from early on, and I
still agree with, is the last paragraph in:

    http://article.gmane.org/gmane.comp.version-control.git/2298

There was another thread in the recent past

    http://article.gmane.org/gmane.comp.version-control.git/55059

I've seen markdown used elsewhere, and I regularly read pod.
These are both used by other people (I _care_ about good
external support and user community), are readable as straight
text (I personally care more about this than prettyprinted
output), and can be alternative candidates if we consider
switching.

How good are HTML and manpage output support from these (or
other candidates) formats these days?  Output to help page
format Windows folks use (I am assuming Mac people are happy as
long as man is available) would be a definite plus.

Another alternative could be to build on AsciiDoc to get manpage
and html output without relying too heavily on docbook
toolchain, and considering the fact that we still seem to be one
of the most important customers listed on its home page, we
might be able to get help from Stuart himself to improve the
situation (I am assuming that mingwgit folks do not have problem
with Python, but I may be mistaken).

In short, although I do appreciate Johannes's and Sam's attempt,
I would really prefer to see us pick some externally maintained
alternative, instead of inventing a homebrew system that we need
to maintain ourselves.  It is rumored that git has much higher
developer count vs loc count ratio than many other open source
projects, doing the documentation format is not part of our
project, and I'd rather see them spend time working on git, not
building and maintaining AsciiDoc lookalike.
