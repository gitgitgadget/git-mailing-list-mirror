From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: git-config: replaces ~/.gitconfig symlink with real file
Date: Sun, 15 Jul 2007 17:27:59 -0400
Message-ID: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 23:28:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IABdN-0001Z9-Qx
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 23:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbXGOV2B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 17:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbXGOV2B
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 17:28:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:19648 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbXGOV2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 17:28:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so866255ugf
        for <git@vger.kernel.org>; Sun, 15 Jul 2007 14:27:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kj+8vAdThvh64b4ec0iItd46a5lBF/DG7WpqE77zlHpPxyw+D9DVMkQua9rdf5vgSquNoRsoqNGHiUYq0p9COKBPKxekyNLXfvKrDnkF3HgO3OqcfvMYfmNNpDPW1BTqRd+7llHqY/35Bx582JUvep/XhfvtamJ0/6xZA2ZVFxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AiJPn8HVOmBNsm+ZQjf6n2NhGBY02z3gwRHBaUMghfAz4WNyDjOStfgaGvfA12qItqs5ChGqTLbDil7FL7Ab1NrkSmb+g6TaXNxUYZ/1tBpFl2Yr7FO90Vo7i7dSsFi8IbZquMSGX4CGJfgRzAbQ4STl40jARo2elsbPmqrk1fk=
Received: by 10.78.37.7 with SMTP id k7mr1011817huk.1184534879063;
        Sun, 15 Jul 2007 14:27:59 -0700 (PDT)
Received: by 10.78.178.10 with HTTP; Sun, 15 Jul 2007 14:27:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52587>

Since the number of dot-files and dot-directories that I have in my
home directory these days is somewhat overwhelming, I like to keep
those I directly edit all together in an ~/etc directory so I can
easily back them up and/or copy them in bulk to new accounts.  So,
several of my home dot-files are just symlinks to something in ~/etc,
including ~/.gitconfig.

However, when I tried running 'git-config --global color.diff auto'
today, it removed my symlink and replaced it with a real file.  This
left me briefly a bit confused when the changes I had made didn't show
up in ~/etc/gitconfig, but git-config reported them anyway.

If I were to fix this, I'd be tempted to use realpath(3) to follow the
symlink, but I don't think it's very reliably available
cross-platform.  Certainly, it isn't used anywhere in the current git
code.  Can anyone suggest a more portable fix?

Thanks,

Bradford
