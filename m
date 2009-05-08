From: Robert Munteanu <robert.munteanu@gmail.com>
Subject: Maintaining a repository with symlinks
Date: Fri, 8 May 2009 14:00:00 +0300
Message-ID: <e60f3a6e0905080400u3bc8d29ewdf6481dc135e17d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 13:00:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2NoM-0006mW-VS
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 13:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZEHLAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 07:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbZEHLAE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 07:00:04 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54781 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbZEHLAC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 07:00:02 -0400
Received: by fxm2 with SMTP id 2so1323629fxm.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=EzZEbFMOqlywOpO5NRmDMEJ7hErqOGimfBd+ksCwg9o=;
        b=IF4kni9NxIE7z7gKjFzv6z2mBbB0c0R2FEs7MZbWfWiSDEcmktL/TfvZqXzEUwTXdJ
         /r9W7sJR0zRrn40VeC2shTxLYW6qbjiUTsTGlL8V8ekngZ75OZ/nF6xuQCnBzw9bkBi7
         Ttmi7SJVFTgnP466izwWAbXFvR9MTsZF02u3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=V3fPqZ8phy4qqvWxhvI78KS5xmbJCk+7aALELpQcuBP/gYesZ3d8a6u1NHUhK492OU
         P+44ajwWRE1T4f2s1MjeFSE7HXqGdaKsPUoAXmF5e95xAwYd4xPPJVgJtQiwJ8sT8SaH
         zM668ubCHJDWZGy7y925z+FdZxgBKOPnBdYdY=
Received: by 10.223.119.198 with SMTP id a6mr2042322far.42.1241780401453; Fri, 
	08 May 2009 04:00:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118598>

Hi,

I'm trying to build a repository of the system configuration files in
/etc. Named is installed in a chroot jail in
/var/named/chroot/var/named/data . I'm interested in getting both the
regular etc files and the named ones in the same repository since I
use branches to stage changes and it makes life easier when adding an
apache virtual host and a name server entry at the same time.

I've tried unifying the directory structure by symlinking them, but
git refuses to add that path:

[root@ns1 etc]# ln -s /var/named/chroot/var/named/ named-chroot
[root@ns1 etc]# git add named-chroot/*
fatal: 'named-chroot/xxx.xxx' is beyond a symbolic link

I've googled for 'git symlink' but I found no relevant information.

Is there another way of joining these directories into one repository?

Thanks,

Robert
