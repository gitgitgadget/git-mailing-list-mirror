From: Xue Fuqiao <xfq.free@gmail.com>
Subject: Re: ancestor and descendant ~ clarification needed
Date: Fri, 23 Oct 2015 15:29:05 +0800
Message-ID: <CAAF+z6H+wwCOhPCU-_Uh-Odc=411N+G+d_iE_AKX+JxVMDtsMQ@mail.gmail.com>
References: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
	<xmqqfv12r6vn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 09:29:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpWmm-0006aI-3B
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 09:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbbJWH3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 03:29:07 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33963 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbJWH3G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 03:29:06 -0400
Received: by iow1 with SMTP id 1so115896834iow.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 00:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8aMeek8QPOtsOObwxgePTz59e1mM55FGC9pr1DSeyJw=;
        b=KrfUeAd1aJqfnYBmfXf8IPI3LRp8p7mKCLrwsCIahzJFPAfZbHiIbyXgu3ragfcYVF
         mtiZLKr6g26GigU4VZqMyjoPUlyKjerm2ziZ73TElxqHAfGvm/H+tVmr3bombmU2SCdR
         428CvJbNKIWQcRqyMEoA98U4/t0rnwMvfmIrOBl2FgonzKGg3Dpsu/HyBgr73gBkoqO8
         ay5WTc/PT1ap1LDRHtR8l05cSmkcRpCsXo18VhJLINjsxEMrV/CJ9C/xda4UMvFRr+CU
         5rQv88FolgXUIRkMu6rcrC2fB6OAhlj7NjdH0+pIPodlm+le635e4tiHWv/2NGBRBGSb
         BVZw==
X-Received: by 10.107.16.90 with SMTP id y87mr784115ioi.183.1445585345656;
 Fri, 23 Oct 2015 00:29:05 -0700 (PDT)
Received: by 10.79.94.2 with HTTP; Fri, 23 Oct 2015 00:29:05 -0700 (PDT)
In-Reply-To: <xmqqfv12r6vn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280088>

Hi Junio,

On Fri, Oct 23, 2015 at 4:22 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Yeah, that is the other way around.
>
>  (1) If the current branch is a descendant of the other--so every
>      commit present in the other branch is already contained in the
>      current branch--then merging the other branch into the current
>      branch is a no-op "Already up-to-date!".
>
>  (2) If the current branch is an ancestor of the other--so every
>      commit present in the current branch is already contained in
>      the other branch--then merging the other branch into the
>      current branch can be fast-forwarded, by moving the tip of the
>      current branch to point at the commit at the tip of the other
>      branch, and by default Git does so, instead of creating an
>      unnecessary merge.

I see.  Thank you.  What do you think about the following minor patch
for user-manual.txt?  I can send a more formal one using format-patch
and send-email if needed.

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1b7987e..d68df13 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1431,11 +1431,11 @@ differently.  Normally, a merge results in a
merge commit, with two
 parents, one pointing at each of the two lines of development that
 were merged.

-However, if the current branch is a descendant of the other--so every
-commit present in the one is already contained in the other--then Git
-just performs a "fast-forward"; the head of the current branch is moved
-forward to point at the head of the merged-in branch, without any new
-commits being created.
+However, if the current branch is an ancestor of the other--so every commit
+present in the current branch is already contained in the other
branch--then Git
+just performs a "fast-forward"; the head of the current branch is moved forward
+to point at the head of the merged-in branch, without any new commits being
+created.

 [[fixing-mistakes]]
 Fixing mistakes
