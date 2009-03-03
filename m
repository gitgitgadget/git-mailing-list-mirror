From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: remote branches, and branch names in general
Date: Tue, 3 Mar 2009 09:58:55 +0100
Message-ID: <200903030958.56150.markus.heidelberg@web.de>
References: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com> <m3vdqrtp84.fsf@localhost.localdomain> <20090303041631.GB18136@coredump.intra.peff.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 10:00:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQU0-000845-JO
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbZCCI6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZCCI6o
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:58:44 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:38393 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZCCI6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:58:44 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id C253CFB452BA;
	Tue,  3 Mar 2009 09:58:41 +0100 (CET)
Received: from [89.59.98.69] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LeQSX-0001EM-00; Tue, 03 Mar 2009 09:58:41 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090303041631.GB18136@coredump.intra.peff.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX191pdtrG6U/FylZ8wSXxcPxDygJmiJK9QoGk59U
	xoO8Xgi4DcAWgf1iA/FNUiPI6gmJ+srNhp2GmVQN1GM0XbJawh
	fjdxM6URjzEeKl7nAvbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112034>

Jeff King, 03.03.2009:
> On Mon, Mar 02, 2009 at 04:38:42PM -0800, Jakub Narebski wrote:
> 
> > > I see the remote branches with names of the form remotes/pub/name where
> > > pub is the nickname of the place I pull from.  To specify such branches,
> > > must I always spell it out with the leading "remotes/", or can that be
> > > shorted or implied somehow?  
> > 
> > You usually can omit "remotes/" prefix, and just use
> > "<remote>/<branch>" (or even "<remote>" for "<remote>/HEAD"). You need
> > it only if there is need for disambiguation.
> 
> Yes. I don't know if they are documented anywhere, but the complete
> lookup order is:
> 
>   $ git grep -h -A8 ref_rev_parse_rules refs.c
>   const char *ref_rev_parse_rules[] = {
>           "%.*s",
>           "refs/%.*s",
>           "refs/tags/%.*s",
>           "refs/heads/%.*s",
>           "refs/remotes/%.*s",
>           "refs/remotes/%.*s/HEAD",
>           NULL
>   };

Documented in git-rev-parse -> specifying revisions.

Markus
