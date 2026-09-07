Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988044AB84
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779613; cv=none; b=f7+wPMyXStSUZUBQtiukOFqzkrmP3qGC/HCmg+57GeSj7H8lGKFPDl9Rpil3kxqtlJv04clxoRXXp9hrecrNSXCTGx/JrAuukIXPrIeEkww0JNKV0PyiTd4nopJFHubyN42X+LN7Xy+CV3xSswekmrZrilhGBayju9fq7GLuS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779613; c=relaxed/simple;
	bh=QJaGthHgGedEZBcO3Oi8gP8RHg3KkA5BqBvZBVeDy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFpa6Qns7GpBTY05Flk5rBvRxaBbYZg24wlH+ys2Y1F276ApMWW1fEUXJ16tvhkbZmA1ZPNg3uk71hGdzVmZAEI28UP4jrnDIaYnrpq6XaM3ww8P8Koiihe6UY5+O2MoxheLvn1QsS9cYpQe1kwfBTirM5I3sauPmX0hjeCbc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SYECUV48; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVEFCTtx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SYECUV48";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVEFCTtx"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0320814001F4;
	Mon,  7 Sep 2026 07:13:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Sep 2026 07:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788779609; x=1788866009; bh=wx+jvOeIYO
	yEbBGTeMBc1V40VKtWAAiXZOF0FIcD3HY=; b=SYECUV48QcL7ZY+ev7qJf+l2P0
	ztyNXIFka98lQlmNTJY1y4xl78ypEejjWZb2CG5Wf+4EDbcZbey/ucB98WTDXwQz
	2wkxwOsX4rtJWp2hM5F36UGGhZFTyV56h+GWZLfhq1SvV3F/HSKnuxrhfJkV688C
	znWrqwFSnN7zNs+CT8KkMeWD0uDo+K4clqBs8h0O6tw7S4AbWts21bQOFHlDjCAg
	nVsc7hbII3XAaMPFMQSRIwjHcfEMvtFVbI86hCX9Fc1zxxudqXZcejGCPQfr6cc+
	Kn/pMwcPgQ+z9wbYOGxFEHrWEIfN9fXVuncJGcvpLePtTvDq7s1HywXz0rrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788779609; x=1788866009; bh=wx+jvOeIYOyEbBGTeMBc1V40VKtWAAiXZOF
	0FIcD3HY=; b=TVEFCTtxOk67XCRP4Crdy2DY4KY0e9Ij1m8Oyam+ZT6g87+tvc2
	URDXHdIQeL41BZQmLo1ysML9/NXUu9CnHED9xL/IumofLFFioyJ596MbB6jAwOEs
	YnVyRtiG4n/iZZzKDjowAv9JpgA/+FXkKh3NDPKBp5CK9JZp2cPKt4MPFjrMDXGU
	9dvZlgbhPWeiqFbmtKv7vwP7V/BPCW0J6XvCNu7rSyEFnmQsT1yTXC3dFTxCOwn+
	meFcHfGDXtb50Z0KxJdm4xZoxh4kRe7R+L52R5LxI8daSuy+rm5oG9O1FEC2+EHi
	b05NoQbwkI+hCQeNrN+98/0EUb+oNOll/tw==
X-ME-Sender: <xms:WZyeamgwJFffrFlUCXgLUJAZRofpoaT69myppYO_WNonPCCO6xpkQg>
    <xme:WZyeaucDmB_AJVQ1anEWLUl_bTNBpZ8MWwrakJWzAc8X0jqAFlyhRCWpAFnwACM-T
    Qd7zqb7NK8v8zHaR4a-3RVeKM-bPpRHhzGFvdMbNpbd2XpVsveOSQ>
X-ME-Received: <xmr:WZyearc7rSa7z_lQBGuQtrlV5S4Q8XaQE3mMUbxVemKf5OiGhXv3Jw>
X-ME-Proxy-Cause: dmFkZTElYEqMuPUELwwZvXJPV+Mjq3MVlGdPzvy5FACtHHurXC0p67jepTBdmUWufJ8LQN
    929jZfzBAUlT73JnMieeA8CnXlKtS5E75IrlGXdnuBAwKxOSYfjGhAJKEYHMUrLA4fvoyB
    M2WOK+lXVMEZbpz1NPCloa0hnhVqwXw/l1uqaLo51yhlsEDWXEhVs9Aow3vSIVjV7rw2G2
    E3XiRV3Zm1OzIspptBiLHtGmiJdxPyfAeFQPx1+ZU7z9e4KnyPbRhm/gLFm1QJRTgNnttT
    g/ladOy4Kfz86l8tSg9gzSSpcnAJtdgzdCrU5ZFbqgVPeq8xjWxImRYA9UMCE+Ag6d+PK1
    /kmQ8BA8PAkwLMHKSgSFdMTDhE59+7EPfv0cukzzY6+QZiLE/CeSouqSnCfMLn6HdsdvQd
    QBkfSrJb4whyE2Fbjf9e16pHt+HsCdTaHCNWwAgKU3KPhVRpCOObZ279fLk8KVT2aXRxUV
    lgVo9Y0KCpNke+YoIF8byJ24Qy+EnwquqtxRyvdzQHnZBO7uahYY6M4l+aCOOcQtlpN/65
    0odvdzelFcKR3cDk/o8Vilh2qeC9iXRM40wpDLM4d2dP6A0DcRp9JFiANSlJgmCXyef5v4
    D6WmQ/PFjTWkKXsNcSVAogza55vje7UF3/k5+UXsCffC3dBwCl0Lay4koRtQ
X-ME-Proxy: <xmx:WZyeao9a58InKQ02T-omEltLjL_0_dRLS86zg-D5XUFnO30LBjkP4A>
    <xmx:WZyeanmEE8CzcIwEGcZFOdI9KHDk-NlLrA5TdJB38ccUgSt6NGHoCw>
    <xmx:WZyeaq-ecWkFwDCMm_zacrjnlHqIwTNdIbRmVuQH86k8VPuhhA77bg>
    <xmx:WZyealnUGHPiGtYj1h9B2ThUr_RN58xt6kNF7VmylF_pceqb_hr5Ag>
    <xmx:WZyeauf0M3x3q2N0sKcJEAZ2aspfBJ_yVCtbJWiuyPfEA8y-WJ_x03Y->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:13:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b11e4e04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:13:26 +0000 (UTC)
Date: Mon, 7 Sep 2026 13:13:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: history: 'reword HEAD' surfaces a memory leak
Message-ID: <ap6cU2elXvmlLgb8@pks.im>
References: <04faa984-5b56-406b-baa9-dbb4b5eab259@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04faa984-5b56-406b-baa9-dbb4b5eab259@app.fastmail.com>

On Thu, Sep 03, 2026 at 05:26:44PM +0200, Kristoffer Haugsbakk wrote:
> I get a sanitizer error when I run a simple reword command:
> 
>     $ make SANITIZE=address install
>     $ GIT_EDITOR=true git history reword \
>         --dry-run 3cb9185f65410273787f74333cc027d2ea5daada
>     update HEAD eeb9d4b5c4041739c0a19b4043924513c8aad2d2 3cb9185f65410273787f74333cc027d2ea5daada
> 
>     =================================================================
>     ==116999==ERROR: LeakSanitizer: detected memory leaks
> 
>     Direct leak of 283 byte(s) in 1 object(s) allocated from:
>         #0 0x712d2f6b4887 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
>         #1 0x61970a5757b2 in do_xmalloc /home/kristoffer/programming/git-worktree/git-leakcheck/wrapper.c:55
>         #2 0x61970a575ec0 in do_xmallocz /home/kristoffer/programming/git-worktree/git-leakcheck/wrapper.c:89
>         #3 0x61970a575ec0 in do_xmallocz /home/kristoffer/programming/git-worktree/git-leakcheck/wrapper.c:79
>         #4 0x61970a575ec0 in xmallocz_gently /home/kristoffer/programming/git-worktree/git-leakcheck/wrapper.c:102
>         #5 0x61970a309ca0 in unpack_compressed_entry /home/kristoffer/programming/git-worktree/git-leakcheck/packfile.c:1732
>         #6 0x61970a310bf0 in unpack_entry /home/kristoffer/programming/git-worktree/git-leakcheck/packfile.c:1885
>         #7 0x61970a311fbf in cache_or_unpack_entry /home/kristoffer/programming/git-worktree/git-leakcheck/packfile.c:1528
>         #8 0x61970a311fbf in packed_object_info_with_index_pos /home/kristoffer/programming/git-worktree/git-leakcheck/packfile.c:1610
>         #9 0x61970a313097 in packed_object_info /home/kristoffer/programming/git-worktree/git-leakcheck/packfile.c:1720
>         #10 0x61970a313097 in packfile_store_read_object_info /home/kristoffer/programming/git-worktree/git-leakcheck/packfile.c:2214
>         #11 0x61970a2caae8 in odb_source_files_read_object_info odb/source-files.c:58
>         #12 0x61970a2c69a7 in odb_source_read_object_info odb/source.h:326
>         #13 0x61970a2c69a7 in do_oid_object_info_extended /home/kristoffer/programming/git-worktree/git-leakcheck/odb.c:572
>         #14 0x61970a2c69a7 in odb_read_object_info_extended /home/kristoffer/programming/git-worktree/git-leakcheck/odb.c:710
>         #15 0x61970a2c7cbe in odb_read_object /home/kristoffer/programming/git-worktree/git-leakcheck/odb.c:756
>         #16 0x61970a101d5a in repo_get_commit_buffer /home/kristoffer/programming/git-worktree/git-leakcheck/commit.c:399
>         #17 0x61970a101d5a in repo_get_commit_buffer /home/kristoffer/programming/git-worktree/git-leakcheck/commit.c:391
>         #18 0x61970a346bf6 in repo_logmsg_reencode /home/kristoffer/programming/git-worktree/git-leakcheck/pretty.c:716
>         #19 0x619709ebbe64 in commit_tree_ext builtin/history.c:127
>         #20 0x619709ebd17f in commit_tree_with_edited_message builtin/history.c:183
>         #21 0x619709ebd17f in cmd_history_reword builtin/history.c:717
>         #22 0x619709ec186f in cmd_history builtin/history.c:998
>         #23 0x619709d87ca0 in run_builtin /home/kristoffer/programming/git-worktree/git-leakcheck/git.c:506
>         #24 0x619709d87ca0 in handle_builtin /home/kristoffer/programming/git-worktree/git-leakcheck/git.c:782
>         #25 0x619709d8c9a6 in run_argv /home/kristoffer/programming/git-worktree/git-leakcheck/git.c:865
>         #26 0x619709d8c9a6 in cmd_main /home/kristoffer/programming/git-worktree/git-leakcheck/git.c:986
>         #27 0x619709d83f54 in main /home/kristoffer/programming/git-worktree/git-leakcheck/common-main.c:9
>         #28 0x712d2f229d8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> 
>     SUMMARY: AddressSanitizer: 283 byte(s) leaked in 1 allocation(s).

This feels familiar, even though it doesn't reproduce on my machine. Do
you have "i18n.commitencoding" set? In any case, I think the following
patch should fix it:

diff --git a/builtin/history.c b/builtin/history.c
index 000155ad9c..bca95b9d05 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -158,6 +158,7 @@ static int commit_tree_ext(struct repository *repo,
 	*out = lookup_commit_or_die(&rewritten_commit_oid, "rewritten commit");
 
 out:
+	repo_unuse_commit_buffer(repo, commit_with_message, original_message);
 	free_commit_extra_headers(original_extra_headers);
 	strbuf_release(&commit_message);
 	free(original_author);

I know that we've already been discussing this memory leak on the
mailing list at one point in time, and we've already had a patch similar
to the above. So why wasn't this merged...?

Ah, the discussion was in [1]. Cc'ing Kaartic.

Thanks!

Patrick

[1]: https://lore.kernel.org/git/20260614141600.620272-1-kaartic.sivaraam@gmail.com/
