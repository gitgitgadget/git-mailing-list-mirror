From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/4] Git for Windows fixes in preparation for 2.8.0
Date: Wed, 23 Mar 2016 11:54:53 +0100 (CET)
Message-ID: <cover.1458730457.git.johannes.schindelin@gmx.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:55:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigRb-00069W-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbcCWKzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:55:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:51175 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbcCWKzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:55:13 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LhfZR-1ZweJs1z7J-00msOk; Wed, 23 Mar 2016 11:54:57
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1458668543.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Di39Pl5SRMuEysjaR0q/YlP/BIO2ssqH50sGRVaJ+9/lY9VcMGm
 CIpJyO0NEQ6F2NpUsJ1W6ATCOylI3jMohcrz4Hr/z4JdcFQbgQb969ytp7viqScKUFFtgXB
 vy7GxFLageEuVmcBcjXhe7gDHpzYtLbewePKsWpSx220yRs4S+j22+v/qA9u31hra+zTIeS
 d1redSlIouksIpZZr/ZyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mT8D0zlEMi4=:XM1BZyAyk/+1cTwSlfWDpX
 xEtRc7YjH+N4JuFZuotDgi1NMwG9XRJyriaw3zcOpD3WXyiA3sBeZQmg6T1WNB5i0i+S4M4bF
 NHyHpD/uvaZ9u4dcBt79rtndLywri1yBYPRydfcTwRoAW+s/tspIRf5Ru43G/0Aog0LvIWBHe
 OGliiPNyijKwPzXH1MJHoONlviqHu1yhkqzaRR6N0k8VJHwub2rMbnX+fkSOzXdnhOHMsFogS
 nphp1mexax4GF318tTKUaRQV+D0KpVVP0hhhmSdVyu9Ut9Ym4V6dU+Ajzcr8Hd4hIR+SPlXyE
 GxcQRpR2BMw75ENPmm8kTwq9FbglcA14+UomziyyRucI9/gxCJ0BtAamlTIyMyQ+LPKNFaPRQ
 DBtaiWOfhbzYIxN/HP+JfPVxnb3OOO+pgTAY04S0mBw6hGLpGofJtbEdBZUo45vIQnlbGAEFe
 QgeAhZkZFNEzHftw+Pu2ERgZvdU777XVIznLrUko/M11AwtE0jDKgPFlA5nIygMCXctq2RUGn
 pvHLTcIi5PDE4RNM6DHGLIqKnqNI7DI199xhcoWpdRsV/9wvW0ClTMHQ+oMxkumFKZQ+z4APp
 dgg2t+6SzB4kkUv6H22NDIX5WhehfvE6akUOi9mtNSbjOaSRueIVrK8W7SUNl/Hw7AmU0yStW
 vVC+6882Y13LRVBa/s0XHusqsqs7ze5lgHhzFvH5AAdh3XgKywawV9mFqzAaBqBvABfNZBU1O
 ltxAFUG3A7ukT1ocI59p4OgIHveR6cPozUZ3/i/2roxxo7IGgjg52Aqzhx8stNhHLoWuxXtE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289640>

The t1300 and t9115 tests regressed on Windows. These patches fix that.


Johannes Schindelin (4):
  config --show-origin: report paths with forward slashes
  Make t1300-repo-config resilient to being run via 'sh -x'
  t1300: fix the new --show-origin tests on Windows
  mingw: skip some tests in t9115 due to file name issues

 compat/mingw.h                           |  6 ++++++
 path.c                                   |  3 +++
 t/t1300-repo-config.sh                   | 18 +++++++++---------
 t/t9115-git-svn-dcommit-funky-renames.sh |  4 ++--
 4 files changed, 20 insertions(+), 11 deletions(-)

Interdiff vs v1:

 diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
 index 18eb769..a37ebb2 100755
 --- a/t/t1300-repo-config.sh
 +++ b/t/t1300-repo-config.sh
 @@ -700,12 +700,12 @@ test_expect_success 'invalid unit' '
  	git config aninvalid.unit >actual &&
  	test_cmp expect actual &&
  	test_must_fail git config --int --get aninvalid.unit 2>actual &&
 -	grep "^fatal: bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit$" actual
 +	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
  '
  
  test_expect_success 'invalid stdin config' '
  	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
 -	grep "^fatal: bad config line 1 in standard input $" output
 +	test_i18ngrep "bad config line 1 in standard input" output
  '
  
  cat > expect << EOF
 @@ -1205,6 +1205,9 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
  	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
  '
  
 +! test_have_prereq MINGW ||
 +HOME="$(pwd)" # convert to Windows path
 +
  test_expect_success 'set up --show-origin tests' '
  	INCLUDE_DIR="$HOME/include" &&
  	mkdir -p "$INCLUDE_DIR" &&
 @@ -1232,14 +1235,6 @@ test_expect_success 'set up --show-origin tests' '
  	EOF
  '
  
 -if test_have_prereq MINGW
 -then
 -	# convert to Windows paths
 -	HOME="$(pwd)"
 -	INCLUDE_DIR="$HOME/include"
 -	export HOME INCLUDE_DIR
 -	git config -f .gitconfig include.path "$INCLUDE_DIR/absolute.include"
 -fi
  
  test_expect_success '--show-origin with --list' '
  	cat >expect <<-EOF &&
 diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
 index 864395e..a87d3d3 100755
 --- a/t/t9115-git-svn-dcommit-funky-renames.sh
 +++ b/t/t9115-git-svn-dcommit-funky-renames.sh
 @@ -93,7 +93,7 @@ test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
  # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
  # > "Private use area") when creating or accessing files.
  prepare_a_utf8_locale
 -test_expect_success UTF8,!MINGW 'svn.pathnameencoding=cp932 new file on dcommit' '
 +test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 new file on dcommit' '
  	LC_ALL=$a_utf8_locale &&
  	export LC_ALL &&
  	neq=$(printf "\201\202") &&
 @@ -105,7 +105,7 @@ test_expect_success UTF8,!MINGW 'svn.pathnameencoding=cp932 new file on dcommit'
  '
  
  # See the comment on the above test for setting of LC_ALL.
 -test_expect_success !MINGW 'svn.pathnameencoding=cp932 rename on dcommit' '
 +test_expect_success !MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 rename on dcommit' '
  	LC_ALL=$a_utf8_locale &&
  	export LC_ALL &&
  	inf=$(printf "\201\207") &&

-- 
2.7.4.windows.1
