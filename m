Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EC18E28;
	Thu,  2 May 2024 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629391; cv=none; b=daBxZFqs5PeJv6wr1ZL1vn+gu2IGJhcjqBIw5lIpF+G18yxo6EKZ+26YgLEKcaXguP6en74BS6GisR1Oo+zKOiWd7GKw3nq/+GgLb7a6xhN3QyRhZrIVqwA69r7BoKjY0oyjuAZrh9zUPfb1cxmZQFEkbwABEafKzDNsAG9xiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629391; c=relaxed/simple;
	bh=VJVSo+jtSJIClVhIz9JnraE80p7yhL/MTpcdHzpOF9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl33D81IzmrnHTIFfEdUkgGvgXW+RFIj3R++KfvwIrcgIx6HdeeEOe2nV6X4B4x16ZLBQcQfZAxjwTGrqq3MqsM7ajlqCf+K8GA2+sPuqwUt/5X3Ek4BDld1IolQFQ57UxM/7RMtnhG5R6aTVBHC7cJES4II4RtWlcgWWwPFRpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=VUfekoRK; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="VUfekoRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714629383; x=1715234183; i=tboegi@web.de;
	bh=TmnQwYlbB4VpG5QqMTOzXTEYlXiCdiDLf8h18p3l++w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VUfekoRKsQIRHVtX8+vZ3F1xn2+TTynVylAqVK8k+r8Bi0PxbnuCW9ADwhT2YzIC
	 SuRyIbqyoCqi2MqZ85cVLxKmLwb6M/+gze0nA4nIEJwsPPGl9EqHgxFWJBvOIHqUr
	 7L4VxwLCPZ1ZOUuTn6w7s4DewaUAbYo2Kzhonbvd5ckLL4eaSrRrkDmbQ1VZsbL0m
	 NFjAb/qL2z9azHxSp2OvUesRevpkV/L3ZhpEFxayI2yJdkIS3twzuQ69jK1LbgciA
	 AXqrv/75oM2P0oF+kYsMpOnhVB8EPZvr3rQZDzPLmSxzYc6085BI9RmfH9h+3ONLK
	 tKny8x4njDlxwVkeog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3t5-1rpT8q0fu3-0009gz; Thu, 02
 May 2024 07:56:23 +0200
Date: Thu, 2 May 2024 07:56:22 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
	git-packagers@googlegroups.com
Subject: t4216-log-bloom.sh broken ?
Message-ID: <20240502055621.GA29945@tb-raspi4>
References: <xmqq8r0ww0sj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8r0ww0sj.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ocBvdA6JETQ/O4yLTbjHW04RP0OQczDubSP/Cp0RaUp0uVhGs36
 JcOrGEBKCyvYGoaXcypvaUgjhk90UYBE35KBbNIDbXpDmDZIBExkcMZP2NLYtVsIRAzFI/L
 3mmtLzUEgMWX7P03DPsqxzPiIjoHOTiDmSo+dFX3+eStNUN2b9btIfzv2U0Ip+l8dzgYUI+
 lMcy2puMWcz+/dM/p85qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/SwwNXtAT1g=;ZfpclZOUFxdk4bTSXz0Kl7fsh0Q
 rX6rGRCaqgl/fZvzqtL8rzJfk+qnlphj+RfZukDla3Puqzzsdy2GxqMMdgrnDsvEivb9hsfTH
 QvxQM31+2O5d3n8jOE2VCYw5DvWEci0stSXtsIesuCPxPfrS4jX57J/KRpMhqCD11fV+zz2KA
 UB/nbaaWjhsmkrvFD/Tl9kpOBrmdniv8q3JIpvuJHMwB+1U1tok0Lz8iYBdR7G5MXw60VQUh6
 fFj6xsnTWMNEDTPykBSPBS29qUpTsMmFn/2TiF9bf8aaOnViMlZwkqzROj/X76/4kulss+rd/
 /Sg47VpmJNAT3AaxSItJm1EDrJSxqjs2DnBIiTjBHmf8gsXOZkRePSnw95TuReSIcmlqsXFKf
 RiRN7oi5yZVNLmqEuixNVQdymQLIqw4OkohIG0uNvzdag1kUG/xVndG/3Cvp6Y2nivUpM66h7
 pqJTRbEwQJ6G0OKNPIu2rhSE2r93veV4/PT/UzxbU90rXWRPnA+dzBKKwQpStNv27s5zOBUHE
 zX0R8NdsRmUAuEkKjKsQCmqFNzx94p8BUvX3HDhjefZ8wivdGtSeccVnSjHGNDBpWQuXSPblw
 fRVshDoGh+YudAIWA8mwobE3fOL0YmVdeGCSiHR3P5nKdbgngWPfnYrUqYNevHvJOySZvSvHu
 gmW+vgABK3+ulYD4LL58ImO1OzkRmDuJ0W3HEzgKMZ4xCOi9JaNwhyKEz0GmwTNeHpkrM5ZBU
 T4ZuFrrnVgqRksVGheKsr9JtgzwedoYCGCIbF3qZciI6SVSHIXle6UHAyp2oJwM5MKJIdxd5F
 abi1ZOF++892x71ounDfICEpxAHdYU1VTU6a4DC5UJBF8=
Content-Transfer-Encoding: quoted-printable

[]

Highjacking the Git v2.45.0 announcement:
There are 4 test cases in t4216-log-bloom.sh, that do not pass on one
Mac here (they pass on another machine)

I haven't digged further, but here are some log files,
hopefully helpful to somebody.


not ok 141 - Bloom reader notices too-small data chunk
#
#               check_corrupt_graph BDAT clear 00000000 &&
#               echo "warning: ignoring too-small changed-path chunk" \
#                       "(4 < 12) in commit-graph file" >expect.err &&
#               test_cmp expect.err err
#
not ok 142 - Bloom reader notices out-of-bounds filter offsets
#
#               check_corrupt_graph BIDX 12 FFFFFFFF &&
#               # use grep to avoid depending on exact chunk size
#               grep "warning: ignoring out-of-range offset (4294967295) f=
or changed-path filter at pos 3 of .git/objects/info/commit-graph" err

#
not ok 143 - Bloom reader notices too-small index chunk
#
#               # replace the index with a single entry, making most
#               # lookups out-of-bounds
#               check_corrupt_graph BIDX clear 00000000 &&
#               echo "warning: commit-graph changed-path index chunk" \
#                       "is too small" >expect.err &&
#               test_cmp expect.err err
#
not ok 144 - Bloom reader notices out-of-order index offsets
#
#               # we do not know any real offsets, but we can pick
#               # something plausible; we should not get to the point of
#               # actually reading from the bogus offsets anyway.
#               corrupt_graph BIDX 4 0000000c00000005 &&
#               echo "warning: ignoring decreasing changed-path index offs=
ets" \
#                       "(12 > 5) for positions 1 and 2 of .git/objects/in=
fo/commit-graph" >expect.err &&
#               git -c core.commitGraph=3Dfalse log -- A/B/file2 >expect.o=
ut &&
#               git -c core.commitGraph=3Dtrue log -- A/B/file2 >out 2>err=
 &&
#               test_cmp expect.out out &&
#               test_cmp expect.err err
#
# failed 4 among 144 test(s)
1..144


ok 140 - Bloom generation backfills empty commits

expecting success of 4216.141 'Bloom reader notices too-small data chunk':
	check_corrupt_graph BDAT clear 00000000 &&
	echo "warning: ignoring too-small changed-path chunk" \
		"(4 < 12) in commit-graph file" >expect.err &&
	test_cmp expect.err err

++ check_corrupt_graph BDAT clear 00000000
++ corrupt_graph BDAT clear 00000000
++ graph=3D.git/objects/info/commit-graph
++ test_when_finished 'rm -rf .git/objects/info/commit-graph'
++ test 0 =3D 0
++ test_cleanup=3D'{ rm -rf .git/objects/info/commit-graph
		} && (exit "$eval_ret"); eval_ret=3D$?; :'
++ git commit-graph write --reachable --changed-paths
++ corrupt_chunk_file .git/objects/info/commit-graph BDAT clear 00000000
++ fn=3D.git/objects/info/commit-graph
++ shift
++ perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chunk-f=
ile.pl BDAT clear 00000000
++ command /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chun=
k/corrupt-chunk-file.pl BDAT clear 00000000
++ /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrup=
t-chunk-file.pl BDAT clear 00000000
++ mv .git/objects/info/commit-graph.tmp .git/objects/info/commit-graph
override r--r--r--  tb/staff for .git/objects/info/commit-graph? (y/n [n])=
 not overwritten
++ git -c core.commitGraph=3Dfalse log -- A/B/file2
++ git -c core.commitGraph=3Dtrue log -- A/B/file2
++ test_cmp expect.out out
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect.out out
++ echo 'warning: ignoring too-small changed-path chunk' '(4 < 12) in comm=
it-graph file'
++ test_cmp expect.err err
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect.err err
=2D-- expect.err	2024-05-02 05:51:10.000000000 +0000
+++ err	2024-05-02 05:51:10.000000000 +0000
@@ -1 +0,0 @@
-warning: ignoring too-small changed-path chunk (4 < 12) in commit-graph f=
ile
error: last command exited with $?=3D1
++ rm -rf .git/objects/info/commit-graph
++ exit 1
++ eval_ret=3D1
++ :
not ok 141 - Bloom reader notices too-small data chunk


expecting success of 4216.142 'Bloom reader notices out-of-bounds filter o=
ffsets':
	check_corrupt_graph BIDX 12 FFFFFFFF &&
	# use grep to avoid depending on exact chunk size
	grep "warning: ignoring out-of-range offset (4294967295) for changed-path=
 filter at pos 3 of .git/objects/info/commit-graph" err

++ check_corrupt_graph BIDX 12 FFFFFFFF
++ corrupt_graph BIDX 12 FFFFFFFF
++ graph=3D.git/objects/info/commit-graph
++ test_when_finished 'rm -rf .git/objects/info/commit-graph'
++ test 0 =3D 0
++ test_cleanup=3D'{ rm -rf .git/objects/info/commit-graph
		} && (exit "$eval_ret"); eval_ret=3D$?; :'
++ git commit-graph write --reachable --changed-paths
++ corrupt_chunk_file .git/objects/info/commit-graph BIDX 12 FFFFFFFF
++ fn=3D.git/objects/info/commit-graph
++ shift
++ perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chunk-f=
ile.pl BIDX 12 FFFFFFFF
++ command /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chun=
k/corrupt-chunk-file.pl BIDX 12 FFFFFFFF
++ /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrup=
t-chunk-file.pl BIDX 12 FFFFFFFF
++ mv .git/objects/info/commit-graph.tmp .git/objects/info/commit-graph
override r--r--r--  tb/staff for .git/objects/info/commit-graph? (y/n [n])=
 not overwritten
++ git -c core.commitGraph=3Dfalse log -- A/B/file2
++ git -c core.commitGraph=3Dtrue log -- A/B/file2
++ test_cmp expect.out out
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect.out out
++ grep 'warning: ignoring out-of-range offset (4294967295) for changed-pa=
th filter at pos 3 of .git/objects/info/commit-graph' err
error: last command exited with $?=3D1
++ rm -rf .git/objects/info/commit-graph
++ exit 1
++ eval_ret=3D1
++ :
not ok 142 - Bloom reader notices out-of-bounds filter offsets

expecting success of 4216.143 'Bloom reader notices too-small index chunk'=
:
	# replace the index with a single entry, making most
	# lookups out-of-bounds
	check_corrupt_graph BIDX clear 00000000 &&
	echo "warning: commit-graph changed-path index chunk" \
		"is too small" >expect.err &&
	test_cmp expect.err err

++ check_corrupt_graph BIDX clear 00000000
++ corrupt_graph BIDX clear 00000000
++ graph=3D.git/objects/info/commit-graph
++ test_when_finished 'rm -rf .git/objects/info/commit-graph'
++ test 0 =3D 0
++ test_cleanup=3D'{ rm -rf .git/objects/info/commit-graph
		} && (exit "$eval_ret"); eval_ret=3D$?; :'
++ git commit-graph write --reachable --changed-paths
++ corrupt_chunk_file .git/objects/info/commit-graph BIDX clear 00000000
++ fn=3D.git/objects/info/commit-graph
++ shift
++ perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chunk-f=
ile.pl BIDX clear 00000000
++ command /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chun=
k/corrupt-chunk-file.pl BIDX clear 00000000
++ /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrup=
t-chunk-file.pl BIDX clear 00000000
++ mv .git/objects/info/commit-graph.tmp .git/objects/info/commit-graph
override r--r--r--  tb/staff for .git/objects/info/commit-graph? (y/n [n])=
 not overwritten
++ git -c core.commitGraph=3Dfalse log -- A/B/file2
++ git -c core.commitGraph=3Dtrue log -- A/B/file2
++ test_cmp expect.out out
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect.out out
++ echo 'warning: commit-graph changed-path index chunk' 'is too small'
++ test_cmp expect.err err
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect.err err
=2D-- expect.err	2024-05-02 05:51:11.000000000 +0000
+++ err	2024-05-02 05:51:11.000000000 +0000
@@ -1 +0,0 @@
-warning: commit-graph changed-path index chunk is too small
error: last command exited with $?=3D1
++ rm -rf .git/objects/info/commit-graph
++ exit 1
++ eval_ret=3D1
++ :
not ok 143 - Bloom reader notices too-small index chunk

expecting success of 4216.144 'Bloom reader notices out-of-order index off=
sets':
	# we do not know any real offsets, but we can pick
	# something plausible; we should not get to the point of
	# actually reading from the bogus offsets anyway.
	corrupt_graph BIDX 4 0000000c00000005 &&
	echo "warning: ignoring decreasing changed-path index offsets" \
		"(12 > 5) for positions 1 and 2 of .git/objects/info/commit-graph" >expe=
ct.err &&
	git -c core.commitGraph=3Dfalse log -- A/B/file2 >expect.out &&
	git -c core.commitGraph=3Dtrue log -- A/B/file2 >out 2>err &&
	test_cmp expect.out out &&
	test_cmp expect.err err

++ corrupt_graph BIDX 4 0000000c00000005
++ graph=3D.git/objects/info/commit-graph
++ test_when_finished 'rm -rf .git/objects/info/commit-graph'
++ test 0 =3D 0
++ test_cleanup=3D'{ rm -rf .git/objects/info/commit-graph
		} && (exit "$eval_ret"); eval_ret=3D$?; :'
++ git commit-graph write --reachable --changed-paths
++ corrupt_chunk_file .git/objects/info/commit-graph BIDX 4 0000000c000000=
05
++ fn=3D.git/objects/info/commit-graph
++ shift
++ perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chunk-f=
ile.pl BIDX 4 0000000c00000005
++ command /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chun=
k/corrupt-chunk-file.pl BIDX 4 0000000c00000005
++ /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrup=
t-chunk-file.pl BIDX 4 0000000c00000005
++ mv .git/objects/info/commit-graph.tmp .git/objects/info/commit-graph
override r--r--r--  tb/staff for .git/objects/info/commit-graph? (y/n [n])=
 not overwritten
++ echo 'warning: ignoring decreasing changed-path index offsets' '(12 > 5=
) for positions 1 and 2 of .git/objects/info/commit-graph'
++ git -c core.commitGraph=3Dfalse log -- A/B/file2
++ git -c core.commitGraph=3Dtrue log -- A/B/file2
++ test_cmp expect.out out
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect.out out
++ test_cmp expect.err err
++ test 2 -ne 2
++ eval 'diff -u' '"$@"'
+++ diff -u expect.err err
=2D-- expect.err	2024-05-02 05:51:11.000000000 +0000
+++ err	2024-05-02 05:51:11.000000000 +0000
@@ -1 +0,0 @@
-warning: ignoring decreasing changed-path index offsets (12 > 5) for posi=
tions 1 and 2 of .git/objects/info/commit-graph
error: last command exited with $?=3D1
++ rm -rf .git/objects/info/commit-graph
++ exit 1
++ eval_ret=3D1
++ :
not ok 144 - Bloom reader notices out-of-order index offsets
