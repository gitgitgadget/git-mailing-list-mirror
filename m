From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t6302: drop unnecessary GPG requirement
Date: Mon, 1 Feb 2016 08:24:34 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602010759480.2964@virtualbox>
References: <1454271562-24291-1-git-send-email-sunshine@sunshineco.com> <xmqq4mdtxjxf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 08:24:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ8qx-00065J-1k
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 08:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbcBAHYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 02:24:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:61338 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbcBAHYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 02:24:45 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LlUZz-1ZpAGp0127-00bI2M; Mon, 01 Feb 2016 08:24:36
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq4mdtxjxf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xmUcowDuXyMaAoDLjHBM2E2/pfHiavmaFNS06wlFJ5dGQJMlO3E
 ul/SZDipJ51fo7evOFg/yO7XCEc44i5ufm6r1yDejMdId3tCcKl+thbOYZ88K3H10PbLPtT
 UkIR/Gs4Z8DzmiNkHQRS4CnlygnVYyWmmY3DbzQ5+JW+ZrFfXp2yWwKV9rKuFrHagrymnhi
 X1AuE4nk+ILctu0/ED8eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OmPAY7fsSaI=:4xDRHGHaEExAshj3xK23A6
 wGqRTR5hMSAcX58cPfQcHI6XGAjkekk55bZpIjdZjzA/HI2s6HuX0jvN/W4n9dnOOjE9zBIqd
 PwOGwFTNfuFBJw12tcwhat9wbDQGfHb9U0Urfd/bjA1SgzO3gGJfiaCkRC+FMnMDfQP39vxPk
 U22/YFRfxZvQ8fRSyuhtv9sFVaRCDJNBTCCkhCo7FpRfa74ae1ikm0HIdqt/6RoDt5PbX+kMS
 YPGAhzcQEWr1vnzsA+VNF7Nlm2HwC1ShsVlneNGf9sUPnC/sLsDAipENA5LsawIow18NpDDVe
 1hLDugjCNNecvrOqXtw6lY/QVvRy7YDadNYn9zWyRJN3pZ5VFEM1Ojmqd1GLiF6dznMucmfaF
 kNKojqfcpk1+PWK0dczkWWNJj+Sxdzul4hElC2OjivhKWqnhn0QIleMBGF8fvq6R0qeqYqwA5
 nzH24fzo3+37Y3JnD5mrn0IISbFTMb1L2JyplGcC9UjGsJmFa7hMvdl0jYYXhVCxTXEwEhtTX
 qX6qudF5Jpkuc5gAHKP/5WEGHlpMoArLSV9mahn/ghB9fOitKF1E38Tbbqy9a573U1OTC9PIb
 F3WjcRDuf/eBCrTAs/dtzfcMJvbFfPHot6arICKcksPU0FB7wpCzuUbUzJgzKNq3UKx6jltKh
 NTsDixnqoM8nQZ+oHsysVJxmgIKRrY7630ML8LP7pWVNuMNaBF7FqOder13bx7AXKudWWEmMQ
 HqkxmuiAjN8NLTpTtirvaxniPrTlfPWQkVNjmT/JrWsQpESOcQMTvN3Xzro1si0o05ADHJjS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285190>

Hi Eric & Junio,

On Sun, 31 Jan 2016, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > These tests are concerned specifically with filtering, sorting,
> > formatting behavior of git-for-each-ref, yet if GPG is not present,
> > the entire test script is skipped even though none of the tests depend
> > upon or care whether the tags are signed. This unnecessary dependency
> > upon GPG may prevent these tests from being more widely run, so drop
> > it.
> 
> [...]
>
> Would it make sense to introduce a helper function specific to this
> script to be used to prepare the expected output, to replace cat <<,
> that goes like this?
> 
> [...]

An even easier solution might be to *not* set up the signed tags in the
'setup' part, but only in the respective test case, and delete them right
away after said test case?

Something like this (I even tested this with and without the GPG prereq):

-- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Do not make t6302 depend on gpg wholesale

There is but a single test case, in fact, that depends on gpg. Let's just
make the other test cases independent of gpg and add the GPG prereq to
said single test case.

Noticed by Eric Sunshine.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6302-for-each-ref-filter.sh | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fe4796c..e3a5636 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -5,20 +5,12 @@ test_description='test for-each-refs usage of ref-filter APIs'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-if ! test_have_prereq GPG
-then
-	skip_all="skipping for-each-ref tests, GPG not available"
-	test_done
-fi
-
 test_expect_success 'setup some history and refs' '
 	test_commit one &&
 	test_commit two &&
 	test_commit three &&
 	git checkout -b side &&
 	test_commit four &&
-	git tag -s -m "A signed tag message" signed-tag &&
-	git tag -s -m "Annonated doubly" double-tag signed-tag &&
 	git checkout master &&
 	git update-ref refs/odd/spot master
 '
@@ -33,7 +25,10 @@ test_expect_success 'filtering with --points-at' '
 	test_cmp expect actual
 '
 
-test_expect_success 'check signed tags with --points-at' '
+test_expect_success GPG 'check signed tags with --points-at' '
+	git tag -s -m "A signed tag message" signed-tag side &&
+	git tag -s -m "Annonated doubly" double-tag signed-tag &&
+	test_when_finished git tag -d signed-tag &&
 	sed -e "s/Z$//" >expect <<-\EOF &&
 	refs/heads/side Z
 	refs/tags/four Z
@@ -58,9 +53,7 @@ test_expect_success 'filtering with --merged' '
 test_expect_success 'filtering with --no-merged' '
 	cat >expect <<-\EOF &&
 	refs/heads/side
-	refs/tags/double-tag
 	refs/tags/four
-	refs/tags/signed-tag
 	EOF
 	git for-each-ref --format="%(refname)" --no-merged=master >actual &&
 	test_cmp expect actual
@@ -71,9 +64,7 @@ test_expect_success 'filtering with --contains' '
 	refs/heads/master
 	refs/heads/side
 	refs/odd/spot
-	refs/tags/double-tag
 	refs/tags/four
-	refs/tags/signed-tag
 	refs/tags/three
 	refs/tags/two
 	EOF
@@ -90,10 +81,8 @@ test_expect_success 'left alignment is default' '
 	refname is refs/heads/master  |refs/heads/master
 	refname is refs/heads/side    |refs/heads/side
 	refname is refs/odd/spot      |refs/odd/spot
-	refname is refs/tags/double-tag|refs/tags/double-tag
 	refname is refs/tags/four     |refs/tags/four
 	refname is refs/tags/one      |refs/tags/one
-	refname is refs/tags/signed-tag|refs/tags/signed-tag
 	refname is refs/tags/three    |refs/tags/three
 	refname is refs/tags/two      |refs/tags/two
 	EOF
@@ -106,10 +95,8 @@ test_expect_success 'middle alignment' '
 	| refname is refs/heads/master |refs/heads/master
 	|  refname is refs/heads/side  |refs/heads/side
 	|   refname is refs/odd/spot   |refs/odd/spot
-	|refname is refs/tags/double-tag|refs/tags/double-tag
 	|  refname is refs/tags/four   |refs/tags/four
 	|   refname is refs/tags/one   |refs/tags/one
-	|refname is refs/tags/signed-tag|refs/tags/signed-tag
 	|  refname is refs/tags/three  |refs/tags/three
 	|   refname is refs/tags/two   |refs/tags/two
 	EOF
@@ -122,10 +109,8 @@ test_expect_success 'right alignment' '
 	|  refname is refs/heads/master|refs/heads/master
 	|    refname is refs/heads/side|refs/heads/side
 	|      refname is refs/odd/spot|refs/odd/spot
-	|refname is refs/tags/double-tag|refs/tags/double-tag
 	|     refname is refs/tags/four|refs/tags/four
 	|      refname is refs/tags/one|refs/tags/one
-	|refname is refs/tags/signed-tag|refs/tags/signed-tag
 	|    refname is refs/tags/three|refs/tags/three
 	|      refname is refs/tags/two|refs/tags/two
 	EOF
@@ -140,10 +125,8 @@ test_expect_success 'alignment with format quote' "
 	|'      '\''master| A U Thor'\''      '|
 	|'       '\''side| A U Thor'\''       '|
 	|'     '\''odd/spot| A U Thor'\''     '|
-	|'        '\''double-tag| '\''        '|
 	|'       '\''four| A U Thor'\''       '|
 	|'       '\''one| A U Thor'\''        '|
-	|'        '\''signed-tag| '\''        '|
 	|'      '\''three| A U Thor'\''       '|
 	|'       '\''two| A U Thor'\''        '|
 	EOF
@@ -156,10 +139,8 @@ test_expect_success 'nested alignment with quote formatting' "
 	|'         master               '|
 	|'           side               '|
 	|'       odd/spot               '|
-	|'     double-tag               '|
 	|'           four               '|
 	|'            one               '|
-	|'     signed-tag               '|
 	|'          three               '|
 	|'            two               '|
 	EOF
@@ -172,10 +153,8 @@ test_expect_success 'check `%(contents:lines=1)`' '
 	master |three
 	side |four
 	odd/spot |three
-	double-tag |Annonated doubly
 	four |four
 	one |one
-	signed-tag |A signed tag message
 	three |three
 	two |two
 	EOF
@@ -188,10 +167,8 @@ test_expect_success 'check `%(contents:lines=0)`' '
 	master |
 	side |
 	odd/spot |
-	double-tag |
 	four |
 	one |
-	signed-tag |
 	three |
 	two |
 	EOF
@@ -204,10 +181,8 @@ test_expect_success 'check `%(contents:lines=99999)`' '
 	master |three
 	side |four
 	odd/spot |three
-	double-tag |Annonated doubly
 	four |four
 	one |one
-	signed-tag |A signed tag message
 	three |three
 	two |two
 	EOF
-- 
2.7.0.windows.1.7.g55a05c8
