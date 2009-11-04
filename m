From: Greg Price <price@ksplice.com>
Subject: Re: BUG: git rebase -i -p silently looses commits
Date: Wed, 4 Nov 2009 16:46:12 -0500
Message-ID: <20091104214611.GL9139@dr-wily.mit.edu>
References: <alpine.DEB.1.00.0911021832530.2479@felix-maschine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nhW-0006zd-2M
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932916AbZKDVqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932913AbZKDVqQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:46:16 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:40809 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932693AbZKDVqN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 16:46:13 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nA4LjxQO022732;
	Wed, 4 Nov 2009 16:45:59 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nA4LkGCO002538;
	Wed, 4 Nov 2009 16:46:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0911021832530.2479@felix-maschine>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132156>

On Mon, 2 Nov 2009, Johannes Schindelin wrote:
> Having said that, I worked for some time on fixing this issue, and I 
> actually run a version of rebase -i -p here that allows reordering 
> commits, but it is far from stable (and due to GSoC and day-job 
> obligations, I had no time to work on it in months).

I'm interested in this topic too.  Some weeks ago I took your
rebase-i-p branch from January and rebased it onto the latest release;
it's at
  git://repo.or.cz/git/price.git rebase-i-p
and now based on v1.6.5.2.  I fixed a few bugs and added a feature,
and it's the version I run day to day.

Constantine and others interested in reordering commits with -p,
you're welcome to pull and build this version and try it out.  It
mostly solves my problems, and maybe it will solve yours.  Be warned
it does have bugs, and also be warned that I may rewind and rebase
that branch.  I'd be glad to hear about bugs you see, though.

Dscho, do you have a TODO written somewhere of what work you're aware
the topic still needs?  I plan to continue spending a little time
working on it, and I have my own list but it'd be good to compare
it with yours.

Cheers,
Greg


PS - I'm open to suggestions on the workflow for how to develop a
topic branch like this.  Some rewinding seems necessary as half-baked
patches get finished, etc, but if Dscho or someone else finds time to
work on it too, then the rewinding gets in the way of pull/push
collaboration.


PPS - For those just scanning along, the shortlog so far:

Greg Price (6):
      rebase -i -p: honor -s
      rebase -i -p: get full message from original merge commit
      rebase -i -p: always merge --no-ff
      rebase -i: Add the "ref" command
      rebase -i -p: Preserve author information on merges.
      [broken] rebase -i: implement pause

Johannes Schindelin (19):
      Some of Dscho's tools
      debug settings in Makefile
      Make CFLAGS more strict
      rebase -i --root: simplify code
      rebase -i: make pick_one() safer
      rebase -i -p: add helper parse_commit() to find rewritten commits
      rebase -i: add the "goto" command
      rebase -i -p: add a helper to add mappings for rewritten commits
      rebase -i -p: Add the "merge" command
      rebase -i: make sure that the commands record the rewritten commits
      rebase -i: move the code to write the rebase script into generate_script()
      rebase -i: let generate_script output to stdout
      rebase -i -p: refactor the preparation for -p into its own function
      rebase -i -p: use patch-id directly to determine the dropped commits
      rebase tests' fake-editor.sh: allow debugging with DEBUG_EDIT
      rebase's fake-editor: prepare for "goto" and "merge" commands
      rebase -i -p: generate a script using "goto" and "merge"
      TODO
      Make some tests in t3412 a little bit stricter
