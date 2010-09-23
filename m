From: Kevin Ballard <kevin@sb.org>
Subject: git-reflog bails if branch points to bad commit
Date: Thu, 23 Sep 2010 13:13:39 -0700
Message-ID: <F628129C-56AE-4BB5-9227-4282763C5B7E@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OysB3-0006D3-94
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689Ab0IWUNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 16:13:47 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36168 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab0IWUNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 16:13:46 -0400
Received: by pwj6 with SMTP id 6so431245pwj.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 13:13:46 -0700 (PDT)
Received: by 10.142.226.8 with SMTP id y8mr1896869wfg.14.1285272826000;
        Thu, 23 Sep 2010 13:13:46 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id c14sm1322347wfe.2.2010.09.23.13.13.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 13:13:45 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156901>

Attempting to use `git reflog show foo` or `git log -g foo` will bail with "bad object: foo" if the tip commit of foo is invalid. This seems incredibly non-useful. Why should reflog care if foo points to a valid commit? This bug prevents reflog from being used in a time of great need, which someone just ran into on the #git IRC channel. Their power cut out and they ended up with a corrupt commit on the tip of their branch, and they simply could not view the reflog, which would have enabled them to roll the branch back to a previous commit. Does anybody know why reflog has this behavior?

-Kevin Ballard