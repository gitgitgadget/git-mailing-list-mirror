From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Fw: Null deref in recursive merge in
	df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Wed, 29 Jul 2009 18:10:30 +0200
Message-ID: <20090729161030.GA3848@localhost>
References: <D5F958F92101F74D8A5683C2FE14F4200F23102F@post.corp.w3data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: Josh ben Jore <jbenjore@whitepages.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:18:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBr9-0005N9-SL
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbZG2QSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 12:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755444AbZG2QSL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:18:11 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:64841 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbZG2QSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 12:18:10 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 12:18:09 EDT
Received: by fxm28 with SMTP id 28so74894fxm.17
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=hCMeyeXu4kfuHAJ4wrh5ppWXQqy+XcdTKwr4xdZqqXs=;
        b=K9mwlZUl4xTdA8RmmOeCs2LsDpBQ2XapiveTn0EI3yEtefGFPhH0wwmVaIuuXksw4p
         yult/dLDs0pwT7YEJMRdIjUQPSXUUs4JMjs7f0rlBCBrKberjbSwGkymenPedtEZMmvK
         zXgN3KCLUFDWXxZcsggQWMWXMFel4OqHiI7do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=A0qJj0XDSss71YUkSjnQZPGN+x48DmbZDSDjgg1boxA2Nhc5In8vXjkqvg3M0GNkF7
         MoltTESGQktCM/weH6WGD7yWEPFIxI0o69x47LaitlMP3aGPY3WUWcOrD4N53p7zUz8d
         mqYPEYwZdCFvItM1muQsijt/6DP9UeLJbeYRU=
Received: by 10.204.119.70 with SMTP id y6mr5730584bkq.72.1248883844319;
        Wed, 29 Jul 2009 09:10:44 -0700 (PDT)
Received: from darc.dnsalias.org (p549A5360.dip.t-dialin.net [84.154.83.96])
        by mx.google.com with ESMTPS id 3sm754572bwz.88.2009.07.29.09.10.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 09:10:42 -0700 (PDT)
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MWBja-00017A-7r; Wed, 29 Jul 2009 18:10:30 +0200
Content-Disposition: inline
In-Reply-To: <D5F958F92101F74D8A5683C2FE14F4200F23102F@post.corp.w3data.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124365>

Hi,

On Tue, Jul 28, 2009 at 03:23:00PM -0700, Josh ben Jore wrote:
[...]
>   CONFLICT (rename/add): Rename
> config/conf/target/dev-ubuntu/wpn_rails/appserver.yml->config/conf/target/dev/wpn_rails/appserver.yml
> in Temporary merge branch 1. config/conf/target/dev/wpn_rails/appse2
>   Adding as config/conf/target/dev/wpn_rails/appserver.yml~Temporary merge branch 2 instead
>   Skipped config/conf/target/dev/wpn_rails/appserver.yml (merged same as existing)
[...]
>   There are unmerged index entries:
>   2 config/conf/target/dev/wpn_rails/appserver.yml
>   3 config/conf/target/dev/wpn_rails/appserver.yml
>   Merging:
>   virtual merged tree
>   e4a886b Adding legacy click log processing scripts
>   found 1 common ancestor(s):
>   09fb055 Merge commit 'rel_090630_prod_02'
> Segmentation fault

Yeah, if process_entry leaves unmerged entries, write_tree_from_memory will
return NULL. I can reproduce with the following script (same principle as
t7405).

Clemens
---

diff --git a/t/t6035-merge-recursive-ra.sh b/t/t6035-merge-recursive-ra.sh
new file mode 100755
index 0000000..15f2c7d
--- /dev/null
+++ b/t/t6035-merge-recursive-ra.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='test recursive merge with rename/add conflicts'
+
+. ./test-lib.sh
+
+#
+# history
+#
+#        a --- c
+#      /   \ /
+# root      X
+#      \   / \
+#        b --- d
+#
+
+test_expect_success setup '
+
+	: >src &&
+	git add src &&
+	test_tick &&
+	git commit -m root &&
+
+	git checkout -b a master &&
+	git mv src dst
+	test_tick &&
+	git commit -m a &&
+
+	git checkout -b b master &&
+	: >dst &&
+	git add dst &&
+	test_tick &&
+	git commit -m b
+
+	git checkout -b c a &&
+	git merge -s ours b &&
+
+	git checkout -b d b &&
+	git merge -s ours a
+'
+
+test_expect_success 'merging with rename/add conflict' '
+
+	git checkout -b test1 a &&
+	test_must_fail git merge b &&
+	test -f .git/MERGE_MSG &&
+	git diff &&
+	test -n "$(git ls-files -u)"
+'
+
+test_expect_success 'merging with a rename/add conflict between merge bases' '
+
+	git reset --hard HEAD &&
+	git checkout -b test2 c &&
+	git merge d
+
+'
+
+test_done
-- 
1.6.3.1
