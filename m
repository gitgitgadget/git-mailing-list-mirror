From: Darren Hart <dvhart@linux.intel.com>
Subject: mutt aliases file not working
Date: Wed, 27 Oct 2010 14:38:12 -0700
Message-ID: <4CC89BC4.8080009@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 23:38:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBDhN-0006Jx-DN
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 23:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528Ab0J0ViM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 17:38:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:19891 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447Ab0J0ViK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 17:38:10 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 27 Oct 2010 14:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.58,248,1286175600"; 
   d="scan'208";a="567982679"
Received: from unknown (HELO [10.255.12.195]) ([10.255.12.195])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2010 14:38:10 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.11) Gecko/20101006 Lightning/1.0b2 Thunderbird/3.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160127>

For whatever reason, which I'm sure is user error, I haven't been
able to get mutt aliases to work, while mailrc works fine:

$ mkdir aliases.git
$ cd !$
$ git init
Initialized empty Git repository in /home/dvhart/aliases.git/.git/
$ echo "joe Joe Blow joe@foobar.com" > muttaliases
$ git add muttaliases
$ git commit -m "aliases file"
[master (root-commit) b71ae4a] aliases file
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 muttaliases
$ git config sendemail.aliasesfile `pwd`/muttaliases
$ git config sendemail.aliasfiletype mutt
$ cat .git/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[sendemail]
	aliasesfile = /home/dvhart/aliases.git/muttaliases
	aliasfiletype = mutt
$ git send-email --to joe -1 
/tmp/l0xCEC7o3d/0001-aliases-file.patch
Who should the emails appear to be from? [Darren Hart <darren@dvhart.com>] 
Emails will be sent from: Darren Hart <darren@dvhart.com>
Message-ID to be used as In-Reply-To for the first email? 
(mbox) Adding cc: Darren Hart <darren@dvhart.com> from line 'From: Darren Hart <darren@dvhart.com>'

From: Darren Hart <darren@dvhart.com>
To: joe

    ^ when using a mailrc fail this expands to joe@foobar.com

Cc: Darren Hart <darren@dvhart.com>
Subject: [PATCH] aliases file
Date: Wed, 27 Oct 2010 14:29:10 -0700
Message-Id: <1288214950-13695-1-git-send-email-darren@dvhart.com>
X-Mailer: git-send-email 1.7.1

Send this email? ([y]es|[n]o|[q]uit|[a]ll): ^C

$ stty: standard input: Input/output error
^C

Am I doing something obviously wrong?

-- 
Darren Hart
Embedded Linux Kernel
