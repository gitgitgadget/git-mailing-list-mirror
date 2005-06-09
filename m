From: Jon Smirl <jonsmirl@gmail.com>
Subject: Lost uncommitted changes and cogito
Date: Thu, 9 Jun 2005 15:23:00 -0400
Message-ID: <9e473391050609122372080863@mail.gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jun 09 21:19:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgSYW-000374-Hr
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 21:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVFITXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 15:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVFITXH
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 15:23:07 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:1379 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262451AbVFITXA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 15:23:00 -0400
Received: by wproxy.gmail.com with SMTP id 68so313296wra
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 12:23:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qBcyaUnPFiijX8iw2PHnp2l5J39Xid+YjHfkohJ/rM7PTXuIjunKwd/tnfl1laMeHFFgN59K+E0Ei3M9YKtHmOuP0m487/ISYMsmfQPt0pDFmKUzoTFxNbAIvNH/K1e7+WBE8FLQzf2PXCsubbNkjJ8XJiYYbDP9BkJMj65iwow=
Received: by 10.54.124.5 with SMTP id w5mr579286wrc;
        Thu, 09 Jun 2005 12:23:00 -0700 (PDT)
Received: by 10.54.94.8 with HTTP; Thu, 9 Jun 2005 12:23:00 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Uning current updated cogito I have three trees:

linus
linux-good 
linux-merge

linux-merge had uncommitted changes

>From linus I did cg update which pulled from linus.
From linux-merge I did cg update which pulled from linus.

At this point the uncommitted changes in linux-merge were fine. 

Then I wasn't thinking and did cg update linux-good from linux-merge.
linux-merge was already update to date with linux-good since there
were no changes to linux-good pending. Doing that update created an
empty commit and also lost my uncommitted changes. Shouldn't that have
just done nothing?

>From first update in linux-merge:
Applying changes...
drivers/char/drm/Kconfig: locally modified
drivers/char/drm/drm_drv.c: locally modified
drivers/char/drm/radeon_drv.c: locally modified
drivers/char/drm/radeon_drv.h: locally modified
drivers/video/aty/radeon_base.c: locally modified
Merging 35d1bc90546d1f0af198886ae8062a550142d926 ->
cf380ee7308db0f067ceb2ae8b852838788bf453
        to 4952d9aaa928e711b0cd40c6a6d48b73544b88f0...

Committed as 941cc5f620f6f4827885bc3f03519416bd9461ab.
[jonsmirl@jonsmirl linux-merge]$ make

>From second - local changes are gone.
Applying changes...
Merging cf380ee7308db0f067ceb2ae8b852838788bf453 ->
a7db5e4f33e72569936af357084e31305fab6618
        to 941cc5f620f6f4827885bc3f03519416bd9461ab...

Committed as b0165eea961c7f2809a0aaabae7904a3a766ee05.
[jonsmirl@jonsmirl linux-merge]$ make


-- 
Jon Smirl
jonsmirl@gmail.com
