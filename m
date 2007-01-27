From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/7] [DRAFT 2] StGIT, remotes, and parent information
Date: Sat, 27 Jan 2007 18:14:47 +0100
Message-ID: <20070127171435.26870.48987.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArA4-0007pW-DG
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbXA0RQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXA0RQR
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:16:17 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:32794 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbXA0RQR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:16:17 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DF8979B655;
	Sat, 27 Jan 2007 18:16:15 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 2AAB31F089;
	Sat, 27 Jan 2007 18:14:47 +0100 (CET)
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37965>

Here is a new draft version, which re-implements stgit.config to call
git-repo-config (without any caching to get things working right now),
and with write support.

The 5 other patches were modified accordingly, so in this state we can
see:

stgit$ ./stg branch -c bar origin
Checking for changes in the working directory... done
Recording "refs/heads/origin" as parent branch.
Using "origin" remote to pull parent from.  
Branch "bar" created.
stgit$ git-repo-config --get-regexp 'branch\.bar\..*'
branch.bar.merge refs/heads/origin
branch.bar.remote origin

There are many rough edges when you shake it, but that should give the
idea.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
