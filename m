Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DE3B2FFF
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144193; cv=none; b=Ok4MjvsBboWopOHfCoRNy0BKK8wQgrNY9hOgUeI+JR2TZVQ2+bxz6eKZw/hHorp7lpHEGZAZ7dQlYLy1Q84q0Ih/YFzlu2xz9gYeGgfXxjGRBpUKuOmrfV+2v97t5QX0IDTTBjnyPxSV5Lvotwcwp2Z50IR/aKJIsPUcaOqb4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144193; c=relaxed/simple;
	bh=2G0tzAthOAUjhytm+RgRdI4MlTbNVZrNgcnCJkBVeNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1D8vnhkbp4Qs04p2j+ros7dkm9wzcc0LSkMsSwmShzHXajkDYZbqE8okblfj4LWSQzINjViuXATwzrnoUGL18+VJiVS3gaYaM1F45ac+MuM3HHOJLBtYnl/OVIcjkrV6A9h7vzZHweM4QW+07L0XRN9cxWtjxScu+OV4DkYYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YZJ08ycs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OpEeI2Tm; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YZJ08ycs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OpEeI2Tm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D5F87A0074;
	Wed, 15 Jul 2026 15:36:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 15:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784144190; x=1784230590; bh=/nbBNY5OPp
	ImP7LvXgW8s2vYCrHNwoIF+PTVPEAKrgY=; b=YZJ08ycsNuEhREFFuaqIvrnvtx
	MwXrwKYfjSNwYKQmjPGDbf2MlWZHy/9pzbGpMvGkCm+LFu3UIC5/X5gJioWE+6+9
	5z+wDvzm8zLp+8VK8dVes84+e/O9SZYjfrItSHfoTtEiEl+86h847u5/DmHduaHs
	BnyF6sNPKp5mYv42j1dlcOK5OSoGIzR3dWeby3AJYQBGVwyeGu6m7gwecKWyHJsJ
	7RuX7t6rjq7zr4NTByd2y04CslTspBCA1+zqdlTk7JqHnZSm8p++66JEXn99/dOD
	ayvE1TmO9zGnGsMiV+SKNUoweGgJgb1RSSY46S7mV/PqaMtaCs3jQgGF4N4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784144190; x=1784230590; bh=/nbBNY5OPpImP7LvXgW8s2vYCrHNwoIF+PT
	VPEAKrgY=; b=OpEeI2TmVJ7CIVDM1/256cN3pigs8NZ92k6YmM6uMNd5GbfFm+G
	G3P3FiRZxKkVTgMaXD1fzjhsnJ8VIquf0q4pBlI4Whbb9DvSHObndYBkCX4Smcz5
	DX4ThXS0lfsUgH5swbYzy+trlVC0BEM9BJJNBSUpfbkgoHMR9mwc2NI0NLfoQxFb
	SCCDMdml+XWUTOAcZ9uNp2hkiNNqGsy223/xQON0ktk7GauSP2rqBLwYkPF1vGxR
	wO82Vin4omHQeqGSEmDCLIiLL0YV+q5hp3wuz2nEXM1CFnNuHRGrM9JIVNz5DLJk
	0ghfxK/R6aI51Avmys3HXQCMvptKzcl1lCA==
X-ME-Sender: <xms:PuFXavVmgBmdIXsE9aizZ-kLQOIb-eF0EbXdJiKIr1MZgqEKNl2Upg>
    <xme:PuFXavDr2Umhc6U_m2YSVI3kMV01ORiJucgAzu4l6p3A8qlCPk4wpqvGgM5NGoUzA
    UMjUow7C1YdjYc9aJm-OKwC7TFY9o0FfgKSQfeufuuEvpx-allFmfg>
X-ME-Received: <xmr:PuFXaowdgRF6tw4nyBxyZJYYyAk_kq8ojoUid975NSlsO3HR_n8dYq-CFGG4fa22NKfI4IvTBa_zFoh7BVqeP2Y4AdIc3vnSo4qUGZo>
X-ME-Proxy-Cause: dmFkZTGgyRKMOaT/ljo8EmcM6nL77NuSMR3+H95dQPxmjIZsecGphecr097WCjK+i8KYxj
    M9jqdLL5K2zvER+1sWP+QeBIvL+UzAFBX3NJmVMgxy/bTrFtmpIOPVrci6HhecPvt9nX9+
    PzC5dU5QYY3Kc3VgBxb2I6TH/fpUuva7xEHIEC8DyK5GY3yXN6QD+xJ53A3e9E096+Vsw4
    qDp23rcTzRGGcLzsfXpCdhwucOQpHW5Jb7PlMFW3ikQVeJKW4ezUhrWyAOgGtKKOqwje+h
    JFtTrr4VOzwXgGqc9MjFtMNY0Sw6sXAzJSgFk/x50kJzt7P8Tm969/LJ9CrmDE6zpr5nlR
    tQXlajvE2eczT6bdEipsAyyOHxih6T2fjLjD6A1vLS/7JD491UKQMsYNaqPpGg4JvLp2x5
    qNPh1+6uSFL1bN6nkQBJLASYLtqOzHHTijKNT+c22lnSTZu7h5MwQr2dSm3c6pPRcS26iK
    zhTg5bOiTQcj+4/sdXmHjQLPTdqC8+MF7uIeKMxWDzhaD8NWesZDygRa7/CjFx+pu0ssLq
    d1K0LJiHrlfHbdhv2bkdg6BQp99/UOm6r2WGenZb44t/bvN6oLB3ed2RwuHyRA2iPgY6j2
    NDoMxVNdOW+zgqZnN366l/I7wtwR3IhUq5OE977RMoZi1C8vPGV0Bz087HVA
X-ME-Proxy: <xmx:PuFXakDgXwI_xZIfgxRpLvWc8ErK9BTS6JXbNZTnBz5zJDfxx2fzrA>
    <xmx:PuFXatZ2rct515N1JZckGtF8swhRrvFTIEicYcmiub8IUTM2YnI47Q>
    <xmx:PuFXakheeb0KswQiNvOL_GpwFNNOz_B69TFLIRsaH9iFfkldpzPkDQ>
    <xmx:PuFXan7elH9NByUJysJRHiiR44u0AMa_i9e8y_GCYRc7k2ewwK3WHg>
    <xmx:PuFXajDiO_WK_ak7Ru4-2SHdWtvWAgfFQaa_LlwquG2mod2tz9HoAg_o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 15:36:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t7614: avoid hiding git's exit code in a pipe
In-Reply-To: <20260715113344.3490-1-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Wed, 15 Jul 2026 17:03:44 +0530")
References: <20260715113344.3490-1-diy2903@gmail.com>
Date: Wed, 15 Jul 2026 12:36:29 -0700
Message-ID: <xmqq1pd4m4ea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

> The exit code of the upstream command in a pipe is ignored, so in
>
> 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual
>
> a crash of "git cat-file" would go unnoticed: the exit code of the
> pipeline is that of "sed", which happily succeeds on empty input. The
> test would thus pass even though "git cat-file" failed.
>
> Write the output of "git cat-file" to a file first and run "sed" on
> that file, so that the exit codes of both commands are checked by the
> &&-chain.
>
> Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
> ---
> This is a microproject ("Avoid suppressing git's exit code in test
> scripts"), applying the same fix as c6f44e1da5 (t9813: avoid using
> pipes) to another script. A search of the list did not turn up anyone
> working on t7614; please let me know if it is already taken.

All look trivially correct.

Two clean-up possibilities that are clearly outside the scope of
this patch are

 * There is no need to backslash-quote the dollar sign.
   t7604-merge-custom-message.sh next door uses "1,/^$/d" just fine.

 * This "cat-file the commit object, and strip away the object
   header with sed" pattern appears quite often throughout the test
   suite.

   $ git grep -B1 -e 'sed -e "1,/^\\*$/d"' t/

   shows quite a few hits.  It might make sense to give them an easy
   to use helper script

	commit_body () {
		git cat-file commit "$1" >.commit &&
		sed -e "1,/^$/d" .commit &&
		rm -f .commit
	}

   or something like that.

But again, these are clearly outside the scope of this patch.

>
>  t/t7614-merge-signoff.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
> index fee258d4f0..e58bf07b7a 100755
> --- a/t/t7614-merge-signoff.sh
> +++ b/t/t7614-merge-signoff.sh
> @@ -45,7 +45,8 @@ test_expect_success 'git merge --signoff adds a sign-off line' '
>  	test_commit main-branch-2 file2 2 &&
>  	git checkout other-branch &&
>  	git merge main --signoff --no-edit &&
> -	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	git cat-file commit HEAD >commit &&
> +	sed -e "1,/^\$/d" commit >actual &&
>  	test_cmp expected-signed actual
>  '
>  
> @@ -55,7 +56,8 @@ test_expect_success 'git merge does not add a sign-off line' '
>  	test_commit main-branch-3 file3 3 &&
>  	git checkout other-branch &&
>  	git merge main --no-edit &&
> -	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	git cat-file commit HEAD >commit &&
> +	sed -e "1,/^\$/d" commit >actual &&
>  	test_cmp expected-unsigned actual
>  '
>  
> @@ -65,7 +67,8 @@ test_expect_success 'git merge --no-signoff flag cancels --signoff flag' '
>  	test_commit main-branch-4 file4 4 &&
>  	git checkout other-branch &&
>  	git merge main --no-edit --signoff --no-signoff &&
> -	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	git cat-file commit HEAD >commit &&
> +	sed -e "1,/^\$/d" commit >actual &&
>  	test_cmp expected-unsigned actual
>  '
