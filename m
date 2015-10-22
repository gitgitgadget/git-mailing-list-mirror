From: Xue Fuqiao <xfq.free@gmail.com>
Subject: ancestor and descendant ~ clarification needed
Date: Thu, 22 Oct 2015 17:06:03 +0800
Message-ID: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 11:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpBp6-0002v0-I7
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 11:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118AbbJVJGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 05:06:06 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37411 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757107AbbJVJGE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 05:06:04 -0400
Received: by igbhv6 with SMTP id hv6so55637461igb.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2015 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6/rO57XH8Cmu5/17XmFLmwWnhfdyMyVYbPGKMc4JB6g=;
        b=zrBO/UPuKx//Sy4rNnuvSaNXZoPl2fXx24rNXPqpr/seSfA2qhwsw/MTKa3N985o4x
         xhlN4Ul+v+LuR5dYnRRZNDkH1bxteC13HnOUVR200Vk9XexJh+AJ6Uh4YprK3apzu/1q
         jnxwfbkWi2rZAxXrP4fzdIzkq3vjPL1IgviLa2UmDUjDb63KwTmXvdbpBrSTd9Q+zsh+
         JQgwG0KKDoHv2JnS65RrrwML5xaFNuscC5HpRiyjhJfXQcan5eYFC4Ir78/dsrwQhKOi
         NmDr9iuDTPuMX2V+pQq9MTVhgXKnl0nXTJsC4/N4nRxRM91iuZy19jKTO8EZf9GO5nZP
         SbRw==
X-Received: by 10.50.79.164 with SMTP id k4mr14695972igx.16.1445504763433;
 Thu, 22 Oct 2015 02:06:03 -0700 (PDT)
Received: by 10.79.94.2 with HTTP; Thu, 22 Oct 2015 02:06:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280042>

Hi,

In Documentation/user-manual.txt:

   In the following, we say that commit X is "reachable" from commit Y
   if commit X is an ancestor of commit Y.  Equivalently, you could say
   that Y is a descendant of X, or that there is a chain of parents
   leading from commit Y to commit X.
[...]
   However, if the current branch is a descendant of the other--so every
   commit present in the one is already contained in the other--then Git
   just performs a "fast-forward"; the head of the current branch is
   moved forward to point at the head of the merged-in branch, without
   any new commits being created.

I'm a Git newbie.  According to my understanding, the "descendant" in
the second paragraph above should be "ancestor".  I attempt to represent
my understanding using the following diagram (please see it in a
monospaced font):

................................................

         o--o--o <-- Branch A
        /
 o--o--o <-- master

................................................

"master" is the current branch, and (as I understand it) it is an
ancestor of "Branch A", because there is a chain of parents leading from
"Branch A" to master.  So "Branch A" (i.e., "the other" branch, or the
"merged-in" branch) is a descendant of master.  I even set up a test
repository and attempted to test the above diagram with "git merge-base
--is-ancestor" (and "echo $?"), but it seems to me that the master
branch is *not* a descendant of "Branch A".

I hope you can understand my words here (English is not my native
language).  Can anyone point me in the right direction (what am I
missing)?
