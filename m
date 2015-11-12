From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Fw: [git-users] git fsck error - duplicate file entries - different
 then existing stackoverflow scenarios
Date: Thu, 12 Nov 2015 14:02:10 +0300
Message-ID: <20151112140210.ef05a31c401dd49992e9674e@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Wind Over Water <wndovrwtr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 12:02:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwpdz-0003Gg-Hk
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 12:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbbKLLCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 06:02:15 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:50804 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbbKLLCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 06:02:14 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id tACB2A1e009688;
	Thu, 12 Nov 2015 14:02:11 +0300
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281216>

A user recently asked an interesting question on the git-users list.
I think it warrants attentions of a specialists more hard-core than
we're there over at git-users.

So I'd like to solicit help if those knowledgeable, if possible.

Begin forwarded message:

Date: Wed, 11 Nov 2015 14:30:40 -0800 (PST)
From: Wind Over Water <wndovrwtr@g...>
To: Git for human beings <git-users@g...>
Subject: [git-users] git fsck error - duplicate file entries -
different then existing stackoverflow scenarios


Hi all,

I have a repo that is giving a 'git fsck --full' error that seems to be 
different from the existing questions and answers on stackoverflow on
this topic.  For example, in our fsck error it is not obvious which
file is actually duplicated and how/where.  And there is no commit sha
involved - apparently only blob and tree sha's.  But then finding good
documentation on this is challenging.

Might anyone have a pointer as to what to read to help figure out a 
solution/fix to the below?  Or know of a solution outright?

Thanks much in advance!

-sandy

$ git fsck --full

Checking object directories: 100% (256/256), done.

error in tree df79068051fa8702eae7e91635cca7eee1339002: contains
duplicate file entries

error in tree c2d09540a3c3f44c42be1dc8a2b0afa73a35f861: contains
duplicate file entries

Checking objects: 100% (623704/623704), done.

Checking connectivity: 623532, done.

dangling commit 4d1402c8c74c9f4de6172d7dbd5a14c41683c9e8


$ git ls-tree df79068051fa8702eae7e91635cca7eee1339002

100644 blob 14d6d1a6a2f4a7db4e410583c2893d24cb587766 build.gradle

120000 blob cd70e37500a35663957cf60f011f81703be5d032 msrc

040000 tree 658c892e15fbe0d3ea6b8490d9d54c5f2e658fc9 msrc

100644 blob f623819c94a08252298220871ac0ba1118372e59 pom.xml

100644 blob 9223cc2fddb138f691312c1ea2656b9dc17612d2 settings.gradle

040000 tree c3bac1d92722bdee9588a27747b164baa275201f src


$ git ls-tree c2d09540a3c3f44c42be1dc8a2b0afa73a35f861

100644 blob 14d6d1a6a2f4a7db4e410583c2893d24cb587766 build.gradle

120000 blob cd70e37500a35663957cf60f011f81703be5d032 msrc

040000 tree 658c892e15fbe0d3ea6b8490d9d54c5f2e658fc9 msrc

100644 blob f623819c94a08252298220871ac0ba1118372e59 pom.xml

100644 blob 9223cc2fddb138f691312c1ea2656b9dc17612d2 settings.gradle

040000 tree a5aa6758a25fee779cbb8c9717d744297071ea79 src


$ git show cd70e37500a35663957cf60f011f81703be5d032

src/main/java/com/foo/bar/baz/common/


$ git show 658c892e15fbe0d3ea6b8490d9d54c5f2e658fc9

tree 658c892e15fbe0d3ea6b8490d9d54c5f2e658fc9


BillingAggregator.java

BillingDataThriftAdapter.java

[...]

MetricsProcessor.java
