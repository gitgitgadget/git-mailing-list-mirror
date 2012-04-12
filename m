From: Rolf Leggewie <foss@rolf.leggewie.biz>
Subject: prevent push of irrelevant tags
Date: Fri, 13 Apr 2012 03:47:31 +0800
Message-ID: <4F873153.9060004@rolf.leggewie.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 21:48:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQ09-0002lS-KK
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 21:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762598Ab2DLTsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 15:48:12 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:46094 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757150Ab2DLTsK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 15:48:10 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id A2CB3D8534
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 21:48:08 +0200 (CEST)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 9E6B633A39A
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 21:48:08 +0200 (CEST)
Received: from [192.168.3.54] (unknown [112.210.65.20])
	(Authenticated sender: leggewie@arcor.de)
	by mail-in-14.arcor-online.net (Postfix) with ESMTPA id B657113B624
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 21:47:55 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net B657113B624
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195360>

Hello,

I just ran into the situation that "git push --tags" pushed tags to the
remote repo that point to commits that do not exist there.  How can this
happen?  Well, in my case it was because I have more than one remote
repo with non-overlapping tags and they cross-polluted each other. 
Another possibility that comes to mind is local tags for
work-in-progress commits, for example.

Git has the information to know that tag X will be useless in repo Y
because the commit Z it points to does not exist in Y.  It would be nice
if "git push --tags" did the right thing and excluded irrelevant tags
when pushing.  Thank you for your attention and thank you for git!

Regards

Rolf
