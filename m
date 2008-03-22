From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [SoC] egit: pre-proposal, problem recognition
Date: Sat, 22 Mar 2008 17:25:01 +0100
Message-ID: <47E532DD.7030901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gsoc@spearce.org
X-From: git-owner@vger.kernel.org Sat Mar 22 17:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd6XY-0008Ug-Mv
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 17:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYCVQZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 12:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYCVQZL
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 12:25:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:20519 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbYCVQZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 12:25:08 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1946501fgb.17
        for <git@vger.kernel.org>; Sat, 22 Mar 2008 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=DokvaS9jpCXBHM1UMgw9qXCfLQQfKVIdxs36KIE0X9E=;
        b=ZWfzj+LNmzFOOFsRFEMgQ3x3F3ewEqofUahIwAfxbOUFzG1a+36EkUyck1P5Pct5fxs9NrqjjMTHWe3TEKNGroET/GBJUDzitcHrN8tCX0GxNi6RM3O50czleyGNOIOCsYWr5XHtwt29l22feQhEDiDkedKh1pMsxXpVGXD2UUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=nQJL89D27w2fMcQymCAiAoU8LL4EOxSEB83UDOEDswmY9p0XuqmcH7JpTYuo2PqQY2tIWyCW1B97hszGBde0tyL+PhxbHq3CY8U6D3ucVLT0CHE9SOnzLl2TNJV2W2P8JCWpssewrwYr6X3p+T39iKSk0iB6nNyFi8W8vyJp8vE=
Received: by 10.86.99.9 with SMTP id w9mr2829903fgb.58.1206203107081;
        Sat, 22 Mar 2008 09:25:07 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id 12sm4964319fgg.6.2008.03.22.09.25.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Mar 2008 09:25:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080129 Iceape/1.1.8 (Debian-1.1.8-2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77820>

Hello Git Team,

I'm a student interested participating in egit/jgit project for this 
year GSoC. Here I'm trying to investigate what can and need to be done 
for egit plugin and jgit library -> I'm asking you kindly for some 
comments or answers. That's somehow pre-proposal, as I'd like to know on 
which part should I do more research before preparing more detailed 
proposal.

[my git-awareness status]
To this time, I've used mainly SVN as version control. Last days were my 
first days with git, and I'm excited :) I've been doing some intensive 
learning: now I feel quite confident as a git user, also have done 
overview of git's internals (.git/ structure, data structures: DAG of 
objects, branches, tags, index etc.) and workflow of main operations. 
I've also downloaded and tested egit plugin on my Eclipse instance, and 
looked over jgit and egit code (nice!).
[/my git-awareness status]

Let's start from some clean-up:
http://git.or.cz/gitwiki/EclipsePluginWishlist - isn't this site a 
little outdated? It appears that tasks: Commit, Switch Branch (without 
dirty workspace/merge support) are already done, aren't they?
Some operations look for me as rather straight-forward to implement - 
not appropriate for a whole GSoC project (or do I underestimate?). 
Namely: Create/Delete Branch, Create/Delete Tag, Gitignore, Checkout(?).
GSoC2008 site states, that most wanted tasks are (that's reasonable) 
Push and Merge implementation. Fetch operation also looks to be not 
implemented yet? Do you agree that is also one of most important 
operation not yet supported? It seems that Pull and Clone are tasks for 
future, because of Merge or Fetch dependencies.

So what can I do:
I think that 1-2 from 3 main jgit+egit tasks (Push, Fetch, Merge) appear 
to be well-sized for a GSoC project. IMO, there is also need for a lot 
of smaller improvements in egit itself: preferences, preference page, 
user-friendliness related: more icons and information, help in dialogs, 
wizards, menus etc. I'm thinking of taking 1 main task - implementing 
first jgit part, then egit part. And if I finish it before time, I could 
work on set of such smaller improvements in egit itself, to make it 
easier/nicer for user.
I'm particulary interested in protocol implementation (Fetch or Push 
operation) as main-task, but Merge also looks interesting. What is more, 
I perceive Merge and Fetch operations as most wanted, because being on 
project critical-path, blocking implementation of other tasks. Merge 
seems also to be used very often itself.

Current implementation status:
There is currently no Eclipse (GUI, workspace logic) code directly for 
each of main tasks.
What about jgit? I haven't looked at details of implementation yet 
(sorry, I'm starting), but...
For Fetch or Push: I'll need to implement protocol(s) for sure: git, ssh 
protocols first as wiki-recommends - wisely, I think. What about support 
from jgit internals: do I need to add some git structures implementation 
to accomplish Fetch or Push: like object packing, needed objects 
tracking? Or is almost everything available, so I just need to use this 
structures and concentrate on upload/receive operation and protocol 
implementation? In case of Fetch, I guess that Create Branch (easy?) 
implementation is also needed. Is local Fetch or Push already supported 
in jgit? If not, I'd start from this. I've got also some doubts 
concerning SSH vs git access protocols. Are git-receive-pack and 
git-upload-pack used by both of these access protocols? If so, it make 
things easier:)
For Merge: I'll need to implement 3-way merge algorithm. Wiki says that 
one can look at Eclipse, if it is already implemented there. IMHO it's 
better to implement it at jgit level, independently of egit, basing on 
original git implementation, don't you think (I've seen that there are 
some efforts to implement git plugin for NetMeans, basing on jgit 
library)? I wonder how laborious this task is, i.e. as for Fetch/Push: 
does translation of this algorithm written in C to Java requires 
significant changes or improvements to existing jgit code?

What do you think about importance of each task and what is your feeling 
about time needed to implement each?


At the end, few words about me, what you could expect:
I'm a BSc/MSc undergraduate of a Computer Science course at Poznan 
University of Technology (Poland). My main areas of interests are 
distributed systems and software engineering, especially quality of 
software. I'm quite experienced Java developer; and C is my "second" 
language, so I can analyze existing git implementation. I've finished 
Eclipse Summer School workshop some time ago - on Eclipse plugins 
development, so I've got some knowledge on Eclipse internals. I'm ready 
to implement protocol or algorithm when needed.
I've got some experiences with JSch (bad experience...) and Trilead SSH 
(much more postive) - BSD-licensed SSH implementations for Java.

To this time I was working on many smaller projects, and one bigger (>1 
year, BSc and grids related), mostly in small teams, sometimes 
distributed. It seems to be great experience if I can join git community:)

Thank you for your attention, I'd appreciate any comments, expectations 
or info (answers)! If you want I can move to private discussion.

PS BTW: I've wonder what "Checkpoint project" in Eclipse Team menu 
stands for?

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
