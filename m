From: David Greaves <david@dgreaves.com>
Subject: Re: [FILE] Docs update
Date: Wed, 27 Apr 2005 12:46:04 +0100
Message-ID: <426F7B7C.3060407@dgreaves.com>
References: <426BF790.9070406@dgreaves.com> <Pine.LNX.4.58.0504241438280.15879@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000804060701040107020103"
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 15:00:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQm87-00027l-Hg
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 14:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVD0NEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 09:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVD0NEY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 09:04:24 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:6126 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261571AbVD0NCw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 09:02:52 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 4CFEEE6D8A; Wed, 27 Apr 2005 14:00:24 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23285-08; Wed, 27 Apr 2005 14:00:24 +0100 (BST)
Received: from oak.dgreaves.com (modem-1719.lynx.dialup.pol.co.uk [217.135.198.183])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 7258FE6D3F; Wed, 27 Apr 2005 14:00:18 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DQkzU-0006mt-6e; Wed, 27 Apr 2005 12:46:04 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504241438280.15879@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------000804060701040107020103
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

>On Sun, 24 Apr 2005, David Greaves wrote:
>  
>
>>And I've attached this as a file rather than a patch to make it easier 
>>for people to read.
>>    
>>
>Suggestion: move "diff-tree" up above "diff-cache", since as it is now, 
>you explain "diff-cache" in terms of diff-tree, before you've even 
>explained diff-tree in the first place.
>  
>
Yes, but this isn't a tutorial.
Ideally it'll become man pages (the chatty kind)
For now keeping it in alphabetical order is probably easier for people 
looking for info on a particular command - and I've updated the 'see 
diff-tree' comment to point people forward. OK?

>Also, the current diff-tree has an extension:
>  
>
added.
I've also incorporated comments from Junio and Daniel.

I know pasky accepted an early version into his tree but now it's purely 
core-git, it would be nice to get it into your tree.

What I propose is that you accept it as-is and then it would seem 
reasonable for you to ask for relevant patches to include changes to the 
docs before you finally push them.

They don't have to be perfect - no need to patch the synopsis or args 
spec; just some explanatory text - I'll keep an eye on it and fix up the 
editing. And if you're really lazy and just commit with a 'docs need 
updating' or something then I guess I can catch that... eventually. And 
I'll take care of the rename too when it happens.

And yes, I know it's now out-of-date (it is 3 days old!!) - so part 2 of 
my proposal is that I'll continue to send more patches for the missing 
commands and I'll also send patches to the code to bring the usage() 
text in line with the consistent terminology used in the docs.

And since it's not used, how would you feel about making all the 
commands take a -h and returning the usage and possibly a synopsis?
I could patch that in at the same time as I consistency-ise all the 
usage strings.

David


Reference documentation for the core git commands.

Signed-off-by: David Greaves <david@dgreaves.com>
---


--------------000804060701040107020103
Content-Type: text/plain;
 name="README.reference"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.reference"

This file contains reference information for the core git commands.
It is actually based on the source from Petr Baudis' tree and may
therefore contain a few 'extras' that may or may not make it upstream.

The README contains much useful definition and clarification info -
read that first.  And of the commands, I suggest reading
'update-cache' and 'read-tree' first - I wish I had!

Thanks to original email authors and proof readers esp Junio C Hamano
<junkio@cox.net>

David Greaves <david@dgreaves.com>
24/4/05

Identifier terminology used:

<object>
	Indicates any object sha1 identifier

<blob>
	Indicates a blob object sha1 identifier

<tree>
	Indicates a tree object sha1 identifier

<commit>
	Indicates a commit object sha1 identifier

<tree/commit>
	Indicates a tree or commit object sha1 identifier (usually
	because the command can read the <tree> a <commit> contains).
	[Eventually may be replaced with <tree> if <tree> means
	<tree/commit> in all commands]

<type>
	Indicates that an object type is required.
	Currently one of: blob/tree/commit

<file>
	Indicates a filename - often includes leading path

<path>
	Indicates the path of a file (is this ever useful?)



################################################################
cat-file
	cat-file (-t | <type>) <object>

Provide contents or type of objects in the repository. The type is
required if -t is not being used to find the object type.

<object>
	The sha1 identifier of the object.

-t
	show the object type identified by <object>

<type>
	One of: blob/tree/commit

Output

If -t is specified, one of:
        blob/tree/commit

Otherwise the raw (though uncompressed) contents of the <object> will
be returned.


################################################################
check-files
	check-files <file>...

Check that a list of files are up-to-date between the filesystem and
the cache. Used to verify a patch target before doing a patch.

Files that do not exist on the filesystem are considered up-to-date
(whether or not they are in the cache).

Emits an error message on failure.
preparing to update existing file <file> not in cache
	  <file> exists but is not in the cache

preparing to update file <file> not uptodate in cache
	  <file> on disk is not up-to-date with the cache

exits with a status code indicating success if all files are
up-to-date.

see also: update-cache


################################################################
checkout-cache
	checkout-cache [-q] [-a] [-f] [-n] [--prefix=<string>]
		       [--] <file>...

Will copy all files listed from the cache to the working directory
(not overwriting existing files). Note that the file contents are
restored - NOT the file permissions.

-q
	be quiet if files exist or are not in the cache

-f
	forces overwrite of existing files

-a
	checks out all files in the cache (will then continue to
	process listed files).
-n
	Don't checkout new files, only refresh files already checked
	out.

--prefix=<string>
	When creating files, prepend <string> (usually a directory
	including a trailing /)

--
	Do not interpret any more arguments as options.

Note that the order of the flags matters:

	checkout-cache -a -f file.c

will first check out all files listed in the cache (but not overwrite
any old ones), and then force-checkout file.c a second time (ie that
one _will_ overwrite any old contents with the same filename).

Also, just doing "checkout-cache" does nothing. You probably meant
"checkout-cache -a". And if you want to force it, you want
"checkout-cache -f -a".

Intuitiveness is not the goal here. Repeatability is. The reason for
the "no arguments means no work" thing is that from scripts you are
supposed to be able to do things like

	find . -name '*.h' -print0 | xargs -0 checkout-cache -f --

which will force all existing *.h files to be replaced with their
cached copies. If an empty command line implied "all", then this would
force-refresh everything in the cache, which was not the point.

To update and refresh only the files already checked out:

   checkout-cache -n -f -a && update-cache --ignore-missing --refresh

Oh, and the "--" is just a good idea when you know the rest will be
filenames. Just so that you wouldn't have a filename of "-a" causing
problems (not possible in the above example, but get used to it in
scripting!).

The prefix ability basically makes it trivial to use checkout-cache as
a "export as tree" function. Just read the desired tree into the
index, and do a
  
        checkout-cache --prefix=export-dir/ -a
  
and checkout-cache will "export" the cache into the specified
directory.
  
NOTE! The final "/" is important. The exported name is literally just
prefixed with the specified string, so you can also do something like
  
        checkout-cache --prefix=.merged- Makefile
  
to check out the currently cached copy of "Makefile" into the file
".merged-Makefile".


################################################################
commit-tree
	commit-tree <tree> [-p <parent commit>]*   < changelog

Creates a new commit object based on the provided tree object and
emits the new commit object id on stdout. If no parent is given then
it is considered to be an initial tree.

A commit object usually has 1 parent (a commit after a change) or up
to 16 parents.  More than one parent represents a merge of branches
that led to them.

While a tree represents a particular directory state of a working
directory, a commit represents that state in "time", and explains how
to get there.

Normally a commit would identify a new "HEAD" state, and while git
doesn't care where you save the note about that state, in practice we
tend to just write the result to the file ".git/HEAD", so that we can
always see what the last committed state was.

Options

<tree>
	An existing tree object

-p <parent commit>
	Each -p indicates a the id of a parent commit object.
	

Commit Information

A commit encapsulates:
	all parent object ids
	author name, email and date
	committer name and email and the commit time.

If not provided, commit-tree uses your name, hostname and domain to
provide author and committer info. This can be overridden using the
following environment variables.
	AUTHOR_NAME
	AUTHOR_EMAIL
	AUTHOR_DATE
	COMMIT_AUTHOR_NAME
	COMMIT_AUTHOR_EMAIL
(nb <,> and '\n's are stripped)

A commit comment is read from stdin (max 999 chars). If a changelog
entry is not provided via '<' redirection, commit-tree will just wait
for one to be entered and terminated with ^D

see also: write-tree


################################################################
diff-cache
	diff-cache [-r] [-z] [--cached] <tree/commit>

Compares the content and mode of the blobs found via a tree object
with the content of the current cache and, optionally ignoring the
stat state of the file on disk.

(This is basically a special case of diff-tree that works with the
current cache as the first tree - see diff-tree for more details)

<tree/commit>
	The id of a tree or commit object to diff against.

-r
	recurse

-z
	\0 line termination on output

--cached
	do not consider the on-disk file at all

Output format:

For files in the tree but not in the cache
-<mode>\t <type>\t	<object>\t	<path><file>

For files in the cache but not in the tree
+<mode>\t <type>\t	<object>\t	<path><file>

For files that differ:
*<tree-mode>-><cache-mode>\t <type>\t	<tree-sha1>-><cache-sha1>\t	<path><file>

In the special case of the file being changed on disk and out of sync
with the cache, the sha1 is all 0's.  Example:

	*100644->100660 blob    5be4a414b32cf4204f889469942986d3d783da84->0000000000000000000000000000000000000000      file.c
	

Operating Modes

You can choose whether you want to trust the index file entirely
(using the "--cached" flag) or ask the diff logic to show any files
that don't match the stat state as being "tentatively changed".  Both
of these operations are very useful indeed.

Cached Mode

If --cached is specified, it allows you to ask:
	show me the differences between HEAD and the current index
	contents (the ones I'd write with a "write-tree")

For example, let's say that you have worked on your index file, and are
ready to commit. You want to see eactly _what_ you are going to commit is
without having to write a new tree object and compare it that way, and to
do that, you just do

	diff-cache --cached $(cat .git/HEAD)

Example: let's say I had renamed "commit.c" to "git-commit.c", and I had 
done an "upate-cache" to make that effective in the index file. 
"show-diff" wouldn't show anything at all, since the index file matches 
my working directory. But doing a diff-cache does:
	torvalds@ppc970:~/git> diff-cache --cached $(cat .git/HEAD)
	-100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
	+100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        git-commit.c

And as you can see, the output matches "diff-tree -r" output (we
always do "-r", since the index is always fully populated
??CHECK??).
You can trivially see that the above is a rename.

In fact, "diff-cache --cached" _should_ always be entirely equivalent to
actually doing a "write-tree" and comparing that. Except this one is much
nicer for the case where you just want to check where you are.

So doing a "diff-cache --cached" is basically very useful when you are 
asking yourself "what have I already marked for being committed, and 
what's the difference to a previous tree".

Non-cached Mode

The "non-cached" mode takes a different approach, and is potentially
the even more useful of the two in that what it does can't be emulated
with a "write-tree + diff-tree". Thus that's the default mode.  The
non-cached version asks the question

   "show me the differences between HEAD and the currently checked out 
    tree - index contents _and_ files that aren't up-to-date"

which is obviously a very useful question too, since that tells you what
you _could_ commit. Again, the output matches the "diff-tree -r" output to
a tee, but with a twist.

The twist is that if some file doesn't match the cache, we don't have a
backing store thing for it, and we use the magic "all-zero" sha1 to show
that. So let's say that you have edited "kernel/sched.c", but have not
actually done an update-cache on it yet - there is no "object" associated
with the new state, and you get:

	torvalds@ppc970:~/v2.6/linux> diff-cache $(cat .git/HEAD )
	*100644->100664 blob    7476bbcfe5ef5a1dd87d745f298b831143e4d77e->0000000000000000000000000000000000000000      kernel/sched.c

ie it shows that the tree has changed, and that "kernel/sched.c" has is
not up-to-date and may contain new stuff. The all-zero sha1 means that to
get the real diff, you need to look at the object in the working directory
directly rather than do an object-to-object diff.

NOTE! As with other commands of this type, "diff-cache" does not actually 
look at the contents of the file at all. So maybe "kernel/sched.c" hasn't 
actually changed, and it's just that you touched it. In either case, it's 
a note that you need to upate-cache it to make the cache be in sync.

NOTE 2! You can have a mixture of files show up as "has been updated" and
"is still dirty in the working directory" together. You can always tell
which file is in which state, since the "has been updated" ones show a
valid sha1, and the "not in sync with the index" ones will always have the
special all-zero sha1.

################################################################
diff-tree
	diff-tree [-r] [-z] <tree/commit> <tree/commit> [<pattern>]*

Compares the content and mode of the blobs found via two tree objects.

Note that diff-tree can use the tree encapsulated in a commit object.

<tree sha1>
	The id of a tree or commit object.

<pattern>

	If provided, the results are limited to a subset of files
	matching one of these prefix strings.
	ie file matches /^<pattern1>|<pattern2>|.../
	Note that pattern does not provide any wildcard or regexp features.

-r
	recurse

-z
	\0 line termination on output

Limiting Output

If you're only interested in differences in a subset of files, for
example some architecture-specific files, you might do:

	diff-tree -r <tree/commit> <tree/commit> arch/ia64 include/asm-ia64

and it will only show you what changed in those two directories.

Or if you are searching for what changed in just kernel/sched.c, just do

	diff-tree -r <tree/commit> <tree/commit> kernel/sched.c

and it will ignore all differences to other files.

The pattern is always the prefix, and is matched exactly (ie there are no
wildcards - although matching a directory, which it does support, can
obviously be seen as a "wildcard" for all the files under that directory).

Output format:

For files in tree1 but not in tree2
-<mode>\t <type>\t	<object>\t	<path><file>

For files not in tree1 but in tree2
+<mode>\t <type>\t	<object>\t	<path><file>

For files that differ:
*<tree1-mode>-><tree2-mode>\t <type>\t	<tree1 sha1>-><tree2 sha1>\t	<path><file>


An example of normal usage is:

	torvalds@ppc970:~/git> diff-tree 5319e4d609cdd282069cc4dce33c1db559539b03 b4e628ea30d5ab3606119d2ea5caeab141d38df7
	*100664->100664 blob    ac348b7d5278e9d04e3a1cd417389379c32b014f->a01513ed4d4d565911a60981bfb4173311ba3688      fsck-cache.c

which tells you that the last commit changed just one file (it's from
this one:

	commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
	tree 5319e4d609cdd282069cc4dce33c1db559539b03
	parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
	author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
	committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005

	Make "fsck-cache" print out all the root commits it finds.

	Once I do the reference tracking, I'll also make it print out all the
	HEAD commits it finds, which is even more interesting.

in case you care).


################################################################
fsck-cache
	fsck-cache [[--unreachable] <commit>*]

Verifies the connectivity and validity of the objects in the database.

<commit>
	A commit object to treat as the head of an unreachability
	trace

--unreachable
	print out objects that exist but that aren't readable from any
	of the specified root nodes

It tests SHA1 and general object sanity, but it does full tracking of
the resulting reachability and everything else. It prints out any
corruption it finds (missing or bad objects), and if you use the
"--unreachable" flag it will also print out objects that exist but
that aren't readable from any of the specified root nodes.

So for example

	fsck-cache --unreachable $(cat .git/HEAD)

or, for Cogito users:

	fsck-cache --unreachable $(cat .git/heads/*)

will do quite a _lot_ of verification on the tree. There are a few
extra validity tests to be added (make sure that tree objects are
sorted properly etc), but on the whole if "fsck-cache" is happy, you
do have a valid tree.

Any corrupt objects you will have to find in backups or other archives
(ie you can just remove them and do an "rsync" with some other site in
the hopes that somebody else has the object you have corrupted).

Of course, "valid tree" doesn't mean that it wasn't generated by some
evil person, and the end result might be crap. Git is a revision
tracking system, not a quality assurance system ;)

Extracted Diagnostics

expect dangling commits - potential heads - due to lack of head information
	You haven't specified any nodes as heads so it won't be
	possible to differentiate between un-parented commits and
	root nodes.

missing sha1 directory '<dir>'
	The directory holding the sha1 objects is missing.

unreachable <type> <object>
	The <type> object <object>, isn't actually referred to directly
	or indirectly in any of the trees or commits seen. This can
	mean that there's another root na SHA1_ode that you're not specifying
	or that the tree is corrupt. If you haven't missed a root node
	then you might as well delete unreachable nodes since they
	can't be used.

missing <type> <object>
	The <type> object <object>, is referred to but isn't present in
	the database.

dangling <type> <object>
	The <type> object <object>, is present in the database but never
	_directly_ used. A dangling commit could be a root node.

warning: fsck-cache: tree <tree> has full pathnames in it
	And it shouldn't...

sha1 mismatch <object>
	The database has an object who's sha1 doesn't match the
	database value.
	This indicates a ??serious?? data integrity problem.
	(note: this error occured during early git development when
	the database format changed.)

Environment Variables

SHA1_FILE_DIRECTORY
	used to specify the object database root (usually .git/objects)

################################################################
git-export
	git-export top [base]

probably deprecated:
On Wed, 20 Apr 2005, Petr Baudis wrote:
>> I will probably not buy git-export, though. (That is, it is merged, but
>> I won't make git frontend for it.) My "git export" already does
>> something different, but more importantly, "git patch" of mine already
>> does effectively the same thing as you do, just for a single patch; so I
>> will probably just extend it to do it for an (a,b] range of patches.


That's fine. It was a quick hack, just to show that if somebody wants to, 
the data is trivially exportable.

		Linus

Although in Linus' distribution, git-export is not part of 'core' git.

################################################################
init-db
	init-db

This simply creates an empty git object database - basically a .git
directory.

If the object storage directory is specified via the
SHA1_FILE_DIRECTORY environment variable then the sha1 directories are
created underneath - otherwise the default .git/objects directory is
used.

init-db won't hurt an existing repository.


################################################################
ls-tree
	ls-tree [-r] [-z] <tree/commit>

convert the tree object to a human readable (and script
processable) form.

<tree/commit>
	Id of a tree or commit object.
-r
	recurse into sub-trees

-z
	\0 line termination on output

Output Format
<mode>\t	<type>\t	<object>\t	<path><file>	


################################################################
merge-base
	merge-base <commit> <commit>

merge-base finds as good a common ancestor as possible. Given a
selection of equally good common ancestors it should not be relied on
to decide in any particular way.

The merge-base algorithm is still in flux - use the source...


################################################################
merge-cache
	merge-cache <merge-program> (-a | -- | <file>*) 

This looks up the <file>(s) in the cache and, if there are any merge
entries, unpacks all of them (which may be just one file, of course)
into up to three separate temporary files, and then executes the
supplied <merge-program> with those three files as arguments 1,2,3
(empty argument if no file), and <file> as argument 4.

--
	Interpret all future arguments as filenames

-a
	Run merge against all files in the cache that need merging.

If merge-cache is called with multiple <file>s (or -a) then it
processes them in turn only stopping if merge returns a non-zero exit
code.

Typically this is run with the a script calling the merge command from
the RCS package.

A sample script called git-merge-one-file-script is included in the
ditribution.

ALERT ALERT ALERT! The git "merge object order" is different from the
RCS "merge" program merge object order. In the above ordering, the
original is first. But the argument order to the 3-way merge program
"merge" is to have the original in the middle. Don't ask me why.

Examples:

	torvalds@ppc970:~/merge-test> merge-cache cat MM
	This is MM from the original tree.			# original
	This is modified MM in the branch A.			# merge1
	This is modified MM in the branch B.			# merge2
	This is modified MM in the branch B.			# current contents

or 

	torvalds@ppc970:~/merge-test> merge-cache cat AA MM
	cat: : No such file or directory
	This is added AA in the branch A.
	This is added AA in the branch B.
	This is added AA in the branch B.
	fatal: merge program failed

where the latter example shows how "merge-cache" will stop trying to
merge once anything has returned an error (ie "cat" returned an error
for the AA file, because it didn't exist in the original, and thus
"merge-cache" didn't even try to merge the MM thing).


################################################################
read-tree
	read-tree (<tree/commit> | -m <tree/commit1> [<tree/commit2> <tree/commit3>])"

Reads the tree information given by <tree> into the directory cache,
but does not actually _update_ any of the files it "caches". (see:
checkout-cache)

Optionally, it can merge a tree into the cache or perform a 3-way
merge.

Trivial merges are done by read-tree itself.  Only conflicting paths
will be in unmerged state when read-tree returns.

-m
	Perform a merge, not just a read

<tree#>
	The id of the tree object(s) to be read/merged.


Merging
If -m is specified, read-tree performs 2 kinds of merge, a single tree
merge if only 1 tree is given or a 3-way merge if 3 trees are
provided.

Single Tree Merge
If only 1 tree is specified, read-tree operates as if the user did not
specify "-m", except that if the original cache has an entry for a
given pathname; and the contents of the path matches with the tree
being read, the stat info from the cache is used. (In other words, the
cache's stat()s take precedence over the merged tree's)

That means that if you do a "read-tree -m <newtree>" followed by a
"checkout-cache -f -a", the checkout-cache only checks out the stuff
that really changed.

This is used to avoid unnecessary false hits when show-diff is
run after read-tree.

3-Way Merge
Each "index" entry has two bits worth of "stage" state. stage 0 is the
normal one, and is the only one you'd see in any kind of normal use.

However, when you do "read-tree" with multiple trees, the "stage"
starts out at 0, but increments for each tree you read. And in
particular, the "-m" flag means "start at stage 1" instead.

This means that you can do

	read-tree -m <tree1> <tree2> <tree3>

and you will end up with an index with all of the <tree1> entries in
"stage1", all of the <tree2> entries in "stage2" and all of the
<tree3> entries in "stage3".

Furthermore, "read-tree" has special-case logic that says: if you see
a file that matches in all respects in the following states, it
"collapses" back to "stage0":

   - stage 2 and 3 are the same; take one or the other (it makes no
     difference - the same work has been done on stage 2 and 3)

   - stage 1 and stage 2 are the same and stage 3 is different; take
     stage 3 (some work has been done on stage 3)

   - stage 1 and stage 3 are the same and stage 2 is different take
     stage 2 (some work has been done on stage 2)

Write-tree refuses to write a nonsensical tree, so write-tree will
complain about unmerged entries if it sees a single entry that is not
stage 0".

Ok, this all sounds like a collection of totally nonsensical rules,
but it's actually exactly what you want in order to do a fast
merge. The different stages represent the "result tree" (stage 0, aka
"merged"), the original tree (stage 1, aka "orig"), and the two trees
you are trying to merge (stage 2 and 3 respectively).

In fact, the way "read-tree" works, it's entirely agnostic about how
you assign the stages, and you could really assign them any which way,
and the above is just a suggested way to do it (except since
"write-tree" refuses to write anything but stage0 entries, it makes
sense to always consider stage 0 to be the "full merge" state).

So what happens? Try it out. Select the original tree, and two trees
to merge, and look how it works:

 - if a file exists in identical format in all three trees, it will 
   automatically collapse to "merged" state by the new read-tree.

 - a file that has _any_ difference what-so-ever in the three trees
   will stay as separate entries in the index. It's up to "script
   policy" to determine how to remove the non-0 stages, and insert a
   merged version.  But since the index is always sorted, they're easy
   to find: they'll be clustered together.

 - the index file saves and restores with all this information, so you
   can merge things incrementally, but as long as it has entries in
   stages 1/2/3 (ie "unmerged entries") you can't write the result.

So now the merge algorithm ends up being really simple:

 - you walk the index in order, and ignore all entries of stage 0,
   since they've already been done.

 - if you find a "stage1", but no matching "stage2" or "stage3", you
   know it's been removed from both trees (it only existed in the
   original tree), and you remove that entry.  - if you find a
   matching "stage2" and "stage3" tree, you remove one of them, and
   turn the other into a "stage0" entry. Remove any matching "stage1"
   entry if it exists too.  .. all the normal trivial rules ..

Incidentally - it also means that you don't even have to have a separate 
subdirectory for this. All the information literally is in the index file, 
which is a temporary thing anyway. There is no need to worry about what is in 
the working directory, since it is never shown and never used.

see also:
write-tree
show-files


################################################################
rev-list <commit>

Lists commit objects in reverse chronological order starting at the
given commit, taking ancestry relationship into account.  This is
useful to produce human-readable log output.


################################################################
rev-tree
	rev-tree [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]

Provides the revision tree for one or more commits.

--edges
	Show edges (ie places where the marking changes between parent
	and child)

--cache <cache-file>
	Use the specified file as a cache. [Not implemented yet]

[^]<commit>
	The commit id to trace (a leading caret means to ignore this
	commit-id and below)

Output:
<date> <commit>:<flags> [<parent-commit>:<flags> ]*

<date>
	Date in 'seconds since epoch'

<commit>
	id of commit object

<parent-commit>
	id of each parent commit object (>1 indicates a merge)

<flags>

	The flags are read as a bitmask representing each commit
	provided on the commandline. eg: given the command:

		 $ rev-tree <com1> <com2> <com3>

	The output:

	    <date> <commit>:5

	 means that <commit> is reachable from <com1>(1) and <com3>(4)
	
A revtree can get quite large. rev-tree will eventually allow you to
cache previous state so that you don't have to follow the whole thing
down.

So the change difference between two commits is literally

	rev-tree [commit-id1]  > commit1-revtree
	rev-tree [commit-id2]  > commit2-revtree
	join -t : commit1-revtree commit2-revtree > common-revisions

(this is also how to find the most common parent - you'd look at just
the head revisions - the ones that aren't referred to by other
revisions - in "common-revision", and figure out the best one. I
think.)


################################################################
show-diff
	show-diff [-R] [-q] [-s] [-z] [paths...]

Shows the difference between the version of the specified file on disk
and the file in the cache.

-R
	Reverse the diff

-q
	Remain silent even on nonexisting files

-s
	Do not show the diff text.  Just output SHA1 and name for
	changed paths (forces -q)

-z
	Machine readable output: 
        . Each output record has the path name at the end of the
          record, instead of the front.
        . Each record is terminated with a NUL '\0' character.
        . For unchanged files, nothing is output.
        . For an unmerged file, the following is output:
            U name
        . For a deleted file, the following is output:
            X name
        . For a modified file, the following is output:
            SHA1 name
          where SHA1 is from the dircache entry.

Environment variables
GIT_DIFF_CMD	Default="diff -L 'a/%s' -L 'b/%s'"
		Command used to generate diff

GIT_DIFF_OPTS	Default="-p -u"
		Options passed to diff command

Although in Linus' distribution, show-diff is not part of 'core' git.

################################################################
show-files
	show-files [-z] [-t] (--[cached|deleted|others|ignored|stage|unmerged])*

This merges the file listing in the directory cache index with the
actual working directory list, and shows different combinations of the
two.

One or more of the options below may be used to determine the files
shown:

--cached
	Show cached files in the output (default)

--deleted
	Show deleted files in the output

--others
	Show other files in the output

--ignored
	Show ignored files in the output

--stage
	Show stage files in the output

--unmerged
	Show unmerged files in the output (forces --stage)

-t
	Show the following tags (followed by a space) at the start of
	each line:
	H	cached
	M	unmerged
	R	removed/deleted
	?	other

-z
	\0 line termination on output

Output
show files just outputs the filename unless --stage is specified in
which case it outputs:

[<tag> ]<mode> <object> <stage> <file>

show-files --unmerged" and "show-files --stage " can be used to examine
detailed information on unmerged paths.

For an unmerged path, instead of recording a single mode/SHA1 pair,
the dircache records up to three such pairs; one from tree O in stage
1, A in stage 2, and B in stage 3.  This information can be used by
the user (or Cogito) to see what should eventually be recorded at the
path. (see read-cache for more information on state)

see also:
read-cache


################################################################
unpack-file
	unpack-file <blob>

Creates a file holding the contents of the blob specified by sha1. It
returns the name of the temporary file in the following format:
	.merge_file_XXXXX

<blob>
	Must be a blob id

################################################################
update-cache
	update-cache [--add] [--remove] [--refresh [--ignore-missing]]
		     [--cacheinfo <mode> <object> <path>]*
		     [--] [<file>]*

Modifies the index or directory cache. Each file mentioned is updated
into the cache and any 'unmerged' or 'needs updating' state is
cleared.

The way update-cache handles files it is told about can be modified
using the various options:

--add
	If a specified file isn't in the cache already then it's
	added.
	Default behaviour is to ignore new files.

--remove
	If a specified file is in the cache but is missing then it's
	removed.
	Default behaviour is to ignore removed file.

--refresh
	Looks at the current cache and checks to see if merges or
	updates are needed by checking stat() information.

--ignore-missing
	Ignores missing files during a --refresh

--cacheinfo <mode> <object> <path>
	Directly insert the specified info into the cache.
	
--
	Do not interpret any more arguments as options.

<file>
	Files to act on.
	Note that files begining with '.' are discarded. This includes
	"./file" and "dir/./file". If you don't want this, then use	
	cleaner names.
	The same applies to directories ending '/' and paths with '//'


Using --refresh

--refresh does not calculate a new sha1 file or bring the cache
up-to-date for mode/content changes. But what it _does_ do is to
"re-match" the stat information of a file with the cache, so that you
can refresh the cache for a file that hasn't been changed but where
the stat entry is out of date.

For example, you'd want to do this after doing a "read-tree", to link
up the stat cache details with the proper files.

Using --cacheinfo
--cacheinfo is used to register a file that is not in the current
working directory.  This is useful for minimum-checkout merging.

To pretend you have a file with mode and sha1 at path, say:

 $ update-cache --cacheinfo mode sha1 path

To update and refresh only the files already checked out:

   checkout-cache -n -f -a && update-cache --ignore-missing --refresh


################################################################
write-tree
	write-tree

Creates a tree object using the current cache.

The cache must be merged.

Conceptually, write-tree sync()s the current directory cache contents
into a set of tree files.
In order to have that match what is actually in your directory right
now, you need to have done a "update-cache" phase before you did the
"write-tree".


################################################################


Terminology: - see README for description
Each line contains terms used interchangeably

object database, .git directory
directory cache, index
id, sha1, sha1-id, sha1 hash
type, tag
blob, blob object
tree, tree object
commit, commit object
parent
root object
changeset


git Environment Variables
AUTHOR_NAME
AUTHOR_EMAIL
AUTHOR_DATE
COMMIT_AUTHOR_NAME
COMMIT_AUTHOR_EMAIL
GIT_DIFF_CMD
GIT_DIFF_OPTS
GIT_INDEX_FILE
SHA1_FILE_DIRECTORY


--------------000804060701040107020103--
