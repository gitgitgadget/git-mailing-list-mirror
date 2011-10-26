From: edman747 <edman747@gmail.com>
Subject: Problem with git svn clone --authors-file
Date: Wed, 26 Oct 2011 18:51:04 -0500
Message-ID: <CABDh3gSsi9xwvw-6stw7URGK112LvF8Rt4XJeTwGM3q-tML=2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 01:52:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJDGf-0002bP-Tu
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 01:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab1JZXvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 19:51:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54085 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab1JZXvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 19:51:05 -0400
Received: by eye27 with SMTP id 27so1978669eye.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Yen7BKYeSqF1y5UCoIAKBnfLw8lRmdEon19yvaejLeY=;
        b=SA6q/ajHqgCvQMn/NfjtiY8UicKQ1fYiiwgzJv010pkpbSFtfnh3135035PsrfZ8Rv
         adn3JJbdDL7947bbWlqbMBr9534egAWMvhehOtE1CjftE8yQ4RNi400pIgDm6SJSABm1
         3fAPqOHNMb4jNwRUXMRKYQEIIW/y77iCXP3RI=
Received: by 10.213.28.78 with SMTP id l14mr86843ebc.19.1319673064723; Wed, 26
 Oct 2011 16:51:04 -0700 (PDT)
Received: by 10.213.28.80 with HTTP; Wed, 26 Oct 2011 16:51:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184279>

Hello,
Attempting to clone a remote svn repo where I don't know all the
previous SVN author names.
installed msysgit (vista)
gitbash,
$ mkdir test
$ cd test

create authors file with a few known authors.

$ git svn clone --authors-file=authors http://svn.repo/trunk
...
runs fine until
Author: (no author) not defined in authors file

edit authors file add line: (no author) = none <email>

------
rerun previous git svn command

$ git svn clone --authors-file=authors http://svn.repo/trunk
Using existing [svn-remote "svn"]
svn-remote.svn.fetch already set to track :refs/remotes/git-svn

It stops.
$ vi trunk/.git/config
delete line: fetch = :refs/remotes/git-svn

-----
rerun previous git svn command

$ git svn clone --authors-file=authors http://svn.repo/trunk
...
runs fine until
Author: Bob not defined in authors file

edit authors file add line: Bob = bobby jones <email>

-----
rerun previous git svn command

$ git svn clone --authors-file=authors http://svn.repo/trunk
Using existing [svn-remote "svn"]
svn-remote.svn.fetch already set to track :refs/remotes/git-svn

Each time it encounters an SVN committer name that is not in the
authors-file it aborts. As expected, edit the authors file and re-run
the previous git svn command to continue

And it quits with
svn-remote.svn.fetch already set to track :refs/remotes/git-svn

Would like for it to continue without having to edit the trunk/.get/config file.
Did I miss a flag or option?

Thank You,


>From git-svn(1)
--authors-file=<filename>

Syntx is compatible with the file used by git cvsimport:

loginname

If this option is specified and git svn encounters an SVN committer
name that does not exist in the authors-file, git svn will abort
operation. The user will then have to add the appropriate entry.
Re-running the previous git svn command after the authors-file is
modified should continue operation.
