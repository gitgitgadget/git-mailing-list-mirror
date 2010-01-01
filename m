From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 0/4] "git reset --merge" related improvements
Date: Thu, 31 Dec 2009 16:25:33 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912311623210.3630@localhost.localdomain>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 01:26:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQVLV-0001mj-25
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 01:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab0AAA0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 19:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184Ab0AAA0B
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 19:26:01 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51635 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078Ab0AAA0A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Dec 2009 19:26:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o010PaSK006279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Dec 2009 16:25:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o010PXHL001817;
	Thu, 31 Dec 2009 16:25:34 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20091230055008.4475.95755.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135992>



On Wed, 30 Dec 2009, Christian Couder wrote:
>
> Another reroll with the following changes:
> - patches to add --keep option have been removed for now
> - documentation patch has been moved before the core code changes
> - commit messages have been improved
> - tests have been much improved thanks to Junio's suggestions
> 
> Christian Couder (3):
>   reset: improve mixed reset error message when in a bare repo
>   Documentation: reset: add some tables to describe the different
>     options
>   reset: add a few tests for "git reset --merge"
> 
> Stephan Beyer (1):
>   reset: use "unpack_trees()" directly instead of "git read-tree"

FWIW, Ack on this version of the whole series - I don't think there is 
anything controversial here, and I think avoiding the execve of read-tree 
for something we have a library function for is a good thing (and the 
change in behavior looks like a bug-fix to me).

And the whole "--keep" discussion can be resurrected later ;)

		Linus
