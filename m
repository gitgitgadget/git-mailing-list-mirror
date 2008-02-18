From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/4] Export some email and pretty-printing functions
Date: Mon, 18 Feb 2008 14:07:12 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802181245580.5816@iabervon.org>
References: <alpine.LNX.1.00.0802171335460.5816@iabervon.org> <alpine.LSU.1.00.0802181241440.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:07:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRBLL-0007Hy-3G
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 20:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbYBRTHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 14:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbYBRTHR
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 14:07:17 -0500
Received: from iabervon.org ([66.92.72.58]:42803 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbYBRTHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 14:07:16 -0500
Received: (qmail 28150 invoked by uid 1000); 18 Feb 2008 19:07:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Feb 2008 19:07:12 -0000
In-Reply-To: <alpine.LSU.1.00.0802181241440.30505@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74333>

On Mon, 18 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 17 Feb 2008, Daniel Barkalow wrote:
> 
> > diff --git a/commit.h b/commit.h
> > index 10e2b5d..42b4825 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -71,6 +71,21 @@ extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
> >                                  int abbrev, const char *subject,
> >                                  const char *after_subject, enum date_mode,
> >  				int non_ascii_present);
> > +void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
> > +		   const char *line, enum date_mode dmode,
> > +		   const char *encoding);
> > +void pp_title_line(enum cmit_fmt fmt,
> > +		   const char **msg_p,
> > +		   struct strbuf *sb,
> > +		   const char *subject,
> > +		   const char *after_subject,
> > +		   const char *encoding,
> > +		   int plain_non_ascii);
> > +void pp_remainder(enum cmit_fmt fmt,
> > +		  const char **msg_p,
> > +		  struct strbuf *sb,
> > +		  int indent);
> > +
> 
> In addition to Junio's concern that add_user_info() really wants to be 
> called pp_add_user_info(), I cannot help myself but suspect that 
> pp_write_email_headers() -- which called for a new name, too -- also wants 
> to live in pretty.c.

Good idea, although I think "pp" is a verb about putting the result in the 
provided strbuf, so "pp_user_info()" and "pp_email_headers()".

It's different, currently, in that it actually outputs the headers, rather 
than putting them in a buffer and uses struct rev_info. I'll need to work 
on this some more.

	-Daniel
*This .sig left intentionally blank*
