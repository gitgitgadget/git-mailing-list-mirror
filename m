From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 0/4] Rename detection, take 2
Date: Fri, 01 Jun 2007 00:34:18 +0200
Message-ID: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 00:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HttG2-0006Ka-Kd
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 00:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbXEaWgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 18:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbXEaWgc
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 18:36:32 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51712 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbXEaWgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 18:36:31 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 050EC7259;
	Fri,  1 Jun 2007 00:36:31 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 5FF3E1F157;
	Fri,  1 Jun 2007 00:34:18 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48824>

This series brings the ability to pass arbitrary flags to git-diff
through StGIT commands.  Eg:

    stg files -O -C
    stg diff -O '-C -w --color'
    stg mail -O --binary

The latter shows that the recently-added --binary is not needed any
more, so I removed it.

While doing this, I realized that many git commands were spawned
through shell commands instead of directly exec'ing them, and that was
annyoing for consistency, so this is part of the same patch.  As a
bonus, it slightly improves performance.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
