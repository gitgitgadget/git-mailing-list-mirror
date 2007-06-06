From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 0/2] Fix issues with series deletion
Date: Wed, 06 Jun 2007 23:05:12 +0200
Message-ID: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw2hL-0003gu-2m
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764308AbXFFVFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935096AbXFFVFO
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:05:14 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:44418 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764308AbXFFVFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:05:12 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BBAB877D7;
	Wed,  6 Jun 2007 23:05:10 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 98C2A1F019;
	Wed,  6 Jun 2007 23:05:12 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49314>

The following series fixes 2 problems with series deletion.

I am however not happy at all with the way we delete patches and
series, starting with an existence check and then deleting.  If any
error occurs midway, then we are left with an inconsistent state that
the user has to cleanup by hand.  IMHO, we should have those methods
be as robust as possible, maybe starting by removing the formatversion
item, and printing a "cleaning up zombie stack" if does not find it.
So at least after fixing a "delete" bug, we could rerun the same
command and get to a sane state again.

Does that make sense ?

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
