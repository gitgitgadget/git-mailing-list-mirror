From: David Coombes <webeire@gmail.com>
Subject: old folders returning
Date: Sat, 10 Nov 2012 17:30:15 +0000
Message-ID: <CAN4PrMavggqn3ZM1atde5CADjszzLOvPoQasjRZfUvRKrqS-uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 18:30:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXEt5-0006in-Py
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 18:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab2KJRaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 12:30:18 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59613 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab2KJRaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 12:30:17 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5058746oag.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=YV3WPeo27avJzCP84WkA9Mn0DiUqhRHyY4D0bQkd70Y=;
        b=dHlyQTDhdxeHDShqpqSkujlnLApgI4ZDbenFUithMZxlvjHTH9NjU1ejbRuyOYYNPI
         prq4ovK/gN1ElhafxDNk8oN4+hpxSkts7SyKjCLExZSNaC6pOvWQ2lk8KGFxBRSXVh9D
         ie/wRWhbVwW4pVKWfUUhJ9VYaFOK1lYOQy+OYh2hZ2yCrf3cK+A06PBESYzeMnoOJFzG
         /QUwJHZvfKyMXkoVzgMrFZjZcxYZbtCROUBXFubdPaHVybKPZcU63dLNFKQOeqrQzd/r
         ba1R9OLSfHn/4iH2owBGJUkFWpr5xvho5Rc3jI3wRPYbsJdJXTubsOYn4HxaOqCcCK+f
         q8qw==
Received: by 10.60.31.139 with SMTP id a11mr10538716oei.74.1352568615631; Sat,
 10 Nov 2012 09:30:15 -0800 (PST)
Received: by 10.182.81.232 with HTTP; Sat, 10 Nov 2012 09:30:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209286>

Issue:
--------
I renamed a deprecated folder that i needed the code for, added ".old"
to name. I then pushed to the repository and the original folder and
the newly renamed are now in the repository and on my local branch.

I renamed 'autoflow' to 'autoflow.old' and worked away ok. But after
the push I now have both of the folders with duplicate files.

The 'autoflow' folder that has appeared is also from an earlier push
this morning 1038 its now 1727

Re-Create:
----------------
No idea how to as its the first time I've seen this. But the output
from the push is:
 git push origin autoflow
Counting objects: 267, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (132/132), done.
Writing objects: 100% (146/146), 140.69 KiB, done.
Total 146 (delta 76), reused 1 (delta 0)
To git@github.com:cityindex/labs.cityindex.com.git
   8ea3cd9..7e6ff4f  autoflow -> autoflow

Cause:
----------
The only suggestion I can think of is that the name wasn't cleared
after the "git add *" and then git went looking for an earlier copy.
But seems the issue is with the git client as well because of the
modified time. If it were pulled then the modified time would've
changed, so it must have been taken from an earlier commit on my local
branch.

System:
------------
$ git --version
git version 1.7.9.5

$ cat /etc/*release*
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=12.04
DISTRIB_CODENAME=precise
DISTRIB_DESCRIPTION="Ubuntu 12.04.1 LTS"

$ uname -a
Linux daithi-laptop 3.2.0-32-generic #51-Ubuntu SMP Wed Sep 26
21:33:09 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

--
"Any society that would give up a little liberty to gain a little security,
               will deserve neither and lose both." - Benjamin Franklin
