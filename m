From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] zlib gurus out there?
Date: Wed, 8 Mar 2006 10:46:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603081042320.906@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602250012230.31162@localhost.localdomain>
 <7vzmk1izpa.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603071658300.32577@g5.osdl.org>
 <7vslptivbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603071753370.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 10:46:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGvFS-00015m-9I
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 10:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWCHJqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 04:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWCHJqW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 04:46:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:6610 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751171AbWCHJqW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 04:46:22 -0500
Received: (qmail invoked by alias); 08 Mar 2006 09:46:20 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp018) with SMTP; 08 Mar 2006 10:46:20 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603071753370.32577@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17366>

Hi,

On Tue, 7 Mar 2006, Linus Torvalds wrote:

> On Tue, 7 Mar 2006, Junio C Hamano wrote:
> > >
> > > No, I don't think that's good. You're only doing a partial deflate, you 
> > > can't ask for a Z_FULL_FLUSH. That only works if you give it the whole 
> > > buffer, and you don't.
> 
> Actually, I misread what you were trying to do, and thought this was the 
> inflate phase, not the deflate.

I don't think it matters if it is inflate or deflate. ZLib keeps an 
internal state depending on the data. That is the whole reason why the 
packing is so good: it uses the redundancy in the data already seen to 
construct a codebook. (And that's also the reason why you can't start to 
deflate in the middle.)

Ciao,
Dscho
