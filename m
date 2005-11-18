From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: git fetch --tags doesn't quite do what I expect
Date: Fri, 18 Nov 2005 14:04:58 -0800
Message-ID: <20051118220458.GA5665@agluck-lia64.sc.intel.com>
References: <12c511ca0511181114jf4ca3c0p195a128fa541b8f2@mail.gmail.com> <7v1x1diuuy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Luck <tony.luck@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 23:06:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdEM9-00007V-Ub
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 23:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVKRWFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 17:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVKRWFN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 17:05:13 -0500
Received: from fmr24.intel.com ([143.183.121.16]:9379 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030266AbVKRWFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 17:05:11 -0500
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr004.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jAIM4xbQ028986;
	Fri, 18 Nov 2005 22:04:59 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id jAIM2hX5020423;
	Fri, 18 Nov 2005 22:02:43 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id A29371A2C9;
	Fri, 18 Nov 2005 14:04:59 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id jAIM4w52005675;
	Fri, 18 Nov 2005 14:04:58 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x1diuuy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12269>

On Fri, Nov 18, 2005 at 12:06:29PM -0800, Junio C Hamano wrote:
> I am not good at documenting things, so I'd appreciate if
> somebody paraphrased the above and send it back to me in a patch
> form to update the document ;-).


How about this:

[PATCH] Update pull/fetch --tags documentation

When fetching/pulling from a remote repository the "--tags" option
can be used to pull tags too.  Document that it will limit the pull
to only commits reachable from the tags.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 0e502ae..a25d04a 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -8,7 +8,9 @@
 -t, \--tags::
 	By default, the git core utilities will not fetch and store
 	tags under the same name as the remote repository;  ask it
-	to do so using `--tags`.
+	to do so using `--tags`.  Using this option will bound the
+	list of objects pulled to the remote tags.  Commits in branches
+	beyond the tags will be ignored.
 
 -u, \--update-head-ok::
 	By default `git-fetch` refuses to update the head which
