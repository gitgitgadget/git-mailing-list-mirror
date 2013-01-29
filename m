From: Michael Tyson <michael@atastypixel.com>
Subject: Cloning remote HTTP repository: Can only see 'master' branch
Date: Tue, 29 Jan 2013 16:54:13 +1100
Message-ID: <83605E83-1110-449B-969D-AB43158376EA@atastypixel.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 07:09:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U04OD-000580-BI
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 07:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab3A2GJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 01:09:28 -0500
Received: from bs4-dallas.accountservergroup.com ([50.23.201.241]:44567 "EHLO
	bs4-dallas.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753551Ab3A2GJ1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 01:09:27 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2013 01:09:27 EST
Received: from 58-6-250-150.dyn.iinet.net.au ([58.6.250.150]:65420 helo=[10.1.1.7])
	by bs4-dallas.accountservergroup.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <michael@atastypixel.com>)
	id 1U0498-000C8n-4M
	for git@vger.kernel.org; Mon, 28 Jan 2013 23:54:14 -0600
X-Mailer: Apple Mail (2.1499)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bs4-dallas.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - atastypixel.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214905>

Hello!

I've a readonly git repository that I'm hosting via HTTP (a bare git repository located within the appropriate directory on the server). I push to it via my own SSH account (local repository with a remote pointing to the ssh:// URL).

This has all worked fine so far - I push via ssh, and others can clone and pull via the HTTP URL.

I've recently added a branch - "beta" - which pushed just fine, but now cloning via the HTTP URL doesn't seem to show the new branch - just master:

$ git clone http://server.tld/path/to/repository.git repository
Cloning into 'repository'...
$ cd repository
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master

Cloning via the readwrite ssh URL works fine though:

$ git clone ssh://user@server.tld:www/path/to/repository.git repository
Cloning into 'repository'...
stdin: is not a tty
remote: Counting objects: 225, done.
remote: Compressing objects: 100% (196/196), done.
remote: Total 225 (delta 109), reused 77 (delta 25)
Receiving objects: 100% (225/225), 9.55 MiB | 295 KiB/s, done.
Resolving deltas: 100% (109/109), done.
$ cd repository
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/beta
  remotes/origin/master

I've tried 'git clone --mirror' just in case, but this just resulted in a bare repository with only the 'master' branch, still.

Anyone have any ideas about what I'm doing wrong?

Cheers,
Michael
