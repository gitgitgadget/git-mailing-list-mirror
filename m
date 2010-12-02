From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH] fast-import: add 'ls' command
Date: Thu, 2 Dec 2010 23:57:18 +1100
Message-ID: <2F775519-BF60-4885-BAC1-1A09F7E0D9B2@cordelta.com>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com> <1291286420-13591-2-git-send-email-david.barr@cordelta.com> <AANLkTi=HuPK+q_+hdkg4yK45UcoOA5PAGi4OmsojCsFa@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 13:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO8j4-0000KO-6w
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524Ab0LBM5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 07:57:25 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:28856
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755394Ab0LBM5Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 07:57:24 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EADkm90zLWHsF/2dsb2JhbACjGAhxuUaIToVHBA
X-IronPort-AV: E=Sophos;i="4.59,288,1288530000"; 
   d="scan'208";a="294161402"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 02 Dec 2010 23:57:19 +1100
Received: (qmail 21535 invoked from network); 2 Dec 2010 23:57:19 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 2 Dec 2010 23:57:19 +1100
In-Reply-To: <AANLkTi=HuPK+q_+hdkg4yK45UcoOA5PAGi4OmsojCsFa@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162702>

Hi Sverre,

>> There are two forms of the 'ls' command, one that takes a tree-ish and
>> one relative to the index. Allow the tree-ish variant to be used anywhere
>> a comment is allowed. Allow the index variant to be used within a commit
>> where file change commands would be used.
> 
> The commit message doesn't explain why the index variant isn't allowed
> anywhere a comment is allowed. I assume that's because there's a
> half-constructed index if you're in the middle of a modify operation
> or such?

The index variant is allowed between file change commands,
at which the index should be consistent albeit deferred for hashing.
I believe this is the only place where there's naturally an implicit
active tree.

Simply, "relative to the index" only makes sense when describing
a commit.

Unfortunately, the list server dropped my summary email :(
The patch was supposed to be marked as a RFC and I gave an outline
of the intended use.

The key features I need for svn-fe are access to the index for the
current commit and access to the content of older marked commits.

NB: This version doesn't support unquoted paths.

--
David Barr
