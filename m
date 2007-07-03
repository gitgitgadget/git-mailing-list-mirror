From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Starting 1.5.3 stabilization cycle
Date: Tue, 3 Jul 2007 20:14:28 +0200
Message-ID: <20070703181428.GD4580@xp.machine.xx>
References: <7v8x9yrllv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:14:31 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5mtJ-0002lt-TN
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 20:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691AbXGCSOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 14:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756494AbXGCSOT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 14:14:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:35937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756026AbXGCSOS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 14:14:18 -0400
Received: (qmail invoked by alias); 03 Jul 2007 18:14:16 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp030) with SMTP; 03 Jul 2007 20:14:16 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19HxJV0N3xHkJJPlwQAxvBYiffR2yPMmQjUr6rwTM
	Ehpu4zx6xh9HNp
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8x9yrllv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51518>

On Tue, Jul 03, 2007 at 12:29:32AM -0700, Junio C Hamano wrote:
> I tagged the tip of 'master' as 1.5.3-rc0; in addition to the
> topics described in the latest "What's in", most of the topics
> that have been cooking in 'next' are there.  The time some of
> them have spent before going to 'master' might be shorter than
> usual and there are a handful patches that I took directly to
> 'master', but the tip of 'master' should be as solid as usual.
> 
> There probably could be a few bits that we have already seen and
> was reviewed on the list that deserve to be in v1.5.3 (the only
> ones I have in mind right now are a few gitweb ones), but other
> than that, I think this is pretty much it, modulo bugfixes.
> 
> Oh, by the way, a maintenance release 1.5.2.3 is also out.
> 
> ----------------------------------------------------------------
> 
> GIT v1.5.3 Release Notes (draft as of -rc0)
> ========================
> 
> Updates since v1.5.2
> --------------------
> 
> * The commit walkers other than http are officially deprecated
>   (but still supported).

/
|> 
|> * The submodule support has Porcelain layer now.
|> 
|> * An initial interation of Porcelain level superproject support
                ^^^^^^^^^^ typo
|>   started to take shape.
\
  Duplicated?

> 
> * Thee are a handful pack-objects changes to help you cope better with
>   repositories with pathologically large blobs in them.
> 
> * For people who need to import from Perforce, a front-end for
>   fast-import is in contrib/fast-import/ now.
> 
> * Comes with git-gui 0.8.0.
> 
> * Comes with updated gitk.
> 
> * New commands and options.
> 
>   - "git stash" allows you to quickly save away your work in
>     progress and replay it later on an updated state.
> 
>   - "git rebase" learned an "interactive" mode.

Short describtion missing?

	This is meant for reordering the commits, merge several commits into
	one or even remove some of them.

> 
>   - "git fsck" can save its findings in lost-found, without a
>     separate invocation of "git lost-found" command.
> 
>   - GIT_WORK_TREE environment variable can be used together with
>     GIT_DIR to work in a subdirectory of a working tree that is
>     not located at "$GIT_DIR/..".
> 
>   - "git log" learned a new option '--follow', to follow
>     renaming history of a single file.
> 
>   - "git-filter-branch" is a reborn cg-admin-rewritehist.

Better mention what it is for, e.g:

	Lets you rewrite GIT revision history by applying custom filters on each revision.
	Those filters can modify each tree or information about each commit.

> 
>   - "git-cvsserver" learned new options (--base-path, --export-all,
>     --strict-paths) inspired by git-daemon.

[...]

>   - snapshot files "gitweb" creates from a repository at
>     $path/$project/.git are more useful.  We use $project part
>     in the filename, which we used to discard.
> 
>   - "git cvsimort" creates lightweight tag; there is not any
                ^- should be "cvsimport"
>     interesting information we can record in an annotated tag,
>     and the handcrafted ones the old code created was not
>     properly formed anyway.
> 
>   - "git-push" pretends that you immediately fetched back from
>     the remote by updating corresponding remote tracking
>     branches if you have any.
> 
>   - The diffstat given after a merge (or a pull) honors the
>     color.diff configuration.
> 
>   - "git-apply --whitespace=strip" removes blank lines added at
>     the end of the file.
> 
>   - "git-fetch" over git native protocols with -v shows connection
>     status, and the IP address of the other end, to help
>     diagnosing problems.
> 
>   - We used to have core.legacyheaders configuration, when
>     set to false, allowed git to write loose objects in a format
>     that mimicks the format used by objects stored in packs.  It
>     turns out that this was not so useful.  Although we will
>     continue to read objects written in that format, we do not
>     honor that configuration anymore and create loose objects in
>     the legacy/traditional format.
> 
>   - "--find-copies-harder" option to diff family can now be
>     spelled as "-C -C" for brevity.
> 
>   - "git-mailsplit" (hence "git-am") can read from Maildir
>     formatted mailboxes.
> 
>   - "git-cvsserver" does not barf upon seeing "cvs login"
>     request.
> 
>   - "pack-objects" honors "delta" attribute set in
>     .gitattributes.  It does not attempt to deltify blobs that
>     come from paths with delta attribute set to false.
> 
>   - new-workdir script (in contrib) can now be used with a bare
>     repository.
> 
>   - "git-mergetool" learned to use gvimdiff.
> 
>   - "gitview" (in contrib) has a better blame interface.
> 
>   - "git log" and friends did not handle a commit log message
>     that is larger than 16kB; they do now.
> 
>   - "--pretty=oneline" output format for "git log" and friends
>     deals with "malformed" commit log messages that have more
>     than one lines in the first paragraph better.  We used to
>     show the first line, cutting the title at mid-sentence; we
>     concatenate them into a single line and treat the result as
>     "oneline".
> 
> * Builds
> 
>   - old-style function definitions (most notably, a function
>     without parameter defined with "func()", not "func(void)")
>     have been eradicated.
> 
> * Performance Tweaks
> 
>   - git-pack-objects avoids re-deltification cost by caching
>     small enough delta results it creates while looking for the
>     best delta candidates.
> 
>   - diff-delta code that is used for packing has been improved
>     to work better on big files.
> 
>   - when there are more than one pack files in the repository,

I'm no native english speaker, but shouldn't this be

    - when there is more then one pack file in the repository,
                 ^^                    ^^^^
>     the runtime used to try finding an object always from the
>     newest packfile; it now tries the same packfile as we found
>     the object requested the last time, which exploits the
>     locality of references.
> 
>   - verifying pack contents done by "git fsck --full" got boost
>     by carefully choosing the order to verify objects in them.
> 
> 
> Fixes since v1.5.2
> ------------------
> 
> All of the fixes in v1.5.2 maintenance series are included in
> this release, unless otherwise noted.
> 
> * Bugfixes
> 
>   - "gitweb" had trouble handling non UTF-8 text with older
>     Encode.pm Perl module.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
