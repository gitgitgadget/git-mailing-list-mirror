From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make test broken w/ 180b0d7483711120e28289ff7d9fa346eddd5cb7
Date: Thu, 09 Mar 2006 22:42:28 -0800
Message-ID: <7v64mm3inf.fsf@assigned-by-dhcp.cox.net>
References: <441119DB.3020207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 10 07:42:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHbKy-0006Dq-Sl
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 07:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbWCJGmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 01:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWCJGmb
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 01:42:31 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14267 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752110AbWCJGma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 01:42:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060310064236.BVJV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Mar 2006 01:42:36 -0500
To: gitzilla@gmail.com
In-Reply-To: <441119DB.3020207@gmail.com> (A. Large Angry's message of "Thu,
	09 Mar 2006 22:16:59 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17459>

A Large Angry SCM <gitzilla@gmail.com> writes:

> *** t1200-tutorial.sh ***
> *   ok 1: blob
> *   ok 2: blob 557db03
> *   ok 3: git-diff-files -p
> *   ok 4: git diff
> *   ok 5: tree
> *   ok 6: commit
> *   ok 7: git-diff-index -p HEAD
> *   ok 8: git diff HEAD
> *   ok 9: git-whatchanged -p --root
> *   ok 10: git tag my-first-tag
> *   ok 11: git checkout -b mybranch
> *   ok 12: git branch
> *   ok 13: git resolve now fails
> *   ok 14: git show-branch
> * FAIL 15: git resolve
>         cmp resolve.expect resolve.output
> *   ok 16: git show-branch
> *   ok 17: git repack
> *   ok 18: git prune-packed
> *   ok 19: -> only packed objects
> * failed 1 among 19 test(s)

Thanks.  Will push out a fix but it should be trivial.

---

diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index c8a85f9..1002413 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -128,7 +128,7 @@ test_expect_success 'git show-branch' 'c
 git checkout mybranch
 
 cat > resolve.expect << EOF
-Updating from VARIABLE to VARIABLE.
+Updating from VARIABLE to VARIABLE
  example |    1 +
  hello   |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)
