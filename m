Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3E71FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbcHILdv (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:33:51 -0400
Received: from mout.web.de ([212.227.17.12]:59618 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932306AbcHILdq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:33:46 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LkyIj-1ayZHi36Qv-00aoKe; Tue, 09 Aug 2016 13:33:39
 +0200
Date:	Tue, 9 Aug 2016 11:33:37 +0000
From:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160809113337.GA1143@tb-raspi>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <20160808203224.GA28431@tb-raspi>
 <20160809065110.GB17777@peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160809065110.GB17777@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:I4dkU7ICLJITOSYbMlOEwH50Mknl+m7hf+qxXMxJ14n/5JAWRR0
 HgNdb435ai/Q8lDzfm0wz1VwfWtbO+FDlw+Mqn5Dmixznf6d3MpScBmpJQbJA0zjMiRlen3
 9eWzrI2F2Jmi7kKGieo5VynIawO4g8PMdrsm4E7rugkAFx2AfqpfcvrLYoKM2brow4VLn9d
 9KCzcKGHmmhudO7ZnehaA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:9JGezaiHPiM=:XyhGJDsOJXPaE8kZt6EH7C
 f7Du/mUGLYGHDrRN9zczYwPvMDUtOqYJ0oQYJA2EfPeF1rf9cUJifjMdI/ipWhnbK0Iu95qCr
 AXvvFWKzWJazc+FhpxJyNT6XCUyRoxNPwhFpjZB73+yC++U5aomwuyLqbUF1tLVEtak3kNdi8
 uwuFz0qiMlNU0do4ps6DoZtz1yAtzy2Ih/k402KmNLXKK3+SD5xFn0Up0/f2telfIamDt1yfS
 H4zmRTJKdchnKEqA5BiXORCPup874gONHBJ5sbABx9mrZJnVuysNAUaakMdANH1NQoFw+u4QR
 ZIkL2DV5Ipcz7MXrDKHahsZvsQEUbAU3kUlzS81AZEG/KpveGSB+OL1D/DhYmjMGh4DOvEHsq
 ez4MZKNoPpPtTjkQuAorgn8ugRk3wnJDhTmJJjRyip2Is0MffhNdvI91/t2KKl3HUp0YVkzfd
 T0bhXKrWb317eT8CTIK1Oevyas4281aBjzr/q7DJH+OaqSnQj3Qa2IkgFskn2dryqJijBwuiU
 aplSeaK1EGn4oAsOubAXjSpWoLeOvm4n2QDQ8TW7EX+bFUgZx4DYtMSrzdzjSf8WY4X6TwSU/
 32yL40kapnRWilIW2eG7gBT3qokkTyJdLucjHdpwjxCgdtySaUC6jSNab66/op229GV63kEdB
 l4fCngGZvPw9UvHmMjZB3uyxL5KzUAz+A6mQ5fQ+5lM5aEeYi0VWF5Vyr32Y8DLdYVFnlYBIe
 qH5y62m6tJwfVjRe5OBM4RfNTJxVnBYkugN96Dm3HNHzxGgyleqvx2ZnDqw=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 02:51:10AM -0400, Jeff King wrote:
> On Mon, Aug 08, 2016 at 08:32:24PM +0000, Torsten Bögershausen wrote:
> 
> > > The verbose output is not very exciting, though:
> > > 
> > > 	expecting success: 
> > > 	                check_warning "$lfwarn" ${pfx}_LF.err
> > > 
> > > 	--- NNO_attr_auto_aeol_crlf_false_LF.err.expect 2016-08-08 15:26:37.061701392 +0000
> > > 	+++ NNO_attr_auto_aeol_crlf_false_LF.err.actual 2016-08-08 15:26:37.061701392 +0000
> > > 	@@ -1 +0,0 @@
> > > 	-warning: LF will be replaced by CRLF
> > > 	not ok 114 - commit NNO files crlf=false attr=auto LF
> > [...]
> > The warning is missing, but should be there:
> > 
> > The file has LF, and after commit and a new checkout these LF will
> > be convertet into CRLF.
> > 
> > So why isn't the warning there (but here on my oldish machines)
> 
> To be clear, the warning _is_ there when I just run t0027 by itself, and
> the test passes.  It's only under heavy load that it isn't. So it's a
> race condition either in the test script or in git itself.
> 
> Usually race conditions like these are due to one of:
> 
>   - git dying from SIGPIPE before it has a chance to output the command.
>     But I don't see any pipes being used in the test script.
> 
>   - index raciness causing us to avoid reading file content. For
>     example, if you do:
> 
>       echo foo >bar
>       git add bar
> 
>     Then _usually_ "bar" and the index will have the same mtime. And
>     therefore subsequent commands that need to refresh the index will
>     re-read the content of "bar", because they cannot tell from the stat
>     information if we have the latest version of "bar" in the index or
>     not (it could have been written after the index update, but in the
>     same second).
> 
>     But on a slow or heavily loaded system (or if you simply get unlucky
>     in crossing the boundary to a new second), they'll have different
>     mtimes. And therefore git knows it can skip reading the content from
>     the filesystem.
> 
>     So if your test relies on git actually re-converting the file
>     content, it would sometimes randomly fail.
> 
> The second one seems plausible, given the history of issues with
> changing CRLF settings for an existing checkout. I'm not sure if it
> would be feasible to reset the index completely before each tested
> command, but that would probably solve it.
The content of the file has been changed (we appended the letter 'Z' to it,
so even if mtime is the same, st.st_size should differ.
And it seems as if the commit is triggered, see below.
> 

(I got the stress script working; no I can reproduce it nicely)

Is it possible to vote for a 3rd option ?
I added some more warnings, to have always some output in stderr. 

This is the good case, this test case passed:
cat NNO_attr_auto_aeol_crlf_true_LF.err 

warning: check_safe_crlf in NNO_attr_auto_aeol_crlf_true_LF.txt 2
warning: LF was here in NNO_attr_auto_aeol_crlf_true_LF.txt..
warning: LF will be replaced by CRLF in NNO_attr_auto_aeol_crlf_true_LF.txt.
The file will have its original line endings in your working directory.
warning: check_safe_crlf in NNO_attr__aeol_crlf_true_CRLF.txt 0
warning: check_safe_crlf in NNO_attr__aeol_crlf_true_CRLF_mix_LF.txt 0
warning: check_safe_crlf in NNO_attr__aeol_crlf_true_LF.txt 0
warning: check_safe_crlf in NNO_attr__aeol_lf_true_CRLF.txt 0
warning: check_safe_crlf in NNO_attr__aeol_lf_true_CRLF_mix_LF.txt 0
warning: check_safe_crlf in NNO_attr__aeol_lf_true_LF.txt 0
warning: check_safe_crlf in NNO_attr_auto_aeol_lf_true_LF.txt 0
[master 2decee0] commit_NNO_attr_auto_aeol_crlf_true_LF.txt
 Author: A U Thor <author@example.com>
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
And this one failed, the same code base, but a different file:
cat commit_NNO_attr_auto_aeol_crlf_input_LF.

[master ce2045a] commit_NNO_attr_auto_aeol_crlf_input_LF.txt
 Author: A U Thor <author@example.com>
 1 file changed, 2 insertions(+), 2 deletions(-)

---------------------------
Both had been generated with a patched convert.c:
git diff convert.c
index 67d69b5..ae64a58 100644
--- a/convert.c
+++ b/convert.c
@@ -191,6 +191,7 @@ static enum eol output_eol(enum crlf_action crlf_action)
 static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
                             struct text_stat *stats, enum safe_crlf checksafe)
 {
+       warning("check_safe_crlf in %s %d", path, (int)checksafe);
        if (!checksafe)
                return;
 
@@ -210,6 +211,7 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
                 * CRLFs would be added by checkout:
                 * check if we have "naked" LFs
                 */
+               warning("LF was here in %s..", path);
                if (stats->lonelf) {
                        if (checksafe == SAFE_CRLF_WARN)
                                warning("LF will be replaced by CRLF in %s.\nThe

---------------------

In the failing case, there is no warning at all printed,
even if I would have expected the list of files to be printed.

The commit has been done, I think.

See t0027, around line 124:
		cp $f $fname &&
		printf Z >>"$fname" &&
		git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
		git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1

Both stdout and stderr are piped into the .err file.
The content of stdout seems to be there always.
The content of stderr seems to be there most of the time.
When the test case fails, the content of stderr seems to be completely missing.

Reverting  f4c3edc0b156362a92bf9de4f0ec794e90a757f does not fix the problem
Reverting f4c3edc0b15 and 3b331e9267146961466 does not fix the problem.
