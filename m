From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix big left-shifts of unsigned char
Date: Thu, 18 Jun 2009 10:15:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906181013390.16802@localhost.localdomain>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain> <E1MH3bD-0004g2-97@fencepost.gnu.org>
 <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain> <alpine.LFD.2.01.0906171654310.16802@localhost.localdomain> <alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302> <alpine.LFD.2.01.0906180856420.16802@localhost.localdomain>
 <alpine.DEB.1.00.0906181845020.4297@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHLDT-0008SR-6Y
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 19:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbZFRRPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 13:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbZFRRPs
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 13:15:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41055 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752926AbZFRRPr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 13:15:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5IHFIba010432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2009 10:15:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5IHFHJ2022429;
	Thu, 18 Jun 2009 10:15:18 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0906181845020.4297@intel-tinevez-2-302>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.472 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121858>



On Thu, 18 Jun 2009, Johannes Schindelin wrote:
> 
> The quick hack is not going to be part of sparse.git, I take it?

Not clear yet. I sent a couple of patches to the sparse list already to 
make things go better in general with running sparse on git. I can now do

	make "CC=cgcc -m64"

on my git tree, and get reasonable warnings. I'll play around with it 
that whole left-shift thing a bit more, but before I do that I'll post a 
patch for all the _other_ things sparse found in git.

		Linus
