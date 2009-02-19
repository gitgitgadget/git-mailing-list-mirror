From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: git svn dcommit difficulties/feature request
Date: Thu, 19 Feb 2009 19:47:22 +0100
Message-ID: <200902191947.22622.kumbayo84@arcor.de>
References: <200902191930.10139.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 19:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaDxb-0008Pi-Q3
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 19:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbZBSSrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 13:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbZBSSrz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 13:47:55 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:53427 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751531AbZBSSry (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 13:47:54 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 3676233A97B
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 19:47:50 +0100 (CET)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 2330923D30E
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 19:47:50 +0100 (CET)
Received: from oberndorfer.lan (91-114-188-13.adsl.highway.telekom.at [91.114.188.13])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-06.arcor-online.net (Postfix) with ESMTPSA id D1D1439A7A7
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 19:47:49 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.6.0 mail-in-06.arcor-online.net D1D1439A7A7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1235069270; bh=T+VzCo26ybtDpl79N5WyuJoil93vr9AlKo1PWHdMR1c=;
	h=From:To:Subject:Date:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id; b=ftYenW+eADr0S
	6yMcbh8mQy0ZN7BTF6HuhB2sPOz3418V4mPD02/LgPLZzGMrJ587nJ72HBqrrEJjwMn
	boYUFPTjdRavNNHjdkZ7BrDs+xsOq0OF4L8npG4CjjCjVpc0tyj41KmxLvvO1X1OMU4
	sqbJJ02LcjzLkGsh6zhMzhTw=
User-Agent: KMail/1.9.7
In-Reply-To: <200902191930.10139.kumbayo84@arcor.de>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.94.2/9013/Thu Feb 19 17:34:10 2009 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110729>

Hi,

With the patch i am replying to git-svn got a bit more comfortable for me but 
there is still a problem left.

I fetch via svn://anonsvn.kde.org/home/kde/trunk/KDE/kdelibs
and push to svn+ssh://YOUR_LOGIN@svn.kde.org/home/kde/trunk/KDE/kdelibs

Pushing multiple changes at once to KDE servers with different fetch/commit 
url is not possible for me.

Here is what it think what happens during a push:
git svn dcommit pushes the first commit to svn.kde.org,
then tries to fetch what it just pushed from anonsvn.kde.org
(which lags behind authenticated svn by a few minutes).

git svn does not see the just committed changes, gets confused
and stops pushing the rest of the commits.

My idea would be to temporarily fetch from the authenticated server, but not 
update the current head and revdb., so nothing is affected beside the push.
But this seems quite complicated.
Or do not care about difference between fetch/dcommit url, and just fetch from 
the dcommit url during dcommit.

Anybody have a good idea if this is possible or a better way to solve this 
problem?

Greetings Peter
