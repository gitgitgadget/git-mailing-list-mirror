From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 08:42:46 -0700
Message-ID: <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
References: <20080114202932.GA25130@steel.home>
	 <20080115200437.GB3213@steel.home>
	 <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
	 <200801160002.51048.robin.rosenberg.lists@dewire.com>
	 <20080116071832.GA2896@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 16:43:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFAQf-0005hK-5Y
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 16:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbYAPPmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 10:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbYAPPmw
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 10:42:52 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:50664 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbYAPPmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 10:42:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so492959wah.23
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 07:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZysvHhre6UZEVabjRK89bCkqX0DCTvdDqoNHdMrnJ3E=;
        b=brCHJc/P+kMjChrIXODIIRUYE+M86/WPAsPUQjya0EAcUCRc5AK9IC8/bTlK0bx/uzTWCcR8WLsjKTrIY1wYT4ZlemVkLboLwg51grUidTMNQvMLKgKfg7lCCjgQpPWPjlvX9EuKt9lY13ffxPSBniNKdWInyx2vSVgdFa/DSlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f3B4qykvuye/j3fg3gh3ak2aWjb/ww4zXqflDOtW9+myowFuX5pSnPMuL8Odx7b3BPmQTFIOcWSbooeUOOm/S5mg/LGy62ePtnWOO9sJT4A13iOh7fPjX62u+K2BHxqRWHxXM6ZGIAmmbIRn/nSELoNb+OaRXRha22ZSjKCdO48=
Received: by 10.114.174.2 with SMTP id w2mr1093061wae.17.1200498166870;
        Wed, 16 Jan 2008 07:42:46 -0800 (PST)
Received: by 10.114.137.1 with HTTP; Wed, 16 Jan 2008 07:42:46 -0800 (PST)
In-Reply-To: <20080116071832.GA2896@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70691>

OK, I think this worked (I'm a Java man, not C/C++). I downloaded the
latest 1.5.3 source from the git repository and ran "make" with
GIT_TEST_OPTS="--verbose --debug". Here's the output:

paulumbers@Devteam29 ~/workspace/git/git-1.5.3/t
$ make
*** t0000-basic.sh ***
*   ok 1: .git/objects should be empty after git init in an empty repo.
*   ok 2: .git/objects should have 3 subdirectories.
*   ok 3: git update-index without --add should fail adding.
*   ok 4: git update-index with --add should succeed.
* FAIL 5: writing tree out with git write-tree
        tree=$(git write-tree)
* FAIL 6: validate object ID of a known tree.
        test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
*   ok 7: git update-index without --remove should fail removing.
*   ok 8: git update-index with --remove should be able to remove.
*   ok 9: git write-tree should be able to write an empty tree.
*   ok 10: validate object ID of a known tree.
*   ok 11: adding various types of objects with git update-index --add.
*   ok 12: showing stage with git ls-files --stage
*   ok 13: validate git ls-files output for a known tree.
* FAIL 14: writing tree out with git write-tree.
        tree=$(git write-tree)
* FAIL 15: validate object ID for a known tree.
        test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
* FAIL 16: showing tree with git ls-tree
        git ls-tree $tree >current
* FAIL 17: git ls-tree output for a known tree.
        diff current expected
* FAIL 18: showing tree with git ls-tree -r
        git ls-tree -r $tree >current
* FAIL 19: git ls-tree -r output for a known tree.
        diff current expected
* FAIL 20: showing tree with git ls-tree -r -t
        git ls-tree -r -t $tree >current
* FAIL 21: git ls-tree -r output for a known tree.
        diff current expected
* FAIL 22: writing partial tree out with git write-tree --prefix.
        ptree=$(git write-tree --prefix=path3)
* FAIL 23: validate object ID for a known tree.
        test "$ptree" = 21ae8269cacbe57ae09138dcc3a2887f904d02b3
* FAIL 24: writing partial tree out with git write-tree --prefix.
        ptree=$(git write-tree --prefix=path3/subp3)
* FAIL 25: validate object ID for a known tree.
        test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2
*   ok 26: put invalid objects into the index.
*   ok 27: writing this tree without --missing-ok.
*   ok 28: writing this tree with --missing-ok.
* FAIL 29: git read-tree followed by write-tree should be idempotent.
        git read-tree $tree &&
             test -f .git/index &&
             newtree=$(git write-tree) &&
             test "$newtree" = "$tree"
* FAIL 30: validate git diff-files output for a know cache/work tree state.
        git diff-files >current && diff >/dev/null -b current expected
*   ok 31: git update-index --refresh should succeed.
*   ok 32: no diff after checkout and git update-index --refresh.
* FAIL 33: git commit-tree records the correct tree in a commit.
        commit0=$(echo NO | git commit-tree $P) &&
             tree=$(git show --pretty=raw $commit0 |
                 sed -n -e "s/^tree //p" -e "/^author /q") &&
             test "z$tree" = "z$P"
* FAIL 34: git commit-tree records the correct parent in a commit.
        commit1=$(echo NO | git commit-tree $P -p $commit0) &&
             parent=$(git show --pretty=raw $commit1 |
                 sed -n -e "s/^parent //p" -e "/^author /q") &&
             test "z$commit0" = "z$parent"
* FAIL 35: git commit-tree omits duplicated parent in a commit.
        commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
             parent=$(git show --pretty=raw $commit2 |
                 sed -n -e "s/^parent //p" -e "/^author /q" |
                 sort -u) &&
             test "z$commit0" = "z$parent" &&
             numparent=$(git show --pretty=raw $commit2 |
                 sed -n -e "s/^parent //p" -e "/^author /q" |
                 wc -l) &&
             test $numparent = 1
*   ok 36: update-index D/F conflict
* FAIL 37: absolute path works as expected

                mkdir first &&
                ln -s ../.git first/.git &&
                mkdir second &&
                ln -s ../first second/other &&
                mkdir third &&
                dir="$(cd .git; pwd -P)" &&
                dir2=third/../second/other/.git &&
                test "$dir" = "$(test-absolute-path $dir2)" &&
                file="$dir"/index &&
                test "$file" = "$(test-absolute-path $dir2/index)" &&
                ln -s ../first/file .git/syml &&
                sym="$(cd first; pwd -P)"/file &&
                test "$sym" = "$(test-absolute-path $dir2/syml)"

* failed 20 among 37 test(s)
make: *** [t0000-basic.sh] Error 1

paulumbers@Devteam29 ~/workspace/git/git-1.5.3/t
$ make -v -d
GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

This program built for i686-pc-cygwin

paulumbers@Devteam29 ~/workspace/git/git-1.5.3/t
$ export GIT_TEST_OPTS="--verbose --debug"

paulumbers@Devteam29 ~/workspace/git/git-1.5.3/t
$ make
*** t0000-basic.sh ***
* expecting success: cmp -s /dev/null should-be-empty
*   ok 1: .git/objects should be empty after git init in an empty repo.

* expecting success: test $(wc -l < full-of-directories) = 3
*   ok 2: .git/objects should have 3 subdirectories.

* expecting failure: git update-index should-be-empty
error: should-be-empty: cannot add to the index - missing --add option?
fatal: Unable to process path should-be-empty
*   ok 3: git update-index without --add should fail adding.

* expecting success: git update-index --add should-be-empty
*   ok 4: git update-index with --add should succeed.

* expecting success: tree=$(git write-tree)
error: invalid object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
fatal: git-write-tree: error building trees
* FAIL 5: writing tree out with git write-tree
        tree=$(git write-tree)

* expecting success: test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
* FAIL 6: validate object ID of a known tree.
        test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a

* expecting failure: git update-index should-be-empty
error: should-be-empty: does not exist and --remove not passed
fatal: Unable to process path should-be-empty
*   ok 7: git update-index without --remove should fail removing.

* expecting success: git update-index --remove should-be-empty
*   ok 8: git update-index with --remove should be able to remove.

* expecting success: tree=$(git write-tree)
*   ok 9: git write-tree should be able to write an empty tree.

* expecting success: test "$tree" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904
*   ok 10: validate object ID of a known tree.

* expecting success: find path* ! -type d -print | xargs git update-index --add
*   ok 11: adding various types of objects with git update-index --add.

* expecting success: git ls-files --stage >current
*   ok 12: showing stage with git ls-files --stage

* expecting success: diff current expected
*   ok 13: validate git ls-files output for a known tree.

* expecting success: tree=$(git write-tree)
error: invalid object 3feff949ed00a62d9f7af97c15cd8a30595e7ac7
fatal: git-write-tree: error building trees
* FAIL 14: writing tree out with git write-tree.
        tree=$(git write-tree)

* expecting success: test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
* FAIL 15: validate object ID for a known tree.
        test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b

* expecting success: git ls-tree $tree >current
usage: git-ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only]
[--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]
* FAIL 16: showing tree with git ls-tree
        git ls-tree $tree >current

* expecting success: diff current expected
0a1,4
> 100644 blob f87290f8eb2cbbea7857214459a0739927eab154  path0
> 120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01  path0sym
> 040000 tree 58a09c23e2ca152193f2786e06986b7b6712bdbe  path2
> 040000 tree 21ae8269cacbe57ae09138dcc3a2887f904d02b3  path3
* FAIL 17: git ls-tree output for a known tree.
        diff current expected

* expecting success: git ls-tree -r $tree >current
usage: git-ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only]
[--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]
* FAIL 18: showing tree with git ls-tree -r
        git ls-tree -r $tree >current

* expecting success: diff current expected
0a1,8
> 100644 blob f87290f8eb2cbbea7857214459a0739927eab154  path0
> 120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01  path0sym
> 100644 blob 3feff949ed00a62d9f7af97c15cd8a30595e7ac7  path2/file2
> 120000 blob d8ce161addc5173867a3c3c730924388daedbc38  path2/file2sym
> 100644 blob 0aa34cae68d0878578ad119c86ca2b5ed5b28376  path3/file3
> 120000 blob 8599103969b43aff7e430efea79ca4636466794f  path3/file3sym
> 100644 blob 00fb5908cb97c2564a9783c0c64087333b3b464f  path3/subp3/file3
> 120000 blob 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c  path3/subp3/file3sym
* FAIL 19: git ls-tree -r output for a known tree.
        diff current expected

* expecting success: git ls-tree -r -t $tree >current
usage: git-ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only]
[--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]
* FAIL 20: showing tree with git ls-tree -r -t
        git ls-tree -r -t $tree >current

* expecting success: diff current expected
0a1,11
> 100644 blob f87290f8eb2cbbea7857214459a0739927eab154  path0
> 120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01  path0sym
> 040000 tree 58a09c23e2ca152193f2786e06986b7b6712bdbe  path2
> 100644 blob 3feff949ed00a62d9f7af97c15cd8a30595e7ac7  path2/file2
> 120000 blob d8ce161addc5173867a3c3c730924388daedbc38  path2/file2sym
> 040000 tree 21ae8269cacbe57ae09138dcc3a2887f904d02b3  path3
> 100644 blob 0aa34cae68d0878578ad119c86ca2b5ed5b28376  path3/file3
> 120000 blob 8599103969b43aff7e430efea79ca4636466794f  path3/file3sym
> 040000 tree 3c5e5399f3a333eddecce7a9b9465b63f65f51e2  path3/subp3
> 100644 blob 00fb5908cb97c2564a9783c0c64087333b3b464f  path3/subp3/file3
> 120000 blob 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c  path3/subp3/file3sym
* FAIL 21: git ls-tree -r output for a known tree.
        diff current expected

* expecting success: ptree=$(git write-tree --prefix=path3)
error: invalid object 3feff949ed00a62d9f7af97c15cd8a30595e7ac7
fatal: git-write-tree: error building trees
* FAIL 22: writing partial tree out with git write-tree --prefix.
        ptree=$(git write-tree --prefix=path3)

* expecting success: test "$ptree" = 21ae8269cacbe57ae09138dcc3a2887f904d02b3
* FAIL 23: validate object ID for a known tree.
        test "$ptree" = 21ae8269cacbe57ae09138dcc3a2887f904d02b3

* expecting success: ptree=$(git write-tree --prefix=path3/subp3)
error: invalid object 3feff949ed00a62d9f7af97c15cd8a30595e7ac7
fatal: git-write-tree: error building trees
* FAIL 24: writing partial tree out with git write-tree --prefix.
        ptree=$(git write-tree --prefix=path3/subp3)

* expecting success: test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2
* FAIL 25: validate object ID for a known tree.
        test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2

* expecting success: git update-index --index-info < badobjects
*   ok 26: put invalid objects into the index.

* expecting failure: git write-tree
error: invalid object 1000000000000000000000000000000000000000
fatal: git-write-tree: error building trees
*   ok 27: writing this tree without --missing-ok.

* expecting success: git write-tree --missing-ok
851a367613bb6e1f0b2b518323eafed530b5b4c4
*   ok 28: writing this tree with --missing-ok.

* expecting success: git read-tree $tree &&
     test -f .git/index &&
     newtree=$(git write-tree) &&
     test "$newtree" = "$tree"
* FAIL 29: git read-tree followed by write-tree should be idempotent.
        git read-tree $tree &&
             test -f .git/index &&
             newtree=$(git write-tree) &&
             test "$newtree" = "$tree"

* expecting success: git diff-files >current && diff >/dev/null -b
current expected
* FAIL 30: validate git diff-files output for a know cache/work tree state.
        git diff-files >current && diff >/dev/null -b current expected

* expecting success: git update-index --refresh
*   ok 31: git update-index --refresh should succeed.

* expecting success: git diff-files >current && cmp -s current /dev/null
*   ok 32: no diff after checkout and git update-index --refresh.

* expecting success: commit0=$(echo NO | git commit-tree $P) &&
     tree=$(git show --pretty=raw $commit0 |
         sed -n -e "s/^tree //p" -e "/^author /q") &&
     test "z$tree" = "z$P"
error: unable to find 087704a96baf1c2d1c869a8b084481e121c88b5b
fatal: 087704a96baf1c2d1c869a8b084481e121c88b5b is not a valid object
* FAIL 33: git commit-tree records the correct tree in a commit.
        commit0=$(echo NO | git commit-tree $P) &&
             tree=$(git show --pretty=raw $commit0 |
                 sed -n -e "s/^tree //p" -e "/^author /q") &&
             test "z$tree" = "z$P"

* expecting success: commit1=$(echo NO | git commit-tree $P -p $commit0) &&
     parent=$(git show --pretty=raw $commit1 |
         sed -n -e "s/^parent //p" -e "/^author /q") &&
     test "z$commit0" = "z$parent"
error: unable to find 087704a96baf1c2d1c869a8b084481e121c88b5b
fatal: 087704a96baf1c2d1c869a8b084481e121c88b5b is not a valid object
* FAIL 34: git commit-tree records the correct parent in a commit.
        commit1=$(echo NO | git commit-tree $P -p $commit0) &&
             parent=$(git show --pretty=raw $commit1 |
                 sed -n -e "s/^parent //p" -e "/^author /q") &&
             test "z$commit0" = "z$parent"

* expecting success: commit2=$(echo NO | git commit-tree $P -p
$commit0 -p $commit0) &&
     parent=$(git show --pretty=raw $commit2 |
         sed -n -e "s/^parent //p" -e "/^author /q" |
         sort -u) &&
     test "z$commit0" = "z$parent" &&
     numparent=$(git show --pretty=raw $commit2 |
         sed -n -e "s/^parent //p" -e "/^author /q" |
         wc -l) &&
     test $numparent = 1
error: unable to find 087704a96baf1c2d1c869a8b084481e121c88b5b
fatal: 087704a96baf1c2d1c869a8b084481e121c88b5b is not a valid object
* FAIL 35: git commit-tree omits duplicated parent in a commit.
        commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
             parent=$(git show --pretty=raw $commit2 |
                 sed -n -e "s/^parent //p" -e "/^author /q" |
                 sort -u) &&
             test "z$commit0" = "z$parent" &&
             numparent=$(git show --pretty=raw $commit2 |
                 sed -n -e "s/^parent //p" -e "/^author /q" |
                 wc -l) &&
             test $numparent = 1

* expecting success:
        mv path0 tmp &&
        mv path2 path0 &&
        mv tmp path2 &&
        git update-index --add --replace path2 path0/file2 &&
        numpath0=$(git ls-files path0 | wc -l) &&
        test $numpath0 = 1

*   ok 36: update-index D/F conflict

* expecting success:
        mkdir first &&
        ln -s ../.git first/.git &&
        mkdir second &&
        ln -s ../first second/other &&
        mkdir third &&
        dir="$(cd .git; pwd -P)" &&
        dir2=third/../second/other/.git &&
        test "$dir" = "$(test-absolute-path $dir2)" &&
        file="$dir"/index &&
        test "$file" = "$(test-absolute-path $dir2/index)" &&
        ln -s ../first/file .git/syml &&
        sym="$(cd first; pwd -P)"/file &&
        test "$sym" = "$(test-absolute-path $dir2/syml)"

* FAIL 37: absolute path works as expected

                mkdir first &&
                ln -s ../.git first/.git &&
                mkdir second &&
                ln -s ../first second/other &&
                mkdir third &&
                dir="$(cd .git; pwd -P)" &&
                dir2=third/../second/other/.git &&
                test "$dir" = "$(test-absolute-path $dir2)" &&
                file="$dir"/index &&
                test "$file" = "$(test-absolute-path $dir2/index)" &&
                ln -s ../first/file .git/syml &&
                sym="$(cd first; pwd -P)"/file &&
                test "$sym" = "$(test-absolute-path $dir2/syml)"


* failed 20 among 37 test(s)
make: *** [t0000-basic.sh] Error 1
