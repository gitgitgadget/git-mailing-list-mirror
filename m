From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 3/3] Convert coding-guidelines.txt and
 submitting-patches.txt to asciidoc
Date: Sun, 30 Dec 2012 11:35:23 +0100 (CET)
Message-ID: <1873169969.1364143.1356863723132.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 11:35:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpGF8-0006kx-F5
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 11:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab2L3Kf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 05:35:27 -0500
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:54406 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754023Ab2L3KfY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2012 05:35:24 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 3D38035A7B2
	for <git@vger.kernel.org>; Sun, 30 Dec 2012 11:35:23 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 36CE028ADD0;
	Sun, 30 Dec 2012 11:35:23 +0100 (CET)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 28464AA114;
	Sun, 30 Dec 2012 11:35:23 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 28464AA114
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356863723; bh=4Glkwe9pl9U4Mx5rZD7ZNt3mJ3Ecka9cnS5UPU7DOpA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=XWY4U1TVzRMKd8rQxCcubSVjgSgt/T1OmuDojM+RSTtt8P2oaFBPAQOSQul73dUZn
	 Llry1hVFMTfNhhDsQPsLuEHoekkUMjZ4AKeR5VizpwO6+klcu272aUtfCEIIFx3FjX
	 qRnzLm4Ump9OxfJTt7+UaJeX8y2/XBpUELOBUimA=
Received: from [188.98.241.53] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Sun, 30 Dec 2012 11:35:23 +0100 (CET)
In-Reply-To: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.241.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212326>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/coding-guidelines.txt  | 175 ++++++++++++++-----------
 Documentation/technical/submitting-patches.txt | 144 ++++++++++----------
 2 files changed, 174 insertions(+), 145 deletions(-)

diff --git a/Documentation/technical/coding-guidelines.txt b/Documentation/technical/coding-guidelines.txt
index 69f7e9b..406ded8 100644
--- a/Documentation/technical/coding-guidelines.txt
+++ b/Documentation/technical/coding-guidelines.txt
@@ -1,23 +1,25 @@
+Coding guidelines
+=================
+
 Like other projects, we also have some guidelines to keep to the
 code.  For git in general, three rough rules are:
 
- - Most importantly, we never say "It's in POSIX; we'll happily
+- Most importantly, we never say "It's in POSIX; we'll happily
    ignore your needs should your system not conform to it."
    We live in the real world.
 
- - However, we often say "Let's stay away from that construct,
+- However, we often say "Let's stay away from that construct,
    it's not even in POSIX".
 
- - In spite of the above two rules, we sometimes say "Although
+- In spite of the above two rules, we sometimes say "Although
    this is not in POSIX, it (is so convenient | makes the code
    much more readable | has other good characteristics) and
    practically all the platforms we care about support it, so
    let's use it".
 
-   Again, we live in the real world, and it is sometimes a
-   judgement call, the decision based more on real world
-   constraints people face than what the paper standard says.
-
+Again, we live in the real world, and it is sometimes a
+judgement call, the decision based more on real world
+constraints people face than what the paper standard says.
 
 As for more concrete guidelines, just imitate the existing code
 (this is a good guideline, no matter which project you are
@@ -30,173 +32,183 @@ uses (even if it doesn't match the overall style of existing code).
 But if you must have a list of rules, here they are.
 
 For shell scripts specifically (not exhaustive):
+------------------------------------------------
 
- - We use tabs for indentation.
+- We use tabs for indentation.
 
- - Case arms are indented at the same depth as case and esac lines.
+- Case arms are indented at the same depth as case and esac lines.
 
- - Redirection operators should be written with space before, but no
+- Redirection operators should be written with space before, but no
    space after them.  In other words, write 'echo test >"$file"'
    instead of 'echo test> $file' or 'echo test > $file'.  Note that
    even though it is not required by POSIX to double-quote the
    redirection target in a variable (as shown above), our code does so
    because some versions of bash issue a warning without the quotes.
 
- - We prefer $( ... ) for command substitution; unlike ``, it
+- We prefer $( ... ) for command substitution; unlike ``, it
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
 
- - If you want to find out if a command is available on the user's
+- If you want to find out if a command is available on the user's
    $PATH, you should use 'type <command>', instead of 'which <command>'.
    The output of 'which' is not machine parseable and its exit code
    is not reliable across platforms.
 
- - We use POSIX compliant parameter substitutions and avoid bashisms;
+- We use POSIX compliant parameter substitutions and avoid bashisms;
    namely:
 
-   - We use ${parameter-word} and its [-=?+] siblings, and their
-     colon'ed "unset or null" form.
+	* We use `${parameter-word}` and its `[-=?+]` siblings, and their
+	  colon'ed "unset or null" form.
 
-   - We use ${parameter#word} and its [#%] siblings, and their
-     doubled "longest matching" form.
+	* We use `${parameter#word}` and its `[#%]` siblings, and their
+	  doubled "longest matching" form.
 
-   - No "Substring Expansion" ${parameter:offset:length}.
+	* No "Substring Expansion" `${parameter:offset:length}`.
 
-   - No shell arrays.
+	* No shell arrays.
 
-   - No strlen ${#parameter}.
+	* No strlen `${#parameter}`.
 
-   - No pattern replacement ${parameter/pattern/string}.
+	* No pattern replacement `${parameter/pattern/string}`.
 
- - We use Arithmetic Expansion $(( ... )).
+- We use Arithmetic Expansion $(( ... )).
 
- - Inside Arithmetic Expansion, spell shell variables with $ in front
+- Inside Arithmetic Expansion, spell shell variables with $ in front
    of them, as some shells do not grok $((x)) while accepting $(($x))
    just fine (e.g. dash older than 0.5.4).
 
- - We do not use Process Substitution <(list) or >(list).
+- We do not use Process Substitution <(list) or >(list).
 
- - Do not write control structures on a single line with semicolon.
+- Do not write control structures on a single line with semicolon.
    "then" should be on the next line for if statements, and "do"
    should be on the next line for "while" and "for".
 
- - We prefer "test" over "[ ... ]".
+- We prefer "test" over "[ ... ]".
 
- - We do not write the noiseword "function" in front of shell
+- We do not write the noiseword "function" in front of shell
    functions.
 
- - We prefer a space between the function name and the parentheses. The
+- We prefer a space between the function name and the parentheses. The
    opening "{" should also be on the same line.
    E.g.: my_function () {
 
- - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
+- As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
    [::], [==], nor [..]) for portability.
 
-   - We do not use \{m,n\};
+	* We do not use \{m,n\};
 
-   - We do not use -E;
+	* We do not use -E;
 
-   - We do not use ? nor + (which are \{0,1\} and \{1,\}
-     respectively in BRE) but that goes without saying as these
-     are ERE elements not BRE (note that \? and \+ are not even part
-     of BRE -- making them accessible from BRE is a GNU extension).
+	* We do not use ? nor + (which are \{0,1\} and \{1,\}
+	  respectively in BRE) but that goes without saying as these
+	  are ERE elements not BRE (note that \? and \+ are not even part
+	  of BRE -- making them accessible from BRE is a GNU extension).
 
- - Use Git's gettext wrappers in git-sh-i18n to make the user
+- Use Git's gettext wrappers in git-sh-i18n to make the user
    interface translatable. See "Marking strings for translation" in
    po/README.
 
 For C programs:
+---------------
 
- - We use tabs to indent, and interpret tabs as taking up to
+- We use tabs to indent, and interpret tabs as taking up to
    8 spaces.
 
- - We try to keep to at most 80 characters per line.
+- We try to keep to at most 80 characters per line.
 
- - We try to support a wide range of C compilers to compile git with,
+- We try to support a wide range of C compilers to compile git with,
    including old ones. That means that you should not use C99
    initializers, even if a lot of compilers grok it.
 
- - Variables have to be declared at the beginning of the block.
-
- - NULL pointers shall be written as NULL, not as 0.
-
- - When declaring pointers, the star sides with the variable
-   name, i.e. "char *string", not "char* string" or
-   "char * string".  This makes it easier to understand code
-   like "char *string, c;".
+- Variables have to be declared at the beginning of the block.
 
- - We avoid using braces unnecessarily.  I.e.
+- NULL pointers shall be written as NULL, not as 0.
 
-	if (bla) {
-		x = 1;
-	}
+- When declaring pointers, the star sides with the variable
+   name, i.e. `char *string`, not `char* string` or
+   `char * string`.  This makes it easier to understand code
+   like `char *string, c;`.
 
-   is frowned upon.  A gray area is when the statement extends
-   over a few lines, and/or you have a lengthy comment atop of
-   it.  Also, like in the Linux kernel, if there is a long list
-   of "else if" statements, it can make sense to add braces to
-   single line blocks.
+- We avoid using braces unnecessarily.  I.e.
++
+............
+if (bla) {
+	x = 1;
+}
+............
++
+is frowned upon.  A gray area is when the statement extends
+over a few lines, and/or you have a lengthy comment atop of
+it.  Also, like in the Linux kernel, if there is a long list
+of `else if` statements, it can make sense to add braces to
+single line blocks.
 
- - We try to avoid assignments inside if().
+- We try to avoid assignments inside if().
 
- - Try to make your code understandable.  You may put comments
+- Try to make your code understandable.  You may put comments
    in, but comments invariably tend to stale out when the code
    they were describing changes.  Often splitting a function
    into two makes the intention of the code much clearer.
 
- - Double negation is often harder to understand than no negation
+- Double negation is often harder to understand than no negation
    at all.
 
- - Some clever tricks, like using the !! operator with arithmetic
+- Some clever tricks, like using the !! operator with arithmetic
    constructs, can be extremely confusing to others.  Avoid them,
    unless there is a compelling reason to use them.
 
- - Use the API.  No, really.  We have a strbuf (variable length
+- Use the API.  No, really.  We have a strbuf (variable length
    string), several arrays with the ALLOC_GROW() macro, a
    string_list for sorted string lists, a hash map (mapping struct
    objects) named "struct decorate", amongst other things.
 
- - When you come up with an API, document it.
+- When you come up with an API, document it.
 
- - The first #include in C files, except in platform specific
+- The first #include in C files, except in platform specific
    compat/ implementations, should be git-compat-util.h or another
    header file that includes it, such as cache.h or builtin.h.
 
- - If you are planning a new command, consider writing it in shell
+- If you are planning a new command, consider writing it in shell
    or perl first, so that changes in semantics can be easily
    changed and discussed.  Many git commands started out like
    that, and a few are still scripts.
 
- - Avoid introducing a new dependency into git. This means you
+- Avoid introducing a new dependency into git. This means you
    usually should stay away from scripting languages not already
    used in the git core command set (unless your command is clearly
    separate from it, such as an importer to convert random-scm-X
    repositories to git).
 
- - When we pass <string, length> pair to functions, we should try to
+- When we pass <string, length> pair to functions, we should try to
    pass them in that order.
 
- - Use Git's gettext wrappers to make the user interface
+- Use Git's gettext wrappers to make the user interface
    translatable. See "Marking strings for translation" in po/README.
 
 Writing Documentation:
+----------------------
 
- Every user-visible change should be reflected in the documentation.
- The same general rule as for code applies -- imitate the existing
- conventions.  A few commented examples follow to provide reference
- when writing or modifying command usage strings and synopsis sections
- in the manual pages:
+Every user-visible change should be reflected in the documentation.
+The same general rule as for code applies -- imitate the existing
+conventions.  A few commented examples follow to provide reference
+when writing or modifying command usage strings and synopsis sections
+in the manual pages:
 
- Placeholders are spelled in lowercase and enclosed in angle brackets:
+Placeholders are spelled in lowercase and enclosed in angle brackets:
+...................
    <file>
    --sort=<key>
    --abbrev[=<n>]
+...................
 
- Possibility of multiple occurrences is indicated by three dots:
+Possibility of multiple occurrences is indicated by three dots:
+...................
    <file>...
    (One or more of <file>.)
+...................
 
- Optional parts are enclosed in square brackets:
+Optional parts are enclosed in square brackets:
+...................
    [<extra>]
    (Zero or one <extra>.)
 
@@ -207,12 +219,16 @@ Writing Documentation:
    [<patch>...]
    (Zero or more of <patch>.  Note that the dots are inside, not
    outside the brackets.)
+...................
 
- Multiple alternatives are indicated with vertical bar:
+Multiple alternatives are indicated with vertical bar:
+...................
    [-q | --quiet]
    [--utf8 | --no-utf8]
+...................
 
- Parentheses are used for grouping:
+Parentheses are used for grouping:
+...................
    [(<rev>|<range>)...]
    (Any number of either <rev> or <range>.  Parens are needed to make
    it clear that "..." pertains to both <rev> and <range>.)
@@ -223,10 +239,13 @@ Writing Documentation:
    git remote set-head <name> (-a | -d | <branch>)
    (One and only one of "-a", "-d" or "<branch>" _must_ (no square
    brackets) be provided.)
+...................
 
- And a somewhat more contrived example:
+And a somewhat more contrived example:
+...................
    --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]
    Here "=" is outside the brackets, because "--diff-filter=" is a
    valid usage.  "*" has its own pair of brackets, because it can
    (optionally) be specified only when one or more of the letters is
    also provided.
+...................
diff --git a/Documentation/technical/submitting-patches.txt b/Documentation/technical/submitting-patches.txt
index 75935d5..925b79e 100644
--- a/Documentation/technical/submitting-patches.txt
+++ b/Documentation/technical/submitting-patches.txt
@@ -1,69 +1,75 @@
+Submitting Patches
+==================
+
 Checklist (and a short version for the impatient):
 
-	Commits:
-
-	- make commits of logical units
-	- check for unnecessary whitespace with "git diff --check"
-	  before committing
-	- do not check in commented out code or unneeded files
-	- the first line of the commit message should be a short
-	  description (50 characters is the soft limit, see DISCUSSION
-	  in git-commit(1)), and should skip the full stop
-	- it is also conventional in most cases to prefix the
-	  first line with "area: " where the area is a filename
-	  or identifier for the general area of the code being
-	  modified, e.g.
-	  . archive: ustar header checksum is computed unsigned
-	  . git-cherry-pick.txt: clarify the use of revision range notation
-	  (if in doubt which identifier to use, run "git log --no-merges"
-	  on the files you are modifying to see the current conventions)
-	- the body should provide a meaningful commit message, which:
-	  . explains the problem the change tries to solve, iow, what
-	    is wrong with the current code without the change.
-	  . justifies the way the change solves the problem, iow, why
-	    the result with the change is better.
-	  . alternate solutions considered but discarded, if any.
-	- describe changes in imperative mood, e.g. "make xyzzy do frotz"
-	  instead of "[This patch] makes xyzzy do frotz" or "[I] changed
-	  xyzzy to do frotz", as if you are giving orders to the codebase
-	  to change its behaviour.
-	- try to make sure your explanation can be understood without
-	  external resources. Instead of giving a URL to a mailing list
-	  archive, summarize the relevant points of the discussion.
-	- add a "Signed-off-by: Your Name <you@example.com>" line to the
-	  commit message (or just use the option "-s" when committing)
-	  to confirm that you agree to the Developer's Certificate of Origin
-	- make sure that you have tests for the bug you are fixing
-	- make sure that the test suite passes after your commit
-
-	Patch:
-
-	- use "git format-patch -M" to create the patch
-	- do not PGP sign your patch
-	- do not attach your patch, but read in the mail
-	  body, unless you cannot teach your mailer to
-	  leave the formatting of the patch alone.
-	- be careful doing cut & paste into your mailer, not to
-	  corrupt whitespaces.
-	- provide additional information (which is unsuitable for
-	  the commit message) between the "---" and the diffstat
-	- if you change, add, or remove a command line option or
-	  make some other user interface change, the associated
-	  documentation should be updated as well.
-	- if your name is not writable in ASCII, make sure that
-	  you send off a message in the correct encoding.
-	- send the patch to the list (git@vger.kernel.org) and the
-	  maintainer (gitster@pobox.com) if (and only if) the patch
-	  is ready for inclusion. If you use git-send-email(1),
-	  please test it first by sending email to yourself.
-	- see below for instructions specific to your mailer
+Commits:
+--------
+
+- make commits of logical units
+- check for unnecessary whitespace with "git diff --check"
+  before committing
+- do not check in commented out code or unneeded files
+- the first line of the commit message should be a short
+  description (50 characters is the soft limit, see DISCUSSION
+  in git-commit(1)), and should skip the full stop
+- it is also conventional in most cases to prefix the
+  first line with "area: " where the area is a filename
+  or identifier for the general area of the code being
+  modified, e.g.
+  * archive: ustar header checksum is computed unsigned
+  * git-cherry-pick.txt: clarify the use of revision range notation
+  (if in doubt which identifier to use, run "git log --no-merges"
+  on the files you are modifying to see the current conventions)
+- the body should provide a meaningful commit message, which:
+  * explains the problem the change tries to solve, iow, what
+	is wrong with the current code without the change.
+  * justifies the way the change solves the problem, iow, why
+	the result with the change is better.
+  * alternate solutions considered but discarded, if any.
+- describe changes in imperative mood, e.g. "make xyzzy do frotz"
+  instead of "[This patch] makes xyzzy do frotz" or "[I] changed
+  xyzzy to do frotz", as if you are giving orders to the codebase
+  to change its behaviour.
+- try to make sure your explanation can be understood without
+  external resources. Instead of giving a URL to a mailing list
+  archive, summarize the relevant points of the discussion.
+- add a `Signed-off-by: Your Name <you@example.com>` line to the
+  commit message (or just use the option "-s" when committing)
+  to confirm that you agree to the Developer's Certificate of Origin
+- make sure that you have tests for the bug you are fixing
+- make sure that the test suite passes after your commit
+
+Patch:
+------
+
+- use "git format-patch -M" to create the patch
+- do not PGP sign your patch
+- do not attach your patch, but read in the mail
+  body, unless you cannot teach your mailer to
+  leave the formatting of the patch alone.
+- be careful doing cut & paste into your mailer, not to
+  corrupt whitespaces.
+- provide additional information (which is unsuitable for
+  the commit message) between the "---" and the diffstat
+- if you change, add, or remove a command line option or
+  make some other user interface change, the associated
+  documentation should be updated as well.
+- if your name is not writable in ASCII, make sure that
+  you send off a message in the correct encoding.
+- send the patch to the list (git@vger.kernel.org) and the
+  maintainer (gitster@pobox.com) if (and only if) the patch
+  is ready for inclusion. If you use git-send-email(1),
+  please test it first by sending email to yourself.
+- see below for instructions specific to your mailer
 
 Long version:
+-------------
 
 I started reading over the SubmittingPatches document for Linux
 kernel, primarily because I wanted to have a document similar to
 it for the core GIT to make sure people understand what they are
-doing when they write "Signed-off-by" line.
+doing when they write `Signed-off-by` line.
 
 But the patch submission requirements are a lot more relaxed
 here on the technical/contents front, because the core GIT is
@@ -285,7 +291,7 @@ If you like, you can put extra tags at the end:
 You can also create your own tag or use one that's in common usage
 such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 
-------------------------------------------------
+..................................
 An ideal patch flow
 
 Here is an ideal patch flow for this project the current maintainer
@@ -319,8 +325,8 @@ In any time between the (2)-(3) cycle, the maintainer may pick it up
 from the list and queue it to 'pu', in order to make it easier for
 people play with it without having to pick up and apply the patch to
 their trees themselves.
+..................................
 
-------------------------------------------------
 Know the status of your patch after submission
 
 * You can use Git itself to find out when your patch is merged in
@@ -334,8 +340,8 @@ Know the status of your patch after submission
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
 
-------------------------------------------------
 MUA specific hints
+~~~~~~~~~~~~~~~~~~
 
 Some of patches I receive or pick up from the list share common
 patterns of breakage.  Please make sure your MUA is set up
@@ -356,7 +362,7 @@ commit message.
 
 
 Pine
-----
+^^^^
 
 (Johannes Schindelin)
 
@@ -364,14 +370,14 @@ I don't know how many people still use pine, but for those poor
 souls it may be good to mention that the quell-flowed-text is
 needed for recent versions.
 
-... the "no-strip-whitespace-before-send" option, too. AFAIK it
+And the "no-strip-whitespace-before-send" option, too. AFAIK it
 was introduced in 4.60.
 
 (Linus Torvalds)
 
 And 4.58 needs at least this.
 
----
+...........................
 diff-tree 8326dd8350be64ac7fc805f6563a1d61ad10d32c (from e886a61f76edf5410573e92e38ce22974f9c40f1)
 Author: Linus Torvalds <torvalds@g5.osdl.org>
 Date:   Mon Aug 15 17:23:51 2005 -0700
@@ -381,6 +387,8 @@ Date:   Mon Aug 15 17:23:51 2005 -0700
     There's no excuse for unconditionally removing whitespace from
     the pico buffers on close.
 
+--------------------------------------
+
 diff --git a/pico/pico.c b/pico/pico.c
 --- a/pico/pico.c
 +++ b/pico/pico.c
@@ -393,12 +401,14 @@ diff --git a/pico/pico.c b/pico/pico.c
 +#endif
 		c |= COMP_EXIT;
 		break;
-
+...........................
 
 (Daniel Barkalow)
 
+...........................
 > A patch to SubmittingPatches, MUA specific help section for
 > users of Pine 4.63 would be very much appreciated.
+...........................
 
 Ah, it looks like a recent version changed the default behavior to do the
 right thing, and inverted the sense of the configuration option. (Either
@@ -409,12 +419,12 @@ it.
 
 
 Thunderbird, KMail, GMail
--------------------------
+^^^^^^^^^^^^^^^^^^^^^^^^^
 
 See the MUA-SPECIFIC HINTS section of git-format-patch(1).
 
 Gnus
-----
+^^^^
 
 '|' in the *Summary* buffer can be used to pipe the current
 message to an external program, and this is a handy way to drive
-- 
1.8.0.msysgit.0


---
Thomas
