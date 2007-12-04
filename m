From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 13:09:22 +0000
Message-ID: <20071204130922.731c407a@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 04 14:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzXh7-0002V3-9I
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 14:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbXLDNTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 08:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbXLDNTw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 08:19:52 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:1085 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbXLDNTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 08:19:51 -0500
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2007 08:19:51 EST
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id lB4D9V7t047879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 14:09:31 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.1.0cvs51 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67042>

1. It won't compile at all with HP C-ANSI-C, so I have to use gcc-3.4.6

I added this to Makefile to get it compiled

ifeq ($(uname_S),HP-UX)
	# HP-UX
	BASIC_LDFLAGS += -L/usr/local/ssl/lib -L/usr/local/lib
	EXTLIBS += -ldce
	NO_HSTRERROR = YesPlease
	NO_ICONV = YesPlease
	NO_INET_NTOP = YesPlease
	NO_INET_PTON = YesPlease
endif

make test then fails:

/pro/3gl/LINUX/git-1.5.3.7 178 > make test
    LINK git-convert-objects
    LINK git
    BUILTIN git-format-patch
    BUILTIN git-show
    BUILTIN git-whatchanged
    BUILTIN git-cherry
    BUILTIN git-get-tar-commit-id
    BUILTIN git-init
    BUILTIN git-repo-config
    BUILTIN git-fsck-objects
    BUILTIN git-cherry-pick
    BUILTIN git-add
    BUILTIN git-annotate
    BUILTIN git-apply
    BUILTIN git-archive
    BUILTIN git-blame
    BUILTIN git-branch
    BUILTIN git-bundle
    BUILTIN git-cat-file
    BUILTIN git-check-attr
    BUILTIN git-checkout-index
    BUILTIN git-check-ref-format
    BUILTIN git-commit-tree
    BUILTIN git-count-objects
    BUILTIN git-describe
    BUILTIN git-diff
    BUILTIN git-diff-files
    BUILTIN git-diff-index
    BUILTIN git-diff-tree
    BUILTIN git-fetch--tool
    BUILTIN git-fmt-merge-msg
    BUILTIN git-for-each-ref
    BUILTIN git-fsck
    BUILTIN git-gc
    BUILTIN git-grep
    BUILTIN git-init-db
    BUILTIN git-log
    BUILTIN git-ls-files
    BUILTIN git-ls-tree
    BUILTIN git-mailinfo
    BUILTIN git-mailsplit
    BUILTIN git-merge-base
    BUILTIN git-merge-file
    BUILTIN git-mv
    BUILTIN git-name-rev
    BUILTIN git-pack-objects
    BUILTIN git-prune
    BUILTIN git-prune-packed
    BUILTIN git-push
    BUILTIN git-read-tree
    BUILTIN git-reflog
    BUILTIN git-config
    BUILTIN git-rerere
    BUILTIN git-rev-list
    BUILTIN git-rev-parse
    BUILTIN git-revert
    BUILTIN git-rm
    BUILTIN git-runstatus
    BUILTIN git-shortlog
    BUILTIN git-show-branch
    BUILTIN git-stripspace
    BUILTIN git-symbolic-ref
    BUILTIN git-tag
    BUILTIN git-tar-tree
    BUILTIN git-unpack-objects
    BUILTIN git-update-index
    BUILTIN git-update-ref
    BUILTIN git-upload-archive
    BUILTIN git-verify-pack
    BUILTIN git-verify-tag
    BUILTIN git-write-tree
    BUILTIN git-show-ref
    BUILTIN git-pack-refs
    SUBDIR git-gui
    INDEX lib/
    SUBDIR perl
    SUBDIR templates
make -C t/ all
make[1]: Entering directory `/pro/3gl/LINUX/git-1.5.3.7/t'
*** t0000-basic.sh ***
*   ok 1: .git/objects should be empty after git init in an empty repo.
*   ok 2: .git/objects should have 3 subdirectories.
*   ok 3: git update-index without --add should fail adding.
*   ok 4: git update-index with --add should succeed.
*   ok 5: writing tree out with git write-tree
*   ok 6: validate object ID of a known tree.
*   ok 7: git update-index without --remove should fail removing.
*   ok 8: git update-index with --remove should be able to remove.
*   ok 9: git write-tree should be able to write an empty tree.
*   ok 10: validate object ID of a known tree.
*   ok 11: adding various types of objects with git update-index --add.
*   ok 12: showing stage with git ls-files --stage
*   ok 13: validate git ls-files output for a known tree.
*   ok 14: writing tree out with git write-tree.
*   ok 15: validate object ID for a known tree.
*   ok 16: showing tree with git ls-tree
*   ok 17: git ls-tree output for a known tree.
*   ok 18: showing tree with git ls-tree -r
*   ok 19: git ls-tree -r output for a known tree.
*   ok 20: showing tree with git ls-tree -r -t
*   ok 21: git ls-tree -r output for a known tree.
*   ok 22: writing partial tree out with git write-tree --prefix.
*   ok 23: validate object ID for a known tree.
*   ok 24: writing partial tree out with git write-tree --prefix.
*   ok 25: validate object ID for a known tree.
*   ok 26: put invalid objects into the index.
*   ok 27: writing this tree without --missing-ok.
*   ok 28: writing this tree with --missing-ok.
*   ok 29: git read-tree followed by write-tree should be idempotent.
*   ok 30: validate git diff-files output for a know cache/work tree state.
*   ok 31: git update-index --refresh should succeed.
*   ok 32: no diff after checkout and git update-index --refresh.
*   ok 33: git commit-tree records the correct tree in a commit.
*   ok 34: git commit-tree records the correct parent in a commit.
*   ok 35: git commit-tree omits duplicated parent in a commit.
*   ok 36: update-index D/F conflict
*   ok 37: absolute path works as expected
* passed all 37 test(s)
*** t0001-init.sh ***
* FAIL 1: plain

                (
                        unset GIT_DIR GIT_WORK_TREE &&
                        mkdir plain &&
                        cd plain &&
                        git init
                ) &&
                check_config plain/.git false unset

*   ok 2: plain with GIT_WORK_TREE
* FAIL 3: plain bare

                (
                        unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
                        mkdir plain-bare-1 &&
                        cd plain-bare-1 &&
                        git --bare init
                ) &&
                check_config plain-bare-1 true unset

*   ok 4: plain bare with GIT_WORK_TREE
*   ok 5: GIT_DIR bare
*   ok 6: GIT_DIR non-bare
*   ok 7: GIT_DIR & GIT_WORK_TREE (1)
*   ok 8: GIT_DIR & GIT_WORK_TREE (2)
* failed 2 among 8 test(s)
make[1]: *** [t0001-init.sh] Error 1
make[1]: Leaving directory `/pro/3gl/LINUX/git-1.5.3.7/t'
make: *** [test] Error 2
Exit 2


and make install probably expects a broken^Wdifferent install than HP-UX has:

/pro/3gl/LINUX/git-1.5.3.7 181 > make install
    SUBDIR git-gui
    INDEX lib/
    SUBDIR perl
    SUBDIR templates
install -d -m755 '/pro/local/bin'
rm: /pro/local/bin/ directory
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
install -d -m755 '/pro/local/bin'
rm: /pro/local/bin/ directory
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
install git-convert-objects git-fetch-pack git-hash-object git-index-pack git-local-fetch git-fast-import git-daemon git-merge-index git-mktag git-mktree git-patch-id git-peek-remote git-receive-pack git-send-pack git-shell git-show-index git-ssh-fetch git-ssh-upload git-unpack-file git-update-server-info git-upload-pack git-pack-redundant git-var git-merge-tree git-imap-send git-merge-recursive  git-ssh-pull git-ssh-push git-bisect git-checkout git-clean git-clone git-commit git-fetch git-ls-remote git-merge-one-file git-mergetool git-parse-remote git-pull git-rebase git-rebase--interactive git-repack git-request-pull git-reset git-sh-setup git-am git-merge git-merge-stupid git-merge-octopus git-merge-resolve git-merge-ours git-lost-found git-quiltimport git-submodule git-filter-branch gi
 t-stash git-add--interactive git-archimport git-cvsimport git-relink git-cvsserver git-remote git-svnimport git-cvsexportcommit git-send-email git-svn git-status git-instaweb git-merge-subt!
 ree '/pro/local/bin'
install git '/pro/local/bin'
make -C templates DESTDIR='' install
make[1]: Entering directory `/pro/3gl/LINUX/git-1.5.3.7/templates'
install -d -m755 '/pro/local/share/git-core/templates/'
Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
       mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
       mv [-f] [-i] [-e warn|force|ignore] d1 d2
(cd blt && tar cf - .) | \
(cd '/pro/local/share/git-core/templates/' && tar xf -)
/bin/sh: /pro/local/share/git-core/templates/:  not found.
make[1]: *** [install] Error 1
make[1]: Leaving directory `/pro/3gl/LINUX/git-1.5.3.7/templates'
make: *** [install] Error 2
Exit 2

I have two:

  14241 100555 -r-x    1      bin      1888  12 Jun 2002 10:58 /opt/imake/bin/install
    634 100555 -r-x    1      bin      5147   7 Nov 1997 09:00 /usr/sbin/install

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
