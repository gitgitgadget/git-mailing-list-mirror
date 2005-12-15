From: Alex Riesen <raa.lkml@gmail.com>
Subject: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 10:05:51 +0100
Message-ID: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Dec 15 10:08:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emp3m-0002iE-9Q
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 10:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVLOJFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 04:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVLOJFy
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 04:05:54 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:52428 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932494AbVLOJFw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 04:05:52 -0500
Received: by nproxy.gmail.com with SMTP id x29so102775nfb
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 01:05:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TMWNXRiROPm2ub4OGuFaRvRKMm9KMUan8f/7Cuwwjsj0ShuaoHDNoBArsqzq8rxA9QQJAd+UXzLP/T516k6QA5jPyR2nfy6xVCyWIOopVDOlOEQBGBdhbgufLa0rZ1+heoairZzRPc4+AE+QYhf46mgm7LdCDZKoIbJ5KEs9Iog=
Received: by 10.49.41.2 with SMTP id t2mr71794nfj;
        Thu, 15 Dec 2005 01:05:51 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 15 Dec 2005 01:05:51 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13690>

Hi,

just a heads-up for everyone tried "git pull" after using "git merge" too much:

$ git pull . ref1 HEAD (notice the space!)

will happily create refs/heads/HEAD. What happens next is not easily
to understand: all files suddenly declared "New" by "git status", "git
checkout" does not work, reporting "Need a single revision" (which is
actually _the_ hint here).

The solution is simple: remove .git/refs/heads/HEAD

Maybe "git fsck-object" can hint on multiple HEADS?
