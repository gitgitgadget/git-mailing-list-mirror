From: skillzero@gmail.com
Subject: git branch --track to link existing local branch to remote?
Date: Tue, 25 May 2010 12:40:40 -0700
Message-ID: <AANLkTinxohzZE6uinzYPIAx3iVjw7afDLsr9MPMUAvHj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 25 21:40:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGzzb-0003Cn-UY
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 21:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758691Ab0EYTkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 15:40:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44791 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758317Ab0EYTkm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 15:40:42 -0400
Received: by gwaa12 with SMTP id a12so125623gwa.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=7xXW2DiDyIjsbIitkgHUmVWxajWAfkd6OLtpDM2q6wY=;
        b=UCUzUUEKg1ubZTNce/VOHX0qVjyNGL4UzmVzT/kNb/svMBbBtM+W4aGjIHAmkQ0rOj
         BfLlVbdUjWxX/aQOSqDu8907PkouXbs+arR3bGK+oy0iJVSTW7NWU99n0W8GCq8PnNn+
         ssZpSFMSibCvheBDdJMiTNJbOBkxiPUMqlgCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=n8gzRaTJ4YTJmLxVMA5+EKLF03kQE6yo6hsAp66DACNTYIsj+BRttRhg5mLMM7HRSd
         g8kekigCf9XzYfugKw6GyGsUzQnrey/Eg8kC0o8r+lUodnW1QHgk/n7xXrPgMSIR6kWL
         7khiViHGh2jNIw2UFVWY4QTKeaJ0JLkt2eE7k=
Received: by 10.91.9.10 with SMTP id m10mr4071921agi.128.1274816441010; Tue, 
	25 May 2010 12:40:41 -0700 (PDT)
Received: by 10.90.35.5 with HTTP; Tue, 25 May 2010 12:40:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147724>

Is there a way to link a local branch, which already exists, to a
remote branch without editing the git config file? I create a local
repository and committed some changes, created a remote repository,
added the remote to the local repository, and then pushed the local
branch to the remote. Now the local master points to the same commit
as origin/master. However, the branches aren't linked in the config
file so I can't just do git pull.

I know I can manually edit the config file (as the error message on
git pull says), but it seems like 'git branch --track master
origin/master' should do that automatically, especially if both
branches point to the same commit. It currently complains that the
branch master already exists and -f doesn't let me replace the current
branch. So what I've had to do is create a temp branch, switch to it,
do git branch -f --track master origin/master, and then delete the
temp branch. Is there a better way?
