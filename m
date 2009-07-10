From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 7/3] Make index preloading check the whole path to the
 file
Date: Thu, 9 Jul 2009 20:29:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907092028480.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain> <alpine.LFD.2.01.0907091348490.3352@localhost.localdomain> <7v8wixw7s0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 05:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP6nY-0001qn-OX
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 05:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZGJD3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 23:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbZGJD3N
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 23:29:13 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39347 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139AbZGJD3N (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 23:29:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6A3T6l9012202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 20:29:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6A3T5tk001335;
	Thu, 9 Jul 2009 20:29:05 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v8wixw7s0.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123031>



On Thu, 9 Jul 2009, Junio C Hamano wrote:
> 
> I must be missing something very obvious, but how would this call behave
> on an uninitialized cache defined above, or do we need reset_lstat_cache()
> on it before the first use?

Neither.

It should be memset() to zero. Good catch.

			Linus
