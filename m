From: Mark Burton <markb@ordern.com>
Subject: Bugs in git-gui and git-push when pushing src:dst to mirror?
Date: Tue, 2 Dec 2008 13:08:59 +0000
Organization: Order N Ltd.
Message-ID: <20081202130859.43ba54f6@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 14:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7V1H-0008Q5-4b
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 14:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYLBNJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 08:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbYLBNJH
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 08:09:07 -0500
Received: from c2bthomr13.btconnect.com ([213.123.20.131]:22192 "EHLO
	c2bthomr13.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYLBNJG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 08:09:06 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2bthomr13.btconnect.com
	with ESMTP id BXI86752;
	Tue, 2 Dec 2008 13:09:00 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id DEFC2190CFB
	for <git@vger.kernel.org>; Tue,  2 Dec 2008 13:08:59 +0000 (GMT)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr13.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0205.49353370.02CA,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102132>


Hi,

Using git 1.6.0.4.

I just tried to push using git-gui to a mirror of the current
repository and it failed because git-gui included a src:dest refspec
and that upset git-push as the remote is a mirror. So, I think that it would
be useful if git-gui notices when the remote is a mirror and does not
pass the refspec (I shall try to form a patch later when I have some time).

The other issue is that although git-push did print the usage blurb,
it didn't actually produce a message saying what it's problem was.
Looking at the source, I would have expected to have seen "--mirror
can't be combined with refspecs" printed but it didn't happen. Here's
what I got when I run the same command (as attempted by git-gui) on the
command line:

$ git push -v tako refs/heads/multi-stream:refs/heads/multi-stream
usage: git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]

    -v, --verbose         be verbose
    --repo <repository>   repository
    --all                 push all refs
    --mirror              mirror all refs
    --tags                push tags
    --dry-run             dry run
    -f, --force           force updates
    --thin                use thin pack
    --receive-pack <receive-pack>
                          receive pack program
    --exec <receive-pack>
                          receive pack program


Any ideas?

Cheers,

Mark
