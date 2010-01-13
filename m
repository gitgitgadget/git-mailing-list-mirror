From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: touching a file causes it to be listed using git diff-files
Date: Wed, 13 Jan 2010 18:57:28 -0500
Message-ID: <p0624080ec7740ddc4caf@[63.138.152.134]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 01:03:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVDBV-0001A9-SO
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 01:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab0ANADQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 19:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968Ab0ANADQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 19:03:16 -0500
Received: from deanbrook.org ([72.52.70.192]:57738 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753231Ab0ANADQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 19:03:16 -0500
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2010 19:03:16 EST
Received: from ::ffff:71.123.114.34 ([71.123.114.34]) by deanbrook.org for <git@vger.kernel.org>; Wed, 13 Jan 2010 15:57:33 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136900>

If I touch a file in the working directory (only changing it's last-modified) attribute it shows up when running git diff-files.

If I then run git status followed by git diff-files again it doesn't show up either time.

Is this an error?

Simple example:

[dev]$ git --version
git version 1.6.5.3

[dev]$ git init t
Initialized empty shared Git repository in /Users/stephen/dev/t/.git/

[dev]$ cd t
[t (master)]$ echo 'hi' > hello; git add hello; git commit -am 'initial commit'
[master (root-commit) f39d21a] initial commit
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 hello

[t (master)]$ git diff-files

[t (master)]$ git status
# On branch master
nothing to commit (working directory clean)

[t (master)]$ touch hello

[t (master)]$ git diff-files
:100644 100644 45b983be36b73c0788dc9cbcb76cbb80fc7bb057 0000000000000000000000000000000000000000 M      hello

[t (master)]$ git status
# On branch master
nothing to commit (working directory clean)

[t (master)]$ git diff-files
