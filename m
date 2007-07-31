From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] Add strbuf_printf() to do formatted printing to a
 strbuf.
Date: Tue, 31 Jul 2007 15:57:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707311556150.14781@racer.site>
References: <11858309261111-git-send-email-krh@redhat.com> 
 <11858309311728-git-send-email-krh@redhat.com>  <11858309322006-git-send-email-krh@redhat.com>
  <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net> <1185891786.11086.40.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1823182068-1185893854=:14781"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 16:58:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFtAf-0003eI-HS
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 16:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760870AbXGaO6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 10:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760765AbXGaO57
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 10:57:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:49882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759279AbXGaO56 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 10:57:58 -0400
Received: (qmail invoked by alias); 31 Jul 2007 14:57:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 31 Jul 2007 16:57:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZPswRY3VZbg9+nz3Iezzft8IuVbYVDHpAUWX2P9
	q7hAg6DrZD5j3F
X-X-Sender: gene099@racer.site
In-Reply-To: <1185891786.11086.40.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54357>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1823182068-1185893854=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 31 Jul 2007, Kristian H?gsberg wrote:

> On Mon, 2007-07-30 at 21:36 -0700, Junio C Hamano wrote:
> > Kristian Høgsberg <krh@redhat.com> writes:
> > 
> > > +void strbuf_printf(struct strbuf *sb, const char *fmt, ...)
> > > +{
> > > +	char one_line[2048];
> > > +	va_list args;
> > > +	int len;
> > 
> > Such a nice abstraction so far, and then at the highest level of
> > callchain we have this hardcoded limit?
> 
> Yeah, I know, it sucks.  I'd like to just run vsnprintf with a 0-sized
> buffer to get the length, and then grow the buffer by that much, but
> that's not very portable as far as I know.

We do have nfvasprintf()...

Ciao,
Dscho

--8323584-1823182068-1185893854=:14781--
