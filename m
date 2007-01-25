From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] add a test case for git-merge-one-file
Date: Thu, 25 Jan 2007 09:34:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701250932360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701240214000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7nsc6f0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 09:34:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA049-00063b-4q
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 09:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965712AbXAYIeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 03:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965714AbXAYIeT
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 03:34:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:50344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965712AbXAYIeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 03:34:18 -0500
Received: (qmail invoked by alias); 25 Jan 2007 08:34:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 25 Jan 2007 09:34:17 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vy7nsc6f0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37712>

Hi,

On Wed, 24 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +git-update-index --index-info << EOF
> > +10644 $hash_one 1	one
> > +10644 $hash_two 2	one
> > +10644 $hash_three 3	one
> > +EOF
> 
> How can this work with 10644 instead of 100644?  Did you spot a
> bug in update-index --index-info?

Actually, since !S_ISLNK(010644), it uses ce_permissions(010644), which 
basically only checks if (010644 & 0100) is set (i.e. if it is executable 
by the user), and depending on this returns 0755 or 0644.

That's why it works.

Ciao,
Dscho
