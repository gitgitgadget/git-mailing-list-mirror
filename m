From: redstun <redstun@gmail.com>
Subject: Wrong 'find' executed by git gc with cygwin
Date: Fri, 25 Feb 2011 14:52:08 +0800
Message-ID: <AANLkTimC3AhO7c8w7dUngu4uB9PzLAa3drQqCOjYeBnR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 07:57:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psrbo-0006bx-3e
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 07:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab1BYG4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 01:56:55 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59602 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1BYG4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 01:56:54 -0500
Received: by fxm17 with SMTP id 17so1343155fxm.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 22:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=qlJiRVWc6PnK3/O5C7EMU2r5gZbWc6jZmo+ML96OMWk=;
        b=QMCIRsEfrc2xVUSsW9IifIHorLhArZS6vW1gCOrVjNxC4IkUXj1HmZkzxkjAzvIiJ6
         cpM+lPkZ9uXbbEVRTmEpRlyb/qEttaV3/n5pH9CvhJOuF+hdiEZtFYDeYEb3d5m85MLb
         WQSuTyVeJZsWrpbTROhrAw6p8gdB3GgnM/Jkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=oMdPPzFic29r2E3F73ihBm/vSG3KicbnkVoMZtabftlpKiV6oa9GTa3Lir28qbFdJV
         rp30US07C6O4RadjTNoCj7XMT1OA7STBvAhM3DkBDIbxpcfIQmgKhrFsXDW/1S8YSI3D
         Et9neEKtFCjKxgExDtj7mchQGFL/R/wRMaT9c=
Received: by 10.223.74.143 with SMTP id u15mr2152591faj.27.1298616772587; Thu,
 24 Feb 2011 22:52:52 -0800 (PST)
Received: by 10.223.75.199 with HTTP; Thu, 24 Feb 2011 22:52:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167877>

I'm using git on Windows via CYGWIN_NT-6.1 1.7.7(0.230/5/3)

when I run git gc, I got the following output

C:\bones> git gc
FIND: Parameter format not correct
Counting objects: 1897, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (631/631), done.
Writing objects: 100% (1897/1897), done.
Total 1897 (delta 1196), reused 1897 (delta 1196)

Looks like git gc expects /usr/bin/find from cygwin to be executed,
but it's Windows find command got executed actually.

Probably find should be executed as /usr/bin/find to avoid this problem?

N.B. altering the PATH by putting /usr/bin ahead is not eligible
because there're many other batch program expect find to be the
Windows find command.

Thanks
