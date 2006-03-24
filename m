From: Matthias Kestenholz <lists@irregular.ch>
Subject: Bug encountered while comitting
Date: Fri, 24 Mar 2006 19:39:51 +0100
Message-ID: <20060324183951.GA23193@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Fri Mar 24 19:40:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMrCm-00058I-3j
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 19:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWCXSkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 13:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCXSkG
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 13:40:06 -0500
Received: from mail11.bluewin.ch ([195.186.18.61]:33446 "EHLO
	mail11.bluewin.ch") by vger.kernel.org with ESMTP id S932562AbWCXSkE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 13:40:04 -0500
Received: from spinlock.ch (62.203.176.109) by mail11.bluewin.ch (Bluewin 7.2.071)
        id 441EA17C0012E80D for git@vger.kernel.org; Fri, 24 Mar 2006 18:40:03 +0000
Received: (nullmailer pid 23519 invoked by uid 1000);
	Fri, 24 Mar 2006 18:39:51 -0000
To: git@vger.kernel.org
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.16-rc6 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17934>

Hello list,

I don't know if this is the right place to report a bug, but I'll
just try and see what comes back.

I am trying to build a Wiki [1] using PHP, a hacked version of Markdown,
and git for content tracking. I use the git core plumbing to do the
history work.

The PHP script created directories under .git/objects which were
only writable by www-data. There were other directories which were
owned by user mk and group www-data, and they were group writable.

So, I had write access to only a part of the .git directory.

When I tried to commit, I got a message saying "Unable to write sha1
filename".

The result was, that only part of the commit was recorded and that I
experienced repository corruption. refs/heads/master pointed to a
non-existant object.

The expected behavior would have been an error message telling me I
had insufficient write privileges and surely no repository
corruption.



Thanks,
Matthias


[1]: http://spinlock.ch/cgi-bin/gitweb.pl?p=swisdk2/bugs.git;a=tree
(See Wiki_ctrl.php for source)


-- 
:wq
