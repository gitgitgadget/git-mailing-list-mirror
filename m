From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] disable post-checkout test on Cygwin
Date: Tue, 17 Mar 2009 21:34:21 +0100
Message-ID: <20090317203421.GB13458@blimp.localdomain>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com> <7vprggqeh2.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, layer <layer@known.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:36:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljg13-0004vB-TI
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 21:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbZCQUee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 16:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbZCQUed
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 16:34:33 -0400
Received: from mout2.freenet.de ([195.4.92.92]:42310 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085AbZCQUec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 16:34:32 -0400
Received: from [195.4.92.23] (helo=13.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #76)
	id 1LjfzW-0007zo-IV; Tue, 17 Mar 2009 21:34:26 +0100
Received: from x6d6d.x.pppool.de ([89.59.109.109]:45721 helo=tigra.home)
	by 13.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #76)
	id 1LjfzW-0001GZ-Aq; Tue, 17 Mar 2009 21:34:26 +0100
Received: from blimp.localdomain (ubuntu.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id C7BA3277D8;
	Tue, 17 Mar 2009 21:34:21 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 8AC7F36D27; Tue, 17 Mar 2009 21:34:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vprggqeh2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113523>

Junio C Hamano, Tue, Mar 17, 2009 17:52:09 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > It is broken because of the tricks we have to play with
> > lstat to get the bearable perfomance out of the call.
> > Sadly, it disables access to Cygwin's executable attribute,
> > which Windows filesystems do not have at all.
> 
> Hmm, perhaps when checking hooks to see if they are executable, Cygwin
> port should avoid using the "tricks"?  Compared to paths inside the
> worktree the number of hooks is a lot smaller, no?

Yes, the damn thing is just hard to disable without ifdef in
builtin-db.c or builtin-clone.c
