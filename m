From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PULL svn-fe] fast-import 'ls', line-buffer changes
Date: Sat, 26 Feb 2011 23:03:33 +1100
Message-ID: <34AB7FDB-87F9-4C46-AC90-D15A55103F02@cordelta.com>
References: <20101224080505.GA29681@burratino> <20110226114435.GB12231@elie>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 13:13:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtJ1k-0004rn-MZ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 13:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab1BZMNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 07:13:31 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:11093
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752062Ab1BZMNa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 07:13:30 -0500
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Feb 2011 07:13:30 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAEp6aE3LWHsF/2dsb2JhbACmPgh0s1SIU4VhBA
X-IronPort-AV: E=Sophos;i="4.62,231,1296997200"; 
   d="scan'208";a="348517788"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 26 Feb 2011 23:03:34 +1100
Received: (qmail 17084 invoked from network); 26 Feb 2011 23:03:34 +1100
Received: from d110-33-88-245.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.88.245)
  by 203.88.123.185 with SMTP; 26 Feb 2011 23:03:34 +1100
In-Reply-To: <20110226114435.GB12231@elie>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167980>



Hi,

> Please pull
> 
>  git://repo.or.cz/git/jrn.git svn-fe
> 
> to get the following changes on top of master + the old jn/svn-fe.
> 
> These are patches from the threads $gmane/164146 and $gmane/167536,
> providing some plumbing to support incremental import in svn-fe.  They
> are probably far from perfect but they seem to work okay so far, and
> I'd be fine with putting any fixes on top of them.
> 
> Thoughts, suggestions, etc welcome as always.

I'll try to put together a new topic based on this branch.
The target is incremental imports and removal of svn-fe's internal tree representation.
The patches that I intend to pick are as follows:

David Barr (9):
vcs-svn: drop obj_pool.h
vcs-svn: drop trp.h
vcs-svn: drop string_pool
vcs-svn: factor out usage of string_pool
vcs-svn: implement perfect hash for top-level keys
vcs-svn: implement perfect hash for node-prop keys
vcs-svn: avoid using ls command twice
vcs-svn: pass paths through to fast-import
vcs-svn: use mark from previous import for parent commit

Jonathan Nieder (7):
vcs-svn: handle filenames with dq correctly
vcs-svn: add a comment before each commit
vcs-svn: simplify repo_modify_path and repo_copy
vcs-svn: prepare to eliminate repo_tree structure
vcs-svn: save marks for imported commits
vcs-svn: use higher mark numbers for blobs
vcs-svn: introduce repo_read_path to check the content at a path
