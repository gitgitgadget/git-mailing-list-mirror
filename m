From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 08:57:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601090850350.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 09:56:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Dhb-0001UG-Vn
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 09:51:00 +0100
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id k09H2I1P094415
	for <gcvg-git@gmane.org>; Mon, 9 Jan 2006 18:02:39 +0100 (CET)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWAIQ5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 11:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWAIQ5Q
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 11:57:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964878AbWAIQ5O (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 11:57:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k09Gv5DZ013370
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Jan 2006 08:57:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k09Gv3Fe009643;
	Mon, 9 Jan 2006 08:57:04 -0800
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15396>



On Mon, 9 Jan 2006, Linus Torvalds wrote:
>
> One thing we could do is to make it easier to apply a patch to a 
> _non_current_ branch.
>   [ ... ]
> Do you think that kind of workflow would be more palatable to you? It 
> shouldn't be /that/ hard to make git-apply branch-aware... (It was part of 
> my original plan, but it is more work than just using the working 
> directory, so I never finished the thought).

Btw, this is true in a bigger sense: the things "git" does have largely 
been driven by user needs. Initially mainly mine, but things like 
"git-rebase" were from people who wanted to work as "sub-maintainers" (eg 
Junio before he became the head honcho for git itself).

But if there are workflow problems, let's try to fix them. The "apply 
patches directly to another branch" suggestion may not be sane (maybe it's 
too confusing to apply a patch and not actually see it in the working 
tree), but workflow suggestions in general are appreciated.

We've made switching branches about as efficient as it can be (but if the 
differences are huge, the cost of re-writing the working directory is 
never going to be low). But switching branches has the "confusion factor" 
(ie you forget which branch you're on, and apply a patch to your working 
branch instead of your development branch), so maybe there are other ways 
of doing the same thing that might be sensible..

So send suggestions to the git lists. Maybe they're insane and can't be 
done, but while I designed git to work with _my_ case (ie mostly merging 
tons of different trees and then having occasional big batches of 
patches), it's certainly _supposed_ to support other maintainers too..

		Linus
