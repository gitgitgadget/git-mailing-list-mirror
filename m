From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: Weird behaviour of git status
Date: Fri, 16 Jan 2009 09:42:51 +0100
Message-ID: <4970488B.3010608@morey-chaisemartin.com>
Reply-To: devel@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 09:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNkQ0-00007O-E6
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 09:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765709AbZAPIto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 03:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764055AbZAPItm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 03:49:42 -0500
Received: from 2.mail-out.ovh.net ([91.121.26.226]:48254 "HELO
	2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1765637AbZAPItk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 03:49:40 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jan 2009 03:49:40 EST
Received: (qmail 19087 invoked by uid 503); 16 Jan 2009 09:55:58 -0000
Received: from b6.ovh.net (HELO mail180.ha.ovh.net) (213.186.33.56)
  by 2.mail-out.ovh.net with SMTP; 16 Jan 2009 09:55:58 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 Jan 2009 08:42:22 -0000
Received: from ensilinx1.imag.fr (HELO ?192.15.81.1?) (devel@morey-chaisemartin.com@195.221.227.189)
  by ns0.ovh.net with SMTP; 16 Jan 2009 08:42:22 -0000
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 5219109019406683870
X-Ovh-Remote: 195.221.227.189 (ensilinx1.imag.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105928>

Hello everyone,

I just noticed a weird behaviour in git status.
I have created new files in different directories in my project.
I have added all of them in the index with git add.
When I run "git status" It shows me that all my 3 files are in the index.
However if I run git-status specifying a directory, it returns that the
file in this directory are in the index but the other one isn't.

In my opinion, it should
- either display all the files as in the index (specifying a directory
wouldn't have any effect then)
- treat only file in the specified dir. So "external" files wouldn't be
shown at all.

Thanks

Nicolas

Here are the logs
_________________________
moreychn@uranus-ubuntu:~/workspace/git/osmdc$ git --version
git version 1.6.1
moreychn@uranus-ubuntu:~/workspace/git/osmdc/include$ git status
# On branch v3
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#    new file:   devmgr_common.h
#    new file:   devmgr_types.h
#    new file:   ../src/devmgr_common.c
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#    modified:   ../src/osmdc_devmgr.h
#
moreychn@uranus-ubuntu:~/workspace/git/osmdc/include$ git status .
# On branch v3
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#    new file:   devmgr_common.h
#    new file:   devmgr_types.h
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#    modified:   ../src/osmdc_devmgr.h
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#    ../src/devmgr_common.c
