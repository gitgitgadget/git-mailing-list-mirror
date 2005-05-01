From: "Brian O'Mahoney" <omb@khandalf.com>
Subject: Re: Quick command reference
Date: Sun, 01 May 2005 17:19:15 +0200
Message-ID: <4274F373.6030001@khandalf.com>
References: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>
    <4274EB3D.2060602@dgreaves.com>
Reply-To: omb@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 17:15:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSGAQ-0001G9-Q0
	for gcvg-git@gmane.org; Sun, 01 May 2005 17:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVEAPVZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 1 May 2005 11:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVEAPVZ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 11:21:25 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:49863 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261653AbVEAPTV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 11:19:21 -0400
Received: from khandalf.com (80-218-57-125.dclient.hispeed.ch [80.218.57.125])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id j41FJIYJ003892
	for <git@vger.kernel.org.>; Sun, 1 May 2005 17:19:18 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
    teraflex.teraflex-research.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
    id j41FJHqj008511; Sun, 1 May 2005 17:19:20 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: David Greaves <david@dgreaves.com>
In-Reply-To: <4274EB3D.2060602@dgreaves.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Md5-Body: 345eed222a49331c0841b5d7bac88886
X-Transmit-Date: Sunday, 1 May 2005 17:19:56 +0200
X-Message-Uid: 0000b49cec9d2a0700000002000000004274f39c0003173a000000010008d8f7
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on smtp-04.tornado.cablecom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thank you both for taking the time and trouble to do this, particularly
with the name changes and new options; why don't you merge your efforts
and produce a GIT-Mini-HOWTO BTW send it off as a patch again!

regards, Brian

David Greaves wrote:
> Paul Mackerras wrote:
>=20
>=20
>>As an aid to my understanding of the core git commands, I created thi=
s
>>summary of the commands and their options and parameters.  I hope it
>>will be useful to others.  Corrections welcome of course.
>>
>>Paul.
>>=20
>>
>=20
>=20
> Thanks Paul
>=20
> Shame to see duplicated effort...
>=20
> I've submitted this document to Linus and the list a few times and
> included all the feedback but for some reason it's not gone into any =
of
> the trees which means that people like you have to redo it from scrat=
ch...
>=20
> Getting frustrated now...
>=20
> David
>=20
>=20
>=20
> ---------------------------------------------------------------------=
---
>=20
> This file contains reference information for the core git commands.
> It is actually based on the source from Petr Baudis' tree and may
> therefore contain a few 'extras' that may or may not make it upstream=
=2E
>=20
> The README contains much useful definition and clarification info -
> read that first.  And of the commands, I suggest reading
> 'update-cache' and 'read-tree' first - I wish I had!
>=20
> Thanks to original email authors and proof readers esp Junio C Hamano
> <junkio@cox.net>
>=20
> David Greaves <david@dgreaves.com>
> 24/4/05
>=20
> Identifier terminology used:
>=20
> <object>
> 	Indicates any object sha1 identifier
>=20
> <blob>
> 	Indicates a blob object sha1 identifier
>=20
> <tree>
> 	Indicates a tree object sha1 identifier
>=20
> <commit>
> 	Indicates a commit object sha1 identifier
>=20
> <tree/commit>
> 	Indicates a tree or commit object sha1 identifier (usually
> 	because the command can read the <tree> a <commit> contains).
> 	[Eventually may be replaced with <tree> if <tree> means
> 	<tree/commit> in all commands]
>=20
> <type>
> 	Indicates that an object type is required.
> 	Currently one of: blob/tree/commit
>=20
> <file>
> 	Indicates a filename - often includes leading path
>=20
> <path>
> 	Indicates the path of a file (is this ever useful?)
>=20
>=20
>=20
> ################################################################
> cat-file
> 	cat-file (-t | <type>) <object>
>=20
> Provide contents or type of objects in the repository. The type is
> required if -t is not being used to find the object type.
>=20
> <object>
> 	The sha1 identifier of the object.
>=20
> -t
> 	show the object type identified by <object>
>=20
> <type>
> 	One of: blob/tree/commit
>=20
> Output
>=20
> If -t is specified, one of:
>         blob/tree/commit
>=20
> Otherwise the raw (though uncompressed) contents of the <object> will
> be returned.
>=20
>=20
> ################################################################
> check-files
> 	check-files <file>...
>=20
> Check that a list of files are up-to-date between the filesystem and
> the cache. Used to verify a patch target before doing a patch.
>=20
> Files that do not exist on the filesystem are considered up-to-date
> (whether or not they are in the cache).
>=20
> Emits an error message on failure.
> preparing to update existing file <file> not in cache
> 	  <file> exists but is not in the cache
>=20
> preparing to update file <file> not uptodate in cache
> 	  <file> on disk is not up-to-date with the cache
>=20
> exits with a status code indicating success if all files are
> up-to-date.
>=20
> see also: update-cache
>=20
>=20
> ################################################################
> checkout-cache
> 	checkout-cache [-q] [-a] [-f] [-n] [--prefix=3D<string>]
> 		       [--] <file>...
>=20
> Will copy all files listed from the cache to the working directory
> (not overwriting existing files). Note that the file contents are
> restored - NOT the file permissions.
> ??? l 58 checkout-cache.c says restore executable bit.
>=20
> -q
> 	be quiet if files exist or are not in the cache
>=20
> -f
> 	forces overwrite of existing files
>=20
> -a
> 	checks out all files in the cache (will then continue to
> 	process listed files).
> -n
> 	Don't checkout new files, only refresh files already checked
> 	out.
>=20
> --prefix=3D<string>
> 	When creating files, prepend <string> (usually a directory
> 	including a trailing /)
>=20
> --
> 	Do not interpret any more arguments as options.
>=20
> Note that the order of the flags matters:
>=20
> 	checkout-cache -a -f file.c
>=20
> will first check out all files listed in the cache (but not overwrite
> any old ones), and then force-checkout file.c a second time (ie that
> one _will_ overwrite any old contents with the same filename).
>=20
> Also, just doing "checkout-cache" does nothing. You probably meant
> "checkout-cache -a". And if you want to force it, you want
> "checkout-cache -f -a".
>=20
> Intuitiveness is not the goal here. Repeatability is. The reason for
> the "no arguments means no work" thing is that from scripts you are
> supposed to be able to do things like
>=20
> 	find . -name '*.h' -print0 | xargs -0 checkout-cache -f --
>=20
> which will force all existing *.h files to be replaced with their
> cached copies. If an empty command line implied "all", then this woul=
d
> force-refresh everything in the cache, which was not the point.
>=20
> To update and refresh only the files already checked out:
>=20
>    checkout-cache -n -f -a && update-cache --ignore-missing --refresh
>=20
> Oh, and the "--" is just a good idea when you know the rest will be
> filenames. Just so that you wouldn't have a filename of "-a" causing
> problems (not possible in the above example, but get used to it in
> scripting!).
>=20
> The prefix ability basically makes it trivial to use checkout-cache a=
s
> a "export as tree" function. Just read the desired tree into the
> index, and do a
>  =20
>         checkout-cache --prefix=3Dexport-dir/ -a
>  =20
> and checkout-cache will "export" the cache into the specified
> directory.
>  =20
> NOTE! The final "/" is important. The exported name is literally just
> prefixed with the specified string, so you can also do something like
>  =20
>         checkout-cache --prefix=3D.merged- Makefile
>  =20
> to check out the currently cached copy of "Makefile" into the file
> ".merged-Makefile".
>=20
>=20
> ################################################################
> commit-tree
> 	commit-tree <tree> [-p <parent commit>]*   < changelog
>=20
> Creates a new commit object based on the provided tree object and
> emits the new commit object id on stdout. If no parent is given then
> it is considered to be an initial tree.
>=20
> A commit object usually has 1 parent (a commit after a change) or up
> to 16 parents.  More than one parent represents a merge of branches
> that led to them.
>=20
> While a tree represents a particular directory state of a working
> directory, a commit represents that state in "time", and explains how
> to get there.
>=20
> Normally a commit would identify a new "HEAD" state, and while git
> doesn't care where you save the note about that state, in practice we
> tend to just write the result to the file ".git/HEAD", so that we can
> always see what the last committed state was.
>=20
> Options
>=20
> <tree>
> 	An existing tree object
>=20
> -p <parent commit>
> 	Each -p indicates a the id of a parent commit object.
> =09
>=20
> Commit Information
>=20
> A commit encapsulates:
> 	all parent object ids
> 	author name, email and date
> 	committer name and email and the commit time.
>=20
> If not provided, commit-tree uses your name, hostname and domain to
> provide author and committer info. This can be overridden using the
> following environment variables.
> 	AUTHOR_NAME
> 	AUTHOR_EMAIL
> 	AUTHOR_DATE
> 	COMMIT_AUTHOR_NAME
> 	COMMIT_AUTHOR_EMAIL
> (nb <,> and '\n's are stripped)
>=20
> A commit comment is read from stdin (max 999 chars). If a changelog
> entry is not provided via '<' redirection, commit-tree will just wait
> for one to be entered and terminated with ^D
>=20
> see also: write-tree
>=20
>=20
> ################################################################
> diff-cache
> 	diff-cache [-p] [-r] [-z] [--cached] <tree/commit>
>=20
> Compares the content and mode of the blobs found via a tree object
> with the content of the current cache and, optionally ignoring the
> stat state of the file on disk.
>=20
> <tree/commit>
> 	The id of a tree or commit object to diff against.
>=20
> -p
> 	generate patch (see section on generating patches)
>=20
> -r
> 	recurse
>=20
> -z
> 	\0 line termination on output
>=20
> --cached
> 	do not consider the on-disk file at all
>=20
> Output format:
>=20
> See "Output format from diff-cache, diff-tree and show-diff" section.
>=20
> Operating Modes
>=20
> You can choose whether you want to trust the index file entirely
> (using the "--cached" flag) or ask the diff logic to show any files
> that don't match the stat state as being "tentatively changed".  Both
> of these operations are very useful indeed.
>=20
> Cached Mode
>=20
> If --cached is specified, it allows you to ask:
> 	show me the differences between HEAD and the current index
> 	contents (the ones I'd write with a "write-tree")
>=20
> For example, let's say that you have worked on your index file, and a=
re
> ready to commit. You want to see eactly _what_ you are going to commi=
t is
> without having to write a new tree object and compare it that way, an=
d to
> do that, you just do
>=20
> 	diff-cache --cached $(cat .git/HEAD)
>=20
> Example: let's say I had renamed "commit.c" to "git-commit.c", and I =
had=20
> done an "upate-cache" to make that effective in the index file.=20
> "show-diff" wouldn't show anything at all, since the index file match=
es=20
> my working directory. But doing a diff-cache does:
> 	torvalds@ppc970:~/git> diff-cache --cached $(cat .git/HEAD)
> 	-100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        comm=
it.c
> 	+100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        git-=
commit.c
>=20
> And as you can see, the output matches "diff-tree -r" output (we
> always do equivalent of "-r", since the index is flat).
> You can trivially see that the above is a rename.
>=20
> In fact, "diff-cache --cached" _should_ always be entirely equivalent=
 to
> actually doing a "write-tree" and comparing that. Except this one is =
much
> nicer for the case where you just want to check where you are.
>=20
> So doing a "diff-cache --cached" is basically very useful when you ar=
e=20
> asking yourself "what have I already marked for being committed, and=20
> what's the difference to a previous tree".
>=20
> Non-cached Mode
>=20
> The "non-cached" mode takes a different approach, and is potentially
> the even more useful of the two in that what it does can't be emulate=
d
> with a "write-tree + diff-tree". Thus that's the default mode.  The
> non-cached version asks the question
>=20
>    "show me the differences between HEAD and the currently checked ou=
t=20
>     tree - index contents _and_ files that aren't up-to-date"
>=20
> which is obviously a very useful question too, since that tells you w=
hat
> you _could_ commit. Again, the output matches the "diff-tree -r" outp=
ut to
> a tee, but with a twist.
>=20
> The twist is that if some file doesn't match the cache, we don't have=
 a
> backing store thing for it, and we use the magic "all-zero" sha1 to s=
how
> that. So let's say that you have edited "kernel/sched.c", but have no=
t
> actually done an update-cache on it yet - there is no "object" associ=
ated
> with the new state, and you get:
>=20
> 	torvalds@ppc970:~/v2.6/linux> diff-cache $(cat .git/HEAD )
> 	*100644->100664 blob    7476bbcfe5ef5a1dd87d745f298b831143e4d77e->00=
00000000000000000000000000000000000000      kernel/sched.c
>=20
> ie it shows that the tree has changed, and that "kernel/sched.c" has =
is
> not up-to-date and may contain new stuff. The all-zero sha1 means tha=
t to
> get the real diff, you need to look at the object in the working dire=
ctory
> directly rather than do an object-to-object diff.
>=20
> NOTE! As with other commands of this type, "diff-cache" does not actu=
ally=20
> look at the contents of the file at all. So maybe "kernel/sched.c" ha=
sn't=20
> actually changed, and it's just that you touched it. In either case, =
it's=20
> a note that you need to upate-cache it to make the cache be in sync.
>=20
> NOTE 2! You can have a mixture of files show up as "has been updated"=
 and
> "is still dirty in the working directory" together. You can always te=
ll
> which file is in which state, since the "has been updated" ones show =
a
> valid sha1, and the "not in sync with the index" ones will always hav=
e the
> special all-zero sha1.
>=20
> ################################################################
> diff-tree
> 	diff-tree [-p] [-r] [-z] <tree/commit> <tree/commit> [<pattern>]*
>=20
> Compares the content and mode of the blobs found via two tree objects=
=2E
>=20
> Note that diff-tree can use the tree encapsulated in a commit object.
>=20
> <tree sha1>
> 	The id of a tree or commit object.
>=20
> <pattern>
>=20
> 	If provided, the results are limited to a subset of files
> 	matching one of these prefix strings.
> 	ie file matches /^<pattern1>|<pattern2>|.../
> 	Note that pattern does not provide any wildcard or regexp features.
>=20
> -p
> 	generate patch (see section on generating patches)
>=20
> -r
> 	recurse
>=20
> -z
> 	\0 line termination on output
>=20
> Limiting Output
>=20
> If you're only interested in differences in a subset of files, for
> example some architecture-specific files, you might do:
>=20
> 	diff-tree -r <tree/commit> <tree/commit> arch/ia64 include/asm-ia64
>=20
> and it will only show you what changed in those two directories.
>=20
> Or if you are searching for what changed in just kernel/sched.c, just=
 do
>=20
> 	diff-tree -r <tree/commit> <tree/commit> kernel/sched.c
>=20
> and it will ignore all differences to other files.
>=20
> The pattern is always the prefix, and is matched exactly (ie there ar=
e no
> wildcards - although matching a directory, which it does support, can
> obviously be seen as a "wildcard" for all the files under that direct=
ory).
>=20
> Output format:
>=20
> See "Output format from diff-cache, diff-tree and show-diff" section.
>=20
> An example of normal usage is:
>=20
> 	torvalds@ppc970:~/git> diff-tree 5319e4d609cdd282069cc4dce33c1db5595=
39b03 b4e628ea30d5ab3606119d2ea5caeab141d38df7
> 	*100664->100664 blob    ac348b7d5278e9d04e3a1cd417389379c32b014f->a0=
1513ed4d4d565911a60981bfb4173311ba3688      fsck-cache.c
>=20
> which tells you that the last commit changed just one file (it's from
> this one:
>=20
> 	commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
> 	tree 5319e4d609cdd282069cc4dce33c1db559539b03
> 	parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
> 	author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 =
2005
> 	committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:=
30 2005
>=20
> 	Make "fsck-cache" print out all the root commits it finds.
>=20
> 	Once I do the reference tracking, I'll also make it print out all th=
e
> 	HEAD commits it finds, which is even more interesting.
>=20
> in case you care).
>=20
> ################################################################
> diff-tree-helper
> 	diff-tree-helper [-z]
>=20
> Reads output from diff-cache, diff-tree and show-diff and
> generates patch format output.
>=20
> -z
> 	\0 line termination on input
>=20
> See also the section on generating patches.
>=20
> ################################################################
> fsck-cache
> 	fsck-cache [[--unreachable] <commit>*]
>=20
> Verifies the connectivity and validity of the objects in the database=
=2E
>=20
> <commit>
> 	A commit object to treat as the head of an unreachability
> 	trace
>=20
> --unreachable
> 	print out objects that exist but that aren't readable from any
> 	of the specified root nodes
>=20
> It tests SHA1 and general object sanity, but it does full tracking of
> the resulting reachability and everything else. It prints out any
> corruption it finds (missing or bad objects), and if you use the
> "--unreachable" flag it will also print out objects that exist but
> that aren't readable from any of the specified root nodes.
>=20
> So for example
>=20
> 	fsck-cache --unreachable $(cat .git/HEAD)
>=20
> or, for Cogito users:
>=20
> 	fsck-cache --unreachable $(cat .git/heads/*)
>=20
> will do quite a _lot_ of verification on the tree. There are a few
> extra validity tests to be added (make sure that tree objects are
> sorted properly etc), but on the whole if "fsck-cache" is happy, you
> do have a valid tree.
>=20
> Any corrupt objects you will have to find in backups or other archive=
s
> (ie you can just remove them and do an "rsync" with some other site i=
n
> the hopes that somebody else has the object you have corrupted).
>=20
> Of course, "valid tree" doesn't mean that it wasn't generated by some
> evil person, and the end result might be crap. Git is a revision
> tracking system, not a quality assurance system ;)
>=20
> Extracted Diagnostics
>=20
> expect dangling commits - potential heads - due to lack of head infor=
mation
> 	You haven't specified any nodes as heads so it won't be
> 	possible to differentiate between un-parented commits and
> 	root nodes.
>=20
> missing sha1 directory '<dir>'
> 	The directory holding the sha1 objects is missing.
>=20
> unreachable <type> <object>
> 	The <type> object <object>, isn't actually referred to directly
> 	or indirectly in any of the trees or commits seen. This can
> 	mean that there's another root na SHA1_ode that you're not specifyin=
g
> 	or that the tree is corrupt. If you haven't missed a root node
> 	then you might as well delete unreachable nodes since they
> 	can't be used.
>=20
> missing <type> <object>
> 	The <type> object <object>, is referred to but isn't present in
> 	the database.
>=20
> dangling <type> <object>
> 	The <type> object <object>, is present in the database but never
> 	_directly_ used. A dangling commit could be a root node.
>=20
> warning: fsck-cache: tree <tree> has full pathnames in it
> 	And it shouldn't...
>=20
> sha1 mismatch <object>
> 	The database has an object who's sha1 doesn't match the
> 	database value.
> 	This indicates a ??serious?? data integrity problem.
> 	(note: this error occured during early git development when
> 	the database format changed.)
>=20
> Environment Variables
>=20
> SHA1_FILE_DIRECTORY
> 	used to specify the object database root (usually .git/objects)
>=20
> ################################################################
> git-export
> 	git-export top [base]
>=20
> probably deprecated:
> On Wed, 20 Apr 2005, Petr Baudis wrote:
>=20
>>>I will probably not buy git-export, though. (That is, it is merged, =
but
>>>I won't make git frontend for it.) My "git export" already does
>>>something different, but more importantly, "git patch" of mine alrea=
dy
>>>does effectively the same thing as you do, just for a single patch; =
so I
>>>will probably just extend it to do it for an (a,b] range of patches.
>=20
>=20
>=20
> That's fine. It was a quick hack, just to show that if somebody wants=
 to,=20
> the data is trivially exportable.
>=20
> 		Linus
>=20
> Although in Linus' distribution, git-export is not part of 'core' git=
=2E
>=20
> ################################################################
> init-db
> 	init-db
>=20
> This simply creates an empty git object database - basically a .git
> directory.
>=20
> If the object storage directory is specified via the
> SHA1_FILE_DIRECTORY environment variable then the sha1 directories ar=
e
> created underneath - otherwise the default .git/objects directory is
> used.
>=20
> init-db won't hurt an existing repository.
>=20
>=20
> ################################################################
> ls-tree
> 	ls-tree [-r] [-z] <tree/commit>
>=20
> convert the tree object to a human readable (and script
> processable) form.
>=20
> <tree/commit>
> 	Id of a tree or commit object.
> -r
> 	recurse into sub-trees
>=20
> -z
> 	\0 line termination on output
>=20
> Output Format
> <mode>\t	<type>\t	<object>\t	<path><file>=09
>=20
>=20
> ################################################################
> merge-base
> 	merge-base <commit> <commit>
>=20
> merge-base finds as good a common ancestor as possible. Given a
> selection of equally good common ancestors it should not be relied on
> to decide in any particular way.
>=20
> The merge-base algorithm is still in flux - use the source...
>=20
>=20
> ################################################################
> merge-cache
> 	merge-cache <merge-program> (-a | -- | <file>*)=20
>=20
> This looks up the <file>(s) in the cache and, if there are any merge
> entries, unpacks all of them (which may be just one file, of course)
> into up to three separate temporary files, and then executes the
> supplied <merge-program> with those three files as arguments 1,2,3
> (empty argument if no file), and <file> as argument 4.
>=20
> --
> 	Interpret all future arguments as filenames
>=20
> -a
> 	Run merge against all files in the cache that need merging.
>=20
> If merge-cache is called with multiple <file>s (or -a) then it
> processes them in turn only stopping if merge returns a non-zero exit
> code.
>=20
> Typically this is run with the a script calling the merge command fro=
m
> the RCS package.
>=20
> A sample script called git-merge-one-file-script is included in the
> ditribution.
>=20
> ALERT ALERT ALERT! The git "merge object order" is different from the
> RCS "merge" program merge object order. In the above ordering, the
> original is first. But the argument order to the 3-way merge program
> "merge" is to have the original in the middle. Don't ask me why.
>=20
> Examples:
>=20
> 	torvalds@ppc970:~/merge-test> merge-cache cat MM
> 	This is MM from the original tree.			# original
> 	This is modified MM in the branch A.			# merge1
> 	This is modified MM in the branch B.			# merge2
> 	This is modified MM in the branch B.			# current contents
>=20
> or=20
>=20
> 	torvalds@ppc970:~/merge-test> merge-cache cat AA MM
> 	cat: : No such file or directory
> 	This is added AA in the branch A.
> 	This is added AA in the branch B.
> 	This is added AA in the branch B.
> 	fatal: merge program failed
>=20
> where the latter example shows how "merge-cache" will stop trying to
> merge once anything has returned an error (ie "cat" returned an error
> for the AA file, because it didn't exist in the original, and thus
> "merge-cache" didn't even try to merge the MM thing).
>=20
>=20
> ################################################################
> read-tree
> 	read-tree (<tree/commit> | -m <tree/commit1> [<tree/commit2> <tree/c=
ommit3>])"
>=20
> Reads the tree information given by <tree> into the directory cache,
> but does not actually _update_ any of the files it "caches". (see:
> checkout-cache)
>=20
> Optionally, it can merge a tree into the cache or perform a 3-way
> merge.
>=20
> Trivial merges are done by read-tree itself.  Only conflicting paths
> will be in unmerged state when read-tree returns.
>=20
> -m
> 	Perform a merge, not just a read
>=20
> <tree#>
> 	The id of the tree object(s) to be read/merged.
>=20
>=20
> Merging
> If -m is specified, read-tree performs 2 kinds of merge, a single tre=
e
> merge if only 1 tree is given or a 3-way merge if 3 trees are
> provided.
>=20
> Single Tree Merge
> If only 1 tree is specified, read-tree operates as if the user did no=
t
> specify "-m", except that if the original cache has an entry for a
> given pathname; and the contents of the path matches with the tree
> being read, the stat info from the cache is used. (In other words, th=
e
> cache's stat()s take precedence over the merged tree's)
>=20
> That means that if you do a "read-tree -m <newtree>" followed by a
> "checkout-cache -f -a", the checkout-cache only checks out the stuff
> that really changed.
>=20
> This is used to avoid unnecessary false hits when show-diff is
> run after read-tree.
>=20
> 3-Way Merge
> Each "index" entry has two bits worth of "stage" state. stage 0 is th=
e
> normal one, and is the only one you'd see in any kind of normal use.
>=20
> However, when you do "read-tree" with multiple trees, the "stage"
> starts out at 0, but increments for each tree you read. And in
> particular, the "-m" flag means "start at stage 1" instead.
>=20
> This means that you can do
>=20
> 	read-tree -m <tree1> <tree2> <tree3>
>=20
> and you will end up with an index with all of the <tree1> entries in
> "stage1", all of the <tree2> entries in "stage2" and all of the
> <tree3> entries in "stage3".
>=20
> Furthermore, "read-tree" has special-case logic that says: if you see
> a file that matches in all respects in the following states, it
> "collapses" back to "stage0":
>=20
>    - stage 2 and 3 are the same; take one or the other (it makes no
>      difference - the same work has been done on stage 2 and 3)
>=20
>    - stage 1 and stage 2 are the same and stage 3 is different; take
>      stage 3 (some work has been done on stage 3)
>=20
>    - stage 1 and stage 3 are the same and stage 2 is different take
>      stage 2 (some work has been done on stage 2)
>=20
> Write-tree refuses to write a nonsensical tree, so write-tree will
> complain about unmerged entries if it sees a single entry that is not
> stage 0".
>=20
> Ok, this all sounds like a collection of totally nonsensical rules,
> but it's actually exactly what you want in order to do a fast
> merge. The different stages represent the "result tree" (stage 0, aka
> "merged"), the original tree (stage 1, aka "orig"), and the two trees
> you are trying to merge (stage 2 and 3 respectively).
>=20
> In fact, the way "read-tree" works, it's entirely agnostic about how
> you assign the stages, and you could really assign them any which way=
,
> and the above is just a suggested way to do it (except since
> "write-tree" refuses to write anything but stage0 entries, it makes
> sense to always consider stage 0 to be the "full merge" state).
>=20
> So what happens? Try it out. Select the original tree, and two trees
> to merge, and look how it works:
>=20
>  - if a file exists in identical format in all three trees, it will=20
>    automatically collapse to "merged" state by the new read-tree.
>=20
>  - a file that has _any_ difference what-so-ever in the three trees
>    will stay as separate entries in the index. It's up to "script
>    policy" to determine how to remove the non-0 stages, and insert a
>    merged version.  But since the index is always sorted, they're eas=
y
>    to find: they'll be clustered together.
>=20
>  - the index file saves and restores with all this information, so yo=
u
>    can merge things incrementally, but as long as it has entries in
>    stages 1/2/3 (ie "unmerged entries") you can't write the result.
>=20
> So now the merge algorithm ends up being really simple:
>=20
>  - you walk the index in order, and ignore all entries of stage 0,
>    since they've already been done.
>=20
>  - if you find a "stage1", but no matching "stage2" or "stage3", you
>    know it's been removed from both trees (it only existed in the
>    original tree), and you remove that entry.  - if you find a
>    matching "stage2" and "stage3" tree, you remove one of them, and
>    turn the other into a "stage0" entry. Remove any matching "stage1"
>    entry if it exists too.  .. all the normal trivial rules ..
>=20
> Incidentally - it also means that you don't even have to have a separ=
ate=20
> subdirectory for this. All the information literally is in the index =
file,=20
> which is a temporary thing anyway. There is no need to worry about wh=
at is in=20
> the working directory, since it is never shown and never used.
>=20
> see also:
> write-tree
> show-files
>=20
>=20
> ################################################################
> rev-list <commit>
>=20
> Lists commit objects in reverse chronological order starting at the
> given commit, taking ancestry relationship into account.  This is
> useful to produce human-readable log output.
>=20
>=20
> ################################################################
> rev-tree
> 	rev-tree [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]
>=20
> Provides the revision tree for one or more commits.
>=20
> --edges
> 	Show edges (ie places where the marking changes between parent
> 	and child)
>=20
> --cache <cache-file>
> 	Use the specified file as a cache. [Not implemented yet]
>=20
> [^]<commit>
> 	The commit id to trace (a leading caret means to ignore this
> 	commit-id and below)
>=20
> Output:
> <date> <commit>:<flags> [<parent-commit>:<flags> ]*
>=20
> <date>
> 	Date in 'seconds since epoch'
>=20
> <commit>
> 	id of commit object
>=20
> <parent-commit>
> 	id of each parent commit object (>1 indicates a merge)
>=20
> <flags>
>=20
> 	The flags are read as a bitmask representing each commit
> 	provided on the commandline. eg: given the command:
>=20
> 		 $ rev-tree <com1> <com2> <com3>
>=20
> 	The output:
>=20
> 	    <date> <commit>:5
>=20
> 	 means that <commit> is reachable from <com1>(1) and <com3>(4)
> =09
> A revtree can get quite large. rev-tree will eventually allow you to
> cache previous state so that you don't have to follow the whole thing
> down.
>=20
> So the change difference between two commits is literally
>=20
> 	rev-tree [commit-id1]  > commit1-revtree
> 	rev-tree [commit-id2]  > commit2-revtree
> 	join -t : commit1-revtree commit2-revtree > common-revisions
>=20
> (this is also how to find the most common parent - you'd look at just
> the head revisions - the ones that aren't referred to by other
> revisions - in "common-revision", and figure out the best one. I
> think.)
>=20
>=20
> ################################################################
> show-diff
> 	show-diff [-p] [-q] [-s] [-z] [paths...]
>=20
> Compares the files in the working tree and the cache.  When paths
> are specified, compares only those named paths.  Otherwise all
> entries in the cache are compared.  The output format is the
> same as diff-cache and diff-tree.
>=20
> -p
> 	generate patch (see section on generating patches)
>=20
> -q
> 	Remain silent even on nonexisting files
>=20
> -s
> 	Does not do anything other than what -q does.
>=20
> Output format:
>=20
> See "Output format from diff-cache, diff-tree and show-diff" section.
>=20
> ################################################################
> show-files
> 	show-files [-z] [-t]
> 		(--[cached|deleted|others|ignored|stage|unmerged])*
> 		(-[c|d|o|i|s|u])*
> 		[-x <pattern>|--exclude=3D<pattern>]
> 		[-X <file>|--exclude-from=3D<file>]
>=20
> This merges the file listing in the directory cache index with the
> actual working directory list, and shows different combinations of th=
e
> two.
>=20
> One or more of the options below may be used to determine the files
> shown:
>=20
> -c|--cached
> 	Show cached files in the output (default)
>=20
> -d|--deleted
> 	Show deleted files in the output
>=20
> -o|--others
> 	Show other files in the output
>=20
> -i|--ignored
> 	Show ignored files in the output
> 	Note the this also reverses any exclude list present.
>=20
> -s|--stage
> 	Show stage files in the output
>=20
> -u|--unmerged
> 	Show unmerged files in the output (forces --stage)
>=20
> #-t [not in Linus' tree (yet?)]
> #	Identify the file status with the following tags (followed by
> #	a space) at the start of each line:
> #	H	cached
> #	M	unmerged
> #	R	removed/deleted
> #	?	other
>=20
> -z
> 	\0 line termination on output
>=20
> -x|--exclude=3D<pattern>
> 	Skips files matching pattern.
> 	Note that pattern is a shell wildcard pattern.
>=20
> -X|--exclude-from=3D<file>
> 	exclude patterns are read from <file>; 1 per line.
> 	Allows the use of the famous dontdiff file as follows to find
> 	out about uncommitted files just as dontdiff is used with
> 	the diff command:
> 	     show-files --others --exclude-from=3Ddontdiff
>=20
> Output
> show files just outputs the filename unless --stage is specified in
> which case it outputs:
>=20
> [<tag> ]<mode> <object> <stage> <file>
>=20
> show-files --unmerged" and "show-files --stage " can be used to exami=
ne
> detailed information on unmerged paths.
>=20
> For an unmerged path, instead of recording a single mode/SHA1 pair,
> the dircache records up to three such pairs; one from tree O in stage
> 1, A in stage 2, and B in stage 3.  This information can be used by
> the user (or Cogito) to see what should eventually be recorded at the
> path. (see read-cache for more information on state)
>=20
> see also:
> read-cache
>=20
>=20
> ################################################################
> unpack-file
> 	unpack-file <blob>
>=20
> Creates a file holding the contents of the blob specified by sha1. It
> returns the name of the temporary file in the following format:
> 	.merge_file_XXXXX
>=20
> <blob>
> 	Must be a blob id
>=20
> ################################################################
> update-cache
> 	update-cache [--add] [--remove] [--refresh [--ignore-missing]]
> 		     [--cacheinfo <mode> <object> <path>]*
> 		     [--] [<file>]*
>=20
> Modifies the index or directory cache. Each file mentioned is updated
> into the cache and any 'unmerged' or 'needs updating' state is
> cleared.
>=20
> The way update-cache handles files it is told about can be modified
> using the various options:
>=20
> --add
> 	If a specified file isn't in the cache already then it's
> 	added.
> 	Default behaviour is to ignore new files.
>=20
> --remove
> 	If a specified file is in the cache but is missing then it's
> 	removed.
> 	Default behaviour is to ignore removed file.
>=20
> --refresh
> 	Looks at the current cache and checks to see if merges or
> 	updates are needed by checking stat() information.
>=20
> --ignore-missing
> 	Ignores missing files during a --refresh
>=20
> --cacheinfo <mode> <object> <path>
> 	Directly insert the specified info into the cache.
> =09
> --
> 	Do not interpret any more arguments as options.
>=20
> <file>
> 	Files to act on.
> 	Note that files begining with '.' are discarded. This includes
> 	"./file" and "dir/./file". If you don't want this, then use=09
> 	cleaner names.
> 	The same applies to directories ending '/' and paths with '//'
>=20
>=20
> Using --refresh
>=20
> --refresh does not calculate a new sha1 file or bring the cache
> up-to-date for mode/content changes. But what it _does_ do is to
> "re-match" the stat information of a file with the cache, so that you
> can refresh the cache for a file that hasn't been changed but where
> the stat entry is out of date.
>=20
> For example, you'd want to do this after doing a "read-tree", to link
> up the stat cache details with the proper files.
>=20
> Using --cacheinfo
> --cacheinfo is used to register a file that is not in the current
> working directory.  This is useful for minimum-checkout merging.
>=20
> To pretend you have a file with mode and sha1 at path, say:
>=20
>  $ update-cache --cacheinfo mode sha1 path
>=20
> To update and refresh only the files already checked out:
>=20
>    checkout-cache -n -f -a && update-cache --ignore-missing --refresh
>=20
>=20
> ################################################################
> write-tree
> 	write-tree
>=20
> Creates a tree object using the current cache.
>=20
> The cache must be merged.
>=20
> Conceptually, write-tree sync()s the current directory cache contents
> into a set of tree files.
> In order to have that match what is actually in your directory right
> now, you need to have done a "update-cache" phase before you did the
> "write-tree".
>=20
>=20
> ################################################################
>=20
> Output format from diff-cache, diff-tree and show-diff.
>=20
> These commands all compare two sets of things; what are
> compared are different:
>=20
>     diff-cache <tree/commit>
>=20
>         compares the <tree/commit> and the files on the filesystem.
>=20
>     diff-cache --cached <tree/commit>
>=20
>         compares the <tree/commit> and the cache.
>=20
>     diff-tree [-r] <tree/commit-1> <tree/commit-2> [paths...]
>=20
>         compares the trees named by the two arguments.
>=20
>     show-diff [paths...]
>=20
>         compares the cache and the files on the filesystem.
>=20
> The following desription uses "old" and "new" to mean those
> compared entities.
>=20
> For files in old but not in new (i.e. removed):
> -<mode> \t <type> \t <object> \t <path>
>=20
> For files not in old but in new (i.e. added):
> +<mode> \t <type> \t <object> \t <path>
>=20
> For files that differ:
> *<old-mode>-><new-mode> \t <type> \t <old-sha1>-><new-sha1> \t <path>
>=20
> <new-sha1> is shown as all 0's if new is a file on the
> filesystem and it is out of sync with the cache.  Example:
>=20
>     *100644->100660 blob    5be4a414b32cf4204f889469942986d3d783da84-=
>0000000000000000000000000000000000000000      file.c
>=20
> ################################################################
>=20
> Generating patches
>=20
> When diff-cache, diff-tree, or show-diff are run with a -p
> option, they do not produce the output described in "Output
> format from diff-cache, diff-tree and show-diff" section.  It
> instead produces a patch file.
>=20
> The patch generation can be customized at two levels.  This
> customization also applies to diff-tree-helper.
>=20
> 1. When the environment variable GIT_EXTERNAL_DIFF is not set,
>    these commands internally invoke diff like this:
>=20
>    diff -L k/<path> -L l/<path> -pu <old> <new>
>=20
>    For added files, /dev/null is used for <old>.  For removed
>    files, /dev/null is used for <new>
>=20
>    The first part of the above command-line can be customized via
>    the environment variable GIT_DIFF_CMD.  For example, if you
>    do not want to show the extra level of leading path, you can
>    say this:
>=20
>    GIT_DIFF_CMD=3D"diff -L'%s' -L'%s'" show-diff -p
>=20
>    Caution:  Do not use more than two '%s' in GIT_DIFF_CMD.
>=20
>    The diff formatting options can be customized via the
>    environment variable GIT_DIFF_OPTS.  For example, if you
>    prefer context diff:
>=20
>    GIT_DIFF_OPTS=3D-c diff-cache -p $(cat .git/HEAD)
>=20
>=20
> 2. When the environment variable GIT_EXTERNAL_DIFF is set, the
>    program named by it is called, instead of the diff invocation
>    described above.
>=20
>    For a path that is added, removed, or modified,
>    GIT_EXTERNAL_DIFF is called with 7 parameters:
>=20
>      path old-file old-hex old-mode new-file new-hex new-mode
>=20
>    where
>      <old|new>-file are files GIT_EXTERNAL_DIFF can use to read the
>                     contents of <old|ne>,
>      <old|new>-hex are the 40-hexdigit SHA1 hashes,
>      <old|new>-mode are the octal representation of the file modes.
>=20
>    The file parameters can point at the user's working file
>    (e.g. new-file in show-diff), /dev/null (e.g. old-file when a
>    new file is added), or a temporary file (e.g. old-file in the
>    cache).  GIT_EXTERNAL_DIFF should not worry about
>    unlinking the temporary file --- it is removed when
>    GIT_EXTERNAL_DIFF exits.
>=20
>    For a path that is unmerged, GIT_EXTERNAL_DIFF is called with
>    1 parameter, path.
>=20
> ################################################################
>=20
> Terminology: - see README for description
> Each line contains terms used interchangeably
>=20
> object database, .git directory
> directory cache, index
> id, sha1, sha1-id, sha1 hash
> type, tag
> blob, blob object
> tree, tree object
> commit, commit object
> parent
> root object
> changeset
>=20
>=20
> git Environment Variables
> AUTHOR_NAME
> AUTHOR_EMAIL
> AUTHOR_DATE
> COMMIT_AUTHOR_NAME
> COMMIT_AUTHOR_EMAIL
> GIT_DIFF_CMD
> GIT_DIFF_OPTS
> GIT_EXTERNAL_DIFF
> GIT_INDEX_FILE
> SHA1_FILE_DIRECTORY
>=20

--=20
mit freundlichen Gr=FC=DFen, Brian.

Dr. Brian O'Mahoney
Mobile +41 (0)79 334 8035 Email: omb@bluewin.ch
Bleicherstrasse 25, CH-8953 Dietikon, Switzerland
PGP Key fingerprint =3D 33 41 A2 DE 35 7C CE 5D  F5 14 39 C9 6D 38 56 D=
5
