From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Fri, 04 Aug 2006 03:12:36 -0700
Message-ID: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 04 12:12:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8wfY-0006JF-Ng
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 12:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWHDKMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 06:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHDKMh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 06:12:37 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21451 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030282AbWHDKMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 06:12:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804101236.VBPU6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 06:12:36 -0400
To: git@vger.kernel.org
X-maint-at: a0764cb838c2f1885fb58ca794c21523fb05c825
X-master-at: 7e18e56920bd38ffc1f2c068d943bfd3f012473d
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24782>

* The 'master' branch has these since the last announcement.
  Since it was tagged as 1.4.2-rc3, it has acquired a couple of
  further fixes.  Hopefully there won't be anything but fixes on
  this branch until the real 1.4.2 happens.

  - Documentation, usage string fixes and general clean-ups
    everywhere by Jeff King, Ramsay Allan Jones, Uwe Zeisberger,
    and Matthias Lederhofer.

  - A few more commands are made built-ins by Matthias
    Kestenholz.

  - A minor memory leak in git-tar-tree was plugged by Rene
    Scharfe.

  - Ramsay Allan Jones has introduced "NO_C99_FORMAT" Makefile
    variable to help running things with a C library that does
    not support %zu and %td format.  This would be a good target
    for autoconf work by Jakub (hint hint).

  - To make it easy to tell which side of the connection the
    errors happened while fetching/pulling, messages from the
    remote side are prefixed with "remote: ".

  - "git diff blob1 blob2" were showing the patch in reverse,
    and did not identify blob names of both sides.  Fixed.

  - "git commit -o path" from subdirectories were broken when
    git-read-tree became a built-in.  Fixed.

* The 'next' branch, in addition, has these.

  - A big gitweb clean-up series by Jakub Narebski, with help
    from Jeff King, Matthias Lederhofer and Martin Waitz to make
    run-time and build-time configuration easier.

  - Jakub Narebski made config.mak.autogen to tell where Perl
    and Python are to the build system.

  - Not-universally-liked Git.pm by Pasky with help from Dennis
    Stosberg, Johannes Schindelin, Pavel Roskin and others.
    One drawback is this pretty much makes Perl scripts that use
    Git.pm unusable with ActiveState right now.

  - A new merge strategy, merge-recur, which is a rewrite of
    merge-recursive in C, by Johannes and Alex.

  - More commands are made built-in by Matthias Kestenholz, and
    I cleaned up the build procedure for built-ins a bit.

  - New style loose objects, which use the same header format as
    in-pack objects, can be copied straight into packs when not
    deltified.  Note that new-style loose objects are not
    enabled by default yet.

  - Matthias Lederhofer introduced $GIT_PAGER environment
    variable that can specify a different pager from $PAGER.

  - I suspect Cygwin needs NO_C99_FORMAT.  Confirmation is
    appreciated.

  - Ramsay Allan Jones has one header fix to add _GNU_SOURCE,
    which helps things to compile in his environment; this needs
    to be checked to make sure it does not break others.

  - Timo Hirvonen made the parameter parsing of diff family
    saner some time ago.  Two minor changes are waiting to
    graduate to "master" after 1.4.2:

    * --name-only, --name-status, --check and -s are mutually exclusive

    * Remove awkward compatibility warts "-s".  Now -s means "do
      not output diff" everywhere, including git-diff-files.

* The 'pu' branch, in addition, has these.

  - Johannes Schindelin has a new diff option --color-words to
    use color to squash word differences into single line
    output.

  - An update to upload-pack to prevent it from going all the
    way back when the downloader has more roots than it.  Needs
    testing and comments.

  - A new merge strategy, merge-rename, which is still a
    work-in-progress to handle renames in read-tree 3-way
    merge.
