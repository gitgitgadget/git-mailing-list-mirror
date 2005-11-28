From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: lost again on syntax change - local repository?
Date: 27 Nov 2005 18:01:18 -0800
Message-ID: <861x118r9t.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 28 03:01:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgYKm-0001u9-UD
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 03:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVK1CBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 21:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVK1CBZ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 21:01:25 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:16971 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751220AbVK1CBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 21:01:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id B67E78F707
	for <git@vger.kernel.org>; Sun, 27 Nov 2005 18:01:19 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 01359-01-34 for <git@vger.kernel.org>;
 Sun, 27 Nov 2005 18:01:19 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 5464B8F74D; Sun, 27 Nov 2005 18:01:19 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.14.19; tzolkin = 10 Cauac; haab = 17 Ceh
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12847>


OK, something that I understood broke again. :)
Repeating the steps from my previous attempt to understand repositories,
knowing that cg-push has been updated:

    localhost:~/Projects/Git/Play % cg-admin-setuprepo remote.git
    localhost:~/Projects/Git/Play % mkdir local.git
    localhost:~/Projects/Git/Play % cd local.git
    localhost:..Git/Play/local.git % cg-init -minitial .
    defaulting to local storage area
    Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
    Committed as 6b9850a86bbe2d07bbdaa0c5595c8f4c0423b13c.
    localhost:..Git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"
    localhost:..Git/Play/local.git % cg-branch-ls
    origin  /Users/merlyn/Projects/Git/Play/remote.git#master
    localhost:..Git/Play/local.git % 

At this point, I'm where I was before.  And this next step worked,
although I had to say "origin":

    localhost:..Git/Play/local.git % cg-push
    WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
    WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
    ssh: \033]2;[zsh] localhost: No address associated with nodename
    fatal: unexpected EOF

Uh, say what?  /some/file/foo.git#branch is no longer legal syntax?
Help!

How do I say /some/file on the local filesystem?  (I also tried
file:/some/file, and that didn't work either.)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
