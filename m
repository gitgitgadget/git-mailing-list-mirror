Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95311FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757326AbcKXRJF (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 12:09:05 -0500
Received: from [192.252.130.194] ([192.252.130.194]:10305 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757261AbcKXRJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 12:09:02 -0500
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Nov 2016 12:09:02 EST
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 70CFC618D1;
        Thu, 24 Nov 2016 11:58:59 -0500 (EST)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Release note spelling and phrasing fixups.
Date:   Thu, 24 Nov 2016 11:59:00 -0500
Message-Id: <20161124165900.30605-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
References: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Mostly just missing words and what I feel are clarifications.

The biggest change is to the "git add -N" item.  Not 100% sure
I got it right.

		M.

 Documentation/RelNotes/2.11.0.txt | 145 +++++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 73 deletions(-)

diff --git a/Documentation/RelNotes/2.11.0.txt b/Documentation/RelNotes/2.11.0.txt
index cea2a50..de5892e 100644
--- a/Documentation/RelNotes/2.11.0.txt
+++ b/Documentation/RelNotes/2.11.0.txt
@@ -57,39 +57,40 @@ UI, Workflows & Features
 
  * Even though "git hash-objects", which is a tool to take an
    on-filesystem data stream and put it into the Git object store,
-   allowed to perform the "outside-world-to-Git" conversions (e.g.
+   can perform "outside-world-to-Git" conversions (e.g.
    end-of-line conversions and application of the clean-filter), and
-   it had the feature on by default from very early days, its reverse
+   it has had this feature on by default from very early days, its reverse
    operation "git cat-file", which takes an object from the Git object
-   store and externalize for the consumption by the outside world,
+   store and externalizes it for consumption by the outside world,
    lacked an equivalent mechanism to run the "Git-to-outside-world"
    conversion.  The command learned the "--filters" option to do so.
 
- * Output from "git diff" can be made easier to read by selecting
+ * Output from "git diff" can be made easier to read by intelligently selecting
    which lines are common and which lines are added/deleted
-   intelligently when the lines before and after the changed section
-   are the same.  A command line option is added to help with the
-   experiment to find a good heuristics.
+   when the lines before and after the changed section
+   are the same.  A command line option (--indent-heuristic) and a
+   configuration variable (diff.indentHeuristic) are added to help with the
+   experiment to find good heuristics.
 
  * In some projects, it is common to use "[RFC PATCH]" as the subject
    prefix for a patch meant for discussion rather than application.  A
-   new option "--rfc" is a short-hand for "--subject-prefix=RFC PATCH"
+   new format-patch option "--rfc" is a short-hand for "--subject-prefix=RFC PATCH"
    to help the participants of such projects.
 
- * "git add --chmod=+x <pathspec>" added recently only toggled the
+ * "git add --chmod={+,-}x <pathspec>" only changed the
    executable bit for paths that are either new or modified. This has
-   been corrected to flip the executable bit for all paths that match
+   been corrected to change the executable bit for all paths that match
    the given pathspec.
 
  * When "git format-patch --stdout" output is placed as an in-body
-   header and it uses the RFC2822 header folding, "git am" failed to
+   header and it uses RFC2822 header folding, "git am" fails to
    put the header line back into a single logical line.  The
    underlying "git mailinfo" was taught to handle this properly.
 
  * "gitweb" can spawn "highlight" to show blob contents with
    (programming) language-specific syntax highlighting, but only
    when the language is known.  "highlight" can however be told
-   to make the guess itself by giving it "--force" option, which
+   to guess the language itself by giving it "--force" option, which
    has been enabled.
 
  * "git gui" l10n to Portuguese.
@@ -109,19 +110,19 @@ UI, Workflows & Features
    history leading to nth parent was looking the other way.
 
  * In recent versions of cURL, GSSAPI credential delegation is
-   disabled by default due to CVE-2011-2192; introduce a configuration
-   to selectively allow enabling this.
+   disabled by default due to CVE-2011-2192; introduce a http.delegation
+   configuration variable to selectively allow enabling this.
    (merge 26a7b23429 ps/http-gssapi-cred-delegation later to maint).
 
  * "git mergetool" learned to honor "-O<orderfile>" to control the
    order of paths to present to the end user.
 
  * "git diff/log --ws-error-highlight=<kind>" lacked the corresponding
-   configuration variable to set it by default.
+   configuration variable (diff.wsErrorHighlight) to set it by default.
 
- * "git ls-files" learned "--recurse-submodules" option that can be
-   used to get a listing of tracked files across submodules (i.e. this
-   only works with "--cached" option, not for listing untracked or
+ * "git ls-files" learned the "--recurse-submodules" option
+   to get a listing of tracked files across submodules (i.e. this
+   only works with the "--cached" option, not for listing untracked or
    ignored files).  This would be a useful tool to sit on the upstream
    side of a pipe that is read with xargs to work on all working tree
    files from the top-level superproject.
@@ -130,7 +131,7 @@ UI, Workflows & Features
    implementations of XDG Secret Service API has been added to
    contrib/credential/.
 
- * The GPG verification status shown in "%G?" pretty format specifier
+ * The GPG verification status shown by the "%G?" pretty format specifier
    was not rich enough to differentiate a signature made by an expired
    key, a signature made by a revoked key, etc.  New output letters
    have been assigned to express them.
@@ -139,17 +140,17 @@ UI, Workflows & Features
    learned to turn "git describe" output (e.g. v2.9.3-599-g2376d31787)
    into clickable links in its output.
 
- * When new paths were added by "git add -N" to the index, it was
-   enough to circumvent the check by "git commit" to refrain from
-   making an empty commit without "--allow-empty".  The same logic
-   prevented "git status" to show such a path as "new file" in the
+ * "git commit" created an empty commit when invoked with an index
+   consisting solely of intend-to-add paths (added with "git add -N").
+   It now requires the "--allow-empty" option to create such a commit.
+   The same logic prevented "git status" from showing such paths as "new files" in the
    "Changes not staged for commit" section.
 
- * The smudge/clean filter API expect an external process is spawned
-   to filter the contents for each path that has a filter defined.  A
+ * The smudge/clean filter API spawns an external process
+   to filter the contents of each path that has a filter defined.  A
    new type of "process" filter API has been added to allow the first
    request to run the filter for a path to spawn a single process, and
-   all filtering need is served by this single process for multiple
+   all filtering is served by this single process for multiple
    paths, reducing the process creation overhead.
 
  * The user always has to say "stash@{$N}" when naming a single
@@ -173,7 +174,7 @@ Performance, Internal Implementation, Development Support etc.
    script file "git am" internally uses.
    (merge a77598e jc/am-read-author-file later to maint).
 
- * Lifts calls to exit(2) and die() higher in the callchain in
+ * Lift calls to exit(2) and die() higher in the callchain in
    sequencer.c files so that more helper functions in it can be used
    by callers that want to handle error conditions themselves.
 
@@ -192,13 +193,13 @@ Performance, Internal Implementation, Development Support etc.
    does not advertise any refs, but "git fetch" was not prepared to
    see such an advertisement.  When the other side disconnects without
    giving any ref advertisement, we used to say "there may not be a
-   repository at that URL", but we may have seen other advertisement
+   repository at that URL", but we may have seen other advertisements
    like "shallow" and ".have" in which case we definitely know that a
    repository is there.  The code to detect this case has also been
    updated.
 
  * Some codepaths in "git pack-objects" were not ready to use an
-   existing pack bitmap; now they are and as the result they have
+   existing pack bitmap; now they are and as a result they have
    become faster.
 
  * The codepath in "git fsck" to detect malformed tree objects has
@@ -214,7 +215,7 @@ Performance, Internal Implementation, Development Support etc.
    packfile first.
    (merge c9af708b1a jk/pack-objects-optim-mru later to maint).
 
- * Codepaths involved in interacting alternate object store have
+ * Codepaths involved in interacting alternate object stores have
    been cleaned up.
 
  * In order for the receiving end of "git push" to inspect the
@@ -222,7 +223,7 @@ Performance, Internal Implementation, Development Support etc.
    from the sending end need to be made available to the hook and
    the mechanism for the connectivity check, and this was done
    traditionally by storing the objects in the receiving repository
-   and letting "git gc" to expire it.  Instead, store the newly
+   and letting "git gc" expire them.  Instead, store the newly
    received objects in a temporary area, and make them available by
    reusing the alternate object store mechanism to them only while we
    decide if we accept the check, and once we decide, either migrate
@@ -237,7 +238,7 @@ Performance, Internal Implementation, Development Support etc.
    replaced with a priority queue.
 
  * "git diff --no-index" codepath has been updated not to try to peek
-   into .git/ directory that happens to be under the current
+   into a .git/ directory that happens to be under the current
    directory, when we know we are operating outside any repository.
 
  * Update of the sequencer codebase to make it reusable to reimplement
@@ -251,8 +252,8 @@ Performance, Internal Implementation, Development Support etc.
    holding onto them.  Use O_CLOEXEC flag to open files in various
    codepaths.
 
- * Update "interpret-trailers" machinery and teaches it that people in
-   real world write all sorts of crufts in the "trailer" that was
+ * Update "interpret-trailers" machinery and teach it that people in
+   the real world write all sorts of cruft in the "trailer" that was
    originally designed to have the neat-o "Mail-Header: like thing"
    and nothing else.
 
@@ -280,7 +281,7 @@ notes for details).
    has been removed.
 
  * Having a submodule whose ".git" repository is somehow corrupt
-   caused a few commands that recurse into submodules loop forever.
+   caused a few commands that recurse into submodules to loop forever.
 
  * "git symbolic-ref -d HEAD" happily removes the symbolic ref, but
    the resulting repository becomes an invalid one.  Teach the command
@@ -308,12 +309,12 @@ notes for details).
    forgot to update "git gui" to look at the configuration to match
    this change.
 
- * "git add --chmod=+x" added recently lacked documentation, which has
+ * "git add --chmod={+,-}x" added recently lacked documentation, which has
    been corrected.
 
  * "git log --cherry-pick" used to include merge commits as candidates
    to be matched up with other commits, resulting a lot of wasted time.
-   The patch-id generation logic has been updated to ignore merges to
+   The patch-id generation logic has been updated to ignore merges and
    avoid the wastage.
 
  * The http transport (with curl-multi option, which is the default
@@ -333,20 +334,20 @@ notes for details).
    line of the next one.  This process may have to merge two adjacent
    hunks, but the code forgot to do so in some cases.
 
- * Performance tests done via "t/perf" did not use the same set of
+ * Performance tests done via "t/perf" did not use the right
    build configuration if the user relied on autoconf generated
    configuration.
 
  * "git format-patch --base=..." feature that was recently added
-   showed the base commit information after "-- " e-mail signature
+   showed the base commit information after the "-- " e-mail signature
    line, which turned out to be inconvenient.  The base information
    has been moved above the signature line.
 
  * More i18n.
 
  * Even when "git pull --rebase=preserve" (and the underlying "git
-   rebase --preserve") can complete without creating any new commit
-   (i.e. fast-forwards), it still insisted on having a usable ident
+   rebase --preserve") can complete without creating any new commits
+   (i.e. fast-forwards), it still insisted on having usable ident
    information (read: user.email is set correctly), which was less
    than nice.  As the underlying commands used inside "git rebase"
    would fail with a more meaningful error message and advice text
@@ -396,7 +397,7 @@ notes for details).
  * Documentation around tools to import from CVS was fairly outdated.
 
  * "git clone --recurse-submodules" lost the progress eye-candy in
-   recent update, which has been corrected.
+   a recent update, which has been corrected.
 
  * A low-level function verify_packfile() was meant to show errors
    that were detected without dying itself, but under some conditions
@@ -409,23 +410,23 @@ notes for details).
    to a design bug, which has been fixed.
 
  * In the codepath that comes up with the hostname to be used in an
-   e-mail when the user didn't tell us, we looked at ai_canonname
+   e-mail when the user didn't tell us, we looked at the ai_canonname
    field in struct addrinfo without making sure it is not NULL first.
 
  * "git worktree", even though it used the default_abbrev setting that
-   ought to be affected by core.abbrev configuration variable, ignored
+   ought to be affected by the core.abbrev configuration variable, ignored
    the variable setting.  The command has been taught to read the
    default set of configuration variables to correct this.
 
  * "git init" tried to record core.worktree in the repository's
-   'config' file when GIT_WORK_TREE environment variable was set and
+   'config' file when the GIT_WORK_TREE environment variable was set and
    it was different from where GIT_DIR appears as ".git" at its top,
    but the logic was faulty when .git is a "gitdir:" file that points
    at the real place, causing trouble in working trees that are
    managed by "git worktree".  This has been corrected.
 
  * Codepaths that read from an on-disk loose object were too loose in
-   validating what they are reading is a proper object file and
+   validating that they are reading a proper object file and
    sometimes read past the data they read from the disk, which has
    been corrected.  H/t to Gustavo Grieco for reporting.
 
@@ -434,8 +435,8 @@ notes for details).
    time, and "git gui" was the last in-tree user of the syntax.  This
    is finally fixed, so that we can move forward with the deprecation.
 
- * An author name, that spelled a backslash-quoted double quote in the
-   human readable part "My \"double quoted\" name", was not unquoted
+ * An author name that has a backslash-quoted double quote in the
+   human readable part ("My \"double quoted\" name"), was not unquoted
    correctly while applying a patch from a piece of e-mail.
 
  * Doc update to clarify what "log -3 --reverse" does.
@@ -449,11 +450,10 @@ notes for details).
    has been fixed; this did not affect any existing code as nobody
    tried to write anything after the padding on such a line, though.
 
- * The code that parses the format parameter of for-each-ref command
+ * The code that parses the format parameter of the for-each-ref command
    has seen a micro-optimization.
 
- * When we started cURL to talk to imap server when a new enough
-   version of cURL library is available, we forgot to explicitly add
+ * When we started to use cURL to talk to an imap server, we forgot to explicitly add
    imap(s):// before the destination.  To some folks, that didn't work
    and the library tried to make HTTP(s) requests instead.
 
@@ -474,13 +474,12 @@ notes for details).
    "Give me only the history since that version".
    (merge cccf74e2da nd/shallow-deepen later to maint).
 
- * It is a common mistake to say "git blame --reverse OLD path",
-   expecting that the command line is dwimmed as if asking how lines
+ * "git blame --reverse OLD path" is now DWIMmed to show how lines
    in path in an old revision OLD have survived up to the current
    commit.
    (merge e1d09701a4 jc/blame-reverse later to maint).
 
- * http.emptyauth configuration is a way to allow an empty username to
+ * The http.emptyauth configuration variable is a way to allow an empty username to
    pass when attempting to authenticate using mechanisms like
    Kerberos.  We took an unspecified (NULL) username and sent ":"
    (i.e. no username, no password) to CURLOPT_USERPWD, but did not do
@@ -494,19 +493,19 @@ notes for details).
    -p <paths>" adds to the current contents of the index to come up
    with what to commit.
 
- * A stray symbolic link in $GIT_DIR/refs/ directory could make name
+ * A stray symbolic link in the $GIT_DIR/refs/ directory could make name
    resolution loop forever, which has been corrected.
 
  * The "submodule.<name>.path" stored in .gitmodules is never copied
    to .git/config and such a key in .git/config has no meaning, but
-   the documentation described it and submodule.<name>.url next to
-   each other as if both belong to .git/config.  This has been fixed.
+   the documentation described it next to submodule.<name>.url
+   as if both belong to .git/config.  This has been fixed.
 
- * In a worktree connected to a repository elsewhere, created via "git
+ * In a worktree created via "git
    worktree", "git checkout" attempts to protect users from confusion
    by refusing to check out a branch that is already checked out in
    another worktree.  However, this also prevented checking out a
-   branch, which is designated as the primary branch of a bare
+   branch which is designated as the primary branch of a bare
    reopsitory, in a worktree that is connected to the bare
    repository.  The check has been corrected to allow it.
 
@@ -515,7 +514,7 @@ notes for details).
 
  * When fetching from a remote that has many tags that are irrelevant
    to branches we are following, we used to waste way too many cycles
-   when checking if the object pointed at by a tag (that we are not
+   checking if the object pointed at by a tag (that we are not
    going to fetch!) exists in our repository too carefully.
 
  * Protect our code from over-eager compilers.
@@ -524,27 +523,27 @@ notes for details).
    "." instead of the branch name; the documentation has been updated
    to describe it.
 
- * A hot-fix for a test added by a recent topic that went to both
+ * Hot-fixed a test added by a recent topic that went to both
    'master' and 'maint' already.
 
  * "git send-email" attempts to pick up valid e-mails from the
-   trailers, but people in real world write non-addresses there, like
+   trailers, but people in the real world write non-addresses there, like
    "Cc: Stable <add@re.ss> # 4.8+", which broke the output depending
-   on the availability and vintage of Mail::Address perl module.
+   on the availability and vintage of the Mail::Address perl module.
    (merge dcfafc5214 mm/send-email-cc-cruft-after-address later to maint).
 
- * The Travis CI configuration we ship ran the tests with --verbose
+ * The Travis CI configuration we ship ran the tests with the --verbose
    option but this risks non-TAP output that happens to be "ok" to be
    misinterpreted as TAP signalling a test that passed.  This resulted
-   in unnecessary failure.  This has been corrected by introducing a
+   in unnecessary failures.  This has been corrected by introducing a
    new mode to run our tests in the test harness to send the verbose
    output separately to the log file.
 
- * Some AsciiDoc formatter mishandles a displayed illustration with
+ * Some AsciiDoc formatters mishandle a displayed illustration with
    tabs in it.  Adjust a few of them in merge-base documentation to
    work around them.
 
- * A minor regression fix for "git submodule" that was introduced
+ * Fixed a minor regression in "git submodule" that was introduced
    when more helper functions were reimplemented in C.
    (merge 77b63ac31e sb/submodule-ignore-trailing-slash later to maint).
 
@@ -553,19 +552,19 @@ notes for details).
    theoretical world.
    (merge bb84735c80 rs/ring-buffer-wraparound later to maint).
 
- * "git daemon" used fixed-length buffers to turn URL to the
+ * "git daemon" used fixed-length buffers to turn URLs to the
    repository the client asked for into the server side directory
-   path, using snprintf() to avoid overflowing these buffers, but
+   paths, using snprintf() to avoid overflowing these buffers, but
    allowed possibly truncated paths to the directory.  This has been
-   tightened to reject such a request that causes overlong path to be
-   required to serve.
+   tightened to reject such a request that causes an overlong path to be
+   served.
    (merge 6bdb0083be jk/daemon-path-ok-check-truncation later to maint).
 
  * Recent update to git-sh-setup (a library of shell functions that
    are used by our in-tree scripted Porcelain commands) included
    another shell library git-sh-i18n without specifying where it is,
    relying on the $PATH.  This has been fixed to be more explicit by
-   prefixing $(git --exec-path) output in front.
+   prefixing with $(git --exec-path) output.
    (merge 1073094f30 ak/sh-setup-dot-source-i18n-fix later to maint).
 
  * Fix for a racy false-positive test failure.
@@ -578,7 +577,7 @@ notes for details).
    caused the command to segfault when on an unborn branch.
    (merge 84679d470d jc/for-each-ref-head-segfault-fix later to maint).
 
- * "git rebase -i" did not work well with core.commentchar
+ * "git rebase -i" did not work well with the core.commentchar
    configuration variable for two reasons, both of which have been
    fixed.
    (merge 882cd23777 js/rebase-i-commentchar-fix later to maint).
-- 
2.10.2

