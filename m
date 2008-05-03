From: "Ping Yin" <pkufranky@gmail.com>
Subject: git and peer review
Date: Sat, 3 May 2008 09:02:41 +0800
Message-ID: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 03 03:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js6AF-0006zz-SJ
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 03:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760016AbYECBCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 21:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756738AbYECBCn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 21:02:43 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:21592 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233AbYECBCn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 21:02:43 -0400
Received: by an-out-0708.google.com with SMTP id d40so365673and.103
        for <git@vger.kernel.org>; Fri, 02 May 2008 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=u/KkcoQFD0SwBwkZnrWx8bXqad6TjwIh+tTn9WgPy3I=;
        b=xM3pNAFROZ6V2a96bfjACCOP5iIELcswrc8dfARt8g2CXhoXlMXkkDq+xfwKFclVGtYz+AmD8I0yTMmgIGMN4cKGt9hYaXv2T6ghQRtLzndRZXCSwQLBuUCGHjgR9AZ94IZgpokSjWE/NUsSbLpomXCZeLEPmjzXH/H8Rf0OGIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tit7RxIMeutlK4n6/v8+R0G0Uh/ch40+54TjRgUtERxJUIGZ1QKpYQfqoxhB0ub7LkJ2T0CYj1NAK5uTa7gnpUs9DlYUDHoAdINd7hI10LBOdxS/hEKK5uBSgFCyIpWmY/i4QHqiUHIaJs2cQuPbZ8+RsWIGsL0F4LOhF4dHQT0=
Received: by 10.100.215.5 with SMTP id n5mr5567028ang.133.1209776561444;
        Fri, 02 May 2008 18:02:41 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 2 May 2008 18:02:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81056>

I have tried many online review tools: cucible, reviewboard and
smartcollaborator. The are both great. However, they can't satisfy all
my requirements:

1. poor git support
2. When reviewing changes between revision (or commit for git) a and
revision b, they display all changes as a single diff instead of one
diff for each intermediate revision

So finally, i decide to use git itself as the reviewing tool if i
can't find better.

I am in a company environment and i want to enforce a policy that
every commit must be reviewed before pushed to central repository. I
think i can use hooks to enforce such kind of policy.

One way i want to try is to check in the hook whether every pushed
commit has a "Reviewed-by " line .  Any suggestion?

And one question, how to add a "Reviewed-by" line automatically?

The reviewers sit near each other, so we do face-to-face peer review
and don't pass patches by email.
Say,  i have prepared a patch series,

Case 1
    I ask someone to review my patches at my machine. If the review
passes, i have to add Reviewed-by line to each commit and then merge
it to the master branch. However, i find no easy way to add
reviewed-by line. Maybe adding --reviewed-by  option to cherry-pick or
rebase or merge?

Case 2
   The reviewer is the maintainer, so i ask him to pull and review. So
now it is his turn to add review-by line. But still, how?

-- 
Ping Yin
