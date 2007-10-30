From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: Missing MIME-headers in git-email-tool ..
Date: Tue, 30 Oct 2007 13:27:50 +0200
Message-ID: <20071030112750.GA6372@mea-ext.zmailer.org>
References: <20071030095338.GZ6372@mea-ext.zmailer.org> <Pine.LNX.4.64.0710301028360.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 12:28:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImpGS-0000Wm-Ab
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 12:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbXJ3L1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 07:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbXJ3L1z
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 07:27:55 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:38588 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbXJ3L1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 07:27:54 -0400
Received: (mea@mea-ext) by mail.zmailer.org id S3540329AbXJ3L1u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 13:27:50 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710301028360.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2007 at 10:31:41AM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 30 Oct 2007, Matti Aarnio wrote:
> 
> > The  git-send-email  does send posts without any sort of MIME labeling:
> > 
> >   From: / To: removed
> > 
> >   Subject: [PATCH 0/2] Blackfin I2C/TWI driver updates
> >   Date: Tue, 30 Oct 2007 17:33:15 +0800
> >   Message-Id: <1193736797-9005-1-git-send-email-bryan.wu@analog.com>
> >   X-Mailer: git-send-email 1.5.3.4
> >   Precedence: bulk
> > 
> > 
> > which per MIME rules means that the message in question is equivalent
> > to one with header labels:
> > 
> >   MIME-Version: 1.0
> >   Content-Type: text/plain; charset=US-ASCII
> >   Content-Transfer-Encoding: 7bit
> 
> AFAICT MIME headers are only added when needed.  (But that might only 
> apply to format-patch; however, if you signed off with your name, all 
> should be well.)

I wish that were true..   We (VGER's Postmasters that is) would not see
so much rejections from all over the places...   Would it motivate you
if we sent all GIT caused ones to you ?


The MIME headers should always be added.  The  charset=  -value can be
debated about.   If the headers are not there, and VGER is sending email
to system which does not report capability of receiving 8BITMIME, then
the message will be converted to QUOTED-PRINTABLE (and headers be added)

Worst that can happen when the message is mis-labelled as US-ASCII  and
still contains 8-bit chars is not outright rejection, but stripping the
8th-bit off..


> > Now if the  git-send-email would add following three lines in all
> > outgoing email headers, things would be 99% correct for a long time..
> > 
> >   MIME-Version: 1.0
> >   Content-Type: text/plain; charset=ISO-8859-15
> >   Content-Transfer-Encoding: 8BIT
> 
> No.
> 
> Not at all.
> 
> ISO-8859-15 is just as wrong as ASCII.  You just forget about the majority 
> of the population on this earth. That is just as arrogant and snobbish as 
> the people who thought that ASCII would be good enough for everyone.

I wish the world was perfect and everybody would use single unified charset..
which obviously is not true.   However as the kernel sources DO NOT SPECIFY
COMMENT CHARSET, using ISO-8859-15 is  LESS WRONG  than picking UTF-8.

The reasoning here is that getting the email thru is more important than
absolutely correct labels.

If you wish, you may scan the message content at first to determine if it does
indeed include characters outside the US-ASCII range.  You may even determine
if the charset in question is likely UTF-8 instead of one of the Latins.

Whatever you do, do put the MIME labels in place.

> Ciao,
> Dscho


/Matti Aarnio -- one of  <postmaster @ vger.kernel.org>
