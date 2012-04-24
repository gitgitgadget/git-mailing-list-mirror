From: Adam Roben <adam@roben.org>
Subject: git-fetch fetches blobs that are already in the local
 repository if no history is shared?
Date: Tue, 24 Apr 2012 10:19:06 -0400
Message-ID: <D7CFF7BD2A9545148AC2553870AA3A15@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?Q?Tor_Arne_Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 16:19:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMgaL-0005lu-SS
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 16:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549Ab2DXOTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 10:19:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35446 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab2DXOTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 10:19:09 -0400
Received: by yenl12 with SMTP id l12so352976yen.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 07:19:08 -0700 (PDT)
Received: by 10.236.73.72 with SMTP id u48mr18218681yhd.77.1335277148710;
        Tue, 24 Apr 2012 07:19:08 -0700 (PDT)
Received: from Adams-MacBook-Pro.local (cpe-069-134-056-157.nc.res.rr.com. [69.134.56.157])
        by mx.google.com with ESMTPS id j24sm11806621ann.18.2012.04.24.07.19.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 07:19:07 -0700 (PDT)
X-Mailer: sparrow 1.5 (build 1043.1)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196222>

Hi all- 

There are two main git mirrors of the WebKit Subversion repository: <git://git.webkit.org/WebKit.git> and <https://github.com/WebKit/webkit>. These repositories have the exact same trees/blobs, but have entirely different commits due to the GitHub mirror using a custom --authors-prog with git-svn.

Tor Arne (CCed) noticed something interesting today:

If you clone one of these repositories, then add the other as a remote and fetch it, all the trees/blobs seem to get pulled down again, even though they're already in the local repository. It seems like only the commit objects should be fetched, since they're the only difference between the two remotes.

Is this a bug in git? 

-Adam
