From: walt <wa1ter@myrealbox.com>
Subject: Re: Problems installing as root
Date: Sun, 25 Feb 2007 07:42:48 -0800
Organization: none
Message-ID: <ersapr$bu5$1@sea.gmane.org>
References: <erpljl$ln9$1@sea.gmane.org> <20070225061258.GA1415@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 16:43:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLLX1-0007Hk-30
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 16:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbXBYPnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 10:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbXBYPnU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 10:43:20 -0500
Received: from main.gmane.org ([80.91.229.2]:59919 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964964AbXBYPnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 10:43:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HLLWn-00051o-Ms
	for git@vger.kernel.org; Sun, 25 Feb 2007 16:43:09 +0100
Received: from adsl-69-234-193-0.dsl.irvnca.pacbell.net ([69.234.193.0])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 16:43:09 +0100
Received: from wa1ter by adsl-69-234-193-0.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 16:43:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-193-0.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1 (X11/20070225)
In-Reply-To: <20070225061258.GA1415@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40552>

Shawn O. Pearce wrote:
> walt <wa1ter@myrealbox.com> wrote:
>> First, 'make install' as root leaves dozens of files owned by root
>> in my personal source directory.

> Which files, specifically? ...

~/src/git $find . -user 0
./git-fsck-objects
./git-archive
./git-cherry
./git-whatchanged
./git-annotate
./git-status
./git-merge-octopus
./git-show
./git-update-index
./git-format-patch
./git-quiltimport
./git-verify-pack
./git-rev-list
./git-cvsserver
./git-runstatus
./git-pull
./git-merge-file
./git-log
./git-repack
./git-mailinfo
./git-rm
./git-applypatch
./git-parse-remote
./git-reset
./git-mailsplit
./git-for-each-ref
./git-svnimport
./git-grep
./git-write-tree
./git-ls-files
./git-add--interactive
./git-verify-tag
./git-prune
./git-diff
./git-rebase
./git-branch
./git-check-ref-format
./git-push
./git-cat-file
./git-prune-packed
./git-merge-stupid
./git-mv
./git-merge-ours
./git-add
./git-name-rev
./git-merge-base
./git-read-tree
./git-commit-tree
./git-ls-remote
./git-tag
./git-init
./git-init-db
./git-rev-parse
./git-pack-refs
./git
./git-show-branch
./git-commit
./git-get-tar-commit-id
./git-fsck
./git-reflog
./git-applymbox
./git-merge
./git-cherry-pick
./git-diff-files
./git-fetch
./git-fmt-merge-msg
./git-blame
./git-tar-tree
./git-request-pull
./git-archimport
./git-count-objects
./git-cvsexportcommit
./git-show-ref
./git-shortlog
./git-merge-resolve
./git-checkout-index
./git-gc
./git-am
./git-diff-index
./git-revert
./git-clean
./git-stripspace
./git-ls-tree
./git-unpack-objects
./git-checkout
./git-pack-objects
./git-merge-one-file
./git-lost-found
./git-svn
./git-remote
./git-update-ref
./git-apply
./git-repo-config
./git-symbolic-ref
./git-diff-tree
./git-upload-archive
./git-sh-setup
./git-send-email
./git-rerere
./git-config
./git-relink
./git-clone
./git-describe
./git-bisect
./git-cvsimport

>> Second, this is a more recent problem with 'make install':
>> make -C git-gui all
>> make[1]: Entering directory `/usr/local/mnt/wa1ter/src/git/git-gui'
>> GITGUI_VERSION = 0.6.GITGUI

> Hmm.  You can't get the right version number for git-gui.  Do you
> have tags fetched?

Oops.  I stupidly forgot to tell you the reason for the failure
when running the script as root:  /usr/local is not in root's path,
and thus /usr/local/bin/git-* can't be found.  Since the script
assumes that git is already installed and working, I would guess
that it would also fail if I had just fetched Junio's repository
for the first time and attempted an initial install.

Sorry for that important omission :o(
