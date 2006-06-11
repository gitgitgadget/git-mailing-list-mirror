From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/3] another series of cg-admin-rewritehist -r fixes
Date: Sun, 11 Jun 2006 12:12:39 +0200
Message-ID: <20060611101239.11876.42498.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 14:04:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpOgY-0002ri-K9
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 14:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWFKMEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 08:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWFKMEw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 08:04:52 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45699 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751173AbWFKMEv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 08:04:51 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C68B49AAA7;
	Sun, 11 Jun 2006 14:04:50 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FpOga-0002v2-3a; Sun, 11 Jun 2006 14:04:56 +0200
To: Petr Baudis <pasky@suse.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21648>

The -r flag is a bit confusing, in that it expects the 1st revision de rewrite, and I
caught myself feeding it the last revision not to rewrite instead.  Patch #2 catches
this early.  Although Patch #2 should take care of most problems, a non-zero status
returned by a command not-last in a pipe is not caught, even under "set -e", so Patch #1
adds an additional safeguard.

Patch #3 corrects seeding of the rewrite map from -r arguments.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
