From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: blame follows renames, but log doesn't
Date: Tue, 19 Jun 2007 13:10:28 +1200
Message-ID: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 03:10:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0SF8-0001z3-Pv
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 03:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282AbXFSBKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 21:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbXFSBKf
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 21:10:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:18398 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765345AbXFSBKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 21:10:30 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1680452wxc
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 18:10:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ktGg3X/BLxy5TNNI8dSV/UdNTi/Jq7agw9mPfPAZKg9Ncb7oLpOz1H7bXYw/H02jvbIZOxzaRUkZ/EONMZfqOOHvMzeDdAO4MeNQfBKJ4vDwE0iSnpRJBPVlSh7/vgKsDeetwdhUkI7hyFcvhxtyy5B52EdcQ73y8f+2RKOUXQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UJdd15u6s8Rl1QrgU1S6rNdcqbvz4o7q1JF9KfIJTE+f5OjSUXEzYtm1o/MvcbBGQx2TEyNNqVpPCER8FQkEuqlNhkM4uO1QT527EPoZDF3WtzJKTNbUtgyV8GF5nEMJCn/zoN8OMkA3AJGLu7Ml6Y5wVCCj9rGYndZzqh3o1zY=
Received: by 10.90.118.12 with SMTP id q12mr4505914agc.1182215428698;
        Mon, 18 Jun 2007 18:10:28 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Mon, 18 Jun 2007 18:10:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50434>

Hi all,

when I show git to newbies or demo it to people using other SCMs, and
we get to the rename part of the conversation, I discuss and show how
GIT's approach is significantly better than explicit recording of
renames.

One great example is git-blame -- actually more spectacular with the
recent git gui blame improvements. But git-log still doesn't do it.

If I say
   git blame git-cvsimport.perl  # goes to the true origin like a champ
   git log git-cvsimport.perl # stops at the Big Tool Rename

In thread in May Linus posted a PoC patch to get git-blame to do it
http://marc.info/?l=git&m=117347893211567&w=2 , and outlined the
reasons why it'd be wrong to try to do that in git-log -- but it
didn't come to happen :-/

cg-log used to have some Perl logic that could do this -- it didn't
always work, but I'm sometimes tempted to go back to it, and review
it.

Linus said:
> But it's an example of the fact that yes, git can do this, but we're so
> stupid that we don't really accept it.

And I'm sure people can cope with git blame --log path/to/file and we
can add a note to git-log manpage about renames being reported by
blame instead.

And I kind of hate having to reply to things like these

    http://www.markshuttleworth.com/archives/125


cheers


martin
