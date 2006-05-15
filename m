From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: align git diff a..b semantics with git log a..b
Date: Mon, 15 May 2006 12:41:35 +0400
Message-ID: <44683EBF.9070307@Intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 15 10:49:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfYlm-0008J9-I9
	for gcvg-git@gmane.org; Mon, 15 May 2006 10:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWEOItf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 04:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWEOItf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 04:49:35 -0400
Received: from mga03.intel.com ([143.182.124.21]:14164 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750792AbWEOIte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 04:49:34 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101-1.ch.intel.com with ESMTP; 15 May 2006 01:49:32 -0700
Received: from fmsmsx331.fm.intel.com (HELO fmsmsx331.amr.corp.intel.com) ([132.233.42.156])
  by azsmga001.ch.intel.com with ESMTP; 15 May 2006 01:42:35 -0700
X-IronPort-AV: i="4.05,128,1146466800"; 
   d="scan'208"; a="36451641:sNHT6268843763"
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 May 2006 01:42:14 -0700
Received: from mssmsx402.ccr.corp.intel.com ([10.125.2.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 May 2006 01:42:13 -0700
Received: from [10.125.151.180] ([10.125.151.180]) by mssmsx402.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 15 May 2006 12:42:10 +0400
User-Agent: Thunderbird 1.5 (Windows/20051201)
To: git@vger.kernel.org
X-OriginalArrivalTime: 15 May 2006 08:42:10.0325 (UTC) FILETIME=[7497F450:01C677FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20035>

Hi,

Currently, git-diff accepts

	git-diff A..B

syntax, and the output seems to be equivalent of 'git-diff A B'.

IMHO, this conflicts with A..B semantics defined for git-log family of commands.
Consider following tree

O--X--Y--A1--A2  (a)
       \
        B1--B2  (b)

The command 'git log a..b' will show B1,B2, so I would find it
intuitive (and useful) to have 'git diff a..b' show B1+B2,
rather than -A2-A1+B1+B2.

So, I suggest to change semantics of 'git diff a..b'
to 'git diff `git-merge-base a b` b'.

I could contribute the documentation change if the idea is accepted and implemented.

Thanks a lot!
