From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Add support for external programs for handling native
 fetches
Date: Sun, 26 Jul 2009 09:27:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907260925020.3960@localhost.localdomain>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org> <alpine.LFD.2.01.0907251107500.3960@localhost.localdomain> <7vmy6srngw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 18:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV6ZJ-0004wY-A4
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 18:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbZGZQ1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 12:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbZGZQ1R
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 12:27:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35945 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753383AbZGZQ1Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 12:27:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6QGRCum030285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Jul 2009 09:27:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6QGRCCn013487;
	Sun, 26 Jul 2009 09:27:12 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vmy6srngw.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.959 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124126>



On Sat, 25 Jul 2009, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > ... Not an insignificant speedup on my machine (with an 
> > obligatory "nyaah, nyaah, I can do the git test-suite under a minute" just 
> > to rub peoples noses in the fact that my desktop computer is disgustingly 
> > fast).
> 
> With git-svn tests?

Yup. There's a few tests I'm skipping, but not many:

	* skipping test, network testing disabled by default
	* skipping test, network testing disabled by default
	* skipping svnserve test. (set $SVNSERVE_PORT to enable)
	* skipping svn-info test (SVN version: 1.6.1 not supported)
	* skipping svnserve test. (set $SVNSERVE_PORT to enable)
	* skipping git-cvsserver tests, Perl SQLite interface unavailable
	* skipping git-cvsserver tests, Perl SQLite interface unavailable
	* skipping cvsimport tests, cvsps not found

(those first two ones are the GIT_TEST_HTTPD ones).

			Linus
