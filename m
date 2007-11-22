From: Sam Vilain <sam@vilain.net>
Subject: Temporary directories getting errantly added into trees
Date: Thu, 22 Nov 2007 16:51:53 +1300
Message-ID: <4744FCD9.7020102@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 04:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv37u-0006cT-Vl
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 04:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbXKVDwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 22:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbXKVDwD
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 22:52:03 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:46038 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbXKVDwB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 22:52:01 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 4359127C105; Thu, 22 Nov 2007 16:51:59 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id C3E8927C0F8;
	Thu, 22 Nov 2007 16:51:55 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65739>

I just got through a rather nasty debugging session with git-rebase,
which relies on a .dotest directory.  Turns out that .dotest was
accidentally added to the tree in the history of the commit that was
being rebased onto.

There are a lot of temporary files like that made by various scripts -
eg, git-filter-branch makes .git-rewrite, etc.

I think it would be a good thing for all if you had to work very hard to
put files like this in the tree, or perhaps it would be better to go
through and make all the tools that create these temporary directories
create them under .git instead.

Thoughts/comments?
Sam.
