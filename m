From: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
Subject: t9200 cvsexportcommit test fails on Ubuntu server 12.04.4 LTS
Date: Fri, 28 Feb 2014 19:45:07 +0100
Organization: Fabio D'Alfonso
Message-ID: <5310D933.1@fabiodalfonso.com>
Reply-To: fabio.dalfonso@fabiodalfonso.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 20:32:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJTAH-0000FC-Gu
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 20:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbaB1TcE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 14:32:04 -0500
Received: from gateway11.websitewelcome.com ([67.18.72.139]:37297 "EHLO
	gateway11.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715AbaB1TcD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 14:32:03 -0500
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2014 14:32:03 EST
Received: by gateway11.websitewelcome.com (Postfix, from userid 500)
	id 436582DDB3DC5; Fri, 28 Feb 2014 12:45:12 -0600 (CST)
Received: from gator4050.hostgator.com (gator4050.hostgator.com [192.185.4.61])
	by gateway11.websitewelcome.com (Postfix) with ESMTP id D4F8C2DDB329D
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 12:45:09 -0600 (CST)
Received: from [95.237.41.141] (port=5662 helo=[192.168.1.16])
	by gator4050.hostgator.com with esmtpa (Exim 4.80.1)
	(envelope-from <fabio.dalfonso@fabiodalfonso.com>)
	id 1WJSQn-0001zn-0x
	for git@vger.kernel.org; Fri, 28 Feb 2014 12:45:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4050.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fabiodalfonso.com
X-BWhitelist: no
X-Source-IP: 95.237.41.141
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.16]) [95.237.41.141]:5662
X-Source-Auth: fabio.dalfonso@fabiodalfonso.com
X-Email-Count: 2
X-Source-Cap: ZGFsZm9uc287ZGFsZm9uc287Z2F0b3I0MDUwLmhvc3RnYXRvci5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243007>

Hi,
I get 12 of 15 tests faling.

Any idea? the same build works fine on 11.04 where I have a desktop ver=
sion.

Thanks


not ok 1 - New file
#    mkdir A B C D E F &&
#         echo hello1 >A/newfile1.txt &&
#         echo hello2 >B/newfile2.txt &&
#         cp "$TEST_DIRECTORY"/test-binary-
1.png C/newfile3.png &&
#         cp "$TEST_DIRECTORY"/test-binary-1.png D/newfile4.png &&
#         git add A/newfile1.txt &&
#         git add B/newfile2.txt &&
#         git add C/newfile3.png &&
#         git add D/newfile4.png &&
#         git commit -a -m "Test: New file" &&
#         id=3D$(git rev-list --max-count=3D1 HEAD) &&
#         (cd "$CVSWORK" &&
#         git cvsexportcommit -c $id &&
#         check_entries A "newfile1.txt/1.1/" &&
#         check_entries B "newfile2.txt/1.1/" &&
#         check_entries C "newfile3.png/1.1/-kb" &&
#         check_entries D "newfile4.png/1.1/-kb" &&
#         test_cmp A/newfile1.txt ../A/newfile1.txt &&
#         test_cmp B/newfile2.txt ../B/newfile2.txt &&
#         test_cmp C/newfile3.png ../C/newfile3.png &&
#         test_cmp D/newfile4.png ../D/newfile4.png
#         )
not ok 2 - Remove two files, add two and update two
#    echo Hello1 >>A/newfile1.txt &&
#         rm -f B/newfile2.txt &&
#         rm -f C/newfile3.png &&
#         echo Hello5  >E/newfile5.txt &&
#         cp "$TEST_DIRECTORY"/test-binary-2.png D/newfile4.png &&
#         cp "$TEST_DIRECTORY"/test-binary-1.png F/newfile6.png &&
#         git add E/newfile5.txt &&
#         git add F/newfile6.png &&
#         git commit -a -m "Test: Remove, add and update" &&
#         id=3D$(git rev-list --max-count=3D1 HEAD) &&
#         (cd "$CVSWORK" &&
#         git cvsexportcommit -c $id &&
#         check_entries A "newfile1.txt/1.2/" &&
#         check_entries B "" &&
#         check_entries C "" &&
#         check_entries D "newfile4.png/1.2/-kb" &&
#         check_entries E "newfile5.txt/1.1/" &&
#         check_entries F "newfile6.png/1.1/-kb" &&
#         test_cmp A/newfile1.txt ../A/newfile1.txt &&
#         test_cmp D/newfile4.png ../D/newfile4.png &&
#         test_cmp E/newfile5.txt ../E/newfile5.txt &&
#         test_cmp F/newfile6.png ../F/newfile6.png
#         )
ok 3 - Fail to change binary more than one generation old
not ok 4 - Remove only binary files
#    git reset --hard HEAD^^ &&
#         rm -f D/newfile4.png &&
#         git commit -a -m "test: remove only a binary file" &&
#         id=3D$(git rev-list --max-count=3D1 HEAD) &&
#         (cd "$CVSWORK" &&
#         git cvsexportcommit -c $id &&
#         check_entries A "newfile1.txt/1.2/" &&
#         check_entries B "" &&
#         check_entries C "" &&
#         check_entries D "" &&
#         check_entries E "newfile5.txt/1.1/" &&
#         check_entries F "newfile6.png/1.1/-kb" &&
#         test_cmp A/newfile1.txt ../A/newfile1.txt &&
#         test_cmp E/newfile5.txt ../E/newfile5.txt &&
#         test_cmp F/newfile6.png ../F/newfile6.png
#         )
not ok 5 - Remove only a text file
#    rm -f A/newfile1.txt &&
#         git commit -a -m "test: remove only a binary file" &&
#         id=3D$(git rev-list --max-count=3D1 HEAD) &&
#         (cd "$CVSWORK" &&
#         git cvsexportcommit -c $id &&
#         check_entries A "" &&
#         check_entries B "" &&
#         check_entries C "" &&
#         check_entries D "" &&
#         check_entries E "newfile5.txt/1.1/" &&
#         check_entries F "newfile6.png/1.1/-kb" &&
#         test_cmp E/newfile5.txt ../E/newfile5.txt &&
#         test_cmp F/newfile6.png ../F/newfile6.png
#         )
not ok 6 - New file with spaces in file name
#    mkdir "G g" &&
#          echo ok then >"G g/with spaces.txt" &&
#          git add "G g/with spaces.txt" && \
#          cp "$TEST_DIRECTORY"/test-binary-1.png "G g/with spaces.png"=
 && \
#          git add "G g/with spaces.png" &&
#          git commit -a -m "With spaces" &&
#          id=3D$(git rev-list --max-count=3D1 HEAD) &&
#          (cd "$CVSWORK" &&
#          git cvsexportcommit -c $id &&
#          check_entries "G g" "with spaces.png/1.1/-kb|with=20
spaces.txt/1.1/"
#          )
not ok 7 - Update file with spaces in file name
#    echo Ok then >>"G g/with spaces.txt" &&
#          cat "$TEST_DIRECTORY"/test-binary-1.png >>"G g/with=20
spaces.png" && \
#          git add "G g/with spaces.png" &&
#          git commit -a -m "Update with spaces" &&
#          id=3D$(git rev-list --max-count=3D1 HEAD) &&
#          (cd "$CVSWORK" &&
#          git cvsexportcommit -c $id
#          check_entries "G g" "with spaces.png/1.2/-kb|with=20
spaces.txt/1.2/"
#          )
not ok 8 - File with non-ascii file name
#    mkdir -p=20
=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
 &&
#          echo Foo=20
 >=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
/g=E5rdets=E5g=E5rdet.txt &&
#          git add=20
=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
/g=E5rdets=E5g=E5rdet.txt=20
&&
#          cp "$TEST_DIRECTORY"/test-binary-1.png=20
=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
/g=E5rdets=E5g=E5rdet.png=20
&&
#          git add=20
=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
/g=E5rdets=E5g=E5rdet.png=20
&&
#          git commit -a -m "G=E5r det s=E5 g=E5r det" && \
#          id=3D$(git rev-list --max-count=3D1 HEAD) &&
#          (cd "$CVSWORK" &&
#          git cvsexportcommit -v -c $id &&
#          check_entries \
#         =20
"=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
" \
#          "g=E5rdets=E5g=E5rdet.png/1.1/-kb|g=E5rdets=E5g=E5rdet.txt/1=
=2E1/"
#          )
ok 9 - Mismatching patch should fail
ok 10 - Retain execute bit
not ok 11 - -w option should work with relative GIT_DIR
#
#          mkdir W &&
#          echo foobar >W/file1.txt &&
#          echo bazzle >W/file2.txt &&
#          git add W/file1.txt &&
#          git add W/file2.txt &&
#          git commit -m "More updates" &&
#          id=3D$(git rev-list --max-count=3D1 HEAD) &&
#          (cd "$GIT_DIR" &&
#          GIT_DIR=3D. git cvsexportcommit -w "$CVSWORK" -c $id &&
#          check_entries "$CVSWORK/W" "file1.txt/1.1/|file2.txt/1.1/" &=
&
#          test_cmp "$CVSWORK/W/file1.txt" ../W/file1.txt &&
#          test_cmp "$CVSWORK/W/file2.txt" ../W/file2.txt
#          )
#
not ok 12 - check files before directories
#
#
#        echo Notes > release-notes &&
#        git add release-notes &&
#        git commit -m "Add release notes" release-notes &&
#        id=3D$(git rev-parse HEAD) &&
#        git cvsexportcommit -w "$CVSWORK" -c $id &&
#
#        echo new > DS &&
#        echo new > E/DS &&
#        echo modified > release-notes &&
#        git add DS E/DS release-notes &&
#        git commit -m "Add two files with the same basename" &&
#        id=3D$(git rev-parse HEAD) &&
#        git cvsexportcommit -w "$CVSWORK" -c $id &&
#        check_entries "$CVSWORK/E" "DS/1.1/|newfile5.txt/1.1/" &&
#        check_entries "$CVSWORK" "DS/1.1/|release-notes/1.2/" &&
#        test_cmp "$CVSWORK/DS" DS &&
#        test_cmp "$CVSWORK/E/DS" E/DS &&
#        test_cmp "$CVSWORK/release-notes" release-notes
#
#
not ok 13 - re-commit a removed filename which remains in CVS attic
#
#
#        (cd "$CVSWORK" &&
#         echo >attic_gremlin &&
#         cvs -Q add attic_gremlin &&
#         cvs -Q ci -m "added attic_gremlin" &&
#         rm attic_gremlin &&
#         cvs -Q rm attic_gremlin &&
#         cvs -Q ci -m "removed attic_gremlin") &&
#
#        echo > attic_gremlin &&
#        git add attic_gremlin &&
#        git commit -m "Added attic_gremlin" &&
#        git cvsexportcommit -w "$CVSWORK" -c HEAD &&
#        (cd "$CVSWORK"; cvs -Q update -d) &&
#        test -f "$CVSWORK/attic_gremlin"
#
not ok 14 - commit a file with leading spaces in the name
#
#
#        echo space > " space" &&
#        git add " space" &&
#        git commit -m "Add a file with a leading space" &&
#        id=3D$(git rev-parse HEAD) &&
#        git cvsexportcommit -w "$CVSWORK" -c $id &&
#        check_entries "$CVSWORK" "=20
space/1.1/|DS/1.1/|attic_gremlin/1.3/|release-notes/1.2/" &&
#        test_cmp "$CVSWORK/ space" " space"
#
#
not ok 15 - use the same checkout for Git and CVS
#
#
#        (mkdir shared &&
#         cd shared &&
#         sane_unset GIT_DIR &&
#         cvs co . &&
#         git init &&
#         git add " space" &&
#         git commit -m "fake initial commit" &&
#         echo Hello >> " space" &&
#         git commit -m "Another change" " space" &&
#         git cvsexportcommit -W -p -u -c HEAD &&
#         grep Hello " space" &&
#         git diff-files)
#
#
# failed 12 among 15 test(s)
1..15
--=20

=46abio D'Alfonso
'Enabling Business Through IT'
cell.  +39.348.059.40.22 ***
web: www.fabiodalfonso.com <http://www.fabiodalfonso.com/>
email: fabio.dalfonso@fabiodalfonso.com
<mailto:fabio.dalfonso@fabiodalfonso.com>linkedin:=20
www.linkedin.com/in/fabiodalfonso <http://it.linkedin.com/in/fabiodalfo=
nso>
twitter: www.twitter.com/#!/fabio_dalfonso=20
<http://www.twitter.com/#%21/fabio_dalfonso>

fax: +39.06.874.599.581
BlackBerry=AE Wireless Enabled Address.


          ** Hidden  numbers are automatically rejected by the phone*
