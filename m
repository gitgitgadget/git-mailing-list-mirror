From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [ANNOUNCE] Git 1.7.11.rc1
Date: Mon, 04 Jun 2012 10:19:26 -0400
Message-ID: <4FCCC3EE.1090009@xiplink.com>
References: <7v1ulwvsz1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 16:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbYEw-0002P9-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 16:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab2FDO0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 10:26:34 -0400
Received: from smtp162.dfw.emailsrvr.com ([67.192.241.162]:40702 "EHLO
	smtp162.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab2FDO0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 10:26:33 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2012 10:26:33 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id E1A398050C
	for <git@vger.kernel.org>; Mon,  4 Jun 2012 10:19:41 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp146.ord.emailsrvr.com (smtp146.ord.emailsrvr.com [173.203.6.146])
	by smtp26.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id C0A998016C
	for <git@vger.kernel.org>; Mon,  4 Jun 2012 10:19:41 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp27.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 42D492A806F;
	Mon,  4 Jun 2012 10:19:10 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp27.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id F22282A806B;
	Mon,  4 Jun 2012 10:19:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7v1ulwvsz1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199139>

On 12-06-03 07:46 PM, Junio C Hamano wrote:
> A release candidate Git v1.7.11-rc1 is now available for testing at
> the usual places.

I have a few release note tweaks, below.

> The release tarballs are found at:
> 
>     http://code.google.com/p/git-core/downloads/list
> 
> and their SHA-1 checksums are:
> 
> c5805f67a1c21922f5fe7456dae9fb9b8c4b9a16  git-1.7.11.rc1.tar.gz
> 379bc711136df07ae64da4f14a90a3837f3e248c  git-htmldocs-1.7.11.rc1.tar.gz
> 5ba3bc8dd9fcf775a2364a5b73bb84600cc903af  git-manpages-1.7.11.rc1.tar.gz
> 
> Also the following public repositories all have a copy of the v1.7.11-rc1
> tag and the master branch that the tag points at:
> 
>   url = git://repo.or.cz/alt-git.git
>   url = https://code.google.com/p/git-core/
>   url = git://git.sourceforge.jp/gitroot/git-core/git.git
>   url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>   url = https://github.com/gitster/git
> 
> Git v1.7.11 Release Notes (draft)
> =========================
> 
> Updates since v1.7.10
> ---------------------
> 
> UI, Workflows & Features
> 
>  * A new mode for push, "simple", which is a cross between "current"
>    and "upstream", has been introduced. "git push" without any refspec
>    will push the current branch out to the same name at the remote
>    repository only when it is set to track the branch with the same
>    name over there.  The plan is to make this mode the new default
>    value when push.default is not configured.
> 
>  * A couple of commands learned the "--column" option to produce
>    columnar output.

It would be nice to list the commands.  I found "tag" "status" and "branch"
from the nd/columns branch.  Any others?

>  * A third-party tool "git subtree" is distributed in contrib/
> 
>  * Error messages given when @{u} is used for a branch without its
>    upstream configured have been clatified.

s/clatified/clarified/

>  * Even with "-q"uiet option, "checkout" used to report setting up

s/with/with the/

>    tracking.  Also "branch" learned the "-q"uiet option to squelch
>    informational message.
> 
>  * Your build platform may support hardlinks but you may prefer not to
>    use them, e.g. when installing to DESTDIR to make a tarball and
>    untarring on a filesystem that has poor support for hardlinks.
>    There is a Makefile option NO_INSTALL_HARDLINKS for you.
> 
>  * The smart-http backend used to always override GIT_COMMITTER_*
>    variables with REMOTE_USER and REMOTE_ADDR, but these variables are
>    now preserved when set.
> 
>  * "git am" learned the "--include" option, which is an opposite of
>    existing the "--exclude" option.
> 
>  * When "git am -3" needs to fall back to an application to a

s/application to/application of/

>    synthesized preimage followed by a 3-way merge, the paths that
>    needed such treatment are now reported to the end user, so that the
>    result in them can be eyeballed with extra care.
> 
>  * The output from "diff/log --stat" used to always allocate 4 columns
>    to show the number of modified lines, but not anymore.
> 
>  * "git difftool" learned the "--dir-diff" option to spawn external
>    diff tools that can compare two directory hierarchies at a time
>    after populating two temporary directories, instead of running an
>    instance of the external tool once per a file pair.
> 
>  * The "fmt-merge-msg" command learns to list the primary contributors

s/learns/learned/

>    involved in the side topic you are merging.
> 
>  * "git rebase" learned to optionally keep commits that do not
>    introduce any change in the original history.
> 
>  * "git push --recurse-submodules" learned to optionally look into the
>    histories of submodules bound to the superproject and push them
>    out.
> 
>  * A 'snapshot' request to "gitweb" honors If-Modified-Since: header,
>    based on the commit date.
> 
>  * "gitweb" learned to highlight the patch it outputs even more.
> 
> Foreign Interface
> 
>  * "git svn" used to die with unwanted SIGPIPE when talking with HTTP

s/HTTP/an HTTP/

>    server that uses keep-alive.
> 
>  * "git svn" learned to use platform specific authentication
>    providers, e.g. gnome-keyring, kwallet, etc.
> 
>  * "git p4" has been moved out of contrib/ area and has seen more work

s/out of/out of the/

>    on importing labels as tags from (and exporting tags as labels to)
>    p4.
> 
> Performance and Internal Implementation (please report possible regressions)
> 
>  * Bash completion script (in contrib/) have been cleaned up to make
>    future work on it simpler.
> 
>  * An experimental "version 4" format of the index file has been
>    introduced to reduce on-disk footprint and I/O overhead.
> 
>  * "git archive" learned to produce its output without reading the
>    blob object it writes out in memory in its entirety.
> 
>  * "git index-pack" that runs when fetching or pushing objects to
>    complete the packfile on the receiving end learned to use multiple
>    threads to do its job when available.
> 
>  * The code to compute hash values for lines used by the internal diff
>    engine was optimized on little-endian machines, using the same
>    trick the kernel folks came up with.
> 
>  * "git apply" had some memory leaks plugged.
> 
>  * Setting up a revision traversal with many starting points was
>    inefficient as these were placed in a date-order priority queue
>    one-by-one.  Now they are collected in the queue unordered first,
>    and sorted immediately before getting used.
> 
>  * More lower-level commands learned to use the streaming API to read
>    from the object store without keeping everything in core.
> 
>  * The weighting parameters to suggestion command name typo have been
>    tweaked, so that "git tags" will suggest "tag?" and not "stage?".
> 
>  * Because "sh" on the user's PATH may be utterly broken on some
>    systems, run-command API now uses SHELL_PATH, not /bin/sh, when
>    spawning an external command (not applicable to Windows port).
> 
>  * The API to iterate over refs/ hierarchy has been tweaked to allow

s/over/over the/


That's all!

		M.
