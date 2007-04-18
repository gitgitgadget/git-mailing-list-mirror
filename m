From: Alon Ziv <alonz@nolaviz.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 20:58:19 +0300
Message-ID: <1176919099.14664.4.camel@bruno.nolaviz.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <"200704171803.58940.a n  dyparkins"@gmail.com>
 <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <4625B99D.9090409@dawes.za.net>
 <alpine.LFD.0.98.0704180748460.2828@woody.linux-foundation.org>
 <46263B8E.9080500@dawes.za.net>
 <alpine.LFD.0.98.0704181147330.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Rogan Dawes <lists@dawes.za.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:14:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeEff-0002tY-VI
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbXDRSOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbXDRSOU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:14:20 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:45725 "EHLO
	mxout4.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbXDRSOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 14:14:19 -0400
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Apr 2007 14:14:19 EDT
Received: from mail.nolaviz.org ([194.90.198.244]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTP id <0JGP0010CGLT0KF0@mxout4.netvision.net.il> for
 git@vger.kernel.org; Wed, 18 Apr 2007 20:58:41 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])	by mail.nolaviz.org (Postfix)
 with ESMTP id EA1A82004283; Wed, 18 Apr 2007 20:58:40 +0300 (IDT)
Received: from mail.nolaviz.org ([127.0.0.1])
	by localhost (gardener.nolaviz.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04204-06; Wed, 18 Apr 2007 20:58:20 +0300 (IDT)
Received: from [192.168.0.17] (bruno.nolaviz.org [192.168.0.17])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)	by mail.nolaviz.org (Postfix)
 with ESMTP id 946472004093; Wed, 18 Apr 2007 20:58:20 +0300 (IDT)
In-reply-to: <alpine.LFD.0.98.0704181147330.4504@xanadu.home>
X-Mailer: Evolution 2.8.1
X-Virus-Scanned: Debian amavisd-new at nolaviz.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44922>

On Wed, 2007-04-18 at 11:59 -0400, Nicolas Pitre wrote:
> So if your .odf file is actually a zip with multiple files, then all you 
> have to do is to convert that zip archive into a non compressed tar 
> archive on checkins, and the reverse transformation on checkouts.  The 
> non compressed tar content will delta well, the Git archive will be 
> small, and no tricks with the index will be needed.
> 

In fact, for the specific case of OO.o files, I would claim the proper
transformation is just converting to non-compressed zip on checkin...

(Non-compressed zip is just as good here as tar, and has the added
advantage that there is no need for a reverse transformation on
checkout :))

	-az
