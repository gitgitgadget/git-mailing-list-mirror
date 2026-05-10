Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD52494F0
	for <git@vger.kernel.org>; Sun, 10 May 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778443216; cv=none; b=aZJk0QP9fEuhqLfREnPxyxVw5yQR5Q2Ows/Ycu2BKbB4137V1oRoDN5Erg1l0+gojEvlcebzuZC2ObQn49CdmR+eaQGh+88THAT2S58xV/OsfnrrDoBWVW14liDXnLUuQRGqBpKcuxr3zVrimGgKgwCnZGPUhpb/Pg+nqJQe8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778443216; c=relaxed/simple;
	bh=gOsUsKYmvYt+zOnjgjAxMK3hvQcXyfAnpAtFiw1AbIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcQzG6bLn+t+Hp0hOwR5FfJ6D4Ue1t/1jVUMfqVhHrCyDQyBo5n9EWHsQw+onl/299iNNkTDRSTz5SbQUzrnNDjQOAPAmAIlHGxNIqP69j3C7vQFGmKLXAmMYPxjE02dIz674o/CGyhMj6T8OUAxrw01kw8q2CtSAEanZ/3t9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=o8wXJtMJ; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="o8wXJtMJ"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7bd8c55c885so35234867b3.2
        for <git@vger.kernel.org>; Sun, 10 May 2026 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778443214; x=1779048014; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2fuuvZ4XMD54gBsl807V0LroZLihF5Dgs1WpZ0n9uG4=;
        b=o8wXJtMJ6OkPtoLSzhmoP40DNg9sKphOEuCEviszFeoQTdBSwfEghEFW59SaDIE6I3
         Nf7LHlkdXziuk5jVHcyqhJsBXvU3sLRO7oS0gU0Kdz56ymPdubmRYrlF/JD3arajZBVY
         a8YNreByGwNvXQiWPdpoh9g+++/IADLl/Vq6ns7DjwlB3pHjzXo5xPwGEEuoDtOPL38W
         TRxlVF1gUTUr3s9rgSZbf12DDc/88uTs2Lvll4xMQ8vXqOYz+Thdw9DB64IbADWNMeDb
         ULLXUF4XquUEzM9TZ9DF2gw3awtmyQlMQHLF7bdSipZ2Pbv9K1hMjb7pUNlMv4e5mRa/
         AIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778443214; x=1779048014;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fuuvZ4XMD54gBsl807V0LroZLihF5Dgs1WpZ0n9uG4=;
        b=Ul81+/ToGEa1iLm4lwz/aLEngcelxs+LOvBYUEeCv8ub8OI/YHHrFJNmPV8RfPIWCF
         47HAxzf/yh1nhUIGXfhOKMNmce87IokUOLGLf2ciLb75THN5Bs3sFh5FxNZtNZfI3c4N
         +lnGVn4AppkmVltUaq3JwU6TIeJoNrQzgvn2/VMJGHo7XFcP4ECBRxQWJYsRuCGm5KLF
         +tcH7TIpVxiTifzQ/3DryoQQtZKAksUdJHcccCewW8zlN6cRJEyABd/JvIEKQSs/umSM
         FuwriJJb+jrX5gnsVYLQ2vD83lFkWIdiu9W/LiUzX9QzO6e3MeHRPe+K7PHgzHnh3n2o
         2Xng==
X-Forwarded-Encrypted: i=1; AFNElJ/+iF5bL0YGzRPkmiz34P/21PH5a9DPgMyEYSG/KpPyNi1nVgougUN1YyOrfm35gy4te00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XcCpeGDHZVXN9rDs/KKJX65p7bQwJEg/vjpbU0UydibxCDMS
	ALOA4tkVfnTWvgiFOfmts45oqtrlkFggxwzdb/67DprqEN8l2KXn7DAmxpXIWWK+HIA=
X-Gm-Gg: Acq92OFi/ztXAEDslwzAdtFtlfNmo2OE3puISV1iIg0nbQ4BYUUP6raNuRkjuJFHzro
	hB+q00jSIeAWZZhu+KW72q5zTkCcJbIIh8vqbqvs25+vSD4Shsp9dmZAPjohyWq2emk341i4+8n
	mHJQ+3jtKHeucPN+1m/TAouWwFR02qHqQDpI9Dq9tQFkjbuzzwNoSYQ1F05JR982+b/zxF9ANLy
	3O/h6gP37uYFWR8Co80nfU30+ssDwdHtUIoOH15RhPzvGDbiNbLtelubljABZpBJ0AnRCNrs/Ml
	LWdDT4g527AA4ZCQMGgFqo5EGW2ek0SVNm1WPX/zfioQewS7Ob4jIAqnR7f7gsETLDff7JqAQsU
	Ao2exFzyhJl/L207CDlVI2N03baaAQ729HQ5BAzJjvFzpmJbAeG9WNnuDSCAcWXsxLI617ctXGb
	FaMoLEyIES9jt5HvDuviaZF5x8eoROGWOO46+FMv5RfHZVGs0p0PLTk3sdG65JTTYBA2QSQMEU3
	cw+lDjgbYRGwAOyggAAQ5oNKR3J481sa5EN+E4H0CJXbOGgOKa6hFvIuAfot0QZMB3WQJSjD4zg
	7MxKezu8/+szceLfFjuvkG0NBY0=
X-Received: by 2002:a05:690c:397:b0:7bd:8952:134a with SMTP id 00721157ae682-7bdf5d99519mr222614837b3.3.1778443213769;
        Sun, 10 May 2026 13:00:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66891246sm137568707b3.46.2026.05.10.13.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 13:00:10 -0700 (PDT)
Date: Sun, 10 May 2026 16:00:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,
	jean-christophe manciot <actionmystique@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <agDjyAXxkOIso8FU@nand.local>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
 <9ddfd37d-7d71-4359-b9be-d993fbfd138c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ddfd37d-7d71-4359-b9be-d993fbfd138c@gmail.com>

On Sun, May 10, 2026 at 12:08:14PM -0400, Derrick Stolee wrote:
> I worry that we're assigning _all_ tempfiles to the child in this
> case, not just specific ones like the maintenance lock. But since
> this is specifically called only in daemonize() then it may be
> fine.

Right, I had wondered about this above, and I'm not sure what the right
behavior is here. I think in our case its fine to pass all tempfiles
down to the child, since we're about to exit.

The only other spot that uses `daemonize()` is 'gc --detach' and 'git
daemon'. I think before considering something like this we would want to
reason through what the intended behavior of each of those callers is.
If we end up pursuing a fix in this direction, I think the safest thing
that we could do would be to have callers opt-in to this behavior so we
can do the right thing in git-maintenance, and other callers retain
their existing behavior.

> Is there any concern that since the child didn't create a tempfile
> that the atexit() may not be initialized in the child process? Or
> will that carry over from the fork() automatically? (This is hard
> to test without something causing a die() in the detached process.)

The child will have its own copy of the tempfile list as well as its own
copy of the atexit() handlers. POSIX (via atexit(3p)) says[1] that
atexit() behaves according to the ISO C standard:

    The functionality described on this reference page is aligned with
    the ISO C standard. Any conflict between the requirements described
    here and the ISO C standard is unintentional. This volume of
    POSIX.1‐2017 defers to the ISO C standard.

, and atexit(3) says[2]:

    When a child process is created via fork(2), it inherits copies of
    its parent's registrations.  Upon a successful call to one of the
    exec(3) functions, all registrations are removed.

So the child has an identical copy of both the atexit() handlers and the
tempfile list.

> > That's not too terrible to write, and I would feel OK about putting it
> > in a 2.54.1 release soon-ish provided that others think it is reasonable.
>
> I'd rather revert the geometric maintenance default for a point
> release and let something more complicated like this percolate
> until the next release window.
>
> > Simply reverting 452b12c2e0 (builtin/maintenance: use "geometric"
> > strategy by default, 2026-02-24) feels somewhat unsatisfying, since it
> > is merely making the bug less likely rather than eliminating it
> > entirely.
>
> It does limit the behavior to those who previously chose to opt-in to
> this behavior, and likely that's a low number or else we'd have more
> bug reports.

I agree with what you're saying. In an ideal world we would be able to
apply a fix on top that would prevent this bug from occurring, but if
that's not trivial to do then we shouldn't rush it in the 2.54.1 window.

I think that not having this bug whatsoever (as opposed to simply
reverting 452b12c2e0) would be preferable, but as you note we haven't
seen any bug reports in a pre-452b12c2e0 world, so perhaps the risk is
low enough that we could merely revert 452b12c2e0.

> For me to be convinced that this forward fix is the right direction,
> I'd need to see a test that proves the detached process will clean up
> the locks on a normal process end and an early exit.

Yeah, I agree. Testing this is a little tricky, but I played around
with it for a while and came up with the following:

--- 8< ---
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4700beacc18..77bfa537385 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1460,6 +1460,56 @@ test_expect_success '--detach causes maintenance to run in background' '
 	)
 '

+test_expect_success PIPE '--detach holds maintenance lock until daemonized child exits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		mkfifo fifo &&
+
+		git config maintenance.auto false &&
+		git config core.lockfilepid true &&
+
+		git remote add origin /does/not/exist &&
+		git config set remote.origin.uploadpack \
+			"echo \$PPID >child && cat \"$(pwd)/fifo\"" &&
+
+		# Start a detached prefetch maintenance task. Note that
+		# we are backgrounding git-maintenance here in order to
+		# determine its PID to validate that the lockfile was
+		# created by the parent.
+		{ git maintenance run --task=prefetch --detach & } &&
+		parent="$!" &&
+
+		# Open fifo for writing, which will block until the
+		# upload-pack helper opens it for reading. Once exec
+		# returns, we know that the daemonized child is alive
+		# and pinned.
+		exec 8>fifo &&
+
+		test_path_is_file .git/objects/maintenance.lock &&
+		test_path_is_file .git/objects/maintenance~pid.lock &&
+
+		# Verify that the maintenance.lock still exists, and
+		# that it was created by the parent process, not the
+		# child.
+		echo "pid $parent" >expect &&
+		test_cmp expect .git/objects/maintenance~pid.lock &&
+
+		# Close the write end of the FIFO, causing our upload-pack
+		# helper to quit. Wait until the grandparent (from the
+		# perspective of our upload-pack helper, the daemonized
+		# git-maintenance child)
+		exec 8>&- &&
+		gpid="$(ps -o ppid= -p $(cat child) | tr -d " ")" &&
+		test -n $gpid && wait $gpid &&
+
+		test_path_is_missing .git/objects/maintenance.lock &&
+		test_path_is_missing .git/objects/maintenance~pid.lock
+	)
+'
+
 test_expect_success 'repacking loose objects is quiet' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
--- >8 ---

I'm not sure how portable it is, though. I think that 'ps -o ppid=' is
OK, since 'start_git_in_background()' uses it, but I'm not sure if $PPID
is available on Windows.

It reliably passes with the fix that I shared earlier in the thread, and
reliably fails without it.

Thanks,
Taylor

[1]: https://man7.org/linux/man-pages/man3/atexit.3p.html
[2]: https://man7.org/linux/man-pages/man3/atexit.3.html
