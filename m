From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 16:20:03 +0100
Message-ID: <200901111620.03345.borntraeger@de.ibm.com>
References: <200901111602.53082.borntraeger@de.ibm.com> <200901111607.59054.borntraeger@de.ibm.com> <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@linux-foundation.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 16:22:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM295-0002AB-Ta
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 16:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbZAKPVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 10:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZAKPVK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 10:21:10 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:42449 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbZAKPVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 10:21:09 -0500
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id n0BFK4X7234154;
	Sun, 11 Jan 2009 15:20:04 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id n0BFK4uB3084340;
	Sun, 11 Jan 2009 15:20:04 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n0BFK3h2032536;
	Sun, 11 Jan 2009 15:20:04 GMT
Received: from sig-9-145-110-244.uk.ibm.com (sig-9-145-110-244.uk.ibm.com [9.145.110.244])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n0BFK2U9032531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Jan 2009 15:20:03 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105190>


Am Sonntag 11 Januar 2009 schrieben Sie:
> Hi,
> 
> On Sun, 11 Jan 2009, Christian Borntraeger wrote:
> 
> > Am Sonntag 11 Januar 2009 schrieb Christian Borntraeger:
> > > doing a 
> > > git bisect start
> > > git bisect good a3a798c
> > > git bisect bad v2.6.29-rc1
> > > 
> > > results in a repository without several files, e.g Makefile!
> > > git describe also fails.
> > 
> > In fact, retesting with a clean repository shows, that there are only 
btrfs 
> > files - nothing else.
> > 
> > Linus did you pull a broken btrfs repository?
> 
> I guess it is a subtree merge.  So no, nothing went wrong
> 
> Use "git bisect skip" to skip over those.

I think we should really avoid merging subtrees to the linux kernel. It makes 
bisecting a real PITA. 
Furthermore, It is unlikely, but what if the problem is part of the 581 
changesets from btrfs?

Christian
