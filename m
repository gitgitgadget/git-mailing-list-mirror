Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9EF1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 09:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfH0JH2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 05:07:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:58431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfH0JH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 05:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566896840;
        bh=MP4lu8SMdMFBBw+vHzDPxw9m0s/VoJUOI1BV0HFDyFI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S1RCBjVNRb0fA/ybEryZ3UVr21WOcPVZ3RzuQ9PtX37D+r/iGioEfHzhWVGq5YBt7
         8iKO/snzVeiQ10wSDCRGU+Sc+uVDhur/r/j5/x0q/KpEeqvCXWg0agUNo0rXLaUjSv
         8kdsl7nUlsgMcbm5baD/JXWm5yWSGYInCcNi1Ges=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFtf4-1hxXW20dlu-00EvJe; Tue, 27
 Aug 2019 11:07:20 +0200
Date:   Tue, 27 Aug 2019 11:07:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v5 2/3] grep: make PCRE2 aware of custom allocator
In-Reply-To: <20190809030210.18353-3-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908271057280.46@tvgsbejvaqbjf.bet>
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com> <20190809030210.18353-3-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-987959592-1566896842=:46"
X-Provags-ID: V03:K1:3NnF1HNTzLsuxq0D78fnEwIPkRl5A1VP4ztq1Mjf3rtOz8JTNro
 kBJxauYZLW17Nv5CtWDwzbvF/46pmoyQ/2nkElvfuEMiOUIvyan9Z5bMTJy8dId1GB6UOXr
 2Xr2F0jkXv52Y16YnG0+riz6mEwNfO6QRzspBb4+2y/lJ/Tamzkc/aRkFGi5gZ16M/avJ8/
 7lwYI1W8cqTc8U9sYgPAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BSzhIUjBwaM=:0R5bzE8bk44YeAC/nGXLpU
 W5zPtG/UIspq6qSNCd9aAxJ/XQZlpjzi3+iMPGE0E8V1hy2XtBgHb/opuQrE7G8iAWClI1u5u
 BAs4pF7LYA9bzEC2fI/enjYmlf4+NMdd2J3Po30R3aE9sZ3byzmUZS5ffAYqbCQ5RuIZuKWaE
 AWBar88FNPkFZlRDLLyJXi1Mg4HlGOd0JzS3ks5xS5QuNXAq3zbeijvtUofPZHvYim8CfM6Xv
 Dd1Bhm9YF2Jc2d6HuSveNEuaHhQooaNOSKYmKCNryAyhitBIMo8QvzhhUH+0PSY23L7EIAsk5
 n21iJ7h4i/TV3IoHcL5V+jkP6hBpsRi/uHeP7LChS2kc3gcGzP5BNpfE4QPOGFJBXfUOODoQR
 NbG5fPoUZc++g6haLE0pZjiCJ7BRCmuyp0jKgw6qWgMr79e9g1o17gje12xyZ2Jwgfbqwv9Yf
 6tfUOht/gzJ/kylhM1/RVbEAQV+QAOF12gCNY/P2vD5AzeOQBushzQ/7AydI7IwoeFbqg0YCt
 GvNydRdgQ73+6cI16pUNL6Bfy5oO6fIHVvuze6ffQKNVpYfca2DkuzDQxlopPv/SyQ/au3ftm
 U9f47zyhhznfsr3o115GN6LGWuGUmz8w09xpXX+RwAg34laNmK640KzKeLu1PR7RgnhHZTlkh
 meMi60u9HQQh3BDHES+/s9d3jK/14fuqs9n4hQPCpD6/SgYUi5Jyu1lZqA1j6WcRdpQfjlx85
 kRo5kYjwJR8pTEKmooTvMsSHid1Qk9RRUiJkTPoLjG+LsAp4JTbaTd2l/7M7yuYQdDDOcQ8pt
 PRldW96vMKwHRUPW7TpPptKb9VSy+S1uShmuw55NiT4l730r5foICT5dqRcY3S2h6FYVkfsGe
 a9611bSS51KJSU+HOSoJ2YMh54Gxu4Bcw8Om7AjmpOONztcDlsjoGQPTtNyxQ306DQng0LoLC
 2G8BYepT51KJhM+HxL0A0Y6jltoAVQH3wLw5pq+sE3okMSkg7houHBlkm1uRwkxBBPLOUFpax
 g0DJ/COmDfv68xevB5acPsLzFxNZqMoGk+Z7fHd25Bok5qlirogFlnOBku/7M1lIXiNapZ0Zf
 KDM7CD6mfAuK0Ds3sYev6UXS/Y5VPDJeyWNXyuV3FwNFfcuTnSISYbr7+4qGZ6ZhQGPEHcsB8
 lmxuk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-987959592-1566896842=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Thu, 8 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 94da9193a6 (grep: add support for PCRE v2, 2017-06-01) didn't include
> a way to override the system allocator, and so it is incompatible with
> USE_NED_ALLOCATOR.  The problem was made visible when an attempt to
> avoid a leak in a data structure that is created by the library was
> passed to NED's free for disposal triggering a segfault in Windows.
>
> PCRE2 requires the use of a general context to override the allocator
> and therefore, there is a lot more code needed than in PCRE1, including
> a couple of wrapper functions.
>
> Extend the grep API with a "destructor" that could be called to cleanup
> any objects that were created and used globally.
>
> Update builtin/grep to use that new API, but any other future
> users should make sure to have matching grep_init/grep_destroy calls
> if they are using the pattern matching functionality (currently only
> relevant when using both NED and PCRE2)
>
> Move the logic to decide if a general context will be needed to an
> earlier phase so it will only be done once per pattern (instead of
> at least once per worker thread) avoiding then the need for locking.
>
> This change does the minimum change required to hopefully solve the
> crash, with the rest of the users of it added later.
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---

Unfortunately, this is _still_ incorrect.

I pointed out multiple times that custom allocators can be activated at
run-time rather than compile-time, therefore making the choice at
compile-time is wrong. Besides, there is nothing specific to nedmalloc
about this. So the patch is double-wrong on that account.

The patch has a yet even more immediate problem: t7816.48 is failing in
the CI build for _weeks_ now: it requires that global context to be
initialized, but no code path hits the initialization, resulting in a
very, very ugly:

	BUG: grep.c:516: pcre2_global_context uninitialized

See
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D15151&view=
=3Dms.vss-test-web.build-test-results-tab&runId=3D41282&resultId=3D101710&=
paneView=3Ddebug
for details.

All of this could be easily avoided. As I had pointed out already, the
obvious fragility is not worth the optimization, and we should just
initialize the global context always, as does this patch
(https://github.com/git-for-windows/git/commit/5e5b959169e6efee73e0b50e464=
166822b7d2d07).

I don't claim that this is complete, you need to check carefully (for
example, I think you will want to get rid of _all_ the references to
nedmalloc), but this patch is at least a stop-gap measure to fix the CI
build (Junio, would you mind adding this as a SQUASH??? so that this
breakage won't keep the CI build of `pu` in the failing state?):

=2D- snipsnap --
diff --git a/grep.c b/grep.c
index ec845141bbb..4242ad0b4ae 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -19,7 +19,6 @@ static struct grep_opt grep_defaults;
 #ifdef USE_LIBPCRE2
 static pcre2_general_context *pcre2_global_context;

-#ifdef USE_NED_ALLOCATOR
 static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data=
)
 {
 	return malloc(size);
@@ -30,7 +29,6 @@ static void pcre2_free(void *pointer, MAYBE_UNUSED void =
*memory_data)
 	return free(pointer);
 }
 #endif
-#endif

 static const char *color_grep_slots[] =3D {
 	[GREP_COLOR_CONTEXT]	    =3D "context",
@@ -176,6 +174,12 @@ void grep_init(struct grep_opt *opt, struct repositor=
y *repo, const char *prefix
 	struct grep_opt *def =3D &grep_defaults;
 	int i;

+#if defined(USE_LIBPCRE2)
+	if (!pcre2_global_context)
+		pcre2_global_context =3D pcre2_general_context_create(
+					pcre2_malloc, pcre2_free, NULL);
+#endif
+
 #ifdef USE_NED_ALLOCATOR
 #ifdef USE_LIBPCRE1
 	pcre_malloc =3D malloc;
@@ -343,11 +347,6 @@ void append_header_grep_pattern(struct grep_opt *opt,
 void append_grep_pattern(struct grep_opt *opt, const char *pat,
 			 const char *origin, int no, enum grep_pat_token t)
 {
-#if defined(USE_LIBPCRE2) && defined(USE_NED_ALLOCATOR)
-	if (!pcre2_global_context && opt->ignore_case && has_non_ascii(pat))
-		pcre2_global_context =3D pcre2_general_context_create(
-					pcre2_malloc, pcre2_free, NULL);
-#endif
 	append_grep_pat(opt, pat, strlen(pat), origin, no, t);
 }

=2D-
2.23.0.windows.1

--8323328-987959592-1566896842=:46--
