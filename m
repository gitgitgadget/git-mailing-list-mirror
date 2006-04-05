From: Nicolas Pitre <nico@cam.org>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 12:25:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604051223510.2550@localhost.localdomain>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
 <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org>
 <Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
 <86wte4rq3d.fsf@blue.stonehenge.com> <20060405155528.GI14625@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 18:25:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRAp3-00044k-M9
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 18:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWDEQZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 12:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWDEQZb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 12:25:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38962 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751240AbWDEQZa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 12:25:30 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IX900L0HCAHSZL0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Apr 2006 12:25:30 -0400 (EDT)
In-reply-to: <20060405155528.GI14625@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18443>

On Wed, 5 Apr 2006, Shawn Pearce wrote:

> The clearly safe approach is to include the full SHA1 ID of the
> old object the patch was created from and use the xdelta in the
> patch only as a means of transporting a compressed form of the new
> version of the object.  If git-diff starts to export say a base 64
> encoding of the xdelta then it should also include the full SHA1
> ID for binary files, even if --full-index wasn't given.
> 
> git-apply should only apply an xdelta patch to the exact same
> old object.  If the tree currently has a different object at that
> path then reject the patch entirely.

Amen.  Exactly what I just said.


Nicolas
