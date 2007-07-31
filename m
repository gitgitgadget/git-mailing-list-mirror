From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] Add strbuf_printf() to do formatted printing to a
 strbuf.
Date: Tue, 31 Jul 2007 15:55:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707311554220.14781@racer.site>
References: <11858309261111-git-send-email-krh@redhat.com> 
 <11858309311728-git-send-email-krh@redhat.com>  <11858309322006-git-send-email-krh@redhat.com>
  <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net> <1185891786.11086.40.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-622390028-1185893725=:14781"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 16:56:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFt9H-0003Bh-6j
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 16:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760915AbXGaOzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 10:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761146AbXGaOzu
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 10:55:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:43030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762095AbXGaOzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 10:55:49 -0400
Received: (qmail invoked by alias); 31 Jul 2007 14:55:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 31 Jul 2007 16:55:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9gvxCLl79rqPd+Pih55VTSpt842kIUuv4E5huAs
	HwUo6Se+1QNu4T
X-X-Sender: gene099@racer.site
In-Reply-To: <1185891786.11086.40.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54356>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-622390028-1185893725=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 31 Jul 2007, Kristian H?gsberg wrote:

> On Mon, 2007-07-30 at 21:36 -0700, Junio C Hamano wrote:
> > Kristian Høgsberg <krh@redhat.com> writes:
> > 
> > > +static void inline strbuf_grow(struct strbuf *sb, size_t extra)
> > > +{
> > > +	while (sb->alloc < sb->len + extra)
> > >  		sb->alloc = sb->alloc * 3 / 2 + 16;
> > > +	sb->buf = xrealloc(sb->buf, sb->alloc);
> > > +}
> > 
> > Somehow this while () loop to compute the growth factor bothers
> > me but that is probably a minor detail.
> 
> Think of it as a more efficient way of adding one character at a time :)
> And it's logarithmic in the number of extra bytes.  By the way, I
> normally just double the size in these cases, which gives you amortized
> linear performance for adding to the buffer.  What's behind the * 3 / 2
> idea?

But why not

	sb->alloc = alloc_nr(sb->len + extra);

Hmm?

Ciao,
Dscho

--8323584-622390028-1185893725=:14781--
