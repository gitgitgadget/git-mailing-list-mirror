From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: svn to git, N-squared?
Date: Sun, 11 Jun 2006 22:02:18 -0400
Message-ID: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 12 04:03:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpblf-0000wM-Bm
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 04:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWFLCCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 22:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWFLCCU
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 22:02:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:55476 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750765AbWFLCCT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 22:02:19 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1526485nze
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 19:02:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hVG0oyPe4rWNSGHCEW4RmKa3tku4TDPFe6Ff9nxQzLX38kj72rEtPT66MegHjaYiS3C8leeb76LNmqN1ay4C1RE25UMc3FVYMvdtEYNZFznyrixbIiohc/GsLEWMNKLDUhSBHh6NqxxiC5aR4UwOtYCOyghQjExaN3rReUYOP9Y=
Received: by 10.36.141.7 with SMTP id o7mr3460389nzd;
        Sun, 11 Jun 2006 19:02:18 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Sun, 11 Jun 2006 19:02:18 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21680>

I have Mozilla CVS in a SVN repository. I've been using git-svnimport
to import it. This time I am letting it run to completion; but the
import has been running for four days now and it is only up to 2004.
The import task is stable at 570MB and it is using about 50% of my
CPU. It is constantly spawning off git write-tree, read-tree,
hash-object, update-index. It is not doing excessive disk activity.

The import seems to be getting n-squared slower. It is still making
forward progress but the progress seems to be getting slower and
slower.

It looks like it is doing write-tree, read-tree, hash-object,
update-index once or more per change set. If these commands are
n-proportional and they are getting run n times, then this is a
n-squared process. Projecting this out, the import may take 10 days or
more to completely finish.

-- 
Jon Smirl
jonsmirl@gmail.com
