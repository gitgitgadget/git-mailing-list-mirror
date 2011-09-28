From: Stephen Bash <bash@genarts.com>
Subject: error: addinfo_cache failed during merge
Date: Wed, 28 Sep 2011 10:44:03 -0400 (EDT)
Message-ID: <26411548.33530.1317221043429.JavaMail.root@mail.hq.genarts.com>
References: <8172019.33448.1317219409234.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 16:44:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8vMz-0006Tx-HY
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab1I1OoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:44:16 -0400
Received: from hq.genarts.com ([173.9.65.1]:23834 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754316Ab1I1OoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:44:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id ADA69EA22EC
	for <git@vger.kernel.org>; Wed, 28 Sep 2011 10:44:11 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hDA+VLwFIcQ for <git@vger.kernel.org>;
	Wed, 28 Sep 2011 10:44:03 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8A8BEEA22F5
	for <git@vger.kernel.org>; Wed, 28 Sep 2011 10:44:03 -0400 (EDT)
In-Reply-To: <8172019.33448.1317219409234.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182327>

Hi all-

I'm in the process of implementing whitespace and EOL normalization for our repo.  Having completed the work on our oldest maintenance branch, I'm attempting to merge the changes recursively into newer branches.

My approach is to merge using '-s recursive -X ours --no-commit' since the only conflicts are whitespace/EOL changes and I have to renormalize the current branch before committing anyway (new files, etc.).  Unfortunately, during the merge, I got a bunch of errors like this:

error: addinfo_cache failed for path 'foo/bar.h'

So first, is this important?  Second, can that message be replaced with something more helpful?  I'm not exactly a newbie, and I certainly can't grok that message...

Doing a bit of archeology, pickaxe shows it arose in 0424138 "Fix bogus error message from merge-recursive error path", but that was Junio cleaning up the message a bit.  The original message is from the creation of merge-recursive.c in 6d297f8 "Status update on merge-recursive in C".  I should caveat that my local git/git is a little out of date because I haven't repointed it since k.org went down (I use it very rarely), so there might be something newer in this area.

Thanks,
Stephen
