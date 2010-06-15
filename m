From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Tue, 15 Jun 2010 15:17:58 +0000
Message-ID: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
	<m3631lp9oe.fsf@localhost.localdomain>
	<AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 17:18:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOXty-0000YC-Fv
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 17:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245Ab0FOPSE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 11:18:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36868 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab0FOPSB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 11:18:01 -0400
Received: by iwn9 with SMTP id 9so4619571iwn.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L2zNtbP8rLMSAdlMJ/npLPl40fgRSYR3DDgXfq7A4dA=;
        b=PvwAjhX7XIK7sbzxKu89qUyiX7p8k8ZLTo1B7V4GeESMskgmUzA3UB9xWuMYat2/OY
         T2ThYYobZR1sli69wWnGAzAyI8qbX15MVGfiyKZJwAT4e6PMIv3hkfMHNHkbQS/kq3tU
         VWMOVyn0XFhiQ+vVRLBoUM3D3ItXaSg6iSQLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CFTqQxYTRyTeajOwNixmnHarvE2kk/kvF3D2XkGP/lOIGIe8w34eqYtSLCmloFJYtQ
         2ITa3rjBL/7rQ/mhHnB8/yeUFxHf43L2TTSQ3yyaNEbDIcgvcLVkZD7xU4LeJqL5844o
         IgHBs06GiU7U7t1XTO9d8ACsBnuaM9R+QoA6g=
Received: by 10.231.120.100 with SMTP id c36mr1862157ibr.77.1276615078390; 
	Tue, 15 Jun 2010 08:17:58 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Tue, 15 Jun 2010 08:17:58 -0700 (PDT)
In-Reply-To: <AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149190>

On Mon, Jun 14, 2010 at 22:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Mon, Jun 14, 2010 at 21:49, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> writ=
es:
>>
>>> All this series does is slightly adjust the raw text output of our
>>> tests so that it conforms. to the TAP standard, i.e. instead of thi=
s:
>>>
>>> =C2=A0 =C2=A0$ ./t0005-signals.sh
>>> =C2=A0 =C2=A0* =C2=A0 ok 1: sigchain works
>>> =C2=A0 =C2=A0* passed all 1 test(s)
>>>
>>> We get this:
>>>
>>> =C2=A0 =C2=A0$ ./t0005-signals.sh
>>> =C2=A0 =C2=A0ok 1 - sigchain works
>>> =C2=A0 =C2=A0# passed all 1 test(s)
>>> =C2=A0 =C2=A01..1
>>>
>>> Changing the output format like this gives us the ability to run th=
e
>>> Git tests with any TAP tool (like prove(1)) at no extra cost. Every
>>> other existing way of running the tests continues to work, it's jus=
t
>>> easier for machines to read the output now.
>
> I'll re-submit a version of the patch with a better commit message
> which addresses all of the below.
>
>> This doesn't tell us if the result of running test suite with
>> '--verbose' and/or with '--debug' changes, and if changes how? =C2=A0=
Is it
>> compatibile with TAP format so that TAP parsers understand it?
>
> It just changes in that the lines that previously said e.g. "* =C2=A0=
 ok 1:
> sigchain works" now say "ok 1 - sigchain works".
>
> TAP parsers still understand it, since ignoring unknown garbage is
> part of the TAP standard.

Actually it doesn't work for all the tests. The following crops up on
prove -j 10 ./t[0-9]*.sh :: --verbose:

    ./t1007-hash-object.sh                             (Wstat: 0
Tests: 19 Failed: 0)
      Parse errors: Tests out of sequence.  Found (12) but expected (11=
)
                    Tests out of sequence.  Found (13) but expected (12=
)
                    Tests out of sequence.  Found (14) but expected (13=
)
                    Tests out of sequence.  Found (15) but expected (14=
)
                    Tests out of sequence.  Found (16) but expected (15=
)
    Displayed the first 5 of 10 TAP syntax errors.
    Re-run prove with the -p option to see them all.
    ./t3411-rebase-preserve-around-merges.sh           (Wstat: 0
Tests: 1 Failed: 0)
      Parse errors: Bad plan.  You planned 3 tests but ran 1.
    ./t3410-rebase-preserve-dropped-merges.sh          (Wstat: 0
Tests: 1 Failed: 0)
      Parse errors: Bad plan.  You planned 3 tests but ran 1.
    ./t3413-rebase-hook.sh                             (Wstat: 0
Tests: 10 Failed: 0)
      Parse errors: Tests out of sequence.  Found (4) but expected (3)
                    Tests out of sequence.  Found (5) but expected (4)
                    Tests out of sequence.  Found (6) but expected (5)
                    Tests out of sequence.  Found (7) but expected (6)
                    Tests out of sequence.  Found (11) but expected (7)
    Displayed the first 5 of 9 TAP syntax errors.
    Re-run prove with the -p option to see them all.
    ./t3409-rebase-preserve-merges.sh                  (Wstat: 0
Tests: 1 Failed: 0)
      Parse errors: Bad plan.  You planned 3 tests but ran 1.
    ./t3414-rebase-preserve-onto.sh                    (Wstat: 0
Tests: 1 Failed: 0)
      Parse errors: Bad plan.  You planned 4 tests but ran 1.
    ./t3415-rebase-autosquash.sh                       (Wstat: 0
Tests: 1 Failed: 0)
      Parse errors: Bad plan.  You planned 4 tests but ran 1.
    ./t3416-rebase-onto-threedots.sh                   (Wstat: 0
Tests: 5 Failed: 0)
      Parse errors: Tests out of sequence.  Found (7) but expected (5)
                    Bad plan.  You planned 7 tests but ran 5.
    ./t3412-rebase-root.sh                             (Wstat: 0
Tests: 24 Failed: 0)
    ./t3404-rebase-interactive.sh                      (Wstat: 0
Tests: 23 Failed: 0)
      Parse errors: Tests out of sequence.  Found (6) but expected (2)
                    Tests out of sequence.  Found (8) but expected (3)
                    Tests out of sequence.  Found (9) but expected (4)
                    Tests out of sequence.  Found (10) but expected (5)
                    Tests out of sequence.  Found (11) but expected (6)
    Displayed the first 5 of 23 TAP syntax errors.
    Re-run prove with the -p option to see them all.
    ./t5407-post-rewrite-hook.sh                       (Wstat: 0
Tests: 9 Failed: 0)
      Parse errors: Tests out of sequence.  Found (10) but expected (8)
                    Tests out of sequence.  Found (11) but expected (9)
                    Bad plan.  You planned 12 tests but ran 9.
    ./t7402-submodule-rebase.sh                        (Wstat: 0
Tests: 4 Failed: 0)
      Parse errors: Tests out of sequence.  Found (4) but expected (3)
                    Tests out of sequence.  Found (5) but expected (4)
                    Bad plan.  You planned 5 tests but ran 4.
    ./t7003-filter-branch.sh                           (Wstat: 0
Tests: 30 Failed: 0)
      Parse errors: Tests out of sequence.  Found (8) but expected (7)
                    Tests out of sequence.  Found (9) but expected (8)
                    Tests out of sequence.  Found (10) but expected (9)
                    Tests out of sequence.  Found (11) but expected (10=
)
                    Tests out of sequence.  Found (12) but expected (11=
)
    Displayed the first 5 of 25 TAP syntax errors.
    Re-run prove with the -p option to see them all.
    ./t9001-send-email.sh                              (Wstat: 0
Tests: 63 Failed: 0)
      Parse errors: Tests out of sequence.  Found (45) but expected (44=
)
                    Tests out of sequence.  Found (46) but expected (45=
)
                    Tests out of sequence.  Found (47) but expected (46=
)
                    Tests out of sequence.  Found (48) but expected (47=
)
                    Tests out of sequence.  Found (49) but expected (48=
)

The problem is that these tests all have code outputthat goes
something like this:

    ok 2 - rebase

    expecting success:
            git checkout test &&
            git reset --hard side &&
            EDITOR=3Dtrue git rebase -i master &&
            test "z$(cat git)" =3D zworld

    HEAD is now at c847452 side
    Rebasing (1/1)^Mok 3 - rebase -i

    expecting success:

Caused by tests like these that don't end in a newline:

    test_expect_success 'rebase -i' '
    	git checkout test &&
    	git reset --hard side &&
    	EDITOR=3Dtrue git rebase -i master &&
    	test "z$(cat git)" =3D zworld'
    '

This was of course also broken before TAP, it just revealed the issue:

    Applying: side
    *   ok 2: rebase

    * expecting success:
            git checkout test &&
            git reset --hard side &&
            EDITOR=3Dtrue git rebase -i master &&
            test "z$(cat git)" =3D zworld

    HEAD is now at c847452 side
    Rebasing (1/1)^M*   ok 3: rebase -i

I propose to fix it like this:

    diff --git a/t/test-lib.sh b/t/test-lib.sh
    index 37987d7..86a46bf 100644
    --- a/t/test-lib.sh
    +++ b/t/test-lib.sh
    @@ -369,6 +369,9 @@ test_run_ () {
            eval >&3 2>&4 "$1"
            eval_ret=3D$?
            eval >&3 2>&4 "$test_cleanup"
    +       if test "$verbose" =3D "t" && test -n "$HARNESS_ACTIVE"; th=
en
    +               echo ""
    +       fi
            return 0
     }

That makes all tests a bit more verbose when run under --verbose and a
TAP::Harness, but fixes the issue everywhere and in any future code by
ensuring that there's a newline before /^(?:not )?ok/ lines.

The alternative would be to change all the tests in question so that
they end with && echo, or to munge the `eval >&3 2>&4 "$1"' part above
(maybe with tempfiles?) so that a newline is only added to the end if
there isn't one already.

Aside from that, making sure that nothing in the test suite itself
says "ok" on an otherwise empty line is also required:

     t/t1020-subdirectory.sh          |   12 ++++++------
     t/t2102-update-index-symlinks.sh |    2 +-
     t/t3700-add.sh                   |   12 ++++++------
     3 files changed, 13 insertions(+), 13 deletions(-)

    diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
    index 210e594..5687499 100755
    --- a/t/t1020-subdirectory.sh
    +++ b/t/t1020-subdirectory.sh
    @@ -24,18 +24,18 @@ test_expect_success 'update-index and ls-files'=
 '
     	cd "$HERE" &&
     	git update-index --add one &&
     	case "`git ls-files`" in
    -	one) echo ok one ;;
    +	one) echo pass one ;;
     	*) echo bad one; exit 1 ;;
     	esac &&
     	cd dir &&
     	git update-index --add two &&
     	case "`git ls-files`" in
    -	two) echo ok two ;;
    +	two) echo pass two ;;
     	*) echo bad two; exit 1 ;;
     	esac &&
     	cd .. &&
     	case "`git ls-files`" in
    -	dir/two"$LF"one) echo ok both ;;
    +	dir/two"$LF"one) echo pass both ;;
     	*) echo bad; exit 1 ;;
     	esac
     '
    @@ -58,17 +58,17 @@ test_expect_success 'diff-files' '
     	echo a >>one &&
     	echo d >>dir/two &&
     	case "`git diff-files --name-only`" in
    -	dir/two"$LF"one) echo ok top ;;
    +	dir/two"$LF"one) echo pass top ;;
     	*) echo bad top; exit 1 ;;
     	esac &&
     	# diff should not omit leading paths
     	cd dir &&
     	case "`git diff-files --name-only`" in
    -	dir/two"$LF"one) echo ok subdir ;;
    +	dir/two"$LF"one) echo pass subdir ;;
     	*) echo bad subdir; exit 1 ;;
     	esac &&
     	case "`git diff-files --name-only .`" in
    -	dir/two) echo ok subdir limited ;;
    +	dir/two) echo pass subdir limited ;;
     	*) echo bad subdir limited; exit 1 ;;
     	esac
     '
    diff --git a/t/t2102-update-index-symlinks.sh
b/t/t2102-update-index-symlinks.sh
    index 1ed44ee..4d0d0a3 100755
    --- a/t/t2102-update-index-symlinks.sh
    +++ b/t/t2102-update-index-symlinks.sh
    @@ -24,7 +24,7 @@ git update-index symlink'
     test_expect_success \
     'the index entry must still be a symbolic link' '
     case "`git ls-files --stage --cached symlink`" in
    -120000" "*symlink) echo ok;;
    +120000" "*symlink) echo pass;;
     *) echo fail; git ls-files --stage --cached symlink; (exit 1);;
     esac'

    diff --git a/t/t3700-add.sh b/t/t3700-add.sh
    index 525c9a8..6f031af 100755
    --- a/t/t3700-add.sh
    +++ b/t/t3700-add.sh
    @@ -26,7 +26,7 @@ test_expect_success \
     	 chmod 755 xfoo1 &&
     	 git add xfoo1 &&
     	 case "`git ls-files --stage xfoo1`" in
    -	 100644" "*xfoo1) echo ok;;
    +	 100644" "*xfoo1) echo pass;;
     	 *) echo fail; git ls-files --stage xfoo1; (exit 1);;
     	 esac'

    @@ -35,7 +35,7 @@ test_expect_success SYMLINKS 'git add:
filemode=3D0 should not get confused by sym
     	ln -s foo xfoo1 &&
     	git add xfoo1 &&
     	case "`git ls-files --stage xfoo1`" in
    -	120000" "*xfoo1) echo ok;;
    +	120000" "*xfoo1) echo pass;;
     	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
     	esac
     '
    @@ -47,7 +47,7 @@ test_expect_success \
     	 chmod 755 xfoo2 &&
     	 git update-index --add xfoo2 &&
     	 case "`git ls-files --stage xfoo2`" in
    -	 100644" "*xfoo2) echo ok;;
    +	 100644" "*xfoo2) echo pass;;
     	 *) echo fail; git ls-files --stage xfoo2; (exit 1);;
     	 esac'

    @@ -56,7 +56,7 @@ test_expect_success SYMLINKS 'git add:
filemode=3D0 should not get confused by sym
     	ln -s foo xfoo2 &&
     	git update-index --add xfoo2 &&
     	case "`git ls-files --stage xfoo2`" in
    -	120000" "*xfoo2) echo ok;;
    +	120000" "*xfoo2) echo pass;;
     	*) echo fail; git ls-files --stage xfoo2; (exit 1);;
     	esac
     '
    @@ -67,7 +67,7 @@ test_expect_success SYMLINKS \
     	 ln -s xfoo2 xfoo3 &&
     	 git update-index --add xfoo3 &&
     	 case "`git ls-files --stage xfoo3`" in
    -	 120000" "*xfoo3) echo ok;;
    +	 120000" "*xfoo3) echo pass;;
     	 *) echo fail; git ls-files --stage xfoo3; (exit 1);;
     	 esac'

    @@ -172,7 +172,7 @@ test_expect_success 'git add --refresh' '
     	test -z "`git diff-index HEAD -- foo`" &&
     	git read-tree HEAD &&
     	case "`git diff-index HEAD -- foo`" in
    -	:100644" "*"M	foo") echo ok;;
    +	:100644" "*"M	foo") echo pass;;
     	*) echo fail; (exit 1);;
     	esac &&
     	git add --refresh -- foo &&

Another way to solve all of these would be to apply s/^/# / to all the
--verbose output. This is what the Perl tools do:

    $ perl -MTest::More=3Dtests,2 -E 'pass "a test";
diag("hello\nthere\noutput\n"); pass "another test"'
    1..2
    ok 1 - a test
    # hello
    # there
    # output
    ok 2 - another test

Then the verbose output would only be printed under prove(1) if its
--verbose option was supplied (if lines aren't comments they're
printed as-is). That'd also require something like the eval + tempfile
hack suggested above.
