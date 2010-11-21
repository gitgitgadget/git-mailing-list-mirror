From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Status of the svn remote helper project (Nov 2010, #2)
Date: Sun, 21 Nov 2010 20:38:39 +1100
Message-ID: <BB713021-7826-4E9E-8576-7D1704BF517C@cordelta.com>
References: <20101107112129.GA30042@burratino> <20101121063149.GA15449@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 21 10:38:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PK6Nn-00064i-8y
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 10:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab0KUJip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 04:38:45 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:29620
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751749Ab0KUJin (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Nov 2010 04:38:43 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAIN36EzLWHsF/2dsb2JhbACiXghxslOIUYVLBA
X-IronPort-AV: E=Sophos;i="4.59,231,1288530000"; 
   d="scan'208";a="282809135"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 21 Nov 2010 20:38:40 +1100
Received: (qmail 26374 invoked from network); 21 Nov 2010 20:38:40 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 21 Nov 2010 20:38:40 +1100
In-Reply-To: <20101121063149.GA15449@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161860>

Hi all,

> There are plans for an additional command to print information in
> ls-tree format about a path.

Sorry that progress has been quite slow this week.
My work-in-progess lays out the syntax of the command,
the initial parsing and object lookup.
I still need to break out the tree and path dereferencing logic.
I haven't started on printing yet but I presume it should be easy.

> * db/recognize-v3 (2010-11-20) 2 commits
> - vcs-svn: Allow simple v3 dumps (no deltas yet)
> - vcs-svn: Error out for v3 dumps
> 
> A bugfix and the framework for a feature.

Thanks for this, it should have gone in much earlier.

> * db/prop-delta (2010-11-20) 16 commits
> - vcs-svn: Simplify handling of deleted properties
> - vcs-svn: Implement Prop-delta handling
> - vcs-svn: Sharpen parsing of property lines
> - vcs-svn: Split off function for handling of individual properties
> - vcs-svn: Make source easier to read on small screens
> - vcs-svn: More dump format sanity checks
> - vcs-svn: Reject path nodes without Node-action
> - vcs-svn: Delay read of per-path properties
> - vcs-svn: Combine repo_replace and repo_modify functions
> - vcs-svn: Replace = Delete + Add
> - vcs-svn: handle_node: Handle deletion case early
> - vcs-svn: Use mark to indicate nodes with included text
> - vcs-svn: Unclutter handle_node by introducing have_props var
> - vcs-svn: Eliminate node_ctx.mark global
> - vcs-svn: Eliminate node_ctx.srcRev global
> - vcs-svn: Check for errors from open()
> (this branch uses db/recognize-v3.)
> 
> Needs review and testing.

Testing against my favourite, the ASF repo, as I write this.

> 
> * db/text-delta (2010-11-20) 10 commits
> - svn-fe: Test script for handling of dumps with --deltas
> - vcs-svn: Implement text-delta handling
> - Merge branch 'db/fast-import-cat-blob' into db/text-delta
> - vcs-svn: Teach line_buffer about temporary files
> - vcs-svn: Let caller set up sliding window for delta preimage
> - vcs-svn: Read delta preimage from file descriptor
> - vcs-svn: Introduce fd_buffer routines
> - vcs-svn: Introduce repo_read_path to check the content at a path
> - vcs-svn: Internal fast_export_save_blob helper
> - Merge branch 'jn/svndiff0' into db/text-delta
> (this branch uses db/recognize-v3, db/prop-delta, db/fast-import-cat-blob,
>  and jn/svndiff0.)
> 
> A delta in r36 of <http://svn.apache.org/repos/asf> does not apply
> with this brand of svn-fe.

That's odd, I was able to import up to r354 before receiving:
fatal: missing newline after cat-blob response

So there's some regressions to chase down since the last roll-up.

That's all I've got for now.

--
David Barr.
