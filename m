From: Sam Vilain <sam@vilain.net>
Subject: Efficiency and correctness patches for git-svn mergeinfo support
Date: Sun, 20 Dec 2009 05:33:50 +1300
Message-ID: <1261240435-8948-1-git-send-email-sam@vilain.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 17:34:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2GG-000123-Rs
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbZLSQeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbZLSQeT
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:34:19 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52453 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbZLSQeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:34:19 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 66B9D21C38F; Sun, 20 Dec 2009 05:34:13 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8CD4821C38F;
	Sun, 20 Dec 2009 05:34:04 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NM2Fq-0002Lt-0e; Sun, 20 Dec 2009 05:34:06 +1300
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135486>

This series implements some efficiency enhancements; particularly in
dealing with repositories which have a single trunk branch which
receives many merges of feature branches and/or cherry-picks.  It also
fixes a number of corner cases in the merge conversion code.

It would be nice if the people who have experienced slow git-svn
performance in these situations could test that this fixes the
performance issues, and that the resulting repositories seem to have
correct contents.

Eric, I'm using Alex's trick of a single commit which adds failing
tests - marked as _expect_failure - and then marked them as succeeding
as the series progresses.
