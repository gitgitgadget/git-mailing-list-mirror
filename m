From: Steffen Prohaska <prohaska@zib.de>
Subject: git stash doesn't handle submodules with modifications
Date: Fri, 10 Aug 2007 08:24:19 +0200
Message-ID: <B6C5D5E2-6EBA-427A-8B79-C545BB23226B@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 08:23:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJNuL-00085A-Ug
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 08:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbXHJGXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 02:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbXHJGXc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 02:23:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:39617 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbXHJGXb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 02:23:31 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7A6NTNK009711
	for <git@vger.kernel.org>; Fri, 10 Aug 2007 08:23:29 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1103e.pool.einsundeins.de [77.177.16.62])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7A6NS7b017200
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 08:23:29 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55509>

Stash in combination with a submodule does not work as
expected. A submodule with modifications is not handled
correctly if it has modifications.

I started with some changes in the working tree and with
a submodule having changes, too. I do 'git stash', which
stashes away all my changes to the working tree, but it
does not store changes to the submodule. Thus,
'git status' still shows a modified submodule.

'git apply' refuses to work with a modified submodule with:
'Cannot restore on top of a dirty state'.

So, I have stashed my changes, but can't get them back
easily. This happend to me in the msysgit repo, which
includes git as a submodule.

What would be the right way to solve this?
I'd expect that stash somehow would ignore the submodule.
But it may be more correct to include the submodule into
the stash?

	Steffen
