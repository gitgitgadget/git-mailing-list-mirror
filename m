From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Tue, 09 Nov 2010 08:30:23 +0100
Organization: Bertin Technologies
Message-ID: <20101109083023.783fad9b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	kevin@sb.org
X-From: git-owner@vger.kernel.org Tue Nov 09 08:41:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFipG-0006Cx-MC
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 08:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab0KIHk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 02:40:59 -0500
Received: from blois.bertin.fr ([195.68.26.9]:34012 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab0KIHk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 02:40:59 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id B4CC0543AC
	for <git@vger.kernel.org>; Tue,  9 Nov 2010 08:40:57 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 77C24543B9
	for <git@vger.kernel.org>; Tue,  9 Nov 2010 08:40:57 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LBL00J6QXC9N160@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 09 Nov 2010 08:40:57 +0100 (CET)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17754.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161019>

Jeff wrote:
> It seems to me the natural way to do that would be to use our existing
> generic "start at this ref and follow some chain" syntax, which is
> ref^{foo}. For example: origin/pu^{:Merge 'kb/blame-author-email'}.

We may want to keep the "/" mnemonic (which seems no to conflict
withcurrent use either), rather than the ":" part, with something like
origin/pu^{/Merge 'kb/blame-author-email'}, and keep ":" for future use.

> We also have ref@{upstream}. The analogue here would be
> origin/pu@{:Merge 'kb/blame-author-email'}.

That's somewhat different, it looks like the foo@{...} only applies to
references with name "foo", and not to arbitrary revisions.  Allowing a
search to start from any commit seems more useful here.

Kevin wrote:
> Junio wrote:
> >    $ git log 'HEAD..:( :/Merge branch 'kb/blame-author-email' )^2'
[...]
>
> Interesting idea. It certainly solves the problem of being able to
> embed it within other operations (though you do then have to worry
> about escaping any embedded close-parens in the search), though it
> does mean my suggestion for being able to select the 2nd (or nth)
> match won't work.

Syntax like origin/pu^{/Merge 'kb/blame-author-email'}2 would be
somewhat consistent with the commit^2 case, and would seem unambiguous
as well - a bit weird, though.

-- 
Yann Dirson - Bertin Technologies
