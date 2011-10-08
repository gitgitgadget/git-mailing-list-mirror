From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Sat, 08 Oct 2011 16:00:33 -0600
Message-ID: <ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
References: <1318107488.5865.46.camel@R0b0ty> <20111008213741.GA24409@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Daly Gutierrez <daly.gutierrez@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 00:01:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCexx-0005Zg-Aa
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 00:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab1JHWBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 18:01:48 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:58113 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab1JHWBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 18:01:48 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6493"; a="125981770"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 08 Oct 2011 15:01:47 -0700
Received: from [192.168.1.190] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id D245710004C2;
	Sat,  8 Oct 2011 15:01:46 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20111008213741.GA24409@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183177>

>git reflog to the rescue.  For your example above it will output
>something like this:
>
>deadbeef HEAD@{0}: checkout: moving from
>92aa5381b9f7229523dba42aa94735c30f173451 to New_Branch
>  92aa5381 HEAD@{1}: commit: Committing this in the Detached Head
>3a5bb38a HEAD@{2}: checkout: moving from master to
>3a5bb38a83c00f7acab573f0ec836577143200aa
>  deafbabe HEAD@{3}: ...
>  ...
>
>There you see the first line of the commit message from your "lost"
>commit, and you can do
>
>  git checkout -b lost_detached_head 92aa5381
>
>and you get a branch pointing to that commit you made while on
>detached head, and you can work with it as usual.

While rflog is cool, I can't help but think that git could be even more helpful for these scenarios.

First, maybe git could create refs for these automatically, perhaps with a name like orphans/1?  Maybe these refs would only be visible via git branch --orphans.

-Martin
Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
