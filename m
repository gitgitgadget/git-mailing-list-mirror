From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Need help deciding between subtree and submodule
Date: Tue, 17 Mar 2015 17:14:00 -0500
Message-ID: <CAHd499DN1FUzxGYBtUmZ_gKcCvXWJdR6-6XYXsN6BRn0LVO84g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 23:14:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXzkV-0003ci-PW
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 23:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbbCQWOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 18:14:03 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34683 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbbCQWOB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 18:14:01 -0400
Received: by iecsl2 with SMTP id sl2so23400967iec.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=3TXQKfWYlSaT6qndn3Yuo+YicYpbIW4tS+s8LInxbmk=;
        b=njIuL6bMjPBJhP6mkpkPrq2WQZF4HuBaPVabkvjrBEiGff0tqR/BV748u6fkfyV3XK
         yz93NeOvUDB7JTAcGKEoLOlG9YWuSFJICAtNHwLjABLjtCKDp+FaihlWKswj9ecb1KZn
         CJWDo6sRRs3dotR/dHcre1s/Ocd8f4vp1CijaE0JxBWLUUWpTGD7/23tN5vCqxPrZwov
         HBZlPJj+Ec8HsHU4e6K4fyuB3l5TpvoXuHjoe5ETng92Dm7rSHtY1GvysgUyH5V3+pp9
         o2sJDUo5LB+AbURgz3FdRAtV4Mg5YJzmjz4m9h4EdblsQ6nQKfc/LkOC5Sbsgpln0k99
         XXOA==
X-Received: by 10.50.171.170 with SMTP id av10mr1799317igc.28.1426630440439;
 Tue, 17 Mar 2015 15:14:00 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.49.138 with HTTP; Tue, 17 Mar 2015 15:14:00 -0700 (PDT)
X-Google-Sender-Auth: fPAeKza3WhRywPAwPS3Grzm_eMU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265671>

At my workplace, the team is using Atlassian Stash + git

We have a "Core" library that is our common code between various
projects. To avoid a single monolithic repository and to allow our
apps and tools to be modularized into their own repos, I have
considered moving Core to a subtree or submodule.

I tried subtree and this is definitely far more transparent and simple
to the team (simplicity is very important), however I notice it has
problems with unnecessary conflicts when you do not do `git subtree
push` for each `git subtree pull`. This is unnecessary overhead and
complicates the log graph which I don't like.

Submodule functionally works but it is complicated. We make heavy use
of pull requests for code reviews (they are required due to company
policy). Instead of a pull request being atomic and containing any app
changes + accompanying Core changes, we now need to create two pull
requests and manage them in proper order. Things also become more
difficult when branching. All around it just feels like submodule
would interfere and add more administration overhead on a day to day
basis, affecting productivity.

Is there a third option here I'm missing? If only that issue with
subtree could be addressed (the conflicts), it would be perfect enough
for us I think. I have done all the stackoverflow reading and research
I can manage at this point. I would really love some feedback from the
actual git community on what would be a practical solution and
structure here from a company perspective.

Thanks in advance!
