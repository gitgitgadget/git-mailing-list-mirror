From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/5] [DRAFT] StGIT, remotes, and parent information
Date: Sat, 27 Jan 2007 12:21:11 +0100
Message-ID: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 12:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAlfK-0005iA-8u
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 12:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbXA0LYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 06:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbXA0LYK
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 06:24:10 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:47144 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253AbXA0LYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 06:24:09 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 589B555FD
	for <git@vger.kernel.org>; Sat, 27 Jan 2007 12:24:08 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1HAldq-0003ZH-HQ; Sat, 27 Jan 2007 12:22:42 +0100
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37946>

Although they are not finished, it may be useful to give some context
to current threads to publish a snapshot of what I'm working on, so
here it is.

1/5 Move identification of parent branch's remote def up into stack class.

Mostly code reorg.

2/5 Allows extraction of information about remotes.

Introduces a handful of functions to get informations about remotes in
the repository.  Makes use of remote.<branch>.fetch multi-valued
config entry.

3/5 Basic support for keeping a ref to the parent branch.

Currently relies on the failed assumption that config.set() does what
it sounds, so rely instead on a rewritten config.py.

That's why I'd rather rewrite it rapidly without a dictionnary, at
least as a first step - we can make the implementation better
afterwards, but first make it work.  Indeed I was originally only
working on the 5th patch of this stack, and all this is already a bit
beyond of what I was envisonning...

4/5 Have 'stg branch --create' record parent information.

Putting this all together.  Would also need to do something similar in
'stg clone' and possibly other places, so some code surely needs to be
factorized.

5/5 Make 'stg pull' use git-fetch and not git-pull.

Unfinished.  Git-fetch takes care of using the remote information.
Still have to use the previous work to find out the parent branch name
to rebase onto.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
