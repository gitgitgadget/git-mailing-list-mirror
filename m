From: Sam Vilain <sam@vilain.net>
Subject: Re: Efficiency and correctness patches for git-svn mergeinfo
 support
Date: Sun, 20 Dec 2009 05:42:48 +1300
Message-ID: <1261240968.20752.8.camel@denix>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 17:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2Oe-0004H2-5i
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbZLSQnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZLSQnG
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:43:06 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60756 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbZLSQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:43:04 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 0977921C475; Sun, 20 Dec 2009 05:42:54 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.234] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 0065C21C366;
	Sun, 20 Dec 2009 05:42:46 +1300 (NZDT)
In-Reply-To: <1261240435-8948-1-git-send-email-sam@vilain.net>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135493>

On Sun, 2009-12-20 at 05:33 +1300, Sam Vilain wrote:
> This series implements some efficiency enhancements; particularly in
> dealing with repositories which have a single trunk branch which
> receives many merges of feature branches and/or cherry-picks.  It also
> fixes a number of corner cases in the merge conversion code.
> 
> It would be nice if the people who have experienced slow git-svn
> performance in these situations could test that this fixes the
> performance issues, and that the resulting repositories seem to have
> correct contents.
> 
> Eric, I'm using Alex's trick of a single commit which adds failing
> tests - marked as _expect_failure - and then marked them as succeeding
> as the series progresses.

More useful info:

 git-svn.perl               |  220 +++++++++----
 t/t9151-svn-mergeinfo.sh   |   27 ++-
 t/t9151/make-svnmerge-dump |  166 ++++++---
 t/t9151/svn-mergeinfo.dump |  839
++++++++++++++++++++++++++++++++++++++------
 4 files changed, 1018 insertions(+), 234 deletions(-)

And available at git://github.com/samv/git (branch mergeinfo-fixes)

Sam
