From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 11:09:58 -0400
Message-ID: <20080501150958.GA11145@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Thu May 01 17:10:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JraQr-0005Q1-4h
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753AbYEAPJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757931AbYEAPJ7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:09:59 -0400
Received: from peff.net ([208.65.91.99]:2542 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757628AbYEAPJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:09:59 -0400
Received: (qmail 12771 invoked by uid 111); 1 May 2008 15:09:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 11:09:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 11:09:58 -0400
Content-Disposition: inline
In-Reply-To: <4819D98E.1040004@tikalk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80916>

On Thu, May 01, 2008 at 05:54:06PM +0300, Ittay Dror wrote:

> Also, would anyone like to comment on:  
> http://www.markshuttleworth.com/archives/123 (Renaming is the killer app  
> of distributed version control  
> <http://www.markshuttleworth.com/archives/123>)?

My two cents:

1. I think he is overly obsessed with renaming. He seems concerned that
somebody will show up, make a big renaming patch, and then break your
system. Guess what? They can also show up, make a big code change patch,
and then break your system. In either case you have to review the
changes before accepting them, and it is up to the version control
system to show you the changes in a way you can understand.

2. I see the same old "git developers decided renaming wasn't
important" argument. I think this is bogus. I think renaming _is_
important, but I actually prefer git's approach of deducing renames,
because it reflects a fundamental property of git: we track states, not
changes, and git doesn't care how you arrive at each state. So I am free
to use a combination of git commands, editors, patch application tools,
or anything else to get my tree to the right place.

3. He doesn't like that git doesn't track _directory_ renames. This is
not a fundamental problem with git's approach (which could deduce
directory renames after the fact), but rather comes from the fact that
directory renames are controversial. That is, even if you know (through
deduction or because an explicit rename was recorded) that "subdir1"
moved to "subdir2", that doesn't necessarily mean that new files added
into "subdir1" should make that move, as well.

-Peff
