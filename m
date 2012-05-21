From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/13] move git_default_* variables to ident.c
Date: Mon, 21 May 2012 01:41:18 -0400
Message-ID: <20120521054118.GA2077@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
 <20120518231113.GE30031@sigill.intra.peff.net>
 <7vsjeu89dd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 07:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWLN0-0008Mf-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 07:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826Ab2EUFlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 01:41:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50605
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab2EUFlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 01:41:19 -0400
Received: (qmail 30809 invoked by uid 107); 21 May 2012 05:41:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 01:41:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 01:41:18 -0400
Content-Disposition: inline
In-Reply-To: <7vsjeu89dd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198083>

On Sun, May 20, 2012 at 09:07:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/cache.h b/cache.h
> > index 86224c8..f63b71f 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1142,9 +1142,6 @@ struct config_include_data {
> >  #define CONFIG_INCLUDE_INIT { 0 }
> >  extern int git_config_include(const char *name, const char *value, void *data);
> >  
> > -#define MAX_GITNAME (1000)
> > -extern char git_default_email[MAX_GITNAME];
> > -extern char git_default_name[MAX_GITNAME];
> >  #define IDENT_NAME_GIVEN 01
> >  #define IDENT_MAIL_GIVEN 02
> >  #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
> 
> During this step, builtin/fmt-merge-msg.c ceases to compile, even though
> in the end it is fixed...

Hrm. I ran the series through "make" on each commit before submitting,
and it compiled fine. I just did it again to double-check, and it's
still fine.

What was the error you got? Are you sure you had 03/13 in place
beforehand, which removes the use of MAX_GITNAME from
builtin/fmt-merge-msg.c?

-Peff
