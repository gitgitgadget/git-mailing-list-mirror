Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23712C690
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146056; cv=none; b=Zt9MLLGgtmbC/N4SGJNNbS7qsaEltRnU+GXhLcyKGw40pTFeaTILupZYLVX+UAoMuxBXIM+kxZEkIT7bERu6xljW8cWuKNGx3EbaAObHWUWAK3U6ODvEuYy52I9MCI5A4YZcKmr/c8gLsZ4mfLZq9+8PatgGVcsCSCX6ZW/HaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146056; c=relaxed/simple;
	bh=griLQ4G5aT2RuuXvIJoDGDgb+6HFhqwuRg/TR2GmpDM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version:
	 References:In-Reply-To; b=e99KH+lMkO+wa07BRH4WjCLzLmxUKNolLcszriTd50VX/bOqCYazlwfsFsIj+DyPYjnxu+QIHku8bQTatCQTwnqprmWvx68cr9oAONGidwR8Wpti3dwGXsgAHg6UwdLT5zP4zTlKG4t9TvVOTp2V9Tnl3Q5LxXWv4m/w25e7klI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqtX6gVR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqtX6gVR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d98fc5ebceso6888765ad.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707146054; x=1707750854; darn=vger.kernel.org;
        h=in-reply-to:references:mime-version:content-transfer-encoding
         :subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIC8qOAXE2c5zkHaekAEDb6XcKCDGPQETN8VCO1PW9A=;
        b=IqtX6gVReval0b4qG//ZbBAA1WbYOfr1LHI7Lifm5m2OYkmC01Iss2BC4aHGhiY/tn
         FIG9mGEwLUo4o2Oul7kigOEe5sUjev3hE7+TcYU/WoVcoMvmVMbL1+ZDXBf602fX/xcU
         1RvxBxsmkaGm8VfsdtGt0QpVjMrGwLBb39DywF9UI6VkyPWcN1QLbyLeOUfQns7efz9l
         Wykl8suMUBw0a62AFLW25N1okK3M8VNOHHzy69ha9HzQDzUxxyCrmmVywbj6MkONQCvY
         9gCc5k78HmxOhJ/SEg083uoBv9jVq32myfECHaXO5P3zNMtTa7RFhzAivIjFRb8NA05T
         BHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146054; x=1707750854;
        h=in-reply-to:references:mime-version:content-transfer-encoding
         :subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIC8qOAXE2c5zkHaekAEDb6XcKCDGPQETN8VCO1PW9A=;
        b=DYt3MSvBy9qt1ybgXjK1QWEDTNdM6IrVzlhhi7NraoyX6y39T9WEWsVX6BNID4WgaX
         ETNT38lMWBUofF4J/QqZlceUNcq9N9xTvWqJZcbSUZiqR86UuGkrvGERWrdfHYQs73ua
         zt/Syb6YISf/k4qF8RsLvwAKWKLTeRTD/V3VAxhKqZfTS/dP3clWp2SIPQkZVrMR12cI
         koujao3SvDzRSsMUF8cPnNn1XXdAhF1+ghdaGSHRunu8Efa4X8CIMZkgR7oJAoErX/Io
         oS6bx40pGsnRKUGv79RBRHQMhWQQAYZNqHPKfB5AETNsKf2OCrsE4uiQFM6fUnzMMSfR
         FzVg==
X-Gm-Message-State: AOJu0YxEHblAGtuIJVufH2A5NKJA8Ult/PXHIyIf+hdO3JVeayhVrPs2
	Q7mjmX6lynT8putsQcj0S1piV5I6jaaBNGcqRejHVKjDCeTEkwRF3H+xMPuna2c=
X-Google-Smtp-Source: AGHT+IFla4rln1ceB3qYh79kaBHPYe1Iqusyxp6eFTsPmy8idk+DruUPvfl8yGsHsXhqS20Zz5Mmjw==
X-Received: by 2002:a17:903:2452:b0:1d9:b3ef:8331 with SMTP id l18-20020a170903245200b001d9b3ef8331mr3427743pls.3.1707146053661;
        Mon, 05 Feb 2024 07:14:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnIJicOyePmsZMpZSVYTen/Qus+Wx7DcMpemdSCBGPI/alVydSEaHmZCuTNvoFms5Pai6E+Woq60c=
Received: from localhost ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b001d9a40f50c4sm2917390plg.301.2024.02.05.07.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 07:14:13 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 20:44:08 +0530
Message-Id: <CYX8RO5UFS8T.2XRXYWJ4JO8K6@gmail.com>
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, <ps@pks.im>
Subject: Re: [PATCH v3 2/2] add-patch: classify '@' as a synonym for 'HEAD'
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.15.2
References: <20240202150434.11256-1-shyamthakkar001@gmail.com>
 <20240203112619.979239-6-shyamthakkar001@gmail.com>
 <xmqq34u9qiu5.fsf@gitster.g>
In-Reply-To: <xmqq34u9qiu5.fsf@gitster.g>

On Sun Feb 4, 2024 at 4:03 AM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> > Therefore, make a new function user_meant_head() which takes the
> > revision string and compares it to 'HEAD' as well as '@'. However, in
> > builtin/checkout.c, there is a logic to convert all command line input
> > rev to the raw object name for underlying machinery (e.g., diff-index)
> > that does not recognize the <a>...<b> notation, but we'd need to leave
> > 'HEAD' intact.  Now we need to teach that '@' is a synonym to 'HEAD'
> >  to that code and leave '@' intact, too.
>
> I am not sure what that "However" wants to say.
>
>  - Now we have a helper function to see what the end-user said, and
>    tell if the end-user meant the state that is currently checked
>    out (aka "HEAD" but some folks like a synonym "@"[*]), or if the
>    end-user meant some other "concrete" branch.
>
>  - In builtin/checkout.c, there is a logic to convert unless what
>    the end-user meant is the state that is currently checked out.
>
> Isn't the natural conclusion that follows these two stentences
> "therefore, the latter is a very good place to use that helper
> function, too"?
Yeah, I did not use the helper function in builtin/checkout.c. Hence the
"However". But I agree on the point of exporting the function.
Therefore I have attached the patch with the updated message below.

> 	Side note: the "@" is already problematic not just because
> 	"git branch @" would not refuse to create "refs/heads/@",
> 	but there is no ref "@" (like $GIT_DIR/refs/@ or $GIT_DIR/@)
> 	when it is used as a synonym for "HEAD".  There is a check
> 	in builtin/checkout.c:update_refs_for_switch() that runs
> 	strcmp() on a token given by the end-user from the command
> 	line with "HEAD" to notice the no-op case "git checkout
> 	HEAD" but the code does not trigger when "@" is given, and
> 	it happens to work by accident.  I really wish we didn't add
> 	that oddball synonym, but that is water under the bridge by
> 	now.
well, I suppose it is maybe annoying from the development perspective,
but users seem to like the concept of it[1].

> In any case, I think we'd find more places that currently treats the
> token "HEAD" given directly by the end-user specially and may want
> to teach at least some of them to also accept "@" the same way, and
> the helper function you are introducing may become useful in the
> future, at which time we may move it to a more public header.  If it
> needs to be shared already between add-patch.c and builtin/checkout.c
> (I am guessing what you meant with "However" as an excuse for open
> coding it instead of sharing the code), perhaps we should do so without
> waiting for that future, though.  I dunno.

Yeah, that "However" was for not using the helper function.

> If we choose to do so, for now, a squashable patch may look like the
> attached, but we'd need to update the log message while squashing it
> in.
Thanks for the patch. Updated message is below.

[Footnote]
[1]: https://www.reddit.com/r/git/comments/k15cqm/do_you_know_is_a_shortcut=
_for_head/

-- >8 --
Subject: [PATCH] add-patch: classify '@' as a synonym for 'HEAD'

Currently, (checkout, reset, restore) commands correctly take '@' as a
synonym for 'HEAD'. However, in patch mode (-p/--patch), for both '@' and
'HEAD', different prompts/messages are given by the commands mentioned
above (because of applying reverse mode(-R) in case of '@'). This is due to
the literal and only string comparison with the word 'HEAD' in run_add_p().
Synonymity between '@' and 'HEAD' is obviously desired, especially since
'@' already resolves to 'HEAD'.

Therefore, make a new function the_user_meant_head() which takes the
revision string and compares it to 'HEAD' as well as '@'. Also in
builtin/checkout.c, there is a logic to convert all command line input
rev to the raw object name for underlying machinery (e.g., diff-index)
that does not recognize the <a>...<b> notation, but we'd need to leave
'HEAD' intact.  Now we need to teach that '@' is a synonym to 'HEAD'
to that code and leave '@' intact, too. Therefore, this function is
already useful in add-patch.c and builtin/checkout.c and may also
become helpful in other places in future. Therefore, it makes sense to
export it.

There is one unintended side-effect/behavior change of this, even if
there exists a branch named '@', when providing '@' as a rev-source to
(checkout, reset, restore) commands in patch mode, it will consider it
as HEAD. This is due to the behavior of diff-index. However, naming a
branch '@' is an obvious foot-gun and there are many existing commands
which already take '@' for 'HEAD' regardless of whether 'refs/heads/@'
exists or not (e.g., 'git log @', 'git push origin @' etc.). Therefore,
this should be fine.

Also, add tests for checking the above mentioned synonymity.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-interactive.h         | 14 ++++++++++++
 add-patch.c               |  6 ++---
 builtin/checkout.c        | 10 ++++-----
 t/t2016-checkout-patch.sh | 46 ++++++++++++++++++++++-----------------
 t/t2071-restore-patch.sh  | 18 +++++++++------
 t/t7105-reset-patch.sh    | 10 +++++++++
 6 files changed, 69 insertions(+), 35 deletions(-)

diff --git a/add-interactive.h b/add-interactive.h
index 693f125e8e..ca7326336d 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -38,4 +38,18 @@ enum add_p_mode {
 int run_add_p(struct repository *r, enum add_p_mode mode,
 	      const char *revision, const struct pathspec *ps);
=20
+/*
+ * When the user gives these tokens from the command line, they mean
+ * the state that the currently checked out state came from.  This
+ * single bit of information affects the direction in which the patch
+ * is presented to the end-user: are we showing a patch to go back to
+ * the currently committed state, or are we showing a patch to move
+ * forward to the given commit that may be different from the
+ * committed state we started with?
+ */
+static inline int the_user_meant_head(const char *rev)
+{
+	return !strcmp(rev, "HEAD") || !strcmp(rev, "@");
+}
+
 #endif
diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..5502acebb8 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1729,21 +1729,21 @@ int run_add_p(struct repository *r, enum add_p_mode=
 mode,
 	if (mode =3D=3D ADD_P_STASH)
 		s.mode =3D &patch_mode_stash;
 	else if (mode =3D=3D ADD_P_RESET) {
-		if (!revision || !strcmp(revision, "HEAD"))
+		if (!revision || the_user_meant_head(revision))
 			s.mode =3D &patch_mode_reset_head;
 		else
 			s.mode =3D &patch_mode_reset_nothead;
 	} else if (mode =3D=3D ADD_P_CHECKOUT) {
 		if (!revision)
 			s.mode =3D &patch_mode_checkout_index;
-		else if (!strcmp(revision, "HEAD"))
+		else if (the_user_meant_head(revision))
 			s.mode =3D &patch_mode_checkout_head;
 		else
 			s.mode =3D &patch_mode_checkout_nothead;
 	} else if (mode =3D=3D ADD_P_WORKTREE) {
 		if (!revision)
 			s.mode =3D &patch_mode_checkout_index;
-		else if (!strcmp(revision, "HEAD"))
+		else if (the_user_meant_head(revision))
 			s.mode =3D &patch_mode_worktree_head;
 		else
 			s.mode =3D &patch_mode_worktree_nothead;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6e30931b5..63c669b157 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -539,12 +539,12 @@ static int checkout_paths(const struct checkout_opts =
*opts,
 		 * recognized by diff-index), we will always replace the name
 		 * with the hex of the commit (whether it's in `...` form or
 		 * not) for the run_add_interactive() machinery to work
-		 * properly. However, there is special logic for the HEAD case
-		 * so we mustn't replace that.  Also, when we were given a
-		 * tree-object, new_branch_info->commit would be NULL, but we
-		 * do not have to do any replacement, either.
+		 * properly. However, there is special logic for the 'HEAD' and
+		 * '@' case so we mustn't replace that.  Also, when we were
+		 * given a tree-object, new_branch_info->commit would be NULL,
+		 * but we do not have to do any replacement, either.
 		 */
-		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
+		if (rev && new_branch_info->commit && !the_user_meant_head(rev))
 			rev =3D oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
=20
 		if (opts->checkout_index && opts->checkout_worktree)
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 747eb5563e..c4f9bf09aa 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -38,26 +38,32 @@ test_expect_success 'git checkout -p with staged change=
s' '
 	verify_state dir/foo index index
 '
=20
-test_expect_success 'git checkout -p HEAD with NO staged changes: abort' '
-	set_and_save_state dir/foo work head &&
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_saved_state dir/foo
-'
-
-test_expect_success 'git checkout -p HEAD with NO staged changes: apply' '
-	test_write_lines n y y | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
-
-test_expect_success 'git checkout -p HEAD with change already staged' '
-	set_state dir/foo index index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
+for opt in "HEAD" "@"
+do
+	test_expect_success "git checkout -p $opt with NO staged changes: abort" =
'
+		set_and_save_state dir/foo work head &&
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_saved_state dir/foo &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with NO staged changes: apply" =
'
+		test_write_lines n y y | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with change already staged" '
+		set_state dir/foo index index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+done
=20
 test_expect_success 'git checkout -p HEAD^...' '
 	# the third n is to get out in case it mistakenly does not apply
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index b5c5c0ff7e..3dc9184b4a 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -44,13 +44,17 @@ test_expect_success PERL 'git restore -p with staged ch=
anges' '
 	verify_state dir/foo index index
 '
=20
-test_expect_success PERL 'git restore -p --source=3DHEAD' '
-	set_state dir/foo work index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git restore -p --source=3DHEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head index
-'
+for opt in "HEAD" "@"
+do
+	test_expect_success PERL "git restore -p --source=3D$opt" '
+		set_state dir/foo work index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git restore -p --source=3D$opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head index &&
+		test_grep "Discard" output
+	'
+done
=20
 test_expect_success PERL 'git restore -p --source=3DHEAD^' '
 	set_state dir/foo work index &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 05079c7246..ec7f16dfb6 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -33,6 +33,16 @@ test_expect_success PERL 'git reset -p' '
 	test_grep "Unstage" output
 '
=20
+for opt in "HEAD" "@"
+do
+	test_expect_success PERL "git reset -p $opt" '
+		test_write_lines n y | git reset -p $opt >output &&
+		verify_state dir/foo work head &&
+		verify_saved_state bar &&
+		test_grep "Unstage" output
+	'
+done
+
 test_expect_success PERL 'git reset -p HEAD^' '
 	test_write_lines n y | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
--=20
2.43.0

