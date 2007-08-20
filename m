From: Adam Roben <aroben@apple.com>
Subject: Re: Splitting up a changeset
Date: Mon, 20 Aug 2007 10:11:11 -0700
Message-ID: <F75C083B-2E70-4CD0-8F4B-F207E3333D8E@apple.com>
References: <e1bf234c0708200632g3a2282bfr76863555493d513@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v900)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Showman <fshowman@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 19:11:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INAmb-0006dl-Tj
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 19:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760568AbXHTRLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 13:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759169AbXHTRLN
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 13:11:13 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49463 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbXHTRLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 13:11:12 -0400
Received: from relay12.apple.com (relay12.apple.com [17.128.113.53])
	by mail-out3.apple.com (Postfix) with ESMTP id EE1DAEF8FA8;
	Mon, 20 Aug 2007 10:11:11 -0700 (PDT)
Received: from relay12.apple.com (unknown [127.0.0.1])
	by relay12.apple.com (Symantec Mail Security) with ESMTP id CEB0528814;
	Mon, 20 Aug 2007 10:11:11 -0700 (PDT)
X-AuditID: 11807135-a5763bb000000813-e2-46c9cb2fe5e4
Received: from il0301e-dhcp195.apple.com (il0301e-dhcp195.apple.com [17.203.15.195])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay12.apple.com (Symantec Mail Security) with ESMTP id A8D80285EB;
	Mon, 20 Aug 2007 10:11:11 -0700 (PDT)
In-Reply-To: <e1bf234c0708200632g3a2282bfr76863555493d513@mail.gmail.com>
X-Mailer: Apple Mail (2.900)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56223>

On Aug 20, 2007, at 6:32 AM, Frank Showman wrote:

> What I really want to do is merge a couple of files from a changeset
> at a time. Given that GIT doesn't track files, the only sensible way
> to do that seems to split up the changeset (I want GIT to track the
> merges) and then merge (cherry pick) the split up stuff.
>
> Is there some (reasonably simple) way to do that?

    One way I've done this in the past is like this:

git cherry-pick -n <rev-to-split-up>
git reset HEAD
git add <first-batch-of-files>
git commit
git add <next-batch-of-files>
git commit
...

-Adam
