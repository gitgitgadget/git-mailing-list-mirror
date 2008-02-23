From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] Fix up some name hashing uglies..
Date: Fri, 22 Feb 2008 20:32:59 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802222029180.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 05:34:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSm5T-0007ye-Et
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 05:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYBWEdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 23:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbYBWEdJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 23:33:09 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:46978 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751732AbYBWEdH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 23:33:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1N4X0cY017149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Feb 2008 20:33:02 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1N4WxrK012419;
	Fri, 22 Feb 2008 20:33:00 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.559 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74794>


I'll follow this with a series of three patches that do the name hashing 
cleanups I already sent out earlier, but it's now a nice sequence of three 
independent issues, where each patch is hopefully small and trivial enough 
that people say "yeah, that's obviously correct.

They're individually been run through the test-suite, although the 
problems that they address are obviously not triggered by any current 
test, largely because almost nothing actually uses the name hash lookup at 
all (and the thing that *does* use it - namely "git status", doesn't use 
it in a way that can actually trigger the bugs afaik).

But still, it's best to have it fixed, so that if anybody builds on top of 
it, they don't get bitten by the issues..

		Linus
