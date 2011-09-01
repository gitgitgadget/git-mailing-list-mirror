From: James Blackburn <jamesblackburn@gmail.com>
Subject: Cannot rewrite branch(es) with a dirty working directory
Date: Thu, 1 Sep 2011 16:52:02 +0100
Message-ID: <CACyv8dfL-G0Px0aFe3VFNHP-1xRUDLsFxgUu3amPGzO7qKp7jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 17:52:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz9Yn-0007fe-6B
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 17:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab1IAPwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 11:52:03 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58468 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506Ab1IAPwD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 11:52:03 -0400
Received: by vxi9 with SMTP id 9so1365763vxi.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HEvDwM4bbVXJN/2SxTWZGmzj+aHLj+FNpPh520qzwcA=;
        b=aA3cyX5cBQTCg1TDesquHjqxuMrw6kNXXzdRWV8ASb87qmU/r6VuGt8W03RoRu2adq
         /kQs0X+JwyxFRYwckk4tTA+uHd3QD0k5ivMUNaW4E/roFb+euLpr3yxttAnYW6Ir8q/z
         nF0iEGzS86TiBlKlmaxGbscMB5UtEeWFZ2NUQ=
Received: by 10.52.179.40 with SMTP id dd8mr452vdc.208.1314892322305; Thu, 01
 Sep 2011 08:52:02 -0700 (PDT)
Received: by 10.220.195.68 with HTTP; Thu, 1 Sep 2011 08:52:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180534>

Hi All,

I get a spurious:
"Cannot rewrite branch(es) with a dirty working directory."
trying to filter-branch in a clean git repo (having done a reset). The
error disappears when I do git status.

Log of the shell commands:
bash:jamesb:xl-cbga-20:33083> mkdir org.eclipse.cdt.core.linux.ia64
bash:jamesb:xl-cbga-20:33084> cp -r
../../../CDT_HEAD_GIT/org.eclipse.cdt/.git
org.eclipse.cdt.core.linux.ia64/
bash:jamesb:xl-cbga-20:33085> cd org.eclipse.cdt.core.linux.ia64/
mbash:jamesb:xl-cbga-20:33086> git reset --hard
Checking out files: 100% (11879/11879), done.
HEAD is now at a03d454 Build against a local mirror of the 3.7 p2 repo
bash:jamesb:xl-cbga-20:33087> git filter-branch --subdirectory-filter
core/org.eclipse.cdt.core.linux.ia64 -- master
Cannot rewrite branch(es) with a dirty working directory.
bash:jamesb:xl-cbga-20:33088> git status
# On branch master
nothing to commit (working directory clean)
bash:jamesb:xl-cbga-20:33089> git filter-branch --subdirectory-filter
core/org.eclipse.cdt.core.linux.ia64 -- master
Rewrite d7092b12c93925f6f7c4725a5abc72e55650621c (16/16)
Ref 'refs/heads/master' was rewritten
bash:jamesb:xl-cbga-20:33090> git --version
git version 1.7.3.2

Is there a particular reason why filter-branch thinks the tree is
dirty, and status magically fixes this?

Cheers,
James
