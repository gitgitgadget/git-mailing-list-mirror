From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH amend] git-mailsplit: with maildirs not only process
	cur/, but also new/
Date: Thu, 8 Nov 2007 08:24:13 +0100
Message-ID: <20071108072413.GB3170@steel.home>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home> <20071106085418.14211.qmail@54d7c9212e25c5.315fe32.mid.smarden.org> <7vfxzh7ajt.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 08:24:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq1kg-00059A-Ks
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbXKHHYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 02:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbXKHHYT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:24:19 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:32194 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbXKHHYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:24:18 -0500
Received: from tigra.home (Fc819.f.strato-dslnet.de [195.4.200.25])
	by post.webmailer.de (klopstock mo48) (RZmta 14.0)
	with ESMTP id R047a0jA86MhjA ; Thu, 8 Nov 2007 08:24:13 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 48DE5277AE;
	Thu,  8 Nov 2007 08:24:13 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 232AC56D22; Thu,  8 Nov 2007 08:24:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxzh7ajt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWowxOg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63942>

Junio C Hamano, Thu, Nov 08, 2007 03:09:26 +0100:
> Gerrit Pape <pape@smarden.org> writes:
> 
> > When saving patches to a maildir with e.g. mutt, the files are put into
> > the new/ subdirectory of the maildir, not cur/.  This makes git-am state
> > "Nothing to do.".  This patch lets git-mailsplit additional check new/
> > after reading cur/.
> >
> > This was reported by Joey Hess through
> >  http://bugs.debian.org/447396
> >
> > Signed-off-by: Gerrit Pape <pape@smarden.org>
> > ---
> >
> > On Mon, Nov 05, 2007 at 01:58:50PM +0100, Jakub Narebski wrote:
> >> > +        for (i = 0; i < 2; ++i) {
> >> Wouldn't it be better to use sizeof(sub)/sizeof(sub[0]) or it's macro
> >> equivalent ARRAY_SIZE(sub) instead of hardcoding 2 to avoid errors?
> > I made the array NULL-terminated.
> >
> > On Mon, Nov 05, 2007 at 04:26:24PM -0500, Jeff King wrote:
> >> Isn't the subject line now wrong?
> > Yes, thanks.
> >
> > On Mon, Nov 05, 2007 at 11:52:58PM +0100, Alex Riesen wrote:
> >> Why is missing "cur" (or "new", for that matter) a fatal error?
> >> Why is it error at all? How about just ignoring the fact?
> > As suggested by Jeff, I made it ignore the error on ENOENT.

Better.

> Looks good to me.  Final acks please?

Acked-by: Alex Riesen <raa.lkml@gmail.com>
