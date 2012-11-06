From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: git ls-files --ignored and ignored directory
Date: Tue, 6 Nov 2012 21:19:05 +0000 (UTC)
Message-ID: <k7bus9$o9t$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 22:19:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVqYZ-0002i9-8T
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 22:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab2KFVTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 16:19:23 -0500
Received: from plane.gmane.org ([80.91.229.3]:36920 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab2KFVTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 16:19:20 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TVqYP-0002cX-HG
	for git@vger.kernel.org; Tue, 06 Nov 2012 22:19:25 +0100
Received: from phare.normalesup.org ([129.199.129.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 22:19:25 +0100
Received: from damien.olivier.robert+gmane by phare.normalesup.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 22:19:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: phare.normalesup.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Tue, 06 Nov 2012 22:12:36 +0100 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209122>

I would like to use git ls-files to show all the ignored files, including
directory.

As an example of setup:

mkdir /tmp/git && cd /tmp/git
git init
mkdir a b
touch a/a
touch b/b
cat >.gitignore << EOF
a/
b/*
EOF

Then if I do:
$ git ls-files --exclude-standard --ignored --others
b/b
$ git ls-files --exclude-standard --ignored --others --directory
a/

In the first case I was expecting
a/a
b/b
and in the second case
a/
b/

Is there a way to get the behavior I'd like? Thanks!
