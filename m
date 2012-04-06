From: Pushkar <pushkarkolhe@gmail.com>
Subject: GSOC proposal: Improving parallelism
Date: Thu, 5 Apr 2012 22:24:28 -0400
Message-ID: <CAMv=a95J2jg8of8nS7CYQdttQ52Z0pHa07HDnsU7kZ2MFnN6ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 04:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFyr9-0001mY-3d
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 04:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107Ab2DFCYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 22:24:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54961 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087Ab2DFCYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 22:24:49 -0400
Received: by ghrr11 with SMTP id r11so1117459ghr.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 19:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=paNGol6CsWKQKGpstGg2KEdNgFBgStaIZOsvuWGOLiA=;
        b=DrjSWCIacr19U6hzInQ4yZblFfDOHBlup2ukMVToSWgWq0tUQUTscY8v15eYjkEhxR
         QGnB5JQNEyVOpUcXGQwzGBzmiLjCH3GYzV7dngwhH5/7S9pU+caB/dc1HMa+fmBrTtAn
         kU2u8VQXh+l3NIbozXgkmyWeFHqU7hY1BoHvfezytFhPMrOWD7twBW4PYNkwjkttjxnM
         sI2ww2TwFobmKim5ed5iM+R4NebQzZReAPms5J+gBhRo1rtXg6nTH90wqQOzkmq/Zb6s
         TWQF/WSnoPiAFHS3+gMY/ZVXVurfbyWaxVWigIhQl05DrHF//98GoPsNqTLajf08hPtf
         eD9Q==
Received: by 10.236.170.41 with SMTP id o29mr5075393yhl.83.1333679088762; Thu,
 05 Apr 2012 19:24:48 -0700 (PDT)
Received: by 10.220.117.5 with HTTP; Thu, 5 Apr 2012 19:24:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194836>

Goal:
---------
Improving parallelism in various git commands.

As the idea page says, only git grep seems to be using threads and
there are a lot of commands that can use threads.

It does seem from the codebase that grep uses pthreads and some
interface for using threads (for pack-objects) was started in
thread-utils. To achieve this goal, I will have to mess around with
the core git functionality. I think there are 2 ways to go ahead with
this project: 1. Adding pthread mutex's specific to each and every
functionality within its current implementation (much like what grep
does), or 2. Write a pthread interface (like thread-utils),
consolidate the main data structures that would need to have mutex's
around them and restructuring some of the code base.

I think 2 is a better option, but I would like to see the codebase a
little longer to understand how much time it would involve. As far as
the timeline for gsoc is concerned, I would start of with 2/3 simple
commands which could be easily modified. I would some help from my
mentor and this list to help me identify them. After I have this
working, I can proceed to parallelize other git functionalities.

Week 1-2: Getting familiar with the git codebase
Week 2-6: Work on adding basic functionality to thread-utils and
messing with git diff/log
Week 6-10: Recognizing additional parts of git which can be parallelized
Week 10-12: Documentation/Finalizing or just keep continuing with
additional git commands if everything is going fine

Success Criteria:
----------------------
I would identify commands whose efficiency can be improved by using
threads. And then measuring time metric for each of those commands on
several git repo datasets.

About Me:
-------------
I am a second year CS PhD student at Georgia Tech. I have previously
worked with OpenCV as a gsoc student. I wrote a tracking algorithm for
them. I mostly work with robots (like a huge-a** humanoid called Golem
Krang as you can see on my website). My experience with pthreads and
writing multi-threaded programs comes from developing IPC interfaces
for robots, because robot control has to be real time and it can be
unsafe to run robot control programs in a single process. I learnt
multithreaded programming from my systems courses at Georgia Tech like
Operating Systems and High Performance Computing.

I have used git for over 2 years now, as you can see from the github
account. I had ever looked into the git codebase only to mess with
gitweb while setting up gitolite on a server. But I am interested to
work with git because previous to this the most complex open source
project I had to work with was OpenCV. I realized they were more
interested in developing algorithms, and I want to dirty my hands in
systems programming now.

You can hit up the links below to find more about me. I would like to
hear from you if you think my approach is correct or could be
different.

Web: http://www.pushkar.name/
Github: https://github.com/pushkar (look at cshm, cshm-net projects,
shared mem ipc using circular buffers)
Resume: http://pushkar.name/resume.pdf

Pushkar Kolhe
