From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable descriptions
Date: Sun, 24 Oct 2010 03:24:42 +0200
Message-ID: <201010240324.42721.trast@student.ethz.ch>
References: <cover.1287690696.git.trast@student.ethz.ch> <20101022155307.GB5554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 24 03:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9pKi-00014q-7o
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 03:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab0JXBYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 21:24:52 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:6482 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815Ab0JXBYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 21:24:51 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 24 Oct
 2010 03:24:51 +0200
Received: from pctrast.inf.ethz.ch (129.132.211.15) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 24 Oct
 2010 03:24:49 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc8-32-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20101022155307.GB5554@sigill.intra.peff.net>
X-Originating-IP: [129.132.211.15]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159834>

Jeff King wrote:
>   1. It looks like you're more or less just parsing "::" list keys from
>      all of the manpages. This seems somewhat fragile, as there could be
>      other non-config lists. Can we at least restrict it to
>      CONFIGURATION sections? It would be nice if we could put in some
>      kind of semantic markup, but I'm not sure how painful that would be
>      with asciidoc (we could always resort to comments in the source,
>      but that would probably get unreadable quickly).

I figured for consistency and ease of lookup *all* configuration docs
should name the variables in the same format.  It can still be helpful
to mention them elsewhere, e.g. in the option documentations, but the
main docs should be a CONFIGURATION section formatted like this.

Or do you think that would be a bad thing?

As for false positives, we could do the CONFIGURATION but in any case
I was hoping to avoid a special markup by using an asciidoc markup to
mark false positives if they arise (there currently aren't any).
E.g., it should be possible to make a {noconfig} attribute that
expands to nothing or so.  [Then again the same trick could be used
for all configs...]

>      [2]: Actually, as I mentioned a long time ago, I think it would be
>           nicer to have a table like:
> 
>              format.attach         linkgit:git-format-patch[1]
>              format.cc             linkgit:git-format-patch[1]
>              format.headers        linkgit:git-format-patch[1]
>              format.pretty         linkgit:gitpretty[7]

True, you said that.  I'll hack it into this format, since it's easy
to do once the parsers are stable and can then just say something like
"herein" for all the ones actually in git-config(1).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
