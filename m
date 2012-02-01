From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Wed, 1 Feb 2012 17:35:15 -0600
Message-ID: <20120201233515.GC29599@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 00:35:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsjiD-0007mB-1y
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 00:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab2BAXfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 18:35:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43726 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab2BAXfb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 18:35:31 -0500
Received: by iacb35 with SMTP id b35so2187414iac.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 15:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2yqzN68Aw8E8edetP37hRffeI7oan/8zG07KijiqnJQ=;
        b=BS55tCkWw3Zck98kLNnGsx1zDfDoMR5f9KGEhvxvxe7YZqVuHB7w1Q8oUnArPCRONc
         59U+B3bjBAUUavifSBwqaYsaswtlQaR+ozw3FbH0MCK3Jwks4CFOdUIFL9WdbINQDdCo
         M0i//alMKyWHROIsXstfKhhZOgLfClzgxQXhs=
Received: by 10.50.15.169 with SMTP id y9mr9710176igc.9.1328139331130;
        Wed, 01 Feb 2012 15:35:31 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k3sm8606835igq.1.2012.02.01.15.35.30
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 15:35:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328100907-20397-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189555>

(dropping Thomas from cc)
Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  And this patch's diffstat looks just scary due to test suite's updat=
es.

Not about this patch, but: let's see if we can chisel away at that.

Hidden below are also two minor bug reports about the patch.  See (*)
and (**) below.

> --- a/t/t0023-crlf-am.sh
> +++ b/t/t0023-crlf-am.sh
> @@ -12,7 +12,7 @@ Subject: test1
> =20
>  ---
>   foo |    1 +
> - 1 files changed, 1 insertions(+), 0 deletions(-)
> + 1 file changed, 1 insertion(+)
>   create mode 100644 foo

This patchfile is sample input to "git am", and this patch hunk
changes it to match the modified format-patch output format.  But
don't we want "git am" to work with old patches, too?  So this hunk is
unnecessary.

[...]
> --- a/t/t1200-tutorial.sh
> +++ b/t/t1200-tutorial.sh
> @@ -156,7 +156,7 @@ Updating VARIABLE..VARIABLE
>  FASTFORWARD (no commit created; -m option ignored)
>   example |    1 +
>   hello   |    1 +
> - 2 files changed, 2 insertions(+), 0 deletions(-)
> + 2 files changed, 2 insertions(+)
>  EOF

Yes, this one's necessary.

(*) It's reminding us to update the gitcore-tutorial. :)

[...]
> --- a/t/t3300-funny-names.sh
> +++ b/t/t3300-funny-names.sh
> @@ -167,7 +167,7 @@ test_expect_success TABS_IN_FILENAMES 'git diff-t=
ree delete with-funny' \
>  test_expect_success TABS_IN_FILENAMES 'setup expect' '
>  cat >expected <<\EOF
>   "tabs\t,\" (dq) and spaces"
> - 1 files changed, 0 insertions(+), 0 deletions(-)
> + 1 file changed, 0 insertions(+), 0 deletions(-)
>  EOF
>  '

I'm not sure why this and other tests in the same file use "git apply
--stat" to check their work.  The descriptions refer to diff-tree but
the tests themselves use diff-index | apply --stat.  Puzzling.

[...]
> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -38,13 +38,13 @@ test_expect_success 'cherry-pick first..fourth wo=
rks' '
>  	cat <<-\EOF >expected &&
>  	[master OBJID] second
>  	 Author: A U Thor <author@example.com>
> -	 1 files changed, 1 insertions(+), 0 deletions(-)
> +	 1 file changed, 1 insertion(+)
>  	[master OBJID] third
>  	 Author: A U Thor <author@example.com>
> -	 1 files changed, 1 insertions(+), 0 deletions(-)
> +	 1 file changed, 1 insertion(+)
>  	[master OBJID] fourth
>  	 Author: A U Thor <author@example.com>
> -	 1 files changed, 1 insertions(+), 0 deletions(-)
> +	 1 file changed, 1 insertion(+)
>  	EOF

Probably should be split out as a separate test so cherry-pick's
behavior and progress reporting can be tested separately.  Aside from
that detail, makes sense.

[...]
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -444,7 +444,7 @@ test_expect_success 'stash show - stashes on stac=
k, stash-like argument' '
>  	git reset --hard &&
>  	cat >expected <<-EOF &&
>  	 file |    1 +
> -	 1 files changed, 1 insertions(+), 0 deletions(-)
> +	 1 file changed, 1 insertion(+)

Hm.  "git stash show" defaults to --stat, but these tests are not
really about that.  Maybe there should be one test that checks that
the default uses --stat and others could use --numstat or similar?

This will be a problem with GETTEXT_POISON (except your patch bypasses
poison so it got missed --- will send a relevant fix as a reply).

[...]
> +++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_side
> +++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
> +++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
[...]
> +++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..side
> +++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_in=
itial..master
> +++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3D=
TESTCASE_initial..master
[...]

Testing the --stat option.  Can't really be avoided.  (Though maybe
some more modular tests for these combinations can be made some day.)

[...]
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -520,7 +520,7 @@ test_expect_success 'shortlog of cover-letter wra=
ps overly-long onelines' '
>  cat > expect << EOF
>  ---
>   file |   16 ++++++++++++++++
> - 1 files changed, 16 insertions(+), 0 deletions(-)
> + 1 file changed, 16 insertions(+)

Not relevant to the detail being tested, should probably be fuzzed
out.

[...]
> --- a/t/t4030-diff-textconv.sh
> +++ b/t/t4030-diff-textconv.sh
> @@ -86,7 +86,7 @@ test_expect_success 'status -v produces text' '
> =20
>  cat >expect.stat <<'EOF'
>   file |  Bin 2 -> 4 bytes
> - 1 files changed, 0 insertions(+), 0 deletions(-)
> + 1 file changed, 0 insertions(+), 0 deletions(-)
>  EOF
>  test_expect_success 'diffstat does not run textconv' '
>  	echo file diff=3Dfail >.gitattributes &&

Testing diffstat.  Would be nice to have an accompanying test of
numstat.

[...]
> --- a/t/t4045-diff-relative.sh
> +++ b/t/t4045-diff-relative.sh
> @@ -33,7 +33,7 @@ check_stat() {
>  expect=3D$1; shift
>  cat >expected <<EOF
>   $expect |    1 +
> - 1 files changed, 1 insertions(+), 0 deletions(-)
> + 1 file changed, 1 insertion(+)
>  EOF

Not the detail being tested, so technically it would be nicer to
fuzz the last line out.

[...]
> --- a/t/t4049-diff-stat-count.sh
> +++ b/t/t4049-diff-stat-count.sh
> @@ -16,7 +16,7 @@ test_expect_success setup '
>  	cat >expect <<-\EOF
>  	 a |    1 +
>  	 b |    1 +
> -	 2 files changed, 2 insertions(+), 0 deletions(-)
> +	 2 files changed, 2 insertions(+)
>  	EOF
>  	git diff --stat --stat-count=3D2 >actual &&
>  	test_cmp expect actual

Testing diffstat.  Looks sane.

[...]
> +++ b/t/t4100/t-apply-8.expect
> @@ -1,2 +1,2 @@
>   t/t4100-apply-stat.sh |    2 +-
> - 1 files changed, 1 insertions(+), 1 deletions(-)
> + 1 file changed, 1 insertion(+), 1 deletion(-)
[...]
> +++ b/t/t4100/t-apply-9.expect
> @@ -1,2 +1,2 @@
>   t/t4100-apply-stat.sh |    2 +-
> - 1 files changed, 1 insertions(+), 1 deletions(-)
> + 1 file changed, 1 insertion(+), 1 deletion(-)

Testing apply --stat.  Tests of apply --numstat would be more
interesting, but then we'd still need some tests like these to make
sure --stat is consistent with it, so it still seems sane.

> --- a/t/t5150-request-pull.sh
> +++ b/t/t5150-request-pull.sh
> @@ -95,7 +95,7 @@ test_expect_success 'setup: two scripts for reading=
 pull requests' '
>  	b
>  	: diffstat
>  	n
> -	/ [0-9]* files changed/ {
> +	/ [0-9]* files\? changed/ {

Mimicking a human.

(**) Should probably use "*" instead of \? --- \? is a GNU extension,
not a BRE.

[...]
> +++ b/t/t7602-merge-octopus-many.sh
> @@ -57,7 +57,7 @@ Merge made by the 'octopus' strategy.
>   c2.c |    1 +
>   c3.c |    1 +
>   c4.c |    1 +
> - 3 files changed, 3 insertions(+), 0 deletions(-)
> + 3 files changed, 3 insertions(+)
>   create mode 100644 c2.c
>   create mode 100644 c3.c
>   create mode 100644 c4.c

Test is about the "Trying simple merge with" lines, not the final
diffstat summary.  Should probably be fuzzed out.

Thanks, that was interesting.

Jonathan
