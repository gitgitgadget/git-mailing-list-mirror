From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: give rerere a chance
Date: Thu, 29 Nov 2007 00:22:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711290021280.27959@racer.site>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711221117590.27959@racer.site> <7v7ik129d4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:23:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXBJ-0005LI-Gx
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbXK2AWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756953AbXK2AWq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:22:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:38866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752096AbXK2AWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:22:45 -0500
Received: (qmail invoked by alias); 29 Nov 2007 00:22:43 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp007) with SMTP; 29 Nov 2007 01:22:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19awIQVjpRa9Gzbb4c+kPHA6VuHn2amrrjDrHAvR9
	ui/wLB8jnHmLmy
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ik129d4.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66477>

Hi,

On Wed, 28 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -166,13 +167,13 @@ pick_one_preserving_merges () {
> >  			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
> >  			# No point in merging the first parent, that's HEAD
> >  			new_parents=${new_parents# $first_parent}
> > -			# NEEDSWORK: give rerere a chance
> >  			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
> >  				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
> >  				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
> >  				output git merge $STRATEGY -m "$msg" \
> >  					$new_parents
> >  			then
> > +				git rerere
> 
> This comment is not about this rerere change, but output is a shell
> function and I vaguely recall we had a discussion on "VAR=VAL cmd" form
> of single-shot export not working for them as expected...

Hmm.  What do you propose?  In the long run, I _want_ to have rebase as a 
builtin, which would solve this problem, probably.  But in the short run?

Ciao,
Dscho
