From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] ident: make user_ident_explicitly_given private
Date: Wed, 14 Nov 2012 11:11:05 -0800
Message-ID: <20121114191104.GB3860@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113164931.GA12626@sigill.intra.peff.net>
 <20121114164457.GA6858@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYiMu-0006dk-29
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423254Ab2KNTLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 14:11:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48552 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161019Ab2KNTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:11:08 -0500
Received: (qmail 5522 invoked by uid 107); 14 Nov 2012 19:11:56 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 14:11:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 11:11:05 -0800
Content-Disposition: inline
In-Reply-To: <20121114164457.GA6858@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209740>

On Wed, Nov 14, 2012 at 08:44:57AM -0800, Jonathan Nieder wrote:

> > -#define IDENT_NAME_GIVEN 01
> > -#define IDENT_MAIL_GIVEN 02
> > -#define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
> > -extern int user_ident_explicitly_given;
> >  extern int user_ident_sufficiently_given(void);
> 
> In v1.5.6-rc0~56^2 (2008-05-04) "user_ident_explicitly_given" was
> introduced as a global for communication between config, ident, and
> builtin-commit.  In v1.7.0-rc0~72^2 (2010-01-07) readers switched to
> using the common wrapper user_ident_sufficiently_given().  After
> v1.7.11-rc1~15^2~18 (2012-05-21) the var is only written in ident.c,
> and the variable can finally be made static.

Thanks for digging up the history. I remembered trying to do this before
during the ident refactoring that went into v1.7.11, but it didn't work
then for some reason (I think it was probably an earlier iteration of
the series, and then I forgot to revisit it during the final one).

I'll add your explanation to the commit message if I re-roll.

-Peff
