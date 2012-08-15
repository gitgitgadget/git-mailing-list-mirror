From: Marco S Hyman <marc@snafu.org>
Subject: Can't track untracked file
Date: Wed, 15 Aug 2012 16:58:41 -0700
Message-ID: <A32BFCAF-114F-4A65-B802-8DD2A795B96E@snafu.org>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 02:49:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1oH4-0000Ld-AA
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 02:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab2HPAtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 20:49:16 -0400
Received: from a.mail.sonic.net ([64.142.16.245]:35005 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310Ab2HPAtP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2012 20:49:15 -0400
X-Greylist: delayed 2798 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2012 20:49:15 EDT
Received: from server.snafu.org (server.snafu.org [208.201.244.208])
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id q7G02Zm0030642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 15 Aug 2012 17:02:36 -0700
Received: from dumbcat.snafu.org (dumbcat.snafu.org [IPv6:2001:5a8:4:910:21e:c2ff:fe15:f0f6])
	by server.snafu.org (8.14.5/8.14.5) with ESMTP id q7FNwkhu031360
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 15 Aug 2012 16:58:48 -0700 (PDT)
X-Mailer: Apple Mail (2.1485)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't know if this is a git bug or something I'm doing wrong.
Suggestions appreciated.

On a machine named server:

  server[saturday]$ uname -a
  OpenBSD server.snafu.org 5.1 SERVER#342 amd64
  server[saturday]$ git --version
  git version 1.7.6
  server[saturday]$ git status
  # On branch master
  nothing to commit (working directory clean)

Yeah, I haven't updated that machine in a while.  Ignore that
as everything is fine on that machine.  The issue is on another
machine:

  $ uname -a
  Darwin dumbcat.snafu.org 12.0.0 Darwin Kernel Version 12.0.0: Sun Jun 24 23:00:16 PDT 2012; root:xnu-2050.7.9~1/RELEASE_X86_64 x86_64
  $ git --version
  git version 1.7.11.3
  $ git clone server:~www/www/saturday
  Cloning into 'saturday'...
  remote: Counting objects: 11401, done.
  remote: Compressing objects: 100% (6868/6868), done.
  remote: Total 11401 (delta 5620), reused 9456 (delta 4523)
  Receiving objects: 100% (11401/11401), 658.01 MiB | 10.79 MiB/s, done.
  Resolving deltas: 100% (5620/5620), done.
  Checking out files: 100% (4454/4454), done.

Everything should be fine, right.  Except...

  $ cd saturday/
  $ git status
  # On branch master
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #	2010/
  nothing added to commit but untracked files present (use "git add" to track)

And there is NOTHING I can do to get that directory into git.

  $ git add 2010
  $ git commit -m 'will it work?'
  # On branch master
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #	2010/
  nothing added to commit but untracked files present (use "git add" to track)

The directory is not empty.  Everything was fine prior to the
last commit (into a different directory).  I'd originally done
the changes and commit on this machine.  When things went to hell
I repeated the changes on the machine "server" and cloned it as
an attempted work-around to the issue.

What next?