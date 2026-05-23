Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43433D6E1
	for <git@vger.kernel.org>; Sat, 23 May 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779565719; cv=none; b=pV2pDxjgbxrNuV0t0M65MSXje8IlTeJR0lhJ81V711ZyNuIrRHvzF9nbLg1g9f9fKslS4h1omBbfFViFhbf4Vopjd1meYu99U7W5pnuG05fwmpmU2cBW7CyRRpw88VXBxLC1b4Jq9u7AizpCGZrZELkrlfKwFVM/gy8ADamMoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779565719; c=relaxed/simple;
	bh=Ru5iBCIhUsWMKVWRUAwxoq2zab+JemmueSgnuUykcok=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I9wRU/8o+kVjyG2P7iMjQSsV7dQpQ/IMN8S0Y8pW8qoyCdpe3mbxnTdsRQh8CBvO0fKHTAkveihFxV9ALJl5xRyAb7BtZY352cw+5m5NpVg/DphnlVN4qaS819AMgD0XuvQN1eIKmuxifKHhSQfIZYkFfvv7vw/U94dy1MG7UWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQICcgbS; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQICcgbS"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so81442026d6.1
        for <git@vger.kernel.org>; Sat, 23 May 2026 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779565717; x=1780170517; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZQurbgxbGoPKJgFIanvISOp62hJkznlQT+I5IM/pCs=;
        b=bQICcgbSQL5ntKykSGF7R1jKE/yLuCjRhP5bm5/anFBZ06e9GzVLJo1cbYOCRDlWIA
         xQT6t1HEyDvswBpfcelTwN1K7oEHCbZzXwfdold57xA+uIrxOBbl3qFSo5FIQeDqk+gQ
         y5kQizd0naTy6HXhj2EVqvTykbu/paWK5MI8aVCCsI3BVQjTwo9K770cBuF7gunPBvIE
         llUb5d4TFNghWTSzmsbADXGNp+rGCLonp6VIX87uQXGZFCO9KRNldDNH8kbCxvX7O9dh
         P9i3DZqGJRbOxasxk/hJTKXhg3Nqhx93/BM2V2U4HHzYJ4cZbC72PtWPwXlJ3cJIuz7u
         mwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779565717; x=1780170517;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZQurbgxbGoPKJgFIanvISOp62hJkznlQT+I5IM/pCs=;
        b=Sic3iKEViDqDOVahtj8GOM3aqGjrc0XyxIwczM+2SOND1facfqYGef9cFC+KanYIsW
         ABzl0Tz9exZU3V+E9Bgxun6+JCskcvKyV5nC+krKWrzxbwVI06V7mdumaGn3XlfMG/jZ
         u4mZIYslCftLiyZuciEEPdm3uoYaoI5jyvnNT0l70cb1Ig+97jinsxG5wQWYUfea3oPW
         4igcyEBJ59webbLVSn0UBCd6NVvk9ZT0uOvQvn6O4HqZOkXigwn9yf9/K7TT8iCdGVk/
         7PZJ0JR8u0bRLdGTedZFGzC7JS8NT0YHVIn2Ge65WykFCYaNt2BS3ZdoFTtp/si67eqJ
         Fs3g==
X-Gm-Message-State: AOJu0YyaTabZmBoySk/oYOoTEJyPTJmYR1oaBosWeLQgcqIyz//RgT5j
	K/CC8VosMOB7XRlPFfWtvvchyoWB+5bFMCoVuyzelMMS5hFk/ce4JS8MoNiXnA==
X-Gm-Gg: Acq92OG4Iw9mK+HqDG6/VGAu9t+lfveo47PcUdsUuV1r82nK0S5F/6Z4iVOM2joCsWR
	ac6FakvsOVeMqKw5eDYrm1oX4DP+juopUWqib7W5f/YNOIaQUiYyPQkJX6451udtYDfeUsRFnlI
	lg7ljOPDkFhH77QJmYSV9/VUiIF8yMgdqzrwz8nXc3TC3EDCR+hPzM0wW1RONvdnhcUIhz66zmQ
	MjiM9D3EQmwHxmuGrzWhDFkPx11on8SSRB/7Gjh3Mbu1AdnrUQmORyNPxbzVHM0J9cUH1TrIS28
	ycftHfpqU6RArsoKr0UMucfQ5nMhK074tn86zveMIZKumquEpGrfHayiZ1x7lB5pNlMccjYi9YA
	x54DCwRnD8KuMQEMQtS6oDbwOtCw6wIk09fCzEd5NHj8YiNWuY+6onzFP7OFCGJqyXVmbXDsbvH
	Rf5UmbmGK2/qVSWjjNUkXJstewFvClhelHfk1KyQ==
X-Received: by 2002:a05:6214:3104:b0:8bc:15b:aa6 with SMTP id 6a1803df08f44-8cc7b5d785fmr150677456d6.44.1779565716613;
        Sat, 23 May 2026 12:48:36 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd43dsm55149086d6.3.2026.05.23.12.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 12:48:35 -0700 (PDT)
Message-Id: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v12.git.git.1779358803652.gitgitgadget@gmail.com>
References: <pull.2281.v12.git.git.1779358803652.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 May 2026 19:48:32 +0000
Subject: [PATCH v13 0/2] checkout: --track=fetch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Marc Branchaud <marcnarc@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * Create a preparatory commit that exposes find_tracking_remote_for_ref()
   and advise_ambiguous_fetch_refspec() from branch.c, so checkout can reuse
   the same lookup git branch --track uses.
 * Use advise_ambiguous_fetch_refspec() for the "multiple remotes match"
   case, so the wording matches git branch --track.

Harald Nordgren (2):
  branch: expose helpers for finding the remote owning a tracking ref
  checkout: extend --track with a "fetch" mode to refresh start-point

 Documentation/git-checkout.adoc |  17 +-
 Documentation/git-switch.adoc   |   5 +-
 branch.c                        |  96 ++++++-----
 branch.h                        |  16 ++
 builtin/checkout.c              | 139 +++++++++++++++-
 t/t7201-co.sh                   | 276 ++++++++++++++++++++++++++++++++
 6 files changed, 498 insertions(+), 51 deletions(-)


base-commit: aec3f587505a472db67e9462d0702e7d463a449d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v13
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v12:

 -:  ---------- > 1:  2369afad24 branch: expose helpers for finding the remote owning a tracking ref
 1:  bcd034dbed ! 2:  60adf0e67d checkout: extend --track with a "fetch" mode to refresh start-point
     @@ Commit message
              git checkout -b new_branch --track origin/some-branch
      
          Identify the remote whose configured fetch refspec maps to
     -    <start-point>, then run "git fetch <remote> <src-ref>" for just that
     -    ref so other remote-tracking branches are left untouched. When
     -    <start-point> is a bare <remote> (e.g. "origin"), follow
     +    <start-point> using find_tracking_remote_for_ref() (the same lookup
     +    "--track" uses to pick which remote to record in
     +    branch.<name>.remote), then run "git fetch <remote> <src-ref>" for
     +    just that ref so other remote-tracking branches are left untouched.
     +    When <start-point> is a bare <remote> (e.g. "origin"), follow
          refs/remotes/<remote>/HEAD to learn which branch to refresh. If
          "git fetch" fails but the remote-tracking ref already exists locally,
          warn and proceed from the existing tip; otherwise abort.
     @@ builtin/checkout.c: struct branch_info {
       	char *checkout;
       };
       
     -+struct fetch_target_cb {
     -+	char *dst;
     -+	struct string_list matches;
     -+};
     -+
     -+static int match_fetch_target(struct remote *remote, void *priv)
     -+{
     -+	struct fetch_target_cb *cb = priv;
     -+	struct refspec_item q = { .dst = cb->dst };
     -+
     -+	if (!remote_find_tracking(remote, &q) && q.src)
     -+		string_list_append(&cb->matches, remote->name)->util = q.src;
     -+	return 0;
     -+}
     -+
      +static void fetch_remote_for_start_point(const char *arg, int quiet)
      +{
      +	struct strbuf dst = STRBUF_INIT;
     -+	struct fetch_target_cb cb = { .matches = STRING_LIST_INIT_NODUP };
     ++	struct tracking tracking;
     ++	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
     ++	struct string_list ambiguous_remotes = STRING_LIST_INIT_DUP;
      +	struct child_process cmd = CHILD_PROCESS_INIT;
      +	struct object_id oid;
      +	struct remote *named_remote;
      +	int bare_ns;
     -+	size_t i;
      +
      +	strbuf_addf(&dst, "refs/remotes/%s", arg);
      +	if (check_refname_format(dst.buf, 0))
     @@ builtin/checkout.c: struct branch_info {
      +		free(head_path);
      +	}
      +
     -+	cb.dst = dst.buf;
     -+	for_each_remote(match_fetch_target, &cb);
     -+
     -+	if (cb.matches.nr > 1) {
     -+		struct strbuf msg = STRBUF_INIT;
     -+
     -+		strbuf_addf(&msg,
     -+			    _("cannot fetch start-point '%s': fetch refspecs "
     -+			      "of multiple remotes map to the same destination:"),
     -+			    arg);
     -+		for (i = 0; i < cb.matches.nr; i++)
     -+			strbuf_addf(&msg, "\n  %s", cb.matches.items[i].string);
     -+		strbuf_addstr(&msg,
     -+			      _("\nadjust 'remote.<name>.fetch' so only one "
     -+				"remote maps there, or omit '=fetch'"));
     -+		die("%s", msg.buf);
     ++	memset(&tracking, 0, sizeof(tracking));
     ++	tracking.spec.dst = dst.buf;
     ++	tracking.srcs = &tracking_srcs;
     ++	find_tracking_remote_for_ref(&tracking, &ambiguous_remotes);
     ++
     ++	if (tracking.matches > 1) {
     ++		int status = die_message(_("cannot fetch start-point '%s': "
     ++					   "fetch refspecs of multiple remotes "
     ++					   "map to '%s'"), arg, dst.buf);
     ++		advise_ambiguous_fetch_refspec(dst.buf, &ambiguous_remotes);
     ++		exit(status);
      +	}
      +
     -+	if (!cb.matches.nr) {
     ++	if (!tracking.matches) {
      +		if (bare_ns && named_remote &&
      +		    remote_is_configured(named_remote, 1))
      +			die(_("cannot fetch start-point '%s': "
     @@ builtin/checkout.c: struct branch_info {
      +	strvec_push(&cmd.args, "fetch");
      +	if (quiet)
      +		strvec_push(&cmd.args, "--quiet");
     -+	strvec_pushl(&cmd.args, cb.matches.items[0].string,
     -+		     (char *)cb.matches.items[0].util, NULL);
     ++	strvec_pushl(&cmd.args, tracking.remote,
     ++		     tracking_srcs.items[0].string, NULL);
      +	cmd.git_cmd = 1;
      +	if (run_command(&cmd)) {
      +		if (!refs_read_ref(get_main_ref_store(the_repository),
     @@ builtin/checkout.c: struct branch_info {
      +			die(_("failed to fetch start-point '%s'"), arg);
      +	}
      +
     -+	for (i = 0; i < cb.matches.nr; i++)
     -+		free(cb.matches.items[i].util);
     -+	string_list_clear(&cb.matches, 0);
     ++	string_list_clear(&tracking_srcs, 0);
     ++	string_list_clear(&ambiguous_remotes, 0);
      +	strbuf_release(&dst);
      +}
      +
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_must_fail git checkout --track=fetch -b local_ambig ambig_ns/fetch_ambig 2>err &&
      +	test_grep "fetch_ambig_a" err &&
      +	test_grep "fetch_ambig_b" err &&
     -+	test_grep "remote.<name>.fetch" err &&
     ++	test_grep "tracking namespaces" err &&
      +	test_must_fail git rev-parse --verify refs/heads/local_ambig
      +'
      +

-- 
gitgitgadget
