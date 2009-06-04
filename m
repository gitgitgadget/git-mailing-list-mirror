From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 18:58:21 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906031855460.4880@localhost.localdomain>
References: <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain> <7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain> <7v8wk96knh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain>
 <7vmy8p54fr.fsf@alter.siamese.dyndns.org> <20090603224413.GA2902@coredump.intra.peff.net> <alpine.LFD.2.01.0906031547480.4880@localhost.localdomain> <20090603230606.GA5462@coredump.intra.peff.net> <alpine.LFD.2.01.0906031619150.4880@localhost.localdomain>
 <20090603233710.GA10578@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 04:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC2G1-0004QV-Iy
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 04:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbZFDB7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 21:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754370AbZFDB7k
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 21:59:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58077 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753965AbZFDB7j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 21:59:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n541wMSN023011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2009 18:58:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n541wL9f019291;
	Wed, 3 Jun 2009 18:58:22 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090603233710.GA10578@coredump.intra.peff.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120671>



On Wed, 3 Jun 2009, Jeff King wrote:
>
> I don't even see it with --full-history. 

Oh, that's because I used "gitk" rather than "git log", and that adds 
--parents, which in turn means that it actually keeps the merges. 

So with

	git log --full-history --parents --stat -- b.txt

you actually finally get a visible removal.

		Linus
