From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: git ls-files --error-unmatch weirdness
Date: Fri, 12 Aug 2011 15:24:36 +0200
Message-ID: <20110812132436.GA12147@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 15:30:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrroh-0005Hy-OV
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 15:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab1HLNaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 09:30:17 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:32723 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab1HLNaP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 09:30:15 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Aug 2011 09:30:15 EDT
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 12 Aug
 2011 15:24:31 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 12 Aug
 2011 15:24:35 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179228>

Hi,

I was looking for untracked files when noticed this:

repo$ git init
Initialized empty Git repository in /home/szeder/tmp/git/repo/.git/
repo (master)$ mkdir dir
repo (master)$ touch dir/file
repo (master)$ git add dir/file
repo (master)$ git commit -m 'first'
[master (root-commit) 2c0990c] first
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 dir/file
repo (master)$ git ls-files --others --error-unmatch
repo/dir (master)$ echo $?
0
repo (master)$ cd dir
repo/dir (master)$ git ls-files --others --error-unmatch
error: pathspec '' did not match any file(s) known to git.
Did you forget to 'git add'?
repo/dir (master)$ echo $?
1

So, the same 'git ls-files' command is OK when run at the top of the
worktree, but errors out in a subdirectory.  What's going on?  Is this
a bug?  If not, why not?


Thanks,
G=E1bor
