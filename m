From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Mon, 28 May 2012 17:47:29 -0500
Message-ID: <20120528224729.GK14606@burratino>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 00:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ8j1-0006gP-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 00:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933Ab2E1Wri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 18:47:38 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47355 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab2E1Wrh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2012 18:47:37 -0400
Received: by yenm10 with SMTP id m10so1647393yen.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 15:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vjr303hd4KfU6hFym4X40iaGNdo8AlAxTvsKll+d0nM=;
        b=q/xVRYhq1BzqzXsEIsrWOAj+5e9Jgly7IDhmXY8yUMRx1ffNNgJ1pAlmEP3DMpTG8o
         zB1+qxTArWicSX05K0Dhnqd+8a9BxrbBRR5qbBP0uWtcA2qBA50eW/SYTaYaHkyFFNDo
         azYt2VwDaOPXXpIPeNiqzrrGtQGTeNJabQ32o4xm1pXILiTf3zqYX6YTM9b334mjSVMh
         swjCEOYSz6LNDq+MTyelbzLXFObOBr9uVSGPyYSmjjFvn8gcsCPGZOanDn18pCX8+NWE
         FNTYm8dtTwBPWgPKaIjD+zLplfsEMtvLluCHefOvuok6/IVUdnClUKoHdeu/yT2DDHLt
         RQhg==
Received: by 10.50.46.230 with SMTP id y6mr5459356igm.20.1338245256725;
        Mon, 28 May 2012 15:47:36 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fv9sm2605907igc.8.2012.05.28.15.47.35
        (version=SSLv3 cipher=OTHER);
        Mon, 28 May 2012 15:47:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198728>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  rc times are usually more quiet times, let's slip the series in..
>  minor conflict with revert topic in pu, but should be easy to
>  resolve.

Thanks.  Some semi-automated checks follow. :)

"git log --name-status" reveals that files these patches change don't
overlap.  Good.

=46iltering out changes involving N, _, (, and ) by running "git diff
--word-diff-regex=3D'[^N_()]' origin/master", the remaining changes are
in

	builtin/for-each-ref.c
	builtin/ls-tree.c
	builtin/notes.c
	builtin/rev-parse.c
	builtin/show-branch.c

These are whitespace adjustments to keep continuation lines lined up
given the extra "N_(" characters, except for the for-each-ref.c change
which is an unrelated conversion of 8 spaces to a tab (also seems
fine).

GETTEXT_POISON is annoyed by

  t0006.1-11 relative dates

	test-date show $t >actual &&
	test_cmp expect actual

  t0040.1 test help

	test_must_fail test-parse-options -h > output 2> output.err &&
	test_cmp expect output

  t0040.11-12 handling of unknown options

	test_must_fail test-parse-options $* >output 2>output.err &&
	test_cmp expect output.err

  t0040.27 form of errors from OPT_CALLBACK

	test_cmp expect.err output.err

  t1300.48 no arguments, but no crash

	grep usage output

  t1502.1 --parseopt help output

	test_expect_code 129 git rev-parse --parseopt -- -h > output < options=
pec &&
	test_cmp expect output

  t2006.1,2 checkout-index --gobbledegook, -h

	grep "[Uu]sage" err

  t2107.2 update-index --nonsense dumps usage

	grep "[Uu]sage: git update-index" err

  t3004.3 ls-files with nonsense option

	grep "[Uu]sage: git ls-files" actual

  t3004.4 ls-files -h in corrupt repository

	grep "[Uu]sage: git ls-files " broken/usage

  t3200.3 branch -h in broken repository

	grep "[Uu]sage" broken/usage

  t3200.10 branch -m dumps usage

	grep "[Uu]sage: git branch" err'

  t3501.2,3 cherry-pick/revert --nonsense

	test_must_fail git cherry-pick --nonsense 2>msg &&
	grep '[Uu]sage:' msg

  t4006.4-7 diff --stat, --shorstat

	git diff HEAD --stat >actual &&
	test_cmp expect actual

  t4120.3,5 apply with too large -p

	grep "removing 3 leading" err

  t4012.5-6 apply detects corrupt patch

	 detected=3D`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&

  t4133.2 apply diff with consistent filename in headers

	grep "inconsistent new filename" err &&

  t4200.24,25 rerere --no-no-rerere-autoupdate, -h

	grep [Uu]sage err &&

  t4202.33 log --graph with diff and stats

	sed -e 's/ *$//' \
	    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
	    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
	    -e 's/Merge tag.*/Merge HEADS DESCRIPTION/' \
	    -e 's/Merge commit.*/Merge HEADS DESCRIPTION/' \
	    -e 's/, 0 deletions(-)//' \
	    -e 's/, 0 insertions(+)//' \
	    -e 's/ 1 files changed, / 1 file changed, /' \
	    -e 's/, 1 deletions(-)/, 1 deletion(-)/' \
	    -e 's/, 1 insertions(+)/, 1 insertion(+)/'

  t4205.12 NUL separation with --stat

	expecting success:=20
		  stat0_part=3D$(git diff --stat HEAD^ HEAD) &&
		  stat1_part=3D$(git diff --stat --root HEAD^) &&
		  printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n" >expected &=
&
		  git log -z --stat --pretty=3D"format:%s" >actual &&
		  test_cmp expected actual

	Binary files expected and actual differ
	not ok - 12 NUL separation with --stat
	$ xxd trash\ directory.t4205-log-pretty-formats/expected
	0000000: 6164 6420 6261 720a 2320 4745 5454 4558  add bar.# GETTEX
	0000010: 5420 504f 4953 4f4e 2023 0a00 696e 6974  T POISON #..init
	0000020: 6961 6c0a 2320 4745 5454 4558 5420 504f  ial.# GETTEXT PO
	0000030: 4953 4f4e 2023 0a                        ISON #.
	$ xxd trash\ directory.t4205-log-pretty-formats/actual=20
	0000000: 6164 6420 6261 720a 2320 4745 5454 4558  add bar.# GETTEX
	0000010: 5420 504f 4953 4f4e 2023 0069 6e69 7469  T POISON #.initi
	0000020: 616c 0a23 2047 4554 5445 5854 2050 4f49  al.# GETTEXT POI
	0000030: 534f 4e20 23                             SON #

  t5300.32 index-pack detects the SHA1 collision

	grep "SHA1 COLLISION FOUND" msg

  t5505.2-3,6-9,13,15,46 remote porcelain-ish

	actual=3D$(git remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p=
')
	shift &&
	tokens_match "$*" "$actual"

  r6500.2-3 gc --gobbledegook, -h

	grep "[Uu]sage: git gc" err

  t7508.5 status --column

	COLUMNS=3D50 git status --column=3D"column dense" >output &&
	test_cmp expect output

  t7600.3 merge -h

	grep "[Uu]sage: git merge" broken/usage

Assuming we want to require scripts to set LC_ALL=3DC before trying
to parse error messages and descriptions within usage strings (which
seems like a sensible requirement to me), these look like test suite
bugs and not bugs in git itself.  So for what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
