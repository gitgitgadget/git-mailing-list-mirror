From: Ilya Basin <basinilya@gmail.com>
Subject: git cvsimport: new tags not imported on second cvsimport
Date: Sat, 4 Aug 2012 13:31:08 +0400
Message-ID: <1123570348.20120804133108@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 11:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxagg-00026a-PX
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 11:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab2HDJaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 05:30:17 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56959 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab2HDJaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 05:30:16 -0400
Received: by lbbgm6 with SMTP id gm6so2043378lbb.19
        for <git@vger.kernel.org>; Sat, 04 Aug 2012 02:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GsRNaqiMh8aAt6ZTHzfSG8ho9r2mpFxLbjZEQ5dbUa0=;
        b=rBcBBx1eHD2176YMihJQIja6UjnQSBDiwgyDc+ngI6PimZiumTyBbT82qw+YW91wfQ
         BfKJYCzNnHo8b2tHVwUisCWrFtBIY7ytPBkWfEPcZ5H8GmZ1pMHr99iqC5/StI+zhWCb
         0VzyBCcBkveI9KDQ+qqeultu61GhVrK9vNWgoVkmRGyxnROEnpYs3fKXDYVXTu1S6c3U
         Tr+GSq5w8DswuK7YP1KiJ9XtfHFiUnDr9OsC3mXQuf4RLllEYF/FM+7idB1xQ6R4t6B3
         FityExQsGSzIvWFYeSaJF76gtFwRPf5YJDA/IhI5myMbibn3aWoVL04W2Sg1+yglIXry
         T0ng==
Received: by 10.152.111.71 with SMTP id ig7mr4237801lab.28.1344072615435;
        Sat, 04 Aug 2012 02:30:15 -0700 (PDT)
Received: from MAR2.localnet (ppp91-122-17-72.pppoe.avangarddsl.ru. [91.122.17.72])
        by mx.google.com with ESMTPS id sm7sm11061118lab.5.2012.08.04.02.30.13
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Aug 2012 02:30:14 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202875>

I made the initial import:
    git cvsimport -d :pserver:user@blackbird:10010/data/cvs/webgui -C SAP -r cvs -k SAP

edited .git/config:
    [cvsimport]
            module = SAP
            r = cvs
            d = :pserver:user@blackbird:10010/data/cvs/webgui

did some commits to CVS and created a new tag

Then ran:
    git cvsimport -ak
To synchronize with CVS.

The new commits were imported, but the new tag wasn't.
I made initial import again to another directory and the new tag was
in it.
