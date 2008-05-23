From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix t6031 on filesystems without working exec bit
Date: Fri, 23 May 2008 21:12:09 +0200
Message-ID: <20080523191209.GA3673@steel.home>
References: <20080518145727.GA3058@steel.home> <7v7idqaocb.fsf@gitster.siamese.dyndns.org> <20080519060015.GA3179@steel.home> <7v8wy360l8.fsf@gitster.siamese.dyndns.org> <81b0412b0805220116h4e4ff279k2e433a8a9a1cd9fc@mail.gmail.com> <7vskwawvzq.fsf@gitster.siamese.dyndns.org> <20080522131258.GE3206@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 21:13:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzchi-0008QA-Bi
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 21:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638AbYEWTMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 15:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758614AbYEWTMO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 15:12:14 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:40527 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279AbYEWTMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 15:12:12 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnareO+Vm0
Received: from tigra.home (Faf51.f.strato-dslnet.de [195.4.175.81])
	by post.webmailer.de (klopstock mo57) (RZmta 16.38)
	with ESMTP id w030e6k4NI9Avf ; Fri, 23 May 2008 21:12:09 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6AAF0277BD;
	Fri, 23 May 2008 21:12:09 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 41AA056D28; Fri, 23 May 2008 21:12:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080522131258.GE3206@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82727>

Alex Riesen, Thu, May 22, 2008 15:12:58 +0200:
> Junio C Hamano, Thu, May 22, 2008 11:04:09 +0200:
> > If your repository is marked so that executable bit is untrustworthy
> > there, the check done when switching to branch "a1" to compare if "file1"
> > that is involved in the switch operation has local changes should ignore
> > (apparent and false) executable-bit change, shouldn't it?
> 
> Will see next monday, when I get back to that wretched laptop.
> 

I managed to get my hands on it today and tried the test with your
modification. The test succeeds always and it succeeds with or without
the chmod. So it seems merge-recursive somehow ignores the x-bit from
working tree, I just cannot not find how and where.
