From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Test 9500 - unhelpful without Perl::CGI
Date: Tue, 14 Jun 2011 19:37:15 -0700
Message-ID: <BANLkTikj0GQCN94PvZz6n6fJJb5sHMApig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 04:37:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWfzF-0005bQ-Sq
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 04:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab1FOChh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 22:37:37 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50341 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753508Ab1FOChg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 22:37:36 -0400
Received: from mail-vw0-f46.google.com (mail-vw0-f46.google.com [209.85.212.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p5F2bZ4k015674
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 14 Jun 2011 19:37:36 -0700
Received: by vws1 with SMTP id 1so4999039vws.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 19:37:35 -0700 (PDT)
Received: by 10.52.188.105 with SMTP id fz9mr1044398vdc.90.1308105455162; Tue,
 14 Jun 2011 19:37:35 -0700 (PDT)
Received: by 10.52.108.103 with HTTP; Tue, 14 Jun 2011 19:37:15 -0700 (PDT)
X-Spam-Status: No, hits=-102.979 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175806>

This has probably been going on forever, and the only reason I noticed
is that I had a machine that doesn't have perl-CGI installed.

I'm talking about t9500-gitweb-standalone-no-errors.

Anyway, if you don't have that, the test fails at everything, and it
does so without any clues about _why_ it fails. I ended up figuring it
out by doing a "strace -f" to see what seems to be wrong.

Maybe that test could have some additional check for "is perl::CGI
installed at all" and at least give a useful error message rather than
just saying it failed?

                    Linus
