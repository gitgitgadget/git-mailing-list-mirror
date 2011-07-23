From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: RFC: Should git gc/repack respect .git/refs/replace?
Date: Sat, 23 Jul 2011 11:20:13 +0200
Message-ID: <m2wrf9cq0i.fsf@igel.home>
References: <CAH3AnrqDbebODK-A90msoB9JXUwDHKKtQAQo5VdXZ=k8bxzkYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 11:20:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkYNl-0002P7-Jb
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 11:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab1GWJUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 05:20:19 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35681 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab1GWJUR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 05:20:17 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 07596188B5BF;
	Sat, 23 Jul 2011 11:20:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 5CA8A1C00052;
	Sat, 23 Jul 2011 11:20:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 2M7NcKgLvswJ; Sat, 23 Jul 2011 11:20:14 +0200 (CEST)
Received: from igel.home (ppp-88-217-121-99.dynamic.mnet-online.de [88.217.121.99])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 23 Jul 2011 11:20:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 1D0DDCA293; Sat, 23 Jul 2011 11:20:13 +0200 (CEST)
X-Yow: ..I must be a VETERINARIAN..
In-Reply-To: <CAH3AnrqDbebODK-A90msoB9JXUwDHKKtQAQo5VdXZ=k8bxzkYQ@mail.gmail.com>
	(Jon Seymour's message of "Sat, 23 Jul 2011 18:39:17 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177682>

Jon Seymour <jon.seymour@gmail.com> writes:

> I recently damaged a USB drive containing an archive of a finished project.
>
> I am able to paper over a week of missing history by using the git
> replace mechanism, so that git rev-list now works as expected.
>
> When I run git gc or git repack, I get the following:
>
>    error: Could not read 023a1d5d3977420ba041cb556c0eee17c326aeb6
>    fatal: Failed to traverse parents of commit
> 44d578ea81f7a90989e2ee3c676f50e3aff7071f

git-replace(1):

       Replacement references will be used by default by all git commands
       except those doing reachability traversal (prune, pack transfer and
       fsck).

This is required, since the replaced objects are not supposed to be
recycled.  If you want to make the replacements permanent use git
filter-branch.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
