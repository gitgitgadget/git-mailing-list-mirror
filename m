From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Identifying_user_who_ran_=E2=80=9Cgit_reset=E2=80=9D_command?=
Date: Thu, 26 Mar 2015 12:00:42 +0530
Message-ID: <CAGDgvc1E_-+cHoYEdVJHt=mZNab5WBdpRG785=iZy+OOSBQ+EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 07:30:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb1JY-00051k-JH
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 07:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbbCZGao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 02:30:44 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35532 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbbCZGan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 02:30:43 -0400
Received: by wibbg6 with SMTP id bg6so52068371wib.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 23:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3rSa/+99g751H8CVO2GKm5+yB3nCGjTfbjUDhrNtgq8=;
        b=J7lX8rhUPd4Is91lrZIWksyczDJluszUHjXus9OQkTssRNRrRZ6NzwHjy4OXRK1zBw
         mE3D35CtL87Wmzg9pXogqbyZ7uDHNJZVSmKdRuNAkGDENJnr/xMDbAOXShkSc34KISii
         bL0v57SVtKJJHJVGjrRCvvN7XeRCwlLidnOiI+66VuygORXOsNsPCDlQgjNa82LKCqqp
         yWA2YB4m7FcBseu+lJi22/cKJoEEoCL4s7x9fMFOWxTPHYrw0oiJN1olrdletN++TZz6
         y9Ik++Iawhn5oOpOpT7TmpNEi16N+k6R8mTj1BVM7RMTeTbPVjgW49AKmO8OsynHhWi4
         jW2Q==
X-Received: by 10.194.177.195 with SMTP id cs3mr24243777wjc.141.1427351442348;
 Wed, 25 Mar 2015 23:30:42 -0700 (PDT)
Received: by 10.28.149.198 with HTTP; Wed, 25 Mar 2015 23:30:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266318>

First of all, my sincere apologies for the inordinate delay in reply.
The user who created the mess went on leave. By the time he was back,
I got stuck in some other issue. Later, I took the log of 'history'
command from his machine because i wanted to first simulate the
scenario before i could apply Alfred's check to see whether it works.

I tried simulating the scenario but couldn't reproduce it. :( Here's
the PASTEBIN link which details what the developer did and how i tried
simulating the same: http://pastebin.com/0GkSc59y

As you will notice from the above link, in the original case, the
developer got "Your branch is ahead of 'origin/some_branch' by 2
commit." message while in my simulation, i got "Your branch and
'origin/some_branch' have diverged, and have 1 and 1 different commit
each, respectively."

Not only is the message different, in the simulation, i can actually
see the user's (in this case, harry) detail in 'git log' command. In
the original case, the log did not contain any info on the user who
messed up history.

Although i did suspect that Alfred's suggestion might not actually
address this issue but i still wanted to confirm it. However, thanks
Alfred because it did solve another issue (disabling "force push") for
which i was planning to put a check. :)

@Randall/Kevin: The type of setup you suggested will definitely be
ideal but in the type of environment we operate, i'm highly skeptical
whether it will be implemented. :) I surely will highlight the issue
and its impact though. As Gergely earlier mentioned, i guess i will
have to capture ref updates. I never really looked into 'refs' before
but now i will have to. I'm sure it will help me customize many other
things as well especially access-related stuff.


Thanks again to Junio, Gergely, Alfred, Randall and Kevin for their inputs. :)
