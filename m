From: Michael Horowitz <mike@horowitz.name>
Subject: git-p4: Jobs and skipSubmitEdit
Date: Fri, 22 Jun 2012 12:15:11 -0400
Message-ID: <CAFLRbop2aETNp0-6AdvSTx7Jmh7epYZ6rQc6hhFHbxZrGdEo9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 18:16:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si6XG-0003l8-Ed
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 18:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762626Ab2FVQQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 12:16:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40892 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762511Ab2FVQPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 12:15:12 -0400
Received: by dady13 with SMTP id y13so2522068dad.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=VEpLdalAHLmPaRtObNJ0KlDtKicpeFzbaV1M+sZmNa8=;
        b=I/fWHLiZvWvLmqyJ5aPWCjFumjf09oARCO0dJz2M/wTaCb8IfvwnKV+3B5xKS0QzeN
         nhzCKuQMCskG1sMpt3aNBUjA4SVUUIQ3w0KpMyxylXKbiYHHYA5mx38lOpN5fb1Y+Db9
         f7d5wA7NXbDXNXFsECQcKBsGj+nuv+H+mSREg4fHds1/nQH/f5EYkIvs7RhlMxTP3FH5
         20tfVVUwVLmwuI5bGmsyga3Idu8PvVceAwYUBiiMgCPblfgB7jPGz/FkBNc3muwgx9Li
         HxJa+qa+P1gpvPo0SEJK0dXs3nrpUbok+cP0mkRJYm0wB5tu9httIRG9MCO6Sg3NO9oP
         Afnw==
Received: by 10.68.227.197 with SMTP id sc5mr12334663pbc.58.1340381711902;
 Fri, 22 Jun 2012 09:15:11 -0700 (PDT)
Received: by 10.68.44.73 with HTTP; Fri, 22 Jun 2012 09:15:11 -0700 (PDT)
X-Google-Sender-Auth: 082bnFqrWtdVAUNb64eu9_xSBcI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200445>

Hello,

I've written a git prepare-commit-msg hook to do what the Perforce
JobsView would essentially do, so I can include the jobs directly in
my git commit message, and then use git-p4.skipSubmitEdit=true, so I
can just push things into Perforce directly from git without ever
being prompted by Perforce.

Problem is that this doesn't work, because git-p4 tabs in the entire
commit message to put it in the "Description:" section of the Perforce
changelist, and my "Jobs:" ends up tabbed in, and it it required by
Perforce to be at the beginning of the line.  The submit ends up
failing, because "Jobs:" is required.  I am forced to turn off
skipSubmitEdit and edit the message to remove the tab from the "Jobs:"
line each commit.

Is there any option to make this work right, or does the git-p4 not
support this?

Thanks,

Mike
