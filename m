From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Sanitize for_each_reflog_ent()
Date: Wed, 10 Jan 2007 00:40:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701100039480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701080158500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6u6z3x8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701081316110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <enumq8$oa$1@sea.gmane.org> <Pine.LNX.4.63.0701091056520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz4sj6hb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 10 00:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QZe-0004sv-LQ
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbXAIXkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbXAIXkG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:40:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:45358 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932543AbXAIXkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:40:05 -0500
Received: (qmail invoked by alias); 09 Jan 2007 23:40:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 10 Jan 2007 00:40:03 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz4sj6hb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36425>

Hi,

On Tue, 9 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 9 Jan 2007, Jakub Narebski wrote:
> >
> >> Johannes Schindelin wrote:
> >> ... 
> >> > My reasoning is that invalid entries should rather be ignored than be 
> >> > taken into account. So, to verify that you are not walking invalid data, 
> >> > you have to parse it anyway.
> >> 
> >> I think that Junio was talking about the fact, that if you for example
> >> do need only refname and sha1, there is no need to parse object at all.
> >> If you don't need to, don't parse.
> >
> > And it was exactly what _I_ was talking about, too:
> >
> > if there are invalid entries, you ignore them. So for example, if there is 
> > no timestamp and message, you don't want the osha1 or nsha1, because it is 
> > an _invalid_ record.
> 
> That's fine.  I applied your patch with minimum fixups so that
> it does not make the surviving records _invalid_ ones after
> "reflog expire" runs ;-).

Ah! Missed that one. Thanks!

Ciao,
Dscho
